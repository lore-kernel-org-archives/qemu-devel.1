Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXPaB-0007dT-TJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXPa6-00007G-JS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXPa6-000069-Ba
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:06 -0500
Received: by mail-wm1-x342.google.com with SMTP id c126so2096223wmh.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:55:06 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 13 Dec 2018 11:55:02 +0000
Message-Id: <20181213115503.24188-2-alex.bennee@linaro.org>
In-Reply-To: <20181213115503.24188-1-alex.bennee@linaro.org>
References: <20181213115503.24188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/2] target/arm: kvm64 make guest debug AA32
 break point aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Omair Javaid <omair.javaid@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

When supported by the hardware we can run AA32 guests or even AA64 EL1
code with AA32 EL0 mode code. Inserting a AA64 break point into AA32
code tends to break things. This is especially acute with gdb as it
inserts temporary breakpoints when stepping through code.

The heuristic of checking the current mode works but it's not perfect.
A user could be placing a break point in code after a mode switch and
that will still fail. However there doesn't seem to be a way to force
a hbreak by default. According to "set breakpoint auto-hw on":

  This is the default behavior. When GDB sets a breakpoint, it will try
  to use the target memory map to decide if software or hardware
  breakpoint must be used.

Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Omair Javaid <omair.javaid@linaro.org>
---
 target/arm/kvm64.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0a502091e7..dd564a59b7 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -989,14 +989,20 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
-/* C6.6.29 BRK instruction */
+/* BRK (A64) and BKPT (A32) instructions */
 static const uint32_t brk_insn = 0xd4200000;
+static const uint32_t bkpt_insn = 0xe1200070;
 
 int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
+    CPUARMState *env = &ARM_CPU(cs)->env;
+    int el = arm_current_el(env);
+    bool is_aa64 = arm_el_is_aa64(env, el);
+    const uint32_t *bpi = is_aa64 ? &brk_insn : &bkpt_insn;
+
     if (have_guest_debug) {
         if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
-            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
+            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)bpi, 4, 1)) {
             return -EINVAL;
         }
         return 0;
@@ -1012,7 +1018,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 
     if (have_guest_debug) {
         if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
-            brk != brk_insn ||
+            !(brk == brk_insn || brk == bkpt_insn) ||
             cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
             return -EINVAL;
         }
@@ -1055,6 +1061,7 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
             return false;
         }
         break;
+    case EC_AA32_BKPT:
     case EC_AA64_BKPT:
         if (kvm_find_sw_breakpoint(cs, env->pc)) {
             return true;
-- 
2.17.1
