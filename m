Received: from eggs.gnu.org ([209.51.188.92]:38889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkToi-0007we-DW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkToY-0003aH-L9
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:04:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gkToY-0003We-91
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:04:02 -0500
Received: by mail-wr1-x441.google.com with SMTP id v13so14988568wrw.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:03:59 -0800 (PST)
References: <20190109201559.3906-1-yuval.shaia@oracle.com>
	<7b754432-7c1e-8f22-3410-d95c426c2d0b@gmail.com>
	<20190113191901.GA10017@lap1>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b409cf45-0870-057d-bc31-c7506b164a2a@gmail.com>
Date: Fri, 18 Jan 2019 15:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190113191901.GA10017@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Post CQE when receive invalid
 gid index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org



On 1/13/19 9:19 PM, Yuval Shaia wrote:
> On Sat, Jan 12, 2019 at 05:11:39PM +0200, Marcel Apfelbaum wrote:
>>
>> On 1/9/19 10:15 PM, Yuval Shaia wrote:
>>> This error should propagate back to guest.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> ---
>>>    hw/rdma/rdma_backend.h      | 1 +
>>>    hw/rdma/vmw/pvrdma_qp_ops.c | 6 ++++--
>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
>>> index a9ba40ae48..5114c90e67 100644
>>> --- a/hw/rdma/rdma_backend.h
>>> +++ b/hw/rdma/rdma_backend.h
>>> @@ -32,6 +32,7 @@
>>>    #define VENDOR_ERR_INVLKEY          0x207
>>>    #define VENDOR_ERR_MR_SMALL         0x208
>>>    #define VENDOR_ERR_INV_MAD_BUFF     0x209
>>> +#define VENDOR_ERR_INV_GID_IDX      0x210
>>>    /* Add definition for QP0 and QP1 as there is no userspace enums for them */
>>>    enum ibv_special_qp_type {
>>> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
>>> index 465bee8641..0565eba981 100644
>>> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
>>> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
>>> @@ -178,7 +178,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>>>            sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
>>>            if (!sgid) {
>>>                pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
>>> -            return -EIO;
>>> +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
>> Informing the guest is OK, but are you sure it makes sense
>> to continue sending the other work requests?
> Yes, it is exactly what is expected. RDMA application (or driver) would
> usually push several work requests to ring (optimally populating the entire
> ring) and then ring the doorbell.
> An error in a specific WR does not means all WRs in ring should not be
> processed.

Thanks for the explanation.

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>> Is maybe safer to return with error as before?
> And what about the remaining WR in the ring? any way the device would have
> to process them on next doorbell.
>
>>> +            continue;
>>>            }
>>>            pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
>>>                   sgid->global.interface_id);
>>> @@ -189,7 +190,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>>>            if (sgid_idx <= 0) {
>>>                pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
>>>                       wqe->hdr.wr.ud.av.gid_index);
>>> -            return -EIO;
>>> +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
>>> +            continue;
>> Same question here.
>>
>> Thanks,
>> Marcel
>>>            }
>>>            if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
