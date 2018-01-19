Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecNWi-0006U1-IU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecNWf-0007bn-Ew
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecNWf-0007bN-6W
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:39:33 -0500
Date: Fri, 19 Jan 2018 05:39:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180119053846-mutt-send-email-mst@kernel.org>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
	<1516308132-10272-13-git-send-email-mst@redhat.com>
	<d0bac25d-6735-f83d-2bc6-44b36dd93dce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0bac25d-6735-f83d-2bc6-44b36dd93dce@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 12/29] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Prasad Singamsetty <prasad.singamsety@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Prasad Singamsetty <prasad.singamsetty@oracle.com>

On Fri, Jan 19, 2018 at 11:34:57AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8819=E6=97=A5 04:45, Michael S. Tsirkin wrote:
> > From: Prasad Singamsetty<prasad.singamsetty@oracle.com>
> >=20
> > The current implementation of Intel IOMMU code only supports 39 bits
> > iova address width. This patch provides a new parameter (x-aw-bits)
> > for intel-iommu to extend its address width to 48 bits but keeping th=
e
> > default the same (39 bits). The reason for not changing the default
> > is to avoid potential compatibility problems with live migration of
> > intel-iommu enabled QEMU guest. The only valid values for 'x-aw-bits'
> > parameter are 39 and 48.
> >=20
> > After enabling larger address width (48), we should be able to map
> > larger iova addresses in the guest. For example, a QEMU guest that
> > is configured with large memory ( >=3D1TB ). To check whether 48 bits
> > aw is enabled, we can grep in the guest dmesg output with line:
> > "DMAR: Host address width 48".
> >=20
> > Signed-off-by: Prasad Singamsetty<prasad.singamsety@oracle.com>
> > Reviewed-by: Peter Xu<peterx@redhat.com>
> > Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > ---
> >   hw/i386/intel_iommu_internal.h |   9 ++--
> >   include/hw/i386/intel_iommu.h  |   1 +
> >   hw/i386/acpi-build.c           |   3 +-
> >   hw/i386/intel_iommu.c          | 101 ++++++++++++++++++++++++------=
-----------
> >   4 files changed, 65 insertions(+), 49 deletions(-)
> >=20
>=20
> [...]
>=20
> >   /* DMA Remapping Fault Conditions */
> >   typedef enum VTDFaultReason {
> > @@ -360,8 +358,7 @@ typedef union VTDInvDesc VTDInvDesc;
> >   #define VTD_INV_DESC_IOTLB_DOMAIN       (2ULL << 4)
> >   #define VTD_INV_DESC_IOTLB_PAGE         (3ULL << 4)
> >   #define VTD_INV_DESC_IOTLB_DID(val)     (((val) >> 16) & VTD_DOMAIN=
_ID_MASK)
> > -#define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL & \
> > -                                         ((1ULL << VTD_MGAW) - 1))
> > +#define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL)
> >   #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
> >   #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
> >   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_io=
mmu.h
> > index 372b06d..45ec891 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -304,6 +304,7 @@ struct IntelIOMMUState {
> >       bool intr_eime;                 /* Extended interrupt mode enab=
led */
> >       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
> >       bool buggy_eim;                 /* Force buggy EIM unless eim=3D=
off */
> > +    uint8_t aw_bits;                /* Host/IOVA address width (in b=
its) */
> >   };
>=20
> Consider it's guest visible, do we need to migrate this ?
>=20
> Thanks

I think it's a read-only constant so I guess no.

--=20
MST
