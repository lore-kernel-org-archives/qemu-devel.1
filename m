Received: from eggs.gnu.org ([209.51.188.92]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMD-0008Gg-OF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMA-0003j6-PN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:57 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMA-0003a4-CL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z5so7630465wrt.11
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:38 +0000
Message-Id: <20190201160653.13829-33-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/47] exec.c: Don't reallocate IOMMUNotifiers
 that are in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The tcg_register_iommu_notifier() code has a GArray of
TCGIOMMUNotifier structs which it has registered by passing
memory_region_register_iommu_notifier() a pointer to the embedded
IOMMUNotifier field. Unfortunately, if we need to enlarge the
array via g_array_set_size() this can cause a realloc(), which
invalidates the pointer that memory_region_register_iommu_notifier()
put into the MemoryRegion's iommu_notify list. This can result
in segfaults.

Switch the GArray to holding pointers to the TCGIOMMUNotifier
structs, so that we can individually allocate and free them.

Cc: qemu-stable@nongnu.org
Fixes: 1f871c5e6b0f30644a60a ("exec.c: Handle IOMMUs in address_space_translate_for_iotlb()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190128174241.5860-1-peter.maydell@linaro.org
---
 exec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index da3e635f91b..25f3938a271 100644
--- a/exec.c
+++ b/exec.c
@@ -665,7 +665,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     int i;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
         if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
             break;
         }
@@ -673,7 +673,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     if (i == cpu->iommu_notifiers->len) {
         /* Not found, add a new entry at the end of the array */
         cpu->iommu_notifiers = g_array_set_size(cpu->iommu_notifiers, i + 1);
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_new0(TCGIOMMUNotifier, 1);
+        g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i) = notifier;
 
         notifier->mr = mr;
         notifier->iommu_idx = iommu_idx;
@@ -705,8 +706,9 @@ static void tcg_iommu_free_notifier_list(CPUState *cpu)
     TCGIOMMUNotifier *notifier;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
         memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
+        g_free(notifier);
     }
     g_array_free(cpu->iommu_notifiers, true);
 }
@@ -976,7 +978,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
         vmstate_register(NULL, cpu->cpu_index, cc->vmsd, cpu);
     }
 
-    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier));
+    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
 #endif
 }
 
-- 
2.20.1
