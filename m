Received: from eggs.gnu.org ([2001:4830:134:3::10]:47114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMXBX-0005dj-8v
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMXBT-0000HG-2O
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:44:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:49244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eMXBS-0000Ff-OA
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:44:11 -0500
Message-ID: <5A27CA70.8020704@intel.com>
Date: Wed, 06 Dec 2017 18:46:08 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-8-git-send-email-wei.w.wang@intel.com>
	<20171205160512.GI31150@stefanha-x1.localdomain>
In-Reply-To: <20171205160512.GI31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 7/7] virtio/vhost.c:
 vhost-pci needs remote gpa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com

On 12/06/2017 12:05 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:16AM +0800, Wei Wang wrote:
>> The vhost-pci driver uses the remote guest physical address to send/receive
>> packets from the remote guest, so when sending the ving info to the vhost-pci
>> device, send the guest physical adress directly.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   hw/virtio/vhost.c | 56 +++++++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 36 insertions(+), 20 deletions(-)
> Can you do it inside vhost_memory_map()/vhost_memory_unmap() instead of
> modifying callers?
>
> Looks like vhost_dev_has_iommu() already takes this approach:
>
>    static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
>                                  hwaddr *plen, int is_write)
>    {
>        if (!vhost_dev_has_iommu(dev)) {
>            return cpu_physical_memory_map(addr, plen, is_write);
>        } else {
>            return (void *)(uintptr_t)addr;
>        }
>    }
>
>    static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
>                                   hwaddr len, int is_write,
>                                   hwaddr access_len)
>    {
>        if (!vhost_dev_has_iommu(dev)) {
>            cpu_physical_memory_unmap(buffer, len, is_write, access_len);
>        }
>    }

Thanks for the reminder. I think this patch may be not needed with 
adding the F_IOMMU_PLATFORM feature.


Best,
Wei
