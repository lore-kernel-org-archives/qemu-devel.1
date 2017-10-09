Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1aVM-0005uI-1p
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1aVD-0004Nx-U6
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:02:08 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:48852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1aVD-0004M0-NG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:01:59 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Mon, 9 Oct 2017 17:01:41 +0100
Message-ID: <1507564902-9000-8-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runas <uid>.<gid>
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
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This allows the caller to specify a uid and gid to use, even if there
is no corresponding password entry.  This will be useful in certain
Xen configurations.

We don't support just -runas <uid> because: (i) deprivileging without
calling setgroups would be ineffective (ii) given only a uid we don't
know what gid we ought to use (since uids may eppear in multiple
passwd file entries with different gids).

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
v4: Changed to reuse option -runas
v3: Error messages fixed.  Thanks to Peter Maydell and Ross Lagerwall.
v2: Coding style fixes.
---
 os-posix.c      | 64 +++++++++++++++++++++++++++++++++++++++++++++++----------
 qemu-options.hx |  3 ++-
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 92e9d85..9418bd4 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -43,6 +43,8 @@
 #endif
 
 static struct passwd *user_pwd;
+static uid_t user_uid = (uid_t)-1;
+static gid_t user_gid = (gid_t)-1;
 static const char *chroot_dir;
 static int daemonize;
 static int daemon_pipe;
@@ -128,6 +130,34 @@ void os_set_proc_name(const char *s)
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
+    lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep=='.' */
+    got_uid = lv; /* overflow here is ID in C99 */
+    if (errno || *ep != '.' || got_uid != lv || got_uid == (uid_t)-1) {
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
@@ -145,8 +175,10 @@ void os_parse_cmd_args(int index, const char *optarg)
 #endif
     case QEMU_OPTION_runas:
         user_pwd = getpwnam(optarg);
-        if (!user_pwd) {
-            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
+        if (!user_pwd && !os_parse_runas_uid_gid(optarg)) {
+            fprintf(stderr,
+                    "User \"%s\" doesn't exist (and is not <uid>.<gid>)\n",
+                    optarg);
             exit(1);
         }
         break;
@@ -166,18 +198,28 @@ void os_parse_cmd_args(int index, const char *optarg)
 
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
index 9f6e2ad..bdff99f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3958,7 +3958,8 @@ ETEXI
 
 #ifndef _WIN32
 DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
-    "-runas user     change to user id user just before starting the VM\n",
+    "-runas user     change to user id user just before starting the VM\n" \
+    "                user can be numeric uid.gid instead\n",
     QEMU_ARCH_ALL)
 #endif
 STEXI
-- 
2.1.4
