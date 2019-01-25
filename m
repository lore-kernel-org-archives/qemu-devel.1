Received: from eggs.gnu.org ([209.51.188.92]:56595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsD-00031r-AX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsC-0007Ht-Dd
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzsC-0007H7-6Z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so9906239wrr.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:12 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:52 +0100
Message-Id: <20190125114155.32062-6-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 5/8] i386/kvm: hv-evmcs requires hv-vapic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Enlightened VMCS is enabled by writing to a field in VP assist page and
these require virtual APIC.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b373b4ac06..674c5dc185 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1074,7 +1074,7 @@ static int hv_report_missing_dep(X86CPU *cpu, const char *name,
         return 1;
     }
 
-    if (cpu->hyperv_all) {
+    if (cpu->hyperv_all && strcmp(name, "hv-evmcs")) {
         fprintf(stderr, "Hyper-V %s (requested by 'hv-all' cpu flag) "
                 "requires %s (is not supported by kernel)\n",
                 kvm_hyperv_properties[i].desc, kvm_hyperv_properties[j].desc);
@@ -1174,6 +1174,9 @@ static int hyperv_handle_properties(CPUState *cs,
     if (cpu->hyperv_synic && !cpu->hyperv_synic_kvm_only &&
         !cpu->hyperv_vpindex)
         r |= hv_report_missing_dep(cpu, "hv-synic", "hv-vpindex");
+    if (cpu->hyperv_evmcs && !cpu->hyperv_vapic) {
+        r |= hv_report_missing_dep(cpu, "hv-evmcs", "hv-vapic");
+    }
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-- 
2.20.1
