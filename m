Received: from eggs.gnu.org ([2001:4830:134:3::10]:47004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEe5E-00054X-FV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEe5A-0003dV-Ih
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEe5A-0003co-Dd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEF6C8182D24
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 17:01:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  4 May 2018 19:01:07 +0200
Message-Id: <1525453270-23074-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1525453270-23074-1-git-send-email-thuth@redhat.com>
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] qemu-options: Bail out on unsupported
 options instead of silently ignoring them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>

The dangling remainder of the -tdf option revealed a deficiency in our
option parsing: Options that have been declared, but are not supported
in the switch-case statement in vl.c and not handled in the OS-specifc
os_parse_cmd_args() functions are currently silently ignored. We should
rather tell the users that they specified something that we can not
handle, so let's print an error message and exit instead.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu-common.h | 2 +-
 os-posix.c            | 6 +++++-
 os-win32.c            | 4 ++--
 vl.c                  | 5 ++++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 8a4f63c..85f4749 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -137,7 +137,7 @@ char *qemu_find_file(int type, const char *name);
 /* OS specific functions */
 void os_setup_early_signal_handling(void);
 char *os_find_datadir(void);
-void os_parse_cmd_args(int index, const char *optarg);
+int os_parse_cmd_args(int index, const char *optarg);
 
 #include "qemu/module.h"
 
diff --git a/os-posix.c b/os-posix.c
index 24eb700..9ce6f74 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -165,7 +165,7 @@ static bool os_parse_runas_uid_gid(const char *optarg)
  * Parse OS specific command line options.
  * return 0 if option handled, -1 otherwise
  */
-void os_parse_cmd_args(int index, const char *optarg)
+int os_parse_cmd_args(int index, const char *optarg)
 {
     switch (index) {
 #ifdef CONFIG_SLIRP
@@ -199,7 +199,11 @@ void os_parse_cmd_args(int index, const char *optarg)
         fips_set_state(true);
         break;
 #endif
+    default:
+        return -1;
     }
+
+    return 0;
 }
 
 static void change_process_uid(void)
diff --git a/os-win32.c b/os-win32.c
index 586a7c7..0674f94 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -93,9 +93,9 @@ void os_set_line_buffering(void)
  * Parse OS specific command line options.
  * return 0 if option handled, -1 otherwise
  */
-void os_parse_cmd_args(int index, const char *optarg)
+int os_parse_cmd_args(int index, const char *optarg)
 {
-    return;
+    return -1;
 }
 
 int qemu_create_pidfile(const char *filename)
diff --git a/vl.c b/vl.c
index 806eec2..457e93b 100644
--- a/vl.c
+++ b/vl.c
@@ -4042,7 +4042,10 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             default:
-                os_parse_cmd_args(popt->index, optarg);
+                if (os_parse_cmd_args(popt->index, optarg)) {
+                    error_report("Option not supported in this build");
+                    exit(1);
+                }
             }
         }
     }
-- 
1.8.3.1
