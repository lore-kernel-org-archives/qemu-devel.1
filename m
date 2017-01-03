Received: from eggs.gnu.org ([2001:4830:134:3::10]:41059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cOWVf-0000nt-0f
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 16:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cOWVb-0004xI-2k
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 16:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cOWVa-0004vf-QG
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 16:20:38 -0500
Date: Tue, 3 Jan 2017 14:20:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170103142035.7c946abf@t450s.home>
In-Reply-To: <f37cf386-8fe4-ded8-0341-dc765882cf72@redhat.com>
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
	<b2b1424c-1bd0-00ea-8d14-f935b8901629@redhat.com>
	<20161222110412.GB26435@pxdev.xzpeter.org>
	<6798718b-3949-032f-0e5f-fa6b2e2d83fb@redhat.com>
	<20161223032601.GC26435@pxdev.xzpeter.org>
	<f37cf386-8fe4-ded8-0341-dc765882cf72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Mon, 26 Dec 2016 10:45:55 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2016=E5=B9=B412=E6=9C=8823=E6=97=A5 11:26, Peter Xu wrote:
> > On Thu, Dec 22, 2016 at 07:34:10PM +0800, Jason Wang wrote: =20
> >>
> >> On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 19:04, Peter Xu wrote: =20
> >>> On Thu, Dec 22, 2016 at 05:52:58PM +0800, Jason Wang wrote: =20
> >>>> On 2016=E5=B9=B412=E6=9C=8822=E6=97=A5 17:48, Peter Xu wrote: =20
> >>>>>   /* Handle Translation Enable/Disable */
> >>>>>   static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >>>>>   {
> >>>>> +    if (s->dmar_enabled =3D=3D en) {
> >>>>> +        return;
> >>>>> +    }
> >>>>> +
> >>>>>       VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off")=
);
> >>>>>       if (en) {
> >>>>> @@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUStat=
e *s, bool en)
> >>>>>           /* Ok - report back to driver */
> >>>>>           vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0=
);
> >>>>>       }
> >>>>> +
> >>>>> +    vtd_switch_address_space_all(s, en);
> >>>>>   } =20
> >>>> We may need something like notifier here to tell e.g vhost to stop d=
evice
> >>>> IOTLB. (Since it's likely this series were applied after device IOTLB
> >>>> patches) =20
> >>> Yes, I missed vhost case.
> >>>
> >>> To notify vhost, IMO we should be able to use memory listeners just
> >>> like how vfio devices do (please refer to vfio_memory_listener). =20
> >> Just for switching? This seems an overkill since we don't depends on i=
t for
> >> all other things. Guest should setup correct mappings by explicitly no=
tify
> >> device IOTLB. A quick glance at ATS spec, for enabling and disabling, =
looks
> >> like it was done through enable bit of ASTctl instead of here.
> >>
> >> So we are probably ok here :) =20
> > So we need a more general way to notify ATS about this, right? (e.g.,
> > for future devices that support ATS as well, not only vhost) =20
>=20
> Yes, if we want to make ATS visible to guest. But looks like it needs=20
> more e.g VFIO support for device IOTLB invalidation.

ATS is already visible for vfio-pci devices, it will be enabled if the
host IOMMU supports ATS.  If the host IOMMU does not support ATS,
enabling it on the device by the guest will generate unsupported
requests.  This is yet another case, along with address width, where
it's potentially really complicated and not amenable to hotplug to have
a guest IOMMU.  AFAICT, there's nothing to be added to vfio for device
iotlb invalidations, this occurs automatically between the host IOMMU
and device when a DMA unmap occurs.  Thanks,

Alex
