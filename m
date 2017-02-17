Received: from eggs.gnu.org ([2001:4830:134:3::10]:53611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cecWh-0005e7-Oh
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 02:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cecWd-0004vN-QZ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 02:00:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cecWd-0004v5-Hv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 02:00:15 -0500
Date: Fri, 17 Feb 2017 15:00:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170217070006.GB12693@pxdev.xzpeter.org>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
	<20170217032619.GL15985@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C25743900B765@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743900B765@shsmsx102.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>

On Fri, Feb 17, 2017 at 06:36:41AM +0000, Liu, Yi L wrote:
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, February 17, 2017 11:26 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; qemu-devel@nongnu.org; Peter
> > Maydell <peter.maydell@linaro.org>; Eduardo Habkost
> > <ehabkost@redhat.com>; Jason Wang <jasowang@redhat.com>; Paolo Bonzin=
i
> > <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>; Tian, Kev=
in
> > <kevin.tian@intel.com>; Lan, Tianyu <tianyu.lan@intel.com>
> > Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device io=
tlb
> > descriptor
> >=20
> > On Thu, Feb 16, 2017 at 05:36:06AM +0000, Liu, Yi L wrote:
> > > > -----Original Message-----
> > > > From: Qemu-devel
> > > > [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.org]
> > > > On Behalf Of Michael S. Tsirkin
> > > > Sent: Tuesday, January 10, 2017 1:40 PM
> > > > To: qemu-devel@nongnu.org
> > > > Cc: Peter Maydell <peter.maydell@linaro.org>; Eduardo Habkost
> > > > <ehabkost@redhat.com>; Jason Wang <jasowang@redhat.com>; Peter Xu
> > > > <peterx@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> > > > Henderson <rth@twiddle.net>
> > > > Subject: [Qemu-devel] [PULL 08/41] intel_iommu: support device io=
tlb
> > > > descriptor
> > > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > >
> > > > This patch enables device IOTLB support for intel iommu. The majo=
r
> > > > work is to implement QI device IOTLB descriptor processing and
> > > > notify the device through iommu notifier.
> > > >
> > > Hi Jason/Michael,
> > >
> > > Recently Peter Xu's patch also touched intel-iommu emulation. His
> > > patch shadows second-level page table by capturing iotlb flush from
> > > guest. It would result in page table updating in host. Does this pa=
tch
> > > also use the same map/umap API provided by VFIO? If it is, then I t=
hink it
> > would also update page table in host.
> >=20
> > I haven't considered complex scenarios, but if simply we have a VM wi=
th one
> > vhost device and one vfio-pci device, imho that should not be a probl=
em -
> > device iotlb is targeting SID rather than DOMAIN. So device iotlb inv=
alidations
> > for vhost will be sent to vhost device only.
>=20
> Peter, I think for assigned device, all guest iotlb flush should be tra=
nslated to
> be targeting device in the scope of host. Besides the scenario which ha=
s vhost
> and vfio-pci device at the same time, how about only having vfio-pci de=
vice
> and this device has ATS support. Then there should be device-iotlb flus=
hing.
> With this patch and your patch, it would also introduce two flushing.

Hmm possibly. I'm still not quite familiar with ATS, but here what we
need to do may be that we forward these device-iotlb invalidations to
the hardware below, instead of sending UNMAP notifies, right?

>=20
> > However, vhost may receive two invalidations here, but it won't matte=
r much
> > since vhost is just flushing caches twice.
>=20
> yeah, so far I didn=E2=80=99t see functional issue, may just reduce per=
formance^_^
>=20
> > > It looks to be
> > > a duplicate update. Pls refer to the following snapshot captured fr=
om
> > > section 6.5.2.5 of vtd spec.
> > >
> > > "Since translation requests from a device may be serviced by hardwa=
re
> > > from the IOTLB, software must always request IOTLB invalidation
> > > (iotlb_inv_dsc) before requesting corresponding Device-TLB
> > > (dev_tlb_inv_dsc) invalidation."
> > >
> > > Maybe for device-iotlb, we need a separate API which just pass down
> > > the invalidate info without updating page table. Any thoughts?
> >=20
> > Now imho I slightly prefer just use the current UNMAP notifier type e=
ven for
> > device iotlb device. But, we may need to do one more check that we sk=
ip
> > sending general iotlb invalidations to ATS enabled devices like vhost=
, to avoid
> > duplicated cache flushing. From virt-svm side, do we have specific re=
quirement
> > to introduce a new flag for it?
> I think it is a practical solution to do such a check to avoid duplicat=
e flushing.
>=20
> For virt-svm, requirement is a little bit different since it's not shad=
owing any guest
> page table. It needs to shadow invalidate operations. So virt-svm will =
not use
> MAP/UNMAP notifier. Instead, it may require notifier which passdown inv=
alidate
> info and then submit invalidation directly.(no page table updating in h=
ost).=20

Again, just want to know whether my above understanding is correct. If
so, instead of introducing a new flag, maybe we just need to enhance
current vtd_process_device_iotlb_desc() to behave differently
depending on which device the SID belongs to. E.g.:

(1) for emulated devices (virtio-pci/vhost is one of them), we pass
    down using a UNMAP, or say, do a cache flush

(2) for assigned devices, we pass it down to hardware by some way

I don't know whether there'll be a (3) though. Also, I don't know the
best way to achieve (2) (new vfio driver interface?).

Thanks,

-- peterx
