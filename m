Received: from eggs.gnu.org ([2001:4830:134:3::10]:42656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cU3X0-0003eB-Nd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cU3Wx-0007GH-Le
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cU3Wx-0007FA-FO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:36:55 -0500
References: <fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
	<20170116091801.GL30108@pxdev.xzpeter.org>
	<0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
	<20170117144514.GO30108@pxdev.xzpeter.org>
	<99e185dc-e3c9-678f-7a69-fc006658d07f@redhat.com>
	<20170118081137.GS30108@pxdev.xzpeter.org>
	<f89c8ad4-a95d-bf66-33c6-f151531c2174@redhat.com>
	<20170118084627.GT30108@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C0951D@SHSMSX101.ccr.corp.intel.com>
	<9553e8fa-e8ad-8b28-5f5e-142f10acc030@redhat.com>
	<20170119033256.GC4914@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <df331ec2-898c-800d-f452-373a2335304f@redhat.com>
Date: Thu, 19 Jan 2017 11:36:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170119033256.GC4914@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>



On 2017=E5=B9=B401=E6=9C=8819=E6=97=A5 11:32, Peter Xu wrote:
> On Wed, Jan 18, 2017 at 06:06:57PM +0800, Jason Wang wrote:
>
> [...]
>
>> So I think we should implement DSI and GLOBAL for vfio in this case. W=
e can
>> first try to implement it through current VFIO API which can accepts a=
 range
>> of iova. If not possible, let's discuss for other possible solutions.
> Do you mean VFIO_IOMMU_UNMAP_DMA here?
>
> [...]

Yes.

>
>>> If my understanding above is correct, there is nothing wrong with
>>> above IOMMU driver code - actually it makes sense on bare metal
>>> when CM is disabled.
>>>
>>> But yes, DSI/GLOBAL is far less efficient than PSI when CM is enabled=
.
>>> We rely on cache invalidations to indirectly capture remapping struct=
ure
>>> change. PSI provides accurate info, while DSI/GLOBAL doesn't. To
>>> emulate correct behavior of DSI/GLOBAL, we have to pretend that
>>> the whole address space (iova=3D0, size=3Dagaw) needs to be unmapped
>>> (for GLOBAL it further means multiple address spaces)
>> Maybe a trick to have accurate info is virtual Device IOTLB.
> Could you elaborate a bit on this?
>
> Thanks,
>
> -- peterx

I think the trick is if guest knows device has device IOTLB, it will=20
explicit flush with accurate iova range.

Thanks
