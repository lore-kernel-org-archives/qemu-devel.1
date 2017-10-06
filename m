Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Linu.Cherian@cavium.com>) id 1e0OCw-0002Hf-Rl
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Linu.Cherian@cavium.com>) id 1e0OCv-0004VM-QZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:42:10 -0400
Date: Fri, 6 Oct 2017 14:11:29 +0530
From: Linu Cherian <linu.cherian@cavium.com>
Message-ID: <20171006084129.GA9318@virtx40>
References: <9700cf30-65ed-9c55-c1b9-14bb8deb669f@redhat.com>
	<20170927092147.GA32183@virtx40>
	<0af599c0-f859-f90c-c999-bc4a0a678768@redhat.com>
	<20171004114910.GA6932@virtx40>
	<79234c56-c524-5359-de8a-f266b19821eb@redhat.com>
	<9d173ea5-75a6-c684-7f8d-e2ec1d3eddff@redhat.com>
	<1017080b-aa5f-4a1f-9905-e65f22717cd1@redhat.com>
	<b740e8b7-5859-fd6a-1f1e-480aef6ef4f0@redhat.com>
	<AM5PR0401MB254548523AC95D0A2A8A92E69A710@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<807c8076-af7b-da24-66d5-2c823dc1da34@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807c8076-af7b-da24-66d5-2c823dc1da34@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 0/5] virtio-iommu: VFIO
 integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>, Linu Cherian <linuc.decode@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>

On Fri Oct 06, 2017 at 09:24:20AM +0200, Auger Eric wrote:
> Hi Bharat,
> 
> On 06/10/2017 05:46, Bharat Bhushan wrote:
> > 
> > 
> >>>> Thanks
> >>>>
> >>>> Eric
> >>>>>
> >>>>> However you should be allowed to map 1 sg element of 5 pages and
> >>>>> then notify the host about this event I think. Still looking at the code...
> >>>>>
> >>>>> I still can't reproduce the issue at the moment. What kind of device
> >>>>> are you assigning?
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> Eric
> >>>>>>
> >>>>>> Atleast vfio_get_vaddr called from vfio_iommu_map_notify in Qemu
> >>>>>> expects the map size to be a power of 2.
> >>>
> >>> Actually I missed the most important here ;-)
> >>>>>>
> >>>>>>  if (len & iotlb->addr_mask) {
> >>> This check looks suspiscious to me. In our case the len is not
> >>> modified by the previous translation and it fails, I don't see why. It
> >>> should be valid to be able to notify 5 granules.
> >>
> >> So after discussion with Alex, looks the way we notify the host currently is
> >> wrong. we set the addr_mask to the mapping/unmapping size
> >> -1 whereas this should be a page mask instead (granule size or block size?).
> >> So if the guest maps 5 x 4kB pages we should send 5 notifications for each
> >> page and not a single one. It is unclear to me if we can notify with
> >> hugepage/block page size mask. Peter may confirm/infirm this. in vsmmuv3
> >> code I notify by granule or block size.
> >>
> >> Bharat, please can you add this to your TODO list?
> >>
> >> Linu, thanks a lot for the time you spent debugging this issue.
> >> Curiously on my side, it is really seldom hit but it is ...
> > 
> > Thanks Linu and Eric, I added this to my todo list.
> > While I am still not able to reproduce the issue.  I tried with e1000 and now try with ixgbe device. May I know which device can be used to reproduce this issue?
> 
> On my side I used an i350T2 device (igb) to reproduce the issue.

Myself used a Thunderx NIC which is an on chip PCI device.


-- 
Linu cherian
