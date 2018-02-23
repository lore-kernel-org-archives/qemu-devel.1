Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shea@shealevy.com>) id 1ep5S6-0003gk-09
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 00:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shea@shealevy.com>) id 1ep5QY-0001ut-Qq
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 23:59:22 -0500
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:59854
	helo=smtprelay.hostedemail.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shea@shealevy.com>) id 1ep5QX-0001sF-CS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 23:57:46 -0500
From: Shea Levy <shea@shealevy.com>
Date: Thu, 22 Feb 2018 23:57:35 -0500
Message-Id: <20180223045735.1288-1-shea@shealevy.com>
In-Reply-To: <20180219024555.26467-1-shea@shealevy.com>
References: <20180219024555.26467-1-shea@shealevy.com>
Subject: [Qemu-devel] [PATCH v3] linux-user: Support f_flags in statfs when
 available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shea Levy <shea@shealevy.com>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 configure                 | 21 +++++++++++++++++++
 linux-user/syscall.c      |  3 +++
 linux-user/syscall_defs.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/configure b/configure
index 913e14839d..91082aa1dc 100755
--- a/configure
+++ b/configure
@@ -5303,6 +5303,23 @@ if compile_prog "" "" ; then
     have_utmpx=yes
 fi
 
+##########################################
+# Check for newer fields of struct statfs on Linux
+
+if test "$linux_user" = "yes"; then
+  cat > $TMPC <<EOF
+#include <sys/vfs.h>
+
+int main(void) {
+  struct statfs fs;
+  fs.f_flags = 0;
+  return fs.f_flags;
+}
+EOF
+  if compile_object ; then
+      have_statfs_flags=yes
+  fi
+fi
 ##########################################
 # checks for sanitizers
 
@@ -6518,6 +6535,10 @@ if test "$have_utmpx" = "yes" ; then
   echo "HAVE_UTMPX=y" >> $config_host_mak
 fi
 
+if test "$have_statfs_flags" = "yes" ; then
+  echo "HAVE_STATFS_FLAGS=y" >> $config_host_mak
+fi
+
 if test "$ivshmem" = "yes" ; then
   echo "CONFIG_IVSHMEM=y" >> $config_host_mak
 fi
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 82b35a6bdf..77481eca2c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9534,6 +9534,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
             __put_user(stfs.f_namelen, &target_stfs->f_namelen);
             __put_user(stfs.f_frsize, &target_stfs->f_frsize);
+#ifdef HAVE_STATFS_FLAGS
+            __put_user(stfs.f_flags, &target_stfs->f_flags);
+#endif
             memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
             unlock_user_struct(target_stfs, arg2, 1);
         }
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a35c52a60a..64aa49d3c5 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -362,7 +362,14 @@ struct kernel_statfs {
 	int f_ffree;
         kernel_fsid_t f_fsid;
 	int f_namelen;
+#ifdef HAVE_STATFS_FLAGS
+	int f_frsize;
+	int f_flags;
+	int f_spare[4];
+#else
 	int f_spare[6];
+#endif
+
 };
 
 struct target_dirent {
@@ -2223,7 +2230,12 @@ struct target_statfs {
 	/* Linux specials */
 	target_fsid_t		f_fsid;
 	int32_t			f_namelen;
+#ifdef HAVE_STATFS_FLAGS
+	int32_t			f_flags;
+	int32_t			f_spare[5];
+#else
 	int32_t			f_spare[6];
+#endif
 };
 #else
 struct target_statfs {
@@ -2239,7 +2251,12 @@ struct target_statfs {
 	/* Linux specials */
 	target_fsid_t		f_fsid;
 	abi_long		f_namelen;
+#ifdef HAVE_STATFS_FLAGS
+	abi_long		f_flags;
+	abi_long		f_spare[5];
+#else
 	abi_long		f_spare[6];
+#endif
 };
 #endif
 
@@ -2255,7 +2272,12 @@ struct target_statfs64 {
 	uint64_t	f_bavail;
 	target_fsid_t	f_fsid;
 	uint32_t	f_namelen;
+#ifdef HAVE_STATFS_FLAGS
+	uint32_t	f_flags;
+	uint32_t	f_spare[5];
+#else
 	uint32_t	f_spare[6];
+#endif
 };
 #elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) || \
        defined(TARGET_SPARC64) || defined(TARGET_AARCH64)) && \
@@ -2271,7 +2293,12 @@ struct target_statfs {
 	target_fsid_t f_fsid;
 	abi_long f_namelen;
 	abi_long f_frsize;
+#ifdef HAVE_STATFS_FLAGS
+	abi_long f_flags;
+	abi_long f_spare[4];
+#else
 	abi_long f_spare[5];
+#endif
 };
 
 struct target_statfs64 {
@@ -2285,7 +2312,12 @@ struct target_statfs64 {
 	target_fsid_t f_fsid;
 	abi_long f_namelen;
 	abi_long f_frsize;
+#ifdef HAVE_STATFS_FLAGS
+	abi_long f_flags;
+	abi_long f_spare[4];
+#else
 	abi_long f_spare[5];
+#endif
 };
 #elif defined(TARGET_S390X)
 struct target_statfs {
@@ -2299,7 +2331,13 @@ struct target_statfs {
     kernel_fsid_t f_fsid;
     int32_t  f_namelen;
     int32_t  f_frsize;
+#ifdef HAVE_STATFS_FLAGS
+    int32_t  f_flags;
+    int32_t  f_spare[4];
+#else
     int32_t  f_spare[5];
+#endif
+
 };
 
 struct target_statfs64 {
@@ -2313,7 +2351,12 @@ struct target_statfs64 {
     kernel_fsid_t f_fsid;
     int32_t  f_namelen;
     int32_t  f_frsize;
+#ifdef HAVE_STATFS_FLAGS
+    int32_t  f_flags;
+    int32_t  f_spare[4];
+#else
     int32_t  f_spare[5];
+#endif
 };
 #else
 struct target_statfs {
@@ -2327,7 +2370,12 @@ struct target_statfs {
 	target_fsid_t f_fsid;
 	uint32_t f_namelen;
 	uint32_t f_frsize;
+#ifdef HAVE_STATFS_FLAGS
+	uint32_t f_flags;
+	uint32_t f_spare[4];
+#else
 	uint32_t f_spare[5];
+#endif
 };
 
 struct target_statfs64 {
@@ -2341,7 +2389,12 @@ struct target_statfs64 {
 	target_fsid_t f_fsid;
         uint32_t f_namelen;
 	uint32_t f_frsize;
+#ifdef HAVE_STATFS_FLAGS
+	uint32_t f_flags;
+	uint32_t f_spare[4];
+#else
 	uint32_t f_spare[5];
+#endif
 };
 #endif
 
-- 
2.16.1
