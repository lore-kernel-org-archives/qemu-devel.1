Received: from eggs.gnu.org ([2001:4830:134:3::10]:59730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shea@shealevy.com>) id 1erMBH-0007tw-5m
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shea@shealevy.com>) id 1erMBC-0003vY-4B
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:15:23 -0500
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:39987
	helo=smtprelay.hostedemail.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shea@shealevy.com>) id 1erMBB-0003tr-RT
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:15:18 -0500
From: Shea Levy <shea@shealevy.com>
Date: Thu,  1 Mar 2018 06:15:00 -0500
Message-Id: <20180301111500.15717-1-shea@shealevy.com>
In-Reply-To: <1c105562-7933-d6bf-1071-6836ad8b6e40@vivier.eu>
References: <1c105562-7933-d6bf-1071-6836ad8b6e40@vivier.eu>
Subject: [Qemu-devel] [PATCH v4] linux-user: Support f_flags in statfs when
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
Cc: Laurent Vivier <laurent@vivier.eu>, Shea Levy <shea@shealevy.com>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 linux-user/syscall.c      |  5 +++++
 linux-user/syscall_defs.h | 41 +++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 82b35a6bdf..03dca7ea77 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9534,6 +9534,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
             __put_user(stfs.f_namelen, &target_stfs->f_namelen);
             __put_user(stfs.f_frsize, &target_stfs->f_frsize);
+#ifdef _STATFS_F_FLAGS
+            __put_user(stfs.f_flags, &target_stfs->f_flags);
+#else
+            __put_user(0, &target_stfs->f_flags);
+#endif
             memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
             unlock_user_struct(target_stfs, arg2, 1);
         }
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a35c52a60a..ee340b8eac 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -352,19 +352,6 @@ typedef struct {
         int     val[2];
 } kernel_fsid_t;
 
-struct kernel_statfs {
-	int f_type;
-	int f_bsize;
-	int f_blocks;
-	int f_bfree;
-	int f_bavail;
-	int f_files;
-	int f_ffree;
-        kernel_fsid_t f_fsid;
-	int f_namelen;
-	int f_spare[6];
-};
-
 struct target_dirent {
         abi_long        d_ino;
         abi_long        d_off;
@@ -2223,7 +2210,8 @@ struct target_statfs {
 	/* Linux specials */
 	target_fsid_t		f_fsid;
 	int32_t			f_namelen;
-	int32_t			f_spare[6];
+	int32_t			f_flags;
+	int32_t			f_spare[5];
 };
 #else
 struct target_statfs {
@@ -2239,7 +2227,8 @@ struct target_statfs {
 	/* Linux specials */
 	target_fsid_t		f_fsid;
 	abi_long		f_namelen;
-	abi_long		f_spare[6];
+	abi_long		f_flags;
+	abi_long		f_spare[5];
 };
 #endif
 
@@ -2255,7 +2244,8 @@ struct target_statfs64 {
 	uint64_t	f_bavail;
 	target_fsid_t	f_fsid;
 	uint32_t	f_namelen;
-	uint32_t	f_spare[6];
+	uint32_t	f_flags;
+	uint32_t	f_spare[5];
 };
 #elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) || \
        defined(TARGET_SPARC64) || defined(TARGET_AARCH64)) && \
@@ -2271,7 +2261,8 @@ struct target_statfs {
 	target_fsid_t f_fsid;
 	abi_long f_namelen;
 	abi_long f_frsize;
-	abi_long f_spare[5];
+	abi_long f_flags;
+	abi_long f_spare[4];
 };
 
 struct target_statfs64 {
@@ -2285,7 +2276,8 @@ struct target_statfs64 {
 	target_fsid_t f_fsid;
 	abi_long f_namelen;
 	abi_long f_frsize;
-	abi_long f_spare[5];
+	abi_long f_flags;
+	abi_long f_spare[4];
 };
 #elif defined(TARGET_S390X)
 struct target_statfs {
@@ -2299,7 +2291,9 @@ struct target_statfs {
     kernel_fsid_t f_fsid;
     int32_t  f_namelen;
     int32_t  f_frsize;
-    int32_t  f_spare[5];
+    int32_t  f_flags;
+    int32_t  f_spare[4];
+
 };
 
 struct target_statfs64 {
@@ -2313,7 +2307,8 @@ struct target_statfs64 {
     kernel_fsid_t f_fsid;
     int32_t  f_namelen;
     int32_t  f_frsize;
-    int32_t  f_spare[5];
+    int32_t  f_flags;
+    int32_t  f_spare[4];
 };
 #else
 struct target_statfs {
@@ -2327,7 +2322,8 @@ struct target_statfs {
 	target_fsid_t f_fsid;
 	uint32_t f_namelen;
 	uint32_t f_frsize;
-	uint32_t f_spare[5];
+	uint32_t f_flags;
+	uint32_t f_spare[4];
 };
 
 struct target_statfs64 {
@@ -2341,7 +2337,8 @@ struct target_statfs64 {
 	target_fsid_t f_fsid;
         uint32_t f_namelen;
 	uint32_t f_frsize;
-	uint32_t f_spare[5];
+	uint32_t f_flags;
+	uint32_t f_spare[4];
 };
 #endif
 
-- 
2.16.1
