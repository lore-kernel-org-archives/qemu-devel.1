Received: from eggs.gnu.org ([209.51.188.92]:56519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkble-00068t-KW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblQ-0005t3-L2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:26 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkblO-0005jf-0s
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:18 -0500
Received: by mail-pf1-x443.google.com with SMTP id q1so7204236pfi.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:18 +1100
Message-Id: <20190118213122.22865-45-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 45/49] linux-user: Split out times
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
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  3 ---
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index bd3301a72f..25d5aaccd1 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -204,6 +204,7 @@ SYSCALL_DEF(syncfs, ARG_DEC);
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
+SYSCALL_DEF(times, ARG_PTR);
 #ifdef TARGET_NR_umount
 SYSCALL_DEF(umount, ARG_STR);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 58c0a22300..09a0306406 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -468,6 +468,31 @@ SYSCALL_IMPL(nice)
 }
 #endif
 
+SYSCALL_IMPL(times)
+{
+    abi_ulong target_buf = arg1;
+    struct tms tms;
+    abi_long ret;
+
+    ret = get_errno(times(&tms));
+    if (target_buf) {
+        struct target_tms *tmsp = lock_user(VERIFY_WRITE, target_buf,
+                                            sizeof(struct target_tms), 0);
+        if (!tmsp) {
+            return -TARGET_EFAULT;
+        }
+        tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
+        tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
+        tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
+        tmsp->tms_cstime = tswapal(host_to_target_clock_t(tms.tms_cstime));
+        unlock_user(tmsp, target_buf, sizeof(struct target_tms));
+    }
+    if (!is_error(ret)) {
+        ret = host_to_target_clock_t(ret);
+    }
+    return ret;
+}
+
 /*
  * Map host to target signal numbers for the wait family of syscalls.
  * Assume all other status bits are the same.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3a322a61ca..d0bf339281 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5293,24 +5293,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_times:
-        {
-            struct target_tms *tmsp;
-            struct tms tms;
-            ret = get_errno(times(&tms));
-            if (arg1) {
-                tmsp = lock_user(VERIFY_WRITE, arg1, sizeof(struct target_tms), 0);
-                if (!tmsp)
-                    return -TARGET_EFAULT;
-                tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
-                tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
-                tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
-                tmsp->tms_cstime = tswapal(host_to_target_clock_t(tms.tms_cstime));
-            }
-            if (!is_error(ret))
-                ret = host_to_target_clock_t(ret);
-        }
-        return ret;
     case TARGET_NR_acct:
         if (arg1 == 0) {
             ret = get_errno(acct(NULL));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index ac25e13bfa..4ea11f162e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1290,9 +1290,6 @@
 #ifdef TARGET_NR_timerfd_settime
 { TARGET_NR_timerfd_settime, "timerfd_settime" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_times
-{ TARGET_NR_times, "times" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_tkill
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
-- 
2.17.2
