Received: from eggs.gnu.org ([2001:4830:134:3::10]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB4-0000Ks-TC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB2-0001zB-Eb
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChB2-0001Vx-0F
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D359D307D858
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 08:27:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:41 +0200
Message-Id: <20181017082702.5581-18-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/38] seccomp: Clean up error reporting in
 parse_sandbox()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  parse_sandbox() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Cc: Eduardo Otubo <otubo@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 qemu-seccomp.c | 18 +++++++++---------
 vl.c           |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 1baa5c69ed..5c73e6ad05 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -12,11 +12,12 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/module.h"
-#include "qemu/error-report.h"
 #include <sys/prctl.h>
 #include <seccomp.h>
 #include "sysemu/seccomp.h"
@@ -190,7 +191,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Error=
 **errp)
                  * to provide a little bit of consistency for
                  * the command line */
             } else {
-                error_report("invalid argument for obsolete");
+                error_setg(errp, "invalid argument for obsolete");
                 return -1;
             }
         }
@@ -205,14 +206,13 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Err=
or **errp)
                 /* calling prctl directly because we're
                  * not sure if host has CAP_SYS_ADMIN set*/
                 if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
-                    error_report("failed to set no_new_privs "
-                                 "aborting");
+                    error_setg(errp, "failed to set no_new_privs abortin=
g");
                     return -1;
                 }
             } else if (g_str_equal(value, "allow")) {
                 /* default value */
             } else {
-                error_report("invalid argument for elevateprivileges");
+                error_setg(errp, "invalid argument for elevateprivileges=
");
                 return -1;
             }
         }
@@ -224,7 +224,7 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Error=
 **errp)
             } else if (g_str_equal(value, "allow")) {
                 /* default value */
             } else {
-                error_report("invalid argument for spawn");
+                error_setg(errp, "invalid argument for spawn");
                 return -1;
             }
         }
@@ -236,14 +236,14 @@ int parse_sandbox(void *opaque, QemuOpts *opts, Err=
or **errp)
             } else if (g_str_equal(value, "allow")) {
                 /* default value */
             } else {
-                error_report("invalid argument for resourcecontrol");
+                error_setg(errp, "invalid argument for resourcecontrol")=
;
                 return -1;
             }
         }
=20
         if (seccomp_start(seccomp_opts) < 0) {
-            error_report("failed to install seccomp syscall filter "
-                         "in the kernel");
+            error_setg(errp, "failed to install seccomp syscall filter "
+                       "in the kernel");
             return -1;
         }
     }
diff --git a/vl.c b/vl.c
index ff50199e64..643121e5d4 100644
--- a/vl.c
+++ b/vl.c
@@ -3972,8 +3972,8 @@ int main(int argc, char **argv, char **envp)
=20
 #ifdef CONFIG_SECCOMP
     olist =3D qemu_find_opts_err("sandbox", NULL);
-    if (olist && qemu_opts_foreach(olist, parse_sandbox, NULL, NULL)) {
-        exit(1);
+    if (olist) {
+        qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
     }
 #endif
=20
--=20
2.17.1
