Received: from eggs.gnu.org ([2001:4830:134:3::10]:39152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv49-0000lX-Nc
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv47-0006t2-R9
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:13 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:59995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv47-0006gP-LL
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:11 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 15 Sep 2017 19:09:59 +0100
Message-ID: <1505498999-17427-7-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 6/6] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This allows the caller to specify a uid and gid to use, even if there
is no corresponding password entry.  This will be useful in certain
Xen configurations.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 os-posix.c      | 30 ++++++++++++++++++++++++++----
 qemu-options.hx | 12 ++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 92e9d85..b88995e 100644
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
@@ -134,6 +136,8 @@ void os_set_proc_name(const char *s)
  */
 void os_parse_cmd_args(int index, const char *optarg)
 {
+    unsigned long lv;
+    char *ep;
     switch (index) {
 #ifdef CONFIG_SLIRP
     case QEMU_OPTION_smb:
@@ -150,6 +154,22 @@ void os_parse_cmd_args(int index, const char *optarg)
             exit(1);
         }
         break;
+    case QEMU_OPTION_runasid:
+        errno = 0;
+        lv = strtoul(optarg, &ep, 0);
+        if (errno || *ep != '.' || (user_uid = lv) != lv
+            || (user_uid == (uid_t)-1)) {
+            fprintf(stderr, "Could not obtain uid from \"%s\"", optarg);
+            exit(1);
+        }
+        errno = 0;
+        lv = strtoul(ep+1, &ep, 0);
+        if (errno || *ep || (user_gid = lv) != lv
+            || (user_gid == (gid_t)-1)) {
+            fprintf(stderr ,"Could not obtain gid from \"%s\"", optarg);
+            exit(1);
+        }
+        break;
     case QEMU_OPTION_chroot:
         chroot_dir = optarg;
         break;
@@ -166,17 +186,19 @@ void os_parse_cmd_args(int index, const char *optarg)
 
 static void change_process_uid(void)
 {
-    if (user_pwd) {
-        if (setgid(user_pwd->pw_gid) < 0) {
+    if (user_pwd || user_uid != (uid_t)-1) {
+        if (setgid(user_pwd ? user_pwd->pw_gid : user_gid) < 0) {
             fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
             exit(1);
         }
-        if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
+        if ((user_pwd
+             ? initgroups(user_pwd->pw_name, user_pwd->pw_gid)
+             : setgroups(1, &user_gid)) < 0) {
             fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
                     user_pwd->pw_name, user_pwd->pw_gid);
             exit(1);
         }
-        if (setuid(user_pwd->pw_uid) < 0) {
+        if (setuid(user_pwd ? user_pwd->pw_uid : user_gid) < 0) {
             fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
             exit(1);
         }
diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2ad..34a5329 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3968,6 +3968,18 @@ Immediately before starting guest execution, drop root privileges, switching
 to the specified user.
 ETEXI
 
+#ifndef _WIN32
+DEF("runasid", HAS_ARG, QEMU_OPTION_runasid, \
+    "-runasid uid.gid     change to numeric uid and gid just before starting the VM\n",
+    QEMU_ARCH_ALL)
+#endif
+STEXI
+@item -runasid @var{uid}.@var{gid}
+@findex -runasid
+Immediately before starting guest execution, drop root privileges, switching
+to the specified uid and gid.
+ETEXI
+
 DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
     "-prom-env variable=value\n"
     "                set OpenBIOS nvram variables\n",
-- 
2.1.4
