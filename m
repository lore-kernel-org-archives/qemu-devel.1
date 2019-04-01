Received: from eggs.gnu.org ([209.51.188.92]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45y-0002d9-Mc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45x-0004F8-Cv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45w-00049c-PL
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L3QW7027506
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkq85hryj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:39 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:05 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:56 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-83-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 82/97] exec.c: Don't reallocate IOMMUNotifiers
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
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit 5601be3b01d73e21c09331599e2ce62df016ff94)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 4f5df07b6a..9bafcb155a 100644
--- a/exec.c
+++ b/exec.c
@@ -690,7 +690,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     int i;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
         if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
             break;
         }
@@ -698,7 +698,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     if (i == cpu->iommu_notifiers->len) {
         /* Not found, add a new entry at the end of the array */
         cpu->iommu_notifiers = g_array_set_size(cpu->iommu_notifiers, i + 1);
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_new0(TCGIOMMUNotifier, 1);
+        g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i) = notifier;
 
         notifier->mr = mr;
         notifier->iommu_idx = iommu_idx;
@@ -730,8 +731,9 @@ static void tcg_iommu_free_notifier_list(CPUState *cpu)
     TCGIOMMUNotifier *notifier;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = &g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier, i);
+        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
         memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
+        g_free(notifier);
     }
     g_array_free(cpu->iommu_notifiers, true);
 }
@@ -1000,7 +1002,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
         vmstate_register(NULL, cpu->cpu_index, cc->vmsd, cpu);
     }
 
-    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier));
+    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
 #endif
 }
 
-- 
2.17.1
