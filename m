Received: from eggs.gnu.org ([2001:4830:134:3::10]:55699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG5by-0003EL-53
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG5bt-0005R7-7O
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:37:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG5bs-0005QY-UW
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:37:05 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  8 May 2018 18:36:39 +0200
Message-Id: <20180508163639.7138-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: fix convertion of flock/flock64
 l_type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

As l_type values (F_RDLCK, F_WRLCK, F_UNLCK, F_EXLCK, F_SHLCK)
are not bitmasks, we can't use target_to_host_bitmask() and
host_to_target_bitmask() to convert them.

Introduce target_to_host_flock() and host_to_target_flock()
to convert values between host and target.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4825747f9..fdf6766eca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6546,15 +6546,33 @@ static int target_to_host_fcntl_cmd(int cmd)
     return -TARGET_EINVAL;
 }
 
-#define TRANSTBL_CONVERT(a) { -1, TARGET_##a, -1, a }
-static const bitmask_transtbl flock_tbl[] = {
-    TRANSTBL_CONVERT(F_RDLCK),
-    TRANSTBL_CONVERT(F_WRLCK),
-    TRANSTBL_CONVERT(F_UNLCK),
-    TRANSTBL_CONVERT(F_EXLCK),
-    TRANSTBL_CONVERT(F_SHLCK),
-    { 0, 0, 0, 0 }
-};
+static unsigned int target_to_host_flock(unsigned int type)
+{
+    switch (type) {
+#define TRANSTBL_CONVERT(a) case TARGET_##a: return a;
+    TRANSTBL_CONVERT(F_RDLCK)
+    TRANSTBL_CONVERT(F_WRLCK)
+    TRANSTBL_CONVERT(F_UNLCK)
+    TRANSTBL_CONVERT(F_EXLCK)
+    TRANSTBL_CONVERT(F_SHLCK)
+#undef  TRANSTBL_CONVERT
+    }
+    return type;
+}
+
+static unsigned int host_to_target_flock(unsigned int type)
+{
+    switch (type) {
+#define TRANSTBL_CONVERT(a) case a: return TARGET_##a;
+    TRANSTBL_CONVERT(F_RDLCK)
+    TRANSTBL_CONVERT(F_WRLCK)
+    TRANSTBL_CONVERT(F_UNLCK)
+    TRANSTBL_CONVERT(F_EXLCK)
+    TRANSTBL_CONVERT(F_SHLCK)
+#undef  TRANSTBL_CONVERT
+    }
+    return type;
+}
 
 static inline abi_long copy_from_user_flock(struct flock64 *fl,
                                             abi_ulong target_flock_addr)
@@ -6567,7 +6585,7 @@ static inline abi_long copy_from_user_flock(struct flock64 *fl,
     }
 
     __get_user(l_type, &target_fl->l_type);
-    fl->l_type = target_to_host_bitmask(l_type, flock_tbl);
+    fl->l_type = target_to_host_flock(l_type);
     __get_user(fl->l_whence, &target_fl->l_whence);
     __get_user(fl->l_start, &target_fl->l_start);
     __get_user(fl->l_len, &target_fl->l_len);
@@ -6586,7 +6604,7 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
         return -TARGET_EFAULT;
     }
 
-    l_type = host_to_target_bitmask(fl->l_type, flock_tbl);
+    l_type = host_to_target_flock(fl->l_type);
     __put_user(l_type, &target_fl->l_type);
     __put_user(fl->l_whence, &target_fl->l_whence);
     __put_user(fl->l_start, &target_fl->l_start);
@@ -6611,7 +6629,7 @@ static inline abi_long copy_from_user_oabi_flock64(struct flock64 *fl,
     }
 
     __get_user(l_type, &target_fl->l_type);
-    fl->l_type = target_to_host_bitmask(l_type, flock_tbl);
+    fl->l_type = target_to_host_flock(l_type);
     __get_user(fl->l_whence, &target_fl->l_whence);
     __get_user(fl->l_start, &target_fl->l_start);
     __get_user(fl->l_len, &target_fl->l_len);
@@ -6630,7 +6648,7 @@ static inline abi_long copy_to_user_oabi_flock64(abi_ulong target_flock_addr,
         return -TARGET_EFAULT;
     }
 
-    l_type = host_to_target_bitmask(fl->l_type, flock_tbl);
+    l_type = host_to_target_flock(fl->l_type);
     __put_user(l_type, &target_fl->l_type);
     __put_user(fl->l_whence, &target_fl->l_whence);
     __put_user(fl->l_start, &target_fl->l_start);
@@ -6652,7 +6670,7 @@ static inline abi_long copy_from_user_flock64(struct flock64 *fl,
     }
 
     __get_user(l_type, &target_fl->l_type);
-    fl->l_type = target_to_host_bitmask(l_type, flock_tbl);
+    fl->l_type = target_to_host_flock(l_type);
     __get_user(fl->l_whence, &target_fl->l_whence);
     __get_user(fl->l_start, &target_fl->l_start);
     __get_user(fl->l_len, &target_fl->l_len);
@@ -6671,7 +6689,7 @@ static inline abi_long copy_to_user_flock64(abi_ulong target_flock_addr,
         return -TARGET_EFAULT;
     }
 
-    l_type = host_to_target_bitmask(fl->l_type, flock_tbl);
+    l_type = host_to_target_flock(fl->l_type);
     __put_user(l_type, &target_fl->l_type);
     __put_user(fl->l_whence, &target_fl->l_whence);
     __put_user(fl->l_start, &target_fl->l_start);
-- 
2.14.3
