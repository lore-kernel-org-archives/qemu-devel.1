Received: from eggs.gnu.org ([2001:4830:134:3::10]:34918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGYFY-0007z5-Jk
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGYFV-0002gR-B6
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:11:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fGYFV-0002dz-26
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:11:53 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 10 May 2018 01:11:21 +0200
Message-Id: <20180509231123.20864-5-laurent@vivier.eu>
In-Reply-To: <20180509231123.20864-1-laurent@vivier.eu>
References: <20180509231123.20864-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 4/6] linux-user: fix conversion of
 flock/flock64 l_type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>

As l_type values (F_RDLCK, F_WRLCK, F_UNLCK, F_EXLCK, F_SHLCK)
are not bitmasks, we can't use target_to_host_bitmask() and
host_to_target_bitmask() to convert them.

Introduce target_to_host_flock() and host_to_target_flock()
to convert values between host and target.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2:
      - add common switch macro to convert to/from target to/from host
      - return -TARGET_EINVAL is l_type cannot be converted

 linux-user/syscall.c | 66 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4825747f9..af8603f1b7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6546,28 +6546,50 @@ static int target_to_host_fcntl_cmd(int cmd)
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
+#define FLOCK_TRANSTBL \
+    switch (type) { \
+    TRANSTBL_CONVERT(F_RDLCK); \
+    TRANSTBL_CONVERT(F_WRLCK); \
+    TRANSTBL_CONVERT(F_UNLCK); \
+    TRANSTBL_CONVERT(F_EXLCK); \
+    TRANSTBL_CONVERT(F_SHLCK); \
+    }
+
+static int target_to_host_flock(int type)
+{
+#define TRANSTBL_CONVERT(a) case TARGET_##a: return a
+    FLOCK_TRANSTBL
+#undef  TRANSTBL_CONVERT
+    return -TARGET_EINVAL;
+}
+
+static int host_to_target_flock(int type)
+{
+#define TRANSTBL_CONVERT(a) case a: return TARGET_##a
+    FLOCK_TRANSTBL
+#undef  TRANSTBL_CONVERT
+    /* if we don't know how to convert the value coming
+     * from the host we copy to the target field as-is
+     */
+    return type;
+}
 
 static inline abi_long copy_from_user_flock(struct flock64 *fl,
                                             abi_ulong target_flock_addr)
 {
     struct target_flock *target_fl;
-    short l_type;
+    int l_type;
 
     if (!lock_user_struct(VERIFY_READ, target_fl, target_flock_addr, 1)) {
         return -TARGET_EFAULT;
     }
 
     __get_user(l_type, &target_fl->l_type);
-    fl->l_type = target_to_host_bitmask(l_type, flock_tbl);
+    l_type = target_to_host_flock(l_type);
+    if (l_type < 0) {
+        return l_type;
+    }
+    fl->l_type = l_type;
     __get_user(fl->l_whence, &target_fl->l_whence);
     __get_user(fl->l_start, &target_fl->l_start);
     __get_user(fl->l_len, &target_fl->l_len);
@@ -6586,7 +6608,7 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
         return -TARGET_EFAULT;
     }
 
-    l_type = host_to_target_bitmask(fl->l_type, flock_tbl);
+    l_type = host_to_target_flock(fl->l_type);
     __put_user(l_type, &target_fl->l_type);
     __put_user(fl->l_whence, &target_fl->l_whence);
     __put_user(fl->l_start, &target_fl->l_start);
@@ -6604,14 +6626,18 @@ static inline abi_long copy_from_user_oabi_flock64(struct flock64 *fl,
                                                    abi_ulong target_flock_addr)
 {
     struct target_oabi_flock64 *target_fl;
-    short l_type;
+    int l_type;
 
     if (!lock_user_struct(VERIFY_READ, target_fl, target_flock_addr, 1)) {
         return -TARGET_EFAULT;
     }
 
     __get_user(l_type, &target_fl->l_type);
-    fl->l_type = target_to_host_bitmask(l_type, flock_tbl);
+    l_type = target_to_host_flock(l_type);
+    if (l_type < 0) {
+        return l_type;
+    }
+    fl->l_type = l_type;
     __get_user(fl->l_whence, &target_fl->l_whence);
     __get_user(fl->l_start, &target_fl->l_start);
     __get_user(fl->l_len, &target_fl->l_len);
@@ -6630,7 +6656,7 @@ static inline abi_long copy_to_user_oabi_flock64(abi_ulong target_flock_addr,
         return -TARGET_EFAULT;
     }
 
-    l_type = host_to_target_bitmask(fl->l_type, flock_tbl);
+    l_type = host_to_target_flock(fl->l_type);
     __put_user(l_type, &target_fl->l_type);
     __put_user(fl->l_whence, &target_fl->l_whence);
     __put_user(fl->l_start, &target_fl->l_start);
@@ -6645,14 +6671,18 @@ static inline abi_long copy_from_user_flock64(struct flock64 *fl,
                                               abi_ulong target_flock_addr)
 {
     struct target_flock64 *target_fl;
-    short l_type;
+    int l_type;
 
     if (!lock_user_struct(VERIFY_READ, target_fl, target_flock_addr, 1)) {
         return -TARGET_EFAULT;
     }
 
     __get_user(l_type, &target_fl->l_type);
-    fl->l_type = target_to_host_bitmask(l_type, flock_tbl);
+    l_type = target_to_host_flock(l_type);
+    if (l_type < 0) {
+        return l_type;
+    }
+    fl->l_type = l_type;
     __get_user(fl->l_whence, &target_fl->l_whence);
     __get_user(fl->l_start, &target_fl->l_start);
     __get_user(fl->l_len, &target_fl->l_len);
@@ -6671,7 +6701,7 @@ static inline abi_long copy_to_user_flock64(abi_ulong target_flock_addr,
         return -TARGET_EFAULT;
     }
 
-    l_type = host_to_target_bitmask(fl->l_type, flock_tbl);
+    l_type = host_to_target_flock(fl->l_type);
     __put_user(l_type, &target_fl->l_type);
     __put_user(fl->l_whence, &target_fl->l_whence);
     __put_user(fl->l_start, &target_fl->l_start);
-- 
2.14.3
