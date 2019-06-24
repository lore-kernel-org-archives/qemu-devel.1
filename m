Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0792C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C562220674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C562220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfIdL-0008WD-2I
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hfIcL-0007c8-Jv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hfIcK-0005Mp-3X
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hfIcH-0005G1-Bi
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 02:38:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD010882F5;
 Mon, 24 Jun 2019 06:38:07 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77765608D0;
 Mon, 24 Jun 2019 06:37:55 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 14:37:33 +0800
Message-Id: <20190624063733.22079-3-peterx@redhat.com>
In-Reply-To: <20190624063733.22079-1-peterx@redhat.com>
References: <20190624063733.22079-1-peterx@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 24 Jun 2019 06:38:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] intel_iommu: Fix unexpected unmaps during
 global unmap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yan Zhao <yan.y.zhao@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
 Auger Eric <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This is an replacement work of Yan Zhao's patch:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg625340.html

vtd_address_space_unmap() will do proper page mask alignment to make
sure each IOTLB message will have correct masks for notification
messages (2^N-1), but sometimes it can be expanded to even supercede
the registered range.  That could lead to unexpected UNMAP of already
mapped regions in some other notifiers.

Instead of doing mindless expension of the start address and address
mask, we split the range into smaller ones and guarantee that each
small range will have correct masks (2^N-1) and at the same time we
should also try our best to generate as less IOTLB messages as
possible.

Reported-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[peterx: fixup mask generation algos and other touchups, introduce
 vtd_get_next_mask(), write commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 70 +++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 719ce19ab3..39cedf73b8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3363,11 +3363,31 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState =
*s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
=20
+static uint64_t vtd_get_next_mask(uint64_t start, uint64_t size, int gaw=
)
+{
+    /* Tries to find smallest mask from start first */
+    uint64_t rmask =3D start & -start, max_mask =3D 1ULL << gaw;
+
+    assert(size && gaw > 0 && gaw < 64);
+
+    /* Zero start, or too big */
+    if (!rmask || rmask > max_mask) {
+        rmask =3D max_mask;
+    }
+
+    /* If the start mask worked, then use it */
+    if (rmask <=3D size) {
+        return rmask;
+    }
+
+    /* Find the largest page mask from size */
+    return 1ULL << (63 - clz64(size));
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *=
n)
 {
-    IOMMUTLBEntry entry;
-    hwaddr size;
+    hwaddr size, remain;
     hwaddr start =3D n->start;
     hwaddr end =3D n->end;
     IntelIOMMUState *s =3D as->iommu_state;
@@ -3388,39 +3408,37 @@ static void vtd_address_space_unmap(VTDAddressSpa=
ce *as, IOMMUNotifier *n)
     }
=20
     assert(start <=3D end);
-    size =3D end - start;
+    size =3D remain =3D end - start + 1;
=20
-    if (ctpop64(size) !=3D 1) {
-        /*
-         * This size cannot format a correct mask. Let's enlarge it to
-         * suite the minimum available mask.
-         */
-        int n =3D 64 - clz64(size);
-        if (n > s->aw_bits) {
-            /* should not happen, but in case it happens, limit it */
-            n =3D s->aw_bits;
-        }
-        size =3D 1ULL << n;
+    while (remain > 0) {
+        IOMMUTLBEntry entry;
+        uint64_t mask =3D vtd_get_next_mask(start, remain, s->aw_bits);
+
+        assert(mask);
+
+        entry.iova =3D start;
+        entry.addr_mask =3D mask - 1;
+        entry.target_as =3D &address_space_memory;
+        entry.perm =3D IOMMU_NONE;
+        /* This field is meaningless for unmap */
+        entry.translated_addr =3D 0;
+
+        memory_region_notify_one(n, &entry);
+
+        start +=3D mask;
+        remain -=3D mask;
     }
=20
-    entry.target_as =3D &address_space_memory;
-    /* Adjust iova for the size */
-    entry.iova =3D n->start & ~(size - 1);
-    /* This field is meaningless for unmap */
-    entry.translated_addr =3D 0;
-    entry.perm =3D IOMMU_NONE;
-    entry.addr_mask =3D size - 1;
+    assert(!remain);
=20
     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
                              VTD_PCI_SLOT(as->devfn),
                              VTD_PCI_FUNC(as->devfn),
-                             entry.iova, size);
+                             n->start, size);
=20
-    map.iova =3D entry.iova;
-    map.size =3D entry.addr_mask;
+    map.iova =3D n->start;
+    map.size =3D size;
     iova_tree_remove(as->iova_tree, &map);
-
-    memory_region_notify_one(n, &entry);
 }
=20
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
--=20
2.21.0


