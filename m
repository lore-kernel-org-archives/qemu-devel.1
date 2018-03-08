Received: from eggs.gnu.org ([2001:4830:134:3::10]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW2-0007QM-Ih
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0008MZ-CC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:42 -0500
Received: from smtp.citrix.com ([66.165.176.89]:42122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0008JW-3h
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:41 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 17:39:13 +0000
Message-ID: <1520530757-4477-8-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 07/11] os-posix: Provide new -runas <uid>:<gid>
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
Cc: xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
---
v6: Use qemu_strtoul for the first strtoul.
    Use error_report rather than fprintf to print usage error message.
    Fix an error message which still referred to . rather than :
v5: Use : rather than . to separate uid from gid
v4: Changed to reuse option -runas
v3: Error messages fixed.  Thanks to Peter Maydell and Ross Lagerwall.
v2: Coding style fixes.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 os-posix.c      | 62 +++++++++++++++++++++++++++++++++++++++++++++++----------
 qemu-options.hx |  3 ++-
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index b9c2343..32d7cf0 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -42,6 +42,8 @@
 #endif
 
 static struct passwd *user_pwd;
+static uid_t user_uid = (uid_t)-1;
+static gid_t user_gid = (gid_t)-1;
 static const char *chroot_dir;
 static int daemonize;
 static int daemon_pipe;
@@ -127,6 +129,34 @@ void os_set_proc_name(const char *s)
 #endif
 }
 
+
+static bool os_parse_runas_uid_gid(const char *optarg)
+{
+    unsigned long lv;
+    char *ep;
+    uid_t got_uid;
+    gid_t got_gid;
+    int rc;
+
+    errno = 0;
+    rc = qemu_strtoul(optarg, &ep, 0, &lv);
+    got_uid = lv; /* overflow here is ID in C99 */
+    if (rc || *ep != ':' || got_uid != lv || got_uid == (uid_t)-1) {
+        return false;
+    }
+
+    lv = 0;
+    rc = qemu_strtoul(ep + 1, 0, 0, &lv);
+    got_gid = lv; /* overflow here is ID in C99 */
+    if (rc || got_gid != lv || got_gid == (gid_t)-1) {
+        return false;
+    }
+
+    user_uid = got_uid;
+    user_gid = got_gid;
+    return true;
+}
+
 /*
  * Parse OS specific command line options.
  * return 0 if option handled, -1 otherwise
@@ -144,8 +174,8 @@ void os_parse_cmd_args(int index, const char *optarg)
 #endif
     case QEMU_OPTION_runas:
         user_pwd = getpwnam(optarg);
-        if (!user_pwd) {
-            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
+        if (!user_pwd && !os_parse_runas_uid_gid(optarg)) {
+            error_report("User doesn't exist (and is not <uid>:<gid>)");
             exit(1);
         }
         break;
@@ -165,18 +195,28 @@ void os_parse_cmd_args(int index, const char *optarg)
 
 static void change_process_uid(void)
 {
-    if (user_pwd) {
-        if (setgid(user_pwd->pw_gid) < 0) {
-            fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
+    if (user_pwd || user_uid != (uid_t)-1) {
+        gid_t intended_gid = user_pwd ? user_pwd->pw_gid : user_gid;
+        uid_t intended_uid = user_pwd ? user_pwd->pw_uid : user_uid;
+        if (setgid(intended_gid) < 0) {
+            fprintf(stderr, "Failed to setgid(%d)\n", intended_gid);
             exit(1);
         }
-        if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
-            fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
-                    user_pwd->pw_name, user_pwd->pw_gid);
-            exit(1);
+        if (user_pwd) {
+            if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
+                fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
+                        user_pwd->pw_name, user_pwd->pw_gid);
+                exit(1);
+            }
+        } else {
+            if (setgroups(1, &user_gid) < 0) {
+                fprintf(stderr, "Failed to setgroups(1, [%d])",
+                        user_gid);
+                exit(1);
+            }
         }
-        if (setuid(user_pwd->pw_uid) < 0) {
-            fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
+        if (setuid(intended_uid) < 0) {
+            fprintf(stderr, "Failed to setuid(%d)\n", intended_uid);
             exit(1);
         }
         if (setuid(0) != -1) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 6585058..211f2a6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3763,7 +3763,8 @@ ETEXI
 
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
