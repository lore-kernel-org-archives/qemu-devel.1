Received: from eggs.gnu.org ([209.51.188.92]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkn8k-000545-16
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 04:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gkn8i-0003wK-55
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 04:42:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gkn8h-0003tz-T5
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 04:42:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so6643705wmj.1
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 01:42:07 -0800 (PST)
References: <20190109201559.3906-1-yuval.shaia@oracle.com>
	<9cde91d0-ec6a-d66c-c699-1d35f8dd84a5@gmail.com>
	<20190118162322.GA3558@lap1>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <fe6996fe-58ea-0559-f9f2-2b0ad47eaab4@gmail.com>
Date: Sat, 19 Jan 2019 11:42:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190118162322.GA3558@lap1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Yuval Shaia <yuval.shaia@oracle.com>, liq3ea@163.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org



On 1/18/19 6:23 PM, Yuval Shaia wrote:
> On Fri, Jan 18, 2019 at 03:55:36PM +0200, Marcel Apfelbaum wrote:
>> Hi Yuval,
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
>> There may be a problem here, comp_ctx may be uninitialized at this point.
>> I see that comp_ctx gets initalized after this call:
>>
>>           /* Prepare CQE */
>>          comp_ctx = g_malloc(sizeof(CompHandlerCtx));
>>          comp_ctx->dev = dev;
>>
>>
>> What do you think?
>>
>> Thanks,
>> Marcel
> Applying this patch on top of upstream make sense.
> Problem start because you probably applied Li Qiang's patch "[PATCH v2] hw:
> pvrdma: fix memory leak in error path" which moves the initialization of
> comp_ctx to be right after all checks are done.
>
> More than that, accepting this patch makes Li Qiang's patch redundant since
> the cleanup of comp_ctx will be taken care by the usual process of
> 'completion' (see the callback function pvrdma_qp_ops_comp_handler).
> Li Qiang, can you confirm?

Sounds right to me. I'll add Reported-by tag and keep the coverity info.

Thanks,
Marcel

> Yuval
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
>>>            }
>>>            if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
