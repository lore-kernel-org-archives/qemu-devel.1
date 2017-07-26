Received: from eggs.gnu.org ([2001:4830:134:3::10]:59468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRB6-0003uR-CE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRB5-0003m6-Js
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daRB5-0003lg-EL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:36:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 26 Jul 2017 15:36:44 -0300
Message-Id: <20170726183646.14088-2-ehabkost@redhat.com>
In-Reply-To: <20170726183646.14088-1-ehabkost@redhat.com>
References: <20170726183646.14088-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] target/i386: Use host_vendor_fms() in
 max_x86_cpu_initfn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

The existing code duplicated the logic in host_vendor_fms(), so
reuse the helper function instead.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170712162058.10538-3-ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 89f5fb7..156dc95 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1636,13 +1636,8 @@ static void max_x86_cpu_initfn(Object *obj)
         X86CPUDefinition host_cpudef = { };
         uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
 
-        host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
-        x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
-
-        host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
-        host_cpudef.family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
-        host_cpudef.model = ((eax >> 4) & 0x0F) | ((eax & 0xF0000) >> 12);
-        host_cpudef.stepping = eax & 0x0F;
+        host_vendor_fms(host_cpudef.vendor, &host_cpudef.family,
+                        &host_cpudef.model, &host_cpudef.stepping);
 
         cpu_x86_fill_model_id(host_cpudef.model_id);
 
-- 
2.9.4
