Received: from eggs.gnu.org ([2001:4830:134:3::10]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckzg6-0000Om-Tl
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckzg5-0004US-W9
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:56:23 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ckzg5-0004UN-RJ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:56:21 -0500
Received: by mail-qk0-x243.google.com with SMTP id v125so9349688qkh.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:56:21 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  7 Mar 2017 07:56:09 +1100
Message-Id: <20170306205609.6525-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] target/alpha: Take BQL around clock
 manipulations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
This is similar to the patch that I saw go by for MIPS.

I hadn't noticed any problems caused by this lack of locking.  This may
be because interrupts cannot be delivered while in PALmode while these
registers are being manipulated.  However, it's always better to obey
the rules, right?


r~
---
 target/alpha/sys_helper.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 652195d..6feb30b 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -28,11 +28,14 @@
 uint64_t helper_load_pcc(CPUAlphaState *env)
 {
 #ifndef CONFIG_USER_ONLY
+    uint64_t pcc;
     /* In system mode we have access to a decent high-resolution clock.
        In order to make OS-level time accounting work with the RPCC,
        present it with a well-timed clock fixed at 250MHz.  */
-    return (((uint64_t)env->pcc_ofs << 32)
-            | (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2));
+    qemu_mutex_lock_iothread();
+    pcc = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2;
+    qemu_mutex_unlock_iothread();
+    return deposit64(pcc, 32, 32, env->pcc_ofs);
 #else
     /* In user-mode, QEMU_CLOCK_VIRTUAL doesn't exist.  Just pass through the host cpu
        clock ticks.  Also, don't bother taking PCC_OFS into account.  */
@@ -68,24 +71,34 @@ void helper_halt(uint64_t restart)
 
 uint64_t helper_get_vmtime(void)
 {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t ret;
+    qemu_mutex_lock_iothread();
+    ret = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    qemu_mutex_unlock_iothread();
+    return ret;
 }
 
 uint64_t helper_get_walltime(void)
 {
-    return qemu_clock_get_ns(rtc_clock);
+    uint64_t ret;
+    qemu_mutex_lock_iothread();
+    ret = qemu_clock_get_ns(rtc_clock);
+    qemu_mutex_unlock_iothread();
+    return ret;
 }
 
 void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
 {
     AlphaCPU *cpu = alpha_env_get_cpu(env);
 
+    qemu_mutex_lock_iothread();
     if (expire) {
         env->alarm_expire = expire;
         timer_mod(cpu->alarm_timer, expire);
     } else {
         timer_del(cpu->alarm_timer);
     }
+    qemu_mutex_unlock_iothread();
 }
 
 #endif /* CONFIG_USER_ONLY */
-- 
2.9.3
