Received: from eggs.gnu.org ([2001:4830:134:3::10]:60646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Ch1-0002Hx-71
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgz-0006HL-Bg
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:55 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6403088e3=Ian.Jackson@citrix.com>)
	id 1f9Cgz-0006C9-0d
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:45:53 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Apr 2018 17:45:13 +0100
Message-ID: <1524156319-11465-11-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 10/16] os-posix: Provide new -runas <uid>:<gid>
 facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

This allows the caller to specify a uid and gid to use, even if there
is no corresponding password entry.  This will be useful in certain
Xen configurations.

We don't support just -runas <uid> because: (i) deprivileging without
calling setgroups would be ineffective (ii) given only a uid we don't
know what gid we ought to use (since uids may eppear in multiple
passwd file entries with different gids).

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
CC: Michael Tokarev <mjt@tls.msk.ru>
---
v7: Be much more explicit about legal combinations of user_{pwd,uid,gid}.
    Rely more on qemu_stroul being sane, dropping pointless
     pre-assignments of errno and lv.
    Retain optarg in error message about -runas argument.
    Rebase over introduction of error_report in change_process_uid.
v6.1: Fix constness of qemu_strtoul end pointer parameter.
v6: Use qemu_strtoul for the first strtoul.
    Use error_report rather than fprintf to print usage error message.
    Fix an error message which still referred to . rather than :
v5: Use : rather than . to separate uid from gid
v4: Changed to reuse option -runas
v3: Error messages fixed.  Thanks to Peter Maydell and Ross Lagerwall.
---
 os-posix.c      | 77 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 qemu-options.hx |  3 ++-
 2 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 560db95..0f59566 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -41,7 +41,14 @@
 #include <sys/prctl.h>
 #endif
 
-static struct passwd *user_pwd;
+/*
+ * Must set all three of these at once.
+ * Legal combinations are              unset   by name   by uid
+ */
+static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
+static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
+static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
+
 static const char *chroot_dir;
 static int daemonize;
 static int daemon_pipe;
@@ -127,6 +134,33 @@ void os_set_proc_name(const char *s)
 #endif
 }
 
+
+static bool os_parse_runas_uid_gid(const char *optarg)
+{
+    unsigned long lv;
+    const char *ep;
+    uid_t got_uid;
+    gid_t got_gid;
+    int rc;
+
+    rc = qemu_strtoul(optarg, &ep, 0, &lv);
+    got_uid = lv; /* overflow here is ID in C99 */
+    if (rc || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
+        return false;
+    }
+
+    rc = qemu_strtoul(ep + 1, 0, 0, &lv);
+    got_gid = lv; /* overflow here is ID in C99 */
+    if (rc || got_gid != lv || got_gid == (gid_t)-1) {
+        return false;
+    }
+
+    user_pwd = NULL;
+    user_uid = got_uid;
+    user_gid = got_gid;
+    return true;
+}
+
 /*
  * Parse OS specific command line options.
  * return 0 if option handled, -1 otherwise
@@ -144,8 +178,13 @@ void os_parse_cmd_args(int index, const char *optarg)
 #endif
     case QEMU_OPTION_runas:
         user_pwd = getpwnam(optarg);
-        if (!user_pwd) {
-            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
+        if (user_pwd) {
+            user_uid = -1;
+            user_gid = -1;
+        } else if (!os_parse_runas_uid_gid(optarg)) {
+            error_report("User \"%s\" doesn't exist"
+                         " (and is not <uid>:<gid>)",
+                         optarg);
             exit(1);
         }
         break;
@@ -165,18 +204,32 @@ void os_parse_cmd_args(int index, const char *optarg)
 
 static void change_process_uid(void)
 {
-    if (user_pwd) {
-        if (setgid(user_pwd->pw_gid) < 0) {
-            error_report("Failed to setgid(%d)", user_pwd->pw_gid);
+    assert((user_uid == (uid_t)-1) || user_pwd == NULL);
+    assert((user_uid == (uid_t)-1) ==
+           (user_gid == (gid_t)-1));
+
+    if (user_pwd || user_uid != (uid_t)-1) {
+        gid_t intended_gid = user_pwd ? user_pwd->pw_gid : user_gid;
+        uid_t intended_uid = user_pwd ? user_pwd->pw_uid : user_uid;
+        if (setgid(intended_gid) < 0) {
+            error_report("Failed to setgid(%d)", intended_gid);
             exit(1);
         }
-        if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
-            error_report("Failed to initgroups(\"%s\", %d)",
-                         user_pwd->pw_name, user_pwd->pw_gid);
-            exit(1);
+        if (user_pwd) {
+            if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
+                error_report("Failed to initgroups(\"%s\", %d)",
+                        user_pwd->pw_name, user_pwd->pw_gid);
+                exit(1);
+            }
+        } else {
+            if (setgroups(1, &user_gid) < 0) {
+                error_report("Failed to setgroups(1, [%d])",
+                        user_gid);
+                exit(1);
+            }
         }
-        if (setuid(user_pwd->pw_uid) < 0) {
-            error_report("Failed to setuid(%d)", user_pwd->pw_uid);
+        if (setuid(intended_uid) < 0) {
+            error_report("Failed to setuid(%d)", intended_uid);
             exit(1);
         }
         if (setuid(0) != -1) {
diff --git a/qemu-options.hx b/qemu-options.hx
index ca4e412..5fbf966 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3765,7 +3765,8 @@ ETEXI
 
 #ifndef _WIN32
 DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
-    "-runas user     change to user id user just before starting the VM\n",
+    "-runas user     change to user id user just before starting the VM\n" \
+    "                user can be numeric uid:gid instead\n",
     QEMU_ARCH_ALL)
 #endif
 STEXI
-- 
2.1.4
