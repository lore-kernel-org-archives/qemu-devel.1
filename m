Received: from eggs.gnu.org ([2001:4830:134:3::10]:42571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1e0Jae-0004RV-GF
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1e0Jaa-0007Rs-IE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:46:20 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Fri, 6 Oct 2017 03:46:11 +0000
Message-ID: <AM5PR0401MB254548523AC95D0A2A8A92E69A710@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
	<20170927074109.GA31587@virtx40>
	<AM5PR0401MB25450ACC804B20D93C4F2D9D9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<9700cf30-65ed-9c55-c1b9-14bb8deb669f@redhat.com>
	<20170927092147.GA32183@virtx40>
	<0af599c0-f859-f90c-c999-bc4a0a678768@redhat.com>
	<20171004114910.GA6932@virtx40>
	<79234c56-c524-5359-de8a-f266b19821eb@redhat.com>
	<9d173ea5-75a6-c684-7f8d-e2ec1d3eddff@redhat.com>
	<1017080b-aa5f-4a1f-9905-e65f22717cd1@redhat.com>
	<b740e8b7-5859-fd6a-1f1e-480aef6ef4f0@redhat.com>
In-Reply-To: <b740e8b7-5859-fd6a-1f1e-480aef6ef4f0@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Auger Eric <eric.auger@redhat.com>, Linu Cherian <linuc.decode@gmail.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>



> >> Thanks
> >>
> >> Eric
> >>>
> >>> However you should be allowed to map 1 sg element of 5 pages and
> >>> then notify the host about this event I think. Still looking at the c=
ode...
> >>>
> >>> I still can't reproduce the issue at the moment. What kind of device
> >>> are you assigning?
> >>>
> >>> Thanks
> >>>
> >>> Eric
> >>>>
> >>>> Atleast vfio_get_vaddr called from vfio_iommu_map_notify in Qemu
> >>>> expects the map size to be a power of 2.
> >
> > Actually I missed the most important here ;-)
> >>>>
> >>>>  if (len & iotlb->addr_mask) {
> > This check looks suspiscious to me. In our case the len is not
> > modified by the previous translation and it fails, I don't see why. It
> > should be valid to be able to notify 5 granules.
>=20
> So after discussion with Alex, looks the way we notify the host currently=
 is
> wrong. we set the addr_mask to the mapping/unmapping size
> -1 whereas this should be a page mask instead (granule size or block size=
?).
> So if the guest maps 5 x 4kB pages we should send 5 notifications for eac=
h
> page and not a single one. It is unclear to me if we can notify with
> hugepage/block page size mask. Peter may confirm/infirm this. in vsmmuv3
> code I notify by granule or block size.
>=20
> Bharat, please can you add this to your TODO list?
>=20
> Linu, thanks a lot for the time you spent debugging this issue.
> Curiously on my side, it is really seldom hit but it is ...

Thanks Linu and Eric, I added this to my todo list.
While I am still not able to reproduce the issue.  I tried with e1000 and n=
ow try with ixgbe device. May I know which device can be used to reproduce =
this issue?

Thanks
-Bharat

>=20
> Thanks!
>=20
> Eric
> >
> > Thanks
> >
> > Eric
> >>>>         error_report("iommu has granularity incompatible with target=
 AS");
> >>>>         return false;
> >>>>     }
> >>>>
> >>>> Just trying to understand how this is not hitting in your case.
> >>>>
> >>>>
> >>>
> >>
> >
