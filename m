Received: from eggs.gnu.org ([2001:4830:134:3::10]:35058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT2PV-00058K-4N
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT2PR-0001SC-Ss
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:13:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT2PR-0001Rv-N5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:12:57 -0500
Date: Mon, 16 Jan 2017 16:12:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116081252.GI30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<7a8c721d-8a12-9727-feae-58103942fd55@redhat.com>
	<20170116075043.GE30108@pxdev.xzpeter.org>
	<ae7765c7-7101-357e-3e7f-8ca94d8ad5b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae7765c7-7101-357e-3e7f-8ca94d8ad5b5@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 13/14] intel_iommu: allow dynamic
 switch of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Mon, Jan 16, 2017 at 04:01:00PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 15:50, Peter Xu wrote:
> >On Mon, Jan 16, 2017 at 02:20:31PM +0800, Jason Wang wrote:
> >
> >[...]
> >
> >>>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >>>index fd75112..2596f11 100644
> >>>--- a/hw/i386/intel_iommu.c
> >>>+++ b/hw/i386/intel_iommu.c
> >>>@@ -1343,9 +1343,49 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUS=
tate *s)
> >>>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
> >>>  }
> >>>+static void vtd_switch_address_space(VTDAddressSpace *as, bool iomm=
u_enabled)
> >>Looks like you can check s->dmar_enabled here?
> >Yes, we need to check old state in case we don't need a switch at all.
> >Actually I checked it...
> >
>=20
> I mean is there a chance that iommu_enabled( better name should be
> dmar_enabled) is not equal to s->dmar_enabled? Looks not.
>=20
> vtd_handle_gcmd_te() did:
>=20
>     ...
>     if (en) {
>         s->dmar_enabled =3D true;
>         /* Ok - report back to driver */
>         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_TES);
>     } else {
>         s->dmar_enabled =3D false;
>     ...
>=20
> You can vtd_switch_address_space_all(s, en) after this which will call =
this
> function. And another caller like you've pointed out has already call t=
his
> through s->dmar_enabled. So en here is always s->dmar_enalbed?

Hmm, yes...

(I would still prefer keeping this parameter for readablility.
 Though, I prefer your suggestion to rename it to dmar_enabled)

-- peterx
