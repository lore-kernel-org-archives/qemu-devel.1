Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWFjS-0002yY-2p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWFjR-00085E-C3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 02:39:42 -0400
References: <d5f8be99-9602-a628-bc43-486e7befc4dc@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <90a232ff-74f7-8d10-74f4-87a0008c41df@redhat.com>
Date: Fri, 22 Jun 2018 08:39:33 +0200
MIME-Version: 1.0
In-Reply-To: <d5f8be99-9602-a628-bc43-486e7befc4dc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Questio] What the proper vfio NIC for emulation
 smmu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <hejianet@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hello Jia,

On 06/22/2018 03:44 AM, Jia He wrote:
> Hi Eric
> I want to test your smmu emulation patchset with vfio-pci ethernet device.
> Could you kindly give me the NIC type information.
> In my test, there is vf probe error for menallox connect 4 NIC and TX Unit
> hang error for Intel X540 NIC. That's the reason why I ask this question.
> 
virtual SMMUv3 is not integrated with VFIO and is not planned to be. It
was tested with virtio-net-pci (without vhost-net).

With upstream code you should see the following warning:

"SMMUV3 does not support vhost/vfio integration yet: devices of those
types will not function properly"

With "[PATCH v3 0/4] ARM SMMUv3: IOTLB Emulation and VHOST Support",
vhost-net gets integrated. VFIO won't be integrated either. If vfio-pci
device are attempted to be used along with vsmmu, you will get
"SMMUv3 does not support notification on MAP: device %s will not
function properly"

My attempt to integrate the vsmmu with VFIO in the same manner as intel
iommu (using a fake caching mode) was rejected by the kernel maintainer.
So for VFIO use case, we need either 2 stage enablement (not implemented
yet) or virtio-iommu. I will respin this latter against v0.7 spec
probably next week.

Thanks

Eric
