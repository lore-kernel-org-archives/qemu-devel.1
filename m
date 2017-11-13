Received: from eggs.gnu.org ([2001:4830:134:3::10]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSL-00049m-EV
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSF-0007hp-LZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSF-0007Yd-El
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS5-00023P-FS
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:39 +0000
Message-Id: <1510582304-27058-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 4/9] qom: move CPUClass.tcg_initialize to a
 global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Emilio G. Cota" <cota@braap.org>

55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
introduces a per-CPUClass bool that we check so that the target CPU
is initialized for TCG only once. This works well except when
we end up creating more than one CPUClass, in which case we end
up incorrectly initializing TCG more than once, i.e. once for
each CPUClass.

This can be replicated with:
  $ aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -smp 6 \
      -global driver=xlnx,,zynqmp,property=has_rpu,value=on
In this case the class name of the "RPUs" is prefixed by "cortex-r5-",
whereas the "regular" CPUs are prefixed by "cortex-a53-". This
results in two CPUClass instances being created.

Fix it by introducing a static variable, so that only the first
target CPU being initialized will initialize the target-dependent
part of TCG, regardless of CPUClass instances.

Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1510343626-25861-2-git-send-email-cota@braap.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qom/cpu.h | 1 -
 exec.c            | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index fa4b0c9..c2fa151 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -209,7 +209,6 @@ typedef struct CPUClass {
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
-    bool tcg_initialized;
 } CPUClass;
 
 #ifdef HOST_WORDS_BIGENDIAN
diff --git a/exec.c b/exec.c
index 97a24a8..8b579c0 100644
--- a/exec.c
+++ b/exec.c
@@ -792,11 +792,12 @@ void cpu_exec_initfn(CPUState *cpu)
 void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    static bool tcg_target_initialized;
 
     cpu_list_add(cpu);
 
-    if (tcg_enabled() && !cc->tcg_initialized) {
-        cc->tcg_initialized = true;
+    if (tcg_enabled() && !tcg_target_initialized) {
+        tcg_target_initialized = true;
         cc->tcg_initialize();
     }
 
-- 
2.7.4
