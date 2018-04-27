Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC7zR-0004cC-5x
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC7zM-0002Lu-Ue
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:21:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1fC7zM-0002Ld-Ot
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:20:56 -0400
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-9-marcel@redhat.com>
	<CAFEAcA8pwmYG3waL7V8rLke8964LXzhYWvOoB9BzJqtAq=H9Jg@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <cb93c688-55f4-3e0c-b9ff-f30f19c6b452@redhat.com>
Date: Fri, 27 Apr 2018 21:20:44 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8pwmYG3waL7V8rLke8964LXzhYWvOoB9BzJqtAq=H9Jg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 27/04/2018 17:31, Peter Maydell wrote:
> On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>
>> First PVRDMA sub-module - implementation of the PVRDMA device.
>> - PVRDMA commands such as create CQ and create MR.
>> - Data path QP operations - post_send and post_recv.
>> - Completion handler.
>>
>> Reviewed-by: Dotan Barak <dotanb@mellanox.com>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> Hi; Coverity points out an array bounds overrun in this code:
> 
> 
>> +static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>> +                       union pvrdma_cmd_resp *rsp)
>> +{
>> +    struct pvrdma_cmd_create_bind *cmd = &req->create_bind;
>> +#ifdef PVRDMA_DEBUG
>> +    __be64 *subnet = (__be64 *)&cmd->new_gid[0];
>> +    __be64 *if_id = (__be64 *)&cmd->new_gid[8];
>> +#endif
>> +
>> +    pr_dbg("index=%d\n", cmd->index);
>> +
>> +    if (cmd->index > MAX_PORT_GIDS) {
>> +        return -EINVAL;
>> +    }
> 
> This bounds check allows cmd->index == MAX_PORT_GIDS...
> 
>> +
>> +    pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
>> +           (long long unsigned int)be64_to_cpu(*subnet),
>> +           (long long unsigned int)be64_to_cpu(*if_id));
>> +
>> +    /* Driver forces to one port only */
>> +    memcpy(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, &cmd->new_gid,
>> +           sizeof(cmd->new_gid));
> 
> ...but the gid_tbl[] array we index into is declared with
> 
>     union ibv_gid gid_tbl[MAX_PORT_GIDS];
> 
> so using MAX_PORT_GIDS as an index is off the end of it.
> 
> Presumably the check should be ">=".
> 

Right, thanks for finding it!

>> +static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>> +                        union pvrdma_cmd_resp *rsp)
>> +{
>> +    struct pvrdma_cmd_destroy_bind *cmd = &req->destroy_bind;
>> +
>> +    pr_dbg("clear index %d\n", cmd->index);
>> +
>> +    memset(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw, 0,
>> +           sizeof(dev->rdma_dev_res.ports[0].gid_tbl[cmd->index].raw));
> 
> I'm assuming this function can't be called unless create_bind()
> has previously succeeded and so it doesn't need its own
> bounds check.
> 

The index is provided by the guest, so we should check it,
right Yuval?

I'll take care of it.
Thanks,
Marcel

>> +
>> +    return 0;
>> +}
> 
> thanks
> -- PMM
> 
