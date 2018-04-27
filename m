Received: from eggs.gnu.org ([2001:4830:134:3::10]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC80q-0005Sb-UP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC80m-0003gE-8f
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1fC80m-0003gA-31
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:22:24 -0400
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-9-marcel@redhat.com>
	<CAFEAcA_YeDoYVEJqNq532varAAavXbkJxs8r+_YSq_NB8LZWuw@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e5d03d22-9ebe-a787-450c-64ac485fac7d@redhat.com>
Date: Fri, 27 Apr 2018 21:22:20 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YeDoYVEJqNq532varAAavXbkJxs8r+_YSq_NB8LZWuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH PULL v2 08/10] hw/rdma: PVRDMA commands and
 data-path ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 27/04/2018 17:43, Peter Maydell wrote:
> On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>
>> First PVRDMA sub-module - implementation of the PVRDMA device.
>> - PVRDMA commands such as create CQ and create MR.
>> - Data path QP operations - post_send and post_recv.
>> - Completion handler.
> 
> Coverity (CID1390589, CID1390608) points out more array
> bounds overruns here:
> 
>> +
>> +typedef struct PVRDMADev {
>> +    PCIDevice parent_obj;
>> +    MemoryRegion msix;
>> +    MemoryRegion regs;
>> +    uint32_t regs_data[RDMA_BAR1_REGS_SIZE];
> 
> regs_data is an array of size RDMA_BAR1_REGS_SIZE...
> 
>> +    MemoryRegion uar;
>> +    uint32_t uar_data[RDMA_BAR2_UAR_SIZE];
>> +    DSRInfo dsr_info;
>> +    int interrupt_mask;
>> +    struct ibv_device_attr dev_attr;
>> +    uint64_t node_guid;
>> +    char *backend_device_name;
>> +    uint8_t backend_gid_idx;
>> +    uint8_t backend_port_num;
>> +    RdmaBackendDev backend_dev;
>> +    RdmaDeviceResources rdma_dev_res;
>> +} PVRDMADev;
>> +#define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
>> +
>> +static inline int get_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t *val)
>> +{
>> +    int idx = addr >> 2;
>> +
>> +    if (idx > RDMA_BAR1_REGS_SIZE) {
>> +        return -EINVAL;
>> +    }
> 
> ...but the bounds check here is ">" rather than ">="
> and allows idx == RDMA_BAR1_REGS_SIZE through...
> 
>> +
>> +    *val = dev->regs_data[idx];
> 
> ...and this will overrun the array.
> 
>> +
>> +    return 0;
>> +}
>> +
>> +static inline int set_reg_val(PVRDMADev *dev, hwaddr addr, uint32_t val)
>> +{
>> +    int idx = addr >> 2;
>> +
>> +    if (idx > RDMA_BAR1_REGS_SIZE) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    dev->regs_data[idx] = val;
> 
> Similarly here, where this is a write access.
> 
> Luckily this isn't an exploitable guest escape, because the only
> call to set_reg_val() with a guest-controlled addr value is from
> the read function of an MMIO MemoryRegion which is created with
> a size of RDMA_BAR1_REGS_SIZE, so the guest can't get out of
> range values into here.
> 
> Three times is a pattern -- you might like to check your
> other bounds checks for off-by-one errors. Coverity doesn't
> necessarily catch all of them.
> 

Agreed, I'll go over the code again.

Thanks,
Marcel


> thanks
> -- PMM
> 
