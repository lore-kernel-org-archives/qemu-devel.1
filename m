Received: from eggs.gnu.org ([2001:4830:134:3::10]:45420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8f8x-0001gh-K6
	for qemu-devel@nongnu.org; Wed, 10 May 2017 23:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8f8t-0001Gu-NW
	for qemu-devel@nongnu.org; Wed, 10 May 2017 23:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8f8t-0001Fp-Gi
	for qemu-devel@nongnu.org; Wed, 10 May 2017 23:51:55 -0400
Date: Thu, 11 May 2017 11:51:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170511035143.GD28293@pxdev.xzpeter.org>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-10-git-send-email-peterx@redhat.com>
	<722b6658-0169-584b-0d4d-e8f9d096be34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <722b6658-0169-584b-0d4d-e8f9d096be34@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/12] intel_iommu: allow dev-iotlb
 context entry conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>, yi.l.liu@intel.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, May 11, 2017 at 10:56:42AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8810=E6=97=A5 16:01, Peter Xu wrote:
> >When device-iotlb is not specified, we should fail this check.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index 05ae631..1a7eba2 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -836,6 +836,8 @@ static int vtd_dev_to_context_entry(IntelIOMMUStat=
e *s, uint8_t bus_num,
> >  {
> >      VTDRootEntry re;
> >      int ret_fr;
> >+    bool type_fail =3D false;
> >+    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> >      ret_fr =3D vtd_get_root_entry(s, bus_num, &re);
> >      if (ret_fr) {
> >@@ -872,10 +874,19 @@ static int vtd_dev_to_context_entry(IntelIOMMUSt=
ate *s, uint8_t bus_num,
> >      } else {
> >          switch (vtd_ce_get_type(ce)) {
> >          case VTD_CONTEXT_TT_MULTI_LEVEL:
> >-            /* fall through */
> >+            /* Always supported */
> >+            break;
> >          case VTD_CONTEXT_TT_DEV_IOTLB:
> >+            if (!x86_iommu->dt_supported) {
> >+                type_fail =3D true;
> >+            }
> >              break;
> >          default:
> >+            /* Unknwon type */
> >+            type_fail =3D true;
> >+            break;
> >+        }
> >+        if (type_fail) {
> >              trace_vtd_ce_invalid(ce->hi, ce->lo);
> >              return -VTD_FR_CONTEXT_ENTRY_INV;
> >          }
>=20
> How about e.g exclude the type if not supported in vtd_ce_get_type()? T=
his
> looks better than using something like type_fail.

(after a quick discussion with Jason offlist)

I'll keep current vtd_ce_get_type() since there are other places that
used it, and introduce another vtd_ce_type_check() to make codes more
elegant (and get rid of type_fail variable). Thanks.

--=20
Peter Xu
