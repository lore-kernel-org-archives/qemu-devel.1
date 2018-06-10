Received: from eggs.gnu.org ([2001:4830:134:3::10]:40945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqel-0003QH-LY
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqej-0003rY-Sm
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:39 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqej-0003rN-KT
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:37 -0400
Received: by mail-pf0-x244.google.com with SMTP id y5-v6so7584032pfn.4
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:32 -1000
Message-Id: <20180610030220.3777-61-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 060/108] linux-user: Split out getdents,
 getdents64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 329 ++++++++++++++++++++++---------------------
 1 file changed, 170 insertions(+), 159 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5f21658a8..600702ea3e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8121,6 +8121,170 @@ IMPL(futimesat)
 }
 #endif
 
+#ifdef TARGET_NR_getdents
+IMPL(getdents)
+{
+    abi_long ret;
+# ifdef EMULATE_GETDENTS_WITH_GETDENTS
+#  if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
+    struct target_dirent *target_dirp;
+    struct linux_dirent *dirp;
+    abi_long count = arg3;
+
+    dirp = g_try_malloc(count);
+    if (!dirp) {
+        return -TARGET_ENOMEM;
+    }
+
+    ret = get_errno(sys_getdents(arg1, dirp, count));
+    if (!is_error(ret)) {
+        struct linux_dirent *de;
+        struct target_dirent *tde;
+        int len = ret;
+        int reclen, treclen;
+        int count1, tnamelen;
+
+        count1 = 0;
+        de = dirp;
+        target_dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
+        if (!target_dirp) {
+            return -TARGET_EFAULT;
+        }
+        tde = target_dirp;
+        while (len > 0) {
+            reclen = de->d_reclen;
+            tnamelen = reclen - offsetof(struct linux_dirent, d_name);
+            assert(tnamelen >= 0);
+            treclen = tnamelen + offsetof(struct target_dirent, d_name);
+            assert(count1 + treclen <= count);
+            tde->d_reclen = tswap16(treclen);
+            tde->d_ino = tswapal(de->d_ino);
+            tde->d_off = tswapal(de->d_off);
+            memcpy(tde->d_name, de->d_name, tnamelen);
+            de = (struct linux_dirent *)((char *)de + reclen);
+            len -= reclen;
+            tde = (struct target_dirent *)((char *)tde + treclen);
+            count1 += treclen;
+        }
+        ret = count1;
+        unlock_user(target_dirp, arg2, ret);
+    }
+    g_free(dirp);
+#  else
+    struct linux_dirent *dirp;
+    abi_long count = arg3;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
+    if (!dirp) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sys_getdents(arg1, dirp, count));
+    if (!is_error(ret)) {
+        struct linux_dirent *de = dirp;
+        int len = ret;
+        int reclen;
+
+        while (len > 0) {
+            reclen = de->d_reclen;
+            if (reclen > len) {
+                break;
+            }
+            de->d_reclen = tswap16(reclen);
+            tswapls(&de->d_ino);
+            tswapls(&de->d_off);
+            de = (struct linux_dirent *)((char *)de + reclen);
+            len -= reclen;
+        }
+    }
+    unlock_user(dirp, arg2, ret);
+#  endif
+# else
+    /* Implement getdents in terms of getdents64 */
+    struct linux_dirent64 *dirp;
+    abi_long count = arg3;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
+    if (!dirp) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sys_getdents64(arg1, dirp, count));
+    if (!is_error(ret)) {
+        /* Convert the dirent64 structs to target dirent.  We do this
+         * in-place, since we can guarantee that a target_dirent is no
+         * larger than a dirent64; however this means we have to be
+         * careful to read everything before writing in the new format.
+         */
+        struct linux_dirent64 *de = dirp;
+        struct target_dirent *tde = (struct target_dirent *)dirp;
+        int len = ret;
+        int tlen = 0;
+
+        while (len > 0) {
+            int namelen, treclen;
+            int reclen = de->d_reclen;
+            uint64_t ino = de->d_ino;
+            int64_t off = de->d_off;
+            uint8_t type = de->d_type;
+
+            namelen = strlen(de->d_name);
+            treclen = offsetof(struct target_dirent, d_name) + namelen + 2;
+            treclen = QEMU_ALIGN_UP(treclen, sizeof(abi_long));
+
+            memmove(tde->d_name, de->d_name, namelen + 1);
+            tde->d_ino = tswapal(ino);
+            tde->d_off = tswapal(off);
+            tde->d_reclen = tswap16(treclen);
+            /* The target_dirent type is in what was formerly a padding
+             * byte at the end of the structure:
+             */
+            *(((char *)tde) + treclen - 1) = type;
+
+            de = (struct linux_dirent64 *)((char *)de + reclen);
+            tde = (struct target_dirent *)((char *)tde + treclen);
+            len -= reclen;
+            tlen += treclen;
+        }
+        ret = tlen;
+    }
+    unlock_user(dirp, arg2, ret);
+# endif
+    return ret;
+}
+#endif
+
+#if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
+IMPL(getdents64)
+{
+    struct linux_dirent64 *dirp;
+    abi_long count = arg3;
+    abi_long ret;
+
+    dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
+    if (!dirp) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sys_getdents64(arg1, dirp, count));
+    if (!is_error(ret)) {
+        struct linux_dirent64 *de = dirp;
+        int len = ret;
+
+        while (len > 0) {
+            int reclen = de->d_reclen;
+            if (reclen > len) {
+                break;
+            }
+            de->d_reclen = tswap16(reclen);
+            tswap64s((uint64_t *)&de->d_ino);
+            tswap64s((uint64_t *)&de->d_off);
+            de = (struct linux_dirent64 *)((char *)de + reclen);
+            len -= reclen;
+        }
+    }
+    unlock_user(dirp, arg2, ret);
+    return ret;
+}
+#endif /* TARGET_NR_getdents64 */
+
 IMPL(getitimer)
 {
     struct itimerval value;
@@ -10485,165 +10649,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getdents
-    case TARGET_NR_getdents:
-#ifdef EMULATE_GETDENTS_WITH_GETDENTS
-#if TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
-        {
-            struct target_dirent *target_dirp;
-            struct linux_dirent *dirp;
-            abi_long count = arg3;
-
-            dirp = g_try_malloc(count);
-            if (!dirp) {
-                return -TARGET_ENOMEM;
-            }
-
-            ret = get_errno(sys_getdents(arg1, dirp, count));
-            if (!is_error(ret)) {
-                struct linux_dirent *de;
-		struct target_dirent *tde;
-                int len = ret;
-                int reclen, treclen;
-		int count1, tnamelen;
-
-		count1 = 0;
-                de = dirp;
-                if (!(target_dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
-                    return -TARGET_EFAULT;
-		tde = target_dirp;
-                while (len > 0) {
-                    reclen = de->d_reclen;
-                    tnamelen = reclen - offsetof(struct linux_dirent, d_name);
-                    assert(tnamelen >= 0);
-                    treclen = tnamelen + offsetof(struct target_dirent, d_name);
-                    assert(count1 + treclen <= count);
-                    tde->d_reclen = tswap16(treclen);
-                    tde->d_ino = tswapal(de->d_ino);
-                    tde->d_off = tswapal(de->d_off);
-                    memcpy(tde->d_name, de->d_name, tnamelen);
-                    de = (struct linux_dirent *)((char *)de + reclen);
-                    len -= reclen;
-                    tde = (struct target_dirent *)((char *)tde + treclen);
-		    count1 += treclen;
-                }
-		ret = count1;
-                unlock_user(target_dirp, arg2, ret);
-            }
-            g_free(dirp);
-        }
-#else
-        {
-            struct linux_dirent *dirp;
-            abi_long count = arg3;
-
-            if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
-                return -TARGET_EFAULT;
-            ret = get_errno(sys_getdents(arg1, dirp, count));
-            if (!is_error(ret)) {
-                struct linux_dirent *de;
-                int len = ret;
-                int reclen;
-                de = dirp;
-                while (len > 0) {
-                    reclen = de->d_reclen;
-                    if (reclen > len)
-                        break;
-                    de->d_reclen = tswap16(reclen);
-                    tswapls(&de->d_ino);
-                    tswapls(&de->d_off);
-                    de = (struct linux_dirent *)((char *)de + reclen);
-                    len -= reclen;
-                }
-            }
-            unlock_user(dirp, arg2, ret);
-        }
-#endif
-#else
-        /* Implement getdents in terms of getdents64 */
-        {
-            struct linux_dirent64 *dirp;
-            abi_long count = arg3;
-
-            dirp = lock_user(VERIFY_WRITE, arg2, count, 0);
-            if (!dirp) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(sys_getdents64(arg1, dirp, count));
-            if (!is_error(ret)) {
-                /* Convert the dirent64 structs to target dirent.  We do this
-                 * in-place, since we can guarantee that a target_dirent is no
-                 * larger than a dirent64; however this means we have to be
-                 * careful to read everything before writing in the new format.
-                 */
-                struct linux_dirent64 *de;
-                struct target_dirent *tde;
-                int len = ret;
-                int tlen = 0;
-
-                de = dirp;
-                tde = (struct target_dirent *)dirp;
-                while (len > 0) {
-                    int namelen, treclen;
-                    int reclen = de->d_reclen;
-                    uint64_t ino = de->d_ino;
-                    int64_t off = de->d_off;
-                    uint8_t type = de->d_type;
-
-                    namelen = strlen(de->d_name);
-                    treclen = offsetof(struct target_dirent, d_name)
-                        + namelen + 2;
-                    treclen = QEMU_ALIGN_UP(treclen, sizeof(abi_long));
-
-                    memmove(tde->d_name, de->d_name, namelen + 1);
-                    tde->d_ino = tswapal(ino);
-                    tde->d_off = tswapal(off);
-                    tde->d_reclen = tswap16(treclen);
-                    /* The target_dirent type is in what was formerly a padding
-                     * byte at the end of the structure:
-                     */
-                    *(((char *)tde) + treclen - 1) = type;
-
-                    de = (struct linux_dirent64 *)((char *)de + reclen);
-                    tde = (struct target_dirent *)((char *)tde + treclen);
-                    len -= reclen;
-                    tlen += treclen;
-                }
-                ret = tlen;
-            }
-            unlock_user(dirp, arg2, ret);
-        }
-#endif
-        return ret;
-#endif /* TARGET_NR_getdents */
-#if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
-    case TARGET_NR_getdents64:
-        {
-            struct linux_dirent64 *dirp;
-            abi_long count = arg3;
-            if (!(dirp = lock_user(VERIFY_WRITE, arg2, count, 0)))
-                return -TARGET_EFAULT;
-            ret = get_errno(sys_getdents64(arg1, dirp, count));
-            if (!is_error(ret)) {
-                struct linux_dirent64 *de;
-                int len = ret;
-                int reclen;
-                de = dirp;
-                while (len > 0) {
-                    reclen = de->d_reclen;
-                    if (reclen > len)
-                        break;
-                    de->d_reclen = tswap16(reclen);
-                    tswap64s((uint64_t *)&de->d_ino);
-                    tswap64s((uint64_t *)&de->d_off);
-                    de = (struct linux_dirent64 *)((char *)de + reclen);
-                    len -= reclen;
-                }
-            }
-            unlock_user(dirp, arg2, ret);
-        }
-        return ret;
-#endif /* TARGET_NR_getdents64 */
 #if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
 # ifdef TARGET_NR_poll
     case TARGET_NR_poll:
@@ -12939,6 +12944,12 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(ftruncate);
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
+#endif
+#ifdef TARGET_NR_getdents
+        SYSCALL(getdents);
+#endif
+#if defined(TARGET_NR_getdents64) && defined(__NR_getdents64)
+        SYSCALL(getdents64);
 #endif
         SYSCALL(getitimer);
 #ifdef TARGET_NR_getpeername
-- 
2.17.1
