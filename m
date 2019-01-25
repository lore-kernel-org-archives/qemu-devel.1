Received: from eggs.gnu.org ([209.51.188.92]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsI-00036m-5V
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsG-0007Py-7V
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzsF-0007L2-Lz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so4609294wmh.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:15 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:54 +0100
Message-Id: <20190125114155.32062-8-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 7/8] i386/kvm: hv-tlbflush/ipi require
 hv-vpindex
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

The corresponding hypercalls require using VP indexes.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 7461bf05dd..14d74ca9c7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1183,6 +1183,12 @@ static int hyperv_handle_properties(CPUState *cs,
     if (cpu->hyperv_stimer && !cpu->hyperv_time) {
         r |= hv_report_missing_dep(cpu, "hv-stimer", "hv-time");
     }
+    if (cpu->hyperv_tlbflush && !cpu->hyperv_vpindex) {
+        r |= hv_report_missing_dep(cpu, "hv-tlbflush", "hv-vpindex");
+    }
+    if (cpu->hyperv_ipi && !cpu->hyperv_vpindex) {
+        r |= hv_report_missing_dep(cpu, "hv-ipi", "hv-vpindex");
+    }
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-- 
2.20.1
