Received: from eggs.gnu.org ([2001:4830:134:3::10]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoW-0008Pb-T4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoV-0007lC-Ql
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnoV-0007jm-HE
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:15 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:41 +0100
Message-Id: <20180313173355.4468-5-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 04/18] linux-user: Support f_flags in statfs
 when available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Shea Levy <shea@shealevy.com>

From: Shea Levy <shea@shealevy.com>

Signed-off-by: Shea Levy <shea@shealevy.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180301111500.15717-1-shea@shealevy.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      |  5 +++++
 linux-user/syscall_defs.h | 41 +++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a8abfd421d..e1c3127bdc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9545,6 +9545,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
index 13aa70b93b..e53583e921 100644
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
@@ -2226,7 +2213,8 @@ struct target_statfs {
 	/* Linux specials */
 	target_fsid_t		f_fsid;
 	int32_t			f_namelen;
-	int32_t			f_spare[6];
+	int32_t			f_flags;
+	int32_t			f_spare[5];
 };
 #else
 struct target_statfs {
@@ -2242,7 +2230,8 @@ struct target_statfs {
 	/* Linux specials */
 	target_fsid_t		f_fsid;
 	abi_long		f_namelen;
-	abi_long		f_spare[6];
+	abi_long		f_flags;
+	abi_long		f_spare[5];
 };
 #endif
 
@@ -2258,7 +2247,8 @@ struct target_statfs64 {
 	uint64_t	f_bavail;
 	target_fsid_t	f_fsid;
 	uint32_t	f_namelen;
-	uint32_t	f_spare[6];
+	uint32_t	f_flags;
+	uint32_t	f_spare[5];
 };
 #elif (defined(TARGET_PPC64) || defined(TARGET_X86_64) || \
        defined(TARGET_SPARC64) || defined(TARGET_AARCH64) || \
@@ -2274,7 +2264,8 @@ struct target_statfs {
 	target_fsid_t f_fsid;
 	abi_long f_namelen;
 	abi_long f_frsize;
-	abi_long f_spare[5];
+	abi_long f_flags;
+	abi_long f_spare[4];
 };
 
 struct target_statfs64 {
@@ -2288,7 +2279,8 @@ struct target_statfs64 {
 	target_fsid_t f_fsid;
 	abi_long f_namelen;
 	abi_long f_frsize;
-	abi_long f_spare[5];
+	abi_long f_flags;
+	abi_long f_spare[4];
 };
 #elif defined(TARGET_S390X)
 struct target_statfs {
@@ -2302,7 +2294,9 @@ struct target_statfs {
     kernel_fsid_t f_fsid;
     int32_t  f_namelen;
     int32_t  f_frsize;
-    int32_t  f_spare[5];
+    int32_t  f_flags;
+    int32_t  f_spare[4];
+
 };
 
 struct target_statfs64 {
@@ -2316,7 +2310,8 @@ struct target_statfs64 {
     kernel_fsid_t f_fsid;
     int32_t  f_namelen;
     int32_t  f_frsize;
-    int32_t  f_spare[5];
+    int32_t  f_flags;
+    int32_t  f_spare[4];
 };
 #else
 struct target_statfs {
@@ -2330,7 +2325,8 @@ struct target_statfs {
 	target_fsid_t f_fsid;
 	uint32_t f_namelen;
 	uint32_t f_frsize;
-	uint32_t f_spare[5];
+	uint32_t f_flags;
+	uint32_t f_spare[4];
 };
 
 struct target_statfs64 {
@@ -2344,7 +2340,8 @@ struct target_statfs64 {
 	target_fsid_t f_fsid;
         uint32_t f_namelen;
 	uint32_t f_frsize;
-	uint32_t f_spare[5];
+	uint32_t f_flags;
+	uint32_t f_spare[4];
 };
 #endif
 
-- 
2.14.3
