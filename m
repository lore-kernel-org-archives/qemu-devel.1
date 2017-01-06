Received: from eggs.gnu.org ([2001:4830:134:3::10]:60145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPOiL-0006eF-Ri
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPOiI-0003ls-Nn
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:13:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPOiI-0003lg-I3
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:13:22 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D160C049D5B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 07:13:22 +0000 (UTC)
Date: Fri, 6 Jan 2017 15:13:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170106071314.GD4135@pxdev.xzpeter.org>
References: <1483675573-12636-1-git-send-email-peterx@redhat.com>
	<1483675573-12636-3-git-send-email-peterx@redhat.com>
	<f62ec203-a644-9102-f5e6-4f41cca60d80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f62ec203-a644-9102-f5e6-4f41cca60d80@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel_iommu: allow migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jan 06, 2017 at 03:05:47PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8806=E6=97=A5 12:06, Peter Xu wrote:
> >IOMMU needs to be migrated before all the PCI devices (in case there a=
re
> >devices that will request for address translation). So marking it with=
 a
> >priority higher than the default (which PCI devices and other belong).
> >Migration framework handled the rest.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c       | 22 +++++++++++++++++++++-
> >  include/migration/vmstate.h |  1 +
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index 5f3e351..119217b 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -1996,7 +1996,27 @@ static void vtd_iommu_notify_flag_changed(Memor=
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
> >+        VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
>=20
> Do we need migrate wmask, w1cmask, womask too?

Should not. Although we are using arrays here, they should be only
configured during vtd_define_*() and should be constant values for the
whole lifecycle of the device (which is mostly decided by the spec).

Thanks,

-- peterx
