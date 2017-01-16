Received: from eggs.gnu.org ([2001:4830:134:3::10]:51535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTA6F-0004j4-Qm
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTA6B-0006az-Ja
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:25:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTA6B-0006ac-3A
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:25:35 -0500
Date: Mon, 16 Jan 2017 18:25:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170116182522-mutt-send-email-mst@kernel.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<7a8c721d-8a12-9727-feae-58103942fd55@redhat.com>
	<20170116075043.GE30108@pxdev.xzpeter.org>
	<ae7765c7-7101-357e-3e7f-8ca94d8ad5b5@redhat.com>
	<20170116081252.GI30108@pxdev.xzpeter.org>
	<bcfed61e-d086-0df5-849c-6d2aaa25757c@redhat.com>
	<20170116083224.GK30108@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116083224.GK30108@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Mon, Jan 16, 2017 at 04:32:24PM +0800, Peter Xu wrote:
> On Mon, Jan 16, 2017 at 04:25:35PM +0800, Jason Wang wrote:
> >=20
> >=20
> > On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 16:12, Peter Xu wrote:
> > >On Mon, Jan 16, 2017 at 04:01:00PM +0800, Jason Wang wrote:
> > >>
> > >>On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 15:50, Peter Xu wrote:
> > >>>On Mon, Jan 16, 2017 at 02:20:31PM +0800, Jason Wang wrote:
> > >>>
> > >>>[...]
> > >>>
> > >>>>>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > >>>>>index fd75112..2596f11 100644
> > >>>>>--- a/hw/i386/intel_iommu.c
> > >>>>>+++ b/hw/i386/intel_iommu.c
> > >>>>>@@ -1343,9 +1343,49 @@ static void vtd_handle_gcmd_sirtp(IntelIO=
MMUState *s)
> > >>>>>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTP=
S);
> > >>>>>  }
> > >>>>>+static void vtd_switch_address_space(VTDAddressSpace *as, bool =
iommu_enabled)
> > >>>>Looks like you can check s->dmar_enabled here?
> > >>>Yes, we need to check old state in case we don't need a switch at =
all.
> > >>>Actually I checked it...
> > >>>
> > >>I mean is there a chance that iommu_enabled( better name should be
> > >>dmar_enabled) is not equal to s->dmar_enabled? Looks not.
> > >>
> > >>vtd_handle_gcmd_te() did:
> > >>
> > >>     ...
> > >>     if (en) {
> > >>         s->dmar_enabled =3D true;
> > >>         /* Ok - report back to driver */
> > >>         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_TES)=
;
> > >>     } else {
> > >>         s->dmar_enabled =3D false;
> > >>     ...
> > >>
> > >>You can vtd_switch_address_space_all(s, en) after this which will c=
all this
> > >>function. And another caller like you've pointed out has already ca=
ll this
> > >>through s->dmar_enabled. So en here is always s->dmar_enalbed?
> > >Hmm, yes...
> > >
> > >(I would still prefer keeping this parameter for readablility.
> > >  Though, I prefer your suggestion to rename it to dmar_enabled)
> > >
> > >-- peterx
> >=20
> > I think this does not give more readability :) May I was wrong, let l=
eave
> > this for maintainer.
> >=20
> > Thanks :)
>=20
> Thanks for reviewing this series so fast!
>=20
> I have no strong opinion as well. Maybe you are right. :-)
>=20
> Michael, please let me know if you dislike this, so I can remove this
> parameter (it equals to as->iommu_state->dmar_enabled).
>=20
> Thanks,
>=20
> -- peterx

I prefer not to duplicate data, yes.
