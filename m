Received: from eggs.gnu.org ([209.51.188.92]:56616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsF-00033t-E7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gmzsE-0007Ki-CT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gmzsD-0007JW-SG
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 06:42:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so9925428wrs.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 03:42:13 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 25 Jan 2019 12:41:53 +0100
Message-Id: <20190125114155.32062-7-vkuznets@redhat.com>
In-Reply-To: <20190125114155.32062-1-vkuznets@redhat.com>
References: <20190125114155.32062-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 6/8] i386/kvm: hv-stimer requires hv-time
 and hv-synic
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

Synthetic timers operate in hv-time time and Windows won't use these
without SynIC.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 674c5dc185..7461bf05dd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1177,6 +1177,12 @@ static int hyperv_handle_properties(CPUState *cs,
     if (cpu->hyperv_evmcs && !cpu->hyperv_vapic) {
         r |= hv_report_missing_dep(cpu, "hv-evmcs", "hv-vapic");
     }
+    if (cpu->hyperv_stimer && !cpu->hyperv_synic) {
+        r |= hv_report_missing_dep(cpu, "hv-stimer", "hv-synic");
+    }
+    if (cpu->hyperv_stimer && !cpu->hyperv_time) {
+        r |= hv_report_missing_dep(cpu, "hv-stimer", "hv-time");
+    }
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-- 
2.20.1
