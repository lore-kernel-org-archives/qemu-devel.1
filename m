Received: from eggs.gnu.org ([209.51.188.92]:32888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goAvn-0004hJ-PL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goAvm-0006Yd-SU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:42:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goAvm-0006WK-Km
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:42:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id z5so19013510wrt.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:42:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 17:42:41 +0000
Message-Id: <20190128174241.5860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] exec.c: Don't reallocate IOMMUNotifiers that
 are in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

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
---
I don't know why I've suddenly started running into this; possibly
it's because of a recent Ubuntu upgrade and so a newer glibc.
---
 exec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 895449f9261..cf6bc72c976 100644
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
