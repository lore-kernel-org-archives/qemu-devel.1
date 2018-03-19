Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19x-0002Wh-PN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19v-0006ys-16
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ey19u-0006yM-R5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 19 Mar 2018 17:12:55 -0300
Message-Id: <20180319201255.9317-8-ehabkost@redhat.com>
In-Reply-To: <20180319201255.9317-1-ehabkost@redhat.com>
References: <20180319201255.9317-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v3 7/7] i386: Disable Intel PT if packets IP
 payloads have LIP values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Luwei Kang <luwei.kang@intel.com>

From: Luwei Kang <luwei.kang@intel.com>

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
Message-Id: <1520969191-18162-1-git-send-email-luwei.kang@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 30b4af897b..4f62fe776d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -195,6 +195,8 @@
  * bit[02]: Support Single-Range Output scheme;
  */
 #define INTEL_PT_MINIMAL_ECX     0x7
+/* generated packets which contain IP payloads have LIP values */
+#define INTEL_PT_IP_LIP          (1 << 31)
 #define INTEL_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable address ranges */
 #define INTEL_PT_ADDR_RANGES_NUM_MASK 0x3
 #define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
@@ -4167,7 +4169,8 @@ static int x86_cpu_filter_features(X86CPU *cpu)
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
