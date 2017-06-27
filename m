Received: from eggs.gnu.org ([2001:4830:134:3::10]:51367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPt-000500-OU
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPmPs-00037B-RO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPmPs-00036z-LX
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:04:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8278A8321
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:04:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 17:03:36 +0800
Message-Id: <1498554219-4942-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1498554219-4942-1-git-send-email-peterx@redhat.com>
References: <1498554219-4942-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 5/8] intel_iommu: hmp: allow "-c" for "info
 iommu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

New parameter "-c" for it to clear statistics. Other platforms can
selectively support this (though none yet).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands-info.hx  | 4 ++--
 hw/i386/intel_iommu.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index a39243d..2add941 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -803,8 +803,8 @@ ETEXI
 
     {
         .name       = "iommu",
-        .args_type  = "",
-        .params     = "",
+        .args_type  = "clear_stats:-c",
+        .params     = "[-c]",
         .help       = "Display system IOMMU information",
         .cmd        = hmp_info_iommu,
     },
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 45d0919..72b39f0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3008,6 +3008,7 @@ static void vtd_info_dump(X86IOMMUState *x86_iommu, Monitor *mon,
                           const QDict *qdict)
 {
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(x86_iommu);
+    bool clear_stats = qdict_get_try_bool(qdict, "clear_stats", false);
 
     DUMP("Version: %d\n", 1);
     DUMP("Cap: 0x%"PRIx64"\n", s->cap);
@@ -3047,6 +3048,10 @@ static void vtd_info_dump(X86IOMMUState *x86_iommu, Monitor *mon,
     DUMP("Misc: next_frr=%d, context_gen=%d, buggy_eim=%d\n",
          s->next_frcd_reg, s->context_cache_gen, s->buggy_eim);
     DUMP("      iotlb_size=%d\n", g_hash_table_size(s->iotlb));
+
+    if (clear_stats) {
+        vtd_reset_stats(s);
+    }
 }
 #undef DUMP
 
-- 
2.7.4
