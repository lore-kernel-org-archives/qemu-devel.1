Received: from eggs.gnu.org ([2001:4830:134:3::10]:55154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dOR9n-0002Jp-2F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dOR9m-00022V-7x
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:10:03 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-7-git-send-email-eric.auger@redhat.com>
Message-ID: <05924a52-7b7c-c747-26fb-499670ef468f@arm.com>
Date: Fri, 23 Jun 2017 17:09:51 +0100
MIME-Version: 1.0
In-Reply-To: <1496851287-9428-7-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio-iommu: Implement the
 translation and commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com

On 07/06/17 17:01, Eric Auger wrote:
> This patch adds the actual implementation for the translation routine
> and the virtio-iommu commands.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---[...]
>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>                                 struct virtio_iommu_req_attach *req)
> @@ -95,10 +135,34 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>      uint32_t asid = le32_to_cpu(req->address_space);
>      uint32_t devid = le32_to_cpu(req->device);
>      uint32_t reserved = le32_to_cpu(req->reserved);
> +    viommu_as *as;
> +    viommu_dev *dev;
>  
>      trace_virtio_iommu_attach(asid, devid, reserved);
>  
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
> +    if (dev) {
> +        return -1;

I guess you could return S_INVAL here. However, if the device is already
attached to AS0, it should be detached and attached to AS1. The Linux
driver relies on this behavior when moving a device from kernel to user
address space and back.

Thanks,
Jean
