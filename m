Received: from eggs.gnu.org ([2001:4830:134:3::10]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1ew2VU-0004Kf-1f
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luwei.kang@intel.com>) id 1ew2VP-0002nX-7v
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:15:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:1138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luwei.kang@intel.com>)
	id 1ew2VO-0002mx-K6
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:15:30 -0400
From: Luwei Kang <luwei.kang@intel.com>
Date: Wed, 14 Mar 2018 03:26:31 +0800
Message-Id: <1520969191-18162-1-git-send-email-luwei.kang@intel.com>
Subject: [Qemu-devel] [PATCH] i386: Disable Intel PT if packets IP payloads
 have LIP values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Luwei Kang <luwei.kang@intel.com>

Intel processor trace should be disabled when
CPUID.(EAX=14H,ECX=0H).ECX.[bit31] is set.
Generated packets which contain IP payloads will have LIP
values when this bit is set, or IP payloads will have RIP
values.
Currently, The information of CPUID 14H is constant to make
live migration safty and this bit is always 0 in guest even
if host support LIP values.
Guest sees the bit is 0 will expect IP payloads with RIP
values, but the host CPU will generate IP payloads with
LIP values if this bit is set in HW.
To make sure the value of IP payloads correctly, Intel PT
should be disabled when bit[31] is set.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec1efd3a3c..3c0eda113e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -194,6 +194,8 @@
  * bit[02]: Support Single-Range Output scheme;
  */
 #define INTEL_PT_MINIMAL_ECX     0x7
+/* generated packets which contain IP payloads have LIP values */
+#define INTEL_PT_IP_LIP          (1 << 31)
 #define INTEL_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable address ranges */
 #define INTEL_PT_ADDR_RANGES_NUM_MASK 0x3
 #define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
@@ -4159,7 +4161,8 @@ static int x86_cpu_filter_features(X86CPU *cpu)
            ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
                                            INTEL_PT_ADDR_RANGES_NUM) ||
            ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
-                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {
+                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) ||
+           (ecx_0 & INTEL_PT_IP_LIP)) {
             /*
              * Processor Trace capabilities aren't configurable, so if the
              * host can't emulate the capabilities we report on
-- 
2.14.3
