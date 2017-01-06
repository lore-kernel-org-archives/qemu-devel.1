Received: from eggs.gnu.org ([2001:4830:134:3::10]:57306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLm5-0006kQ-0U
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLm1-00018u-UL
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:05:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPLm1-00018k-Pl
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:05:01 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF8EA61B9C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 04:05:01 +0000 (UTC)
Date: Fri, 6 Jan 2017 12:04:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170106040454.GC4135@pxdev.xzpeter.org>
References: <1483672082-5512-1-git-send-email-peterx@redhat.com>
	<1483672082-5512-3-git-send-email-peterx@redhat.com>
	<c297a765-a4e4-a6d3-de49-14ddb4af4149@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c297a765-a4e4-a6d3-de49-14ddb4af4149@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: allow migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, mst@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 06, 2017 at 11:42:30AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8806=E6=97=A5 11:08, Peter Xu wrote:
> >IOMMU needs to be migrated before all the PCI devices (in case there a=
re
> >devices that will request for address translation). So marking it with=
 a
> >priority higher than the default (which PCI devices and other belong).
> >Migration framework handled the rest.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c       | 21 ++++++++++++++++++++-
> >  include/migration/vmstate.h |  1 +
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index 5f3e351..ea9e526 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -1996,7 +1996,26 @@ static void vtd_iommu_notify_flag_changed(Memor=
yRegion *iommu,
> >  static const VMStateDescription vtd_vmstate =3D {
> >      .name =3D "iommu-intel",
> >-    .unmigratable =3D 1,
> >+    .version_id =3D 1,
> >+    .minimum_version_id =3D 1,
> >+    .priority =3D MIG_PRI_IOMMU,
> >+    .fields =3D (VMStateField[]) {
> >+        VMSTATE_UINT64(root, IntelIOMMUState),
> >+        VMSTATE_UINT64(intr_root, IntelIOMMUState),
> >+        VMSTATE_UINT64(iq, IntelIOMMUState),
> >+        VMSTATE_UINT32(intr_size, IntelIOMMUState),
> >+        VMSTATE_UINT16(iq_head, IntelIOMMUState),
> >+        VMSTATE_UINT16(iq_tail, IntelIOMMUState),
> >+        VMSTATE_UINT16(iq_size, IntelIOMMUState),
> >+        VMSTATE_UINT16(next_frcd_reg, IntelIOMMUState),
> >+        VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
> >+        VMSTATE_BOOL(root_extended, IntelIOMMUState),
> >+        VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
> >+        VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
> >+        VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> >+        VMSTATE_BOOL(intr_eime, IntelIOMMUState),
> >+        VMSTATE_END_OF_LIST()
> >+    }
> >  };
>=20
> Looks like register values were missed (e.g csr[]) ?

Oops, I missed the most important thing. :)

And obviously it even escaped from smoke test... Thanks Jason. Will
repost.

-- peterx
