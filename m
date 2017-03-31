Received: from eggs.gnu.org ([2001:4830:134:3::10]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctp6j-0002aO-Tj
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctp6g-0000Sm-JM
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctp6g-0000SJ-Aq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:28:18 -0400
Date: Fri, 31 Mar 2017 13:28:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170331052804.GG3981@pxdev.xzpeter.org>
References: <1486456099-7345-15-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439032C79@shsmsx102.ccr.corp.intel.com>
	<20170327091208.GG11497@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439032D78@shsmsx102.ccr.corp.intel.com>
	<A2975661238FB949B60364EF0F2C25743903553F@shsmsx102.ccr.corp.intel.com>
	<9c3cda64-b4a3-6f9b-f951-bf73f6613faa@redhat.com>
	<20170331025618.GB3981@pxdev.xzpeter.org>
	<23619b9a-b671-75ff-ffc5-01a61ea9d8c5@redhat.com>
	<20170331050101.GF3981@pxdev.xzpeter.org>
	<9a5bfd93-2d61-96c8-7a95-bccb5a0c819d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a5bfd93-2d61-96c8-7a95-bccb5a0c819d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 14/17] memory: add
 MemoryRegionIOMMUOps.replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "'alex.williamson@redhat.com'" <alex.williamson@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "'mst@redhat.com'" <mst@redhat.com>, "'jan.kiszka@siemens.com'" <jan.kiszka@siemens.com>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>, 'David Gibson' <david@gibson.dropbear.id.au>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

On Fri, Mar 31, 2017 at 01:12:56PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B403=E6=9C=8831=E6=97=A5 13:01, Peter Xu wrote:
> >On Fri, Mar 31, 2017 at 12:21:23PM +0800, Jason Wang wrote:
> >>
> >>On 2017=E5=B9=B403=E6=9C=8831=E6=97=A5 10:56, Peter Xu wrote:
> >>>>>Just come to mind that there may be a corner case here.
> >>>>>
> >>>>>Intel VT-d actually has a "pt" mode which allows device use physic=
al address
> >>>>>even when VT-d is enabled. In kernel, there is a iommu_identity_ma=
pping.
> >>>>>If a device is in this map, then it would use "pt" mode. So that I=
OMMU driver
> >>>>>would not build second-level page table for it.
> >>>>Yes, but qemu does not support ECAP_PT now, so guest will still hav=
e a page
> >>>>table in this case.
> >>>>
> >>>>>Back to the virtual IOVA implementation, if an assigned device is =
in the
> >>>>>iommu_identity_mapping(e.g. VGA controller), it uses GPA directly =
to do DMA.
> >>>>>So it demands a GPA->HPA mapping in host. However, the iommu->ops.=
replay
> >>>>>is not able to build it when guest SL page table is empty.
> >>>>>
> >>>>>So I think building an entire guest PA->HPA mapping before guest k=
ernel boot
> >>>>>would be recommended. Any thoughts?
> >>>>We plan to add PT in 2.10, a possible rough idea is disabled iommu =
dmar
> >>>>region and use another region without iommu_ops. Then
> >>>>vfio_listener_region_add() will just do the correct mappings.
> >>>Even without any new region. With the patch 16/17 ("intel_iommu: all=
ow
> >>>dynamic switch of IOMMU region"), we can just turn the IOMMU region
> >>>on/off, following the device's PT bit, maybe using the new
> >>>vtd_switch_address_space() interface. That should be enough.
> >>Right. For vhost it was probably need more works, e.g setting up stat=
ic
> >>mappings during region_add().
> >Do we need to?
>=20
> Not a must if we don't care about performance.
>=20
> >
> >VFIO will need it for building up shadow page table, even without a
> >vIOMMU. But imho that should not be needed by vhost, right?
>=20
> Device IOTLB will be enabled unconditionally if iommu_platform is speci=
fied.
> If we don't set static mappings, vhost will send IOTLB miss request. Th=
e
> performance will be horrible in this case.

I see, thanks. So looks like we will need one more patch for PT
support now. :)

-- peterx
