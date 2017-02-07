Received: from eggs.gnu.org ([2001:4830:134:3::10]:37952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cazDL-0004VG-9S
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cazDK-00082z-DZ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:25:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cazDK-00082r-7b
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:25:18 -0500
Date: Tue, 7 Feb 2017 14:25:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170207062509.GW5151@pxdev.xzpeter.org>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-9-git-send-email-peterx@redhat.com>
	<5ccb8227-6532-f330-8c6a-48b62a19e372@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ccb8227-6532-f330-8c6a-48b62a19e372@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/18] intel_iommu: fix trace for addr
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Feb 07, 2017 at 01:40:39PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> >Another patch to convert the DPRINTF() stuffs. This patch focuses on t=
he
> >address translation path and caching.
> >
> >Signed-off-by: Peter Xu<peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c | 84 ++++++++++++++++++++---------------------=
----------
> >  hw/i386/trace-events  |  7 +++++
> >  2 files changed, 39 insertions(+), 52 deletions(-)
>=20
> Similar to previous patch, this in fact a conversion not a fix.

I'll fix the subject.

>=20
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index d7b9a01..c672621 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -260,11 +260,9 @@ static void vtd_update_iotlb(IntelIOMMUState *s, =
uint16_t source_id,
> >      uint64_t *key =3D g_malloc(sizeof(*key));
> >      uint64_t gfn =3D vtd_get_iotlb_gfn(addr, level);
> >-    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
> >-                " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr,=
 slpte,
> >-                domain_id);
> >+    trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
> >      if (g_hash_table_size(s->iotlb) >=3D VTD_IOTLB_MAX_SIZE) {
> >-        VTD_DPRINTF(CACHE, "iotlb exceeds size limit, forced to reset=
");
> >+        trace_vtd_iotlb_reset("iotlb exceeds size limit");
> >          vtd_reset_iotlb(s);
> >      }
> >@@ -505,8 +503,7 @@ static int vtd_get_root_entry(IntelIOMMUState *s, =
uint8_t index,
> >      addr =3D s->root + index * sizeof(*re);
> >      if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re)=
)) {
> >-        VTD_DPRINTF(GENERAL, "error: fail to access root-entry at 0x%=
"PRIx64
> >-                    " + %"PRIu8, s->root, index);
> >+        trace_vtd_err("Fail to access root-entry");
>=20
> Looks like some information were removed which may be valuable for
> debugging, any reason for do this?

I was trying to avoid introducing unnecessary traces, and I did a
judgement on which one is important.

I'll keep all the fields printed and add new traces for each of them
if you really want it.

Thanks,

-- peterx
