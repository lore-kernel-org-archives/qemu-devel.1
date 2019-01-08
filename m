Received: from eggs.gnu.org ([209.51.188.92]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggvTq-0006MV-Gi
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggvTp-0007Re-LH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:47:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggvTn-0007GD-Uk
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:47:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so5310365wmd.2
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 09:47:52 -0800 (PST)
References: <20190103130338.49081-1-liq3ea@163.com>
	<fad70169-0cff-ede5-c07d-bff01d113f88@redhat.com>
	<20190107162657.GB3249@lap1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b2d0a80-5108-464c-3f3f-50ef70660246@redhat.com>
Date: Tue, 8 Jan 2019 18:47:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190107162657.GB3249@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: pvrdma: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, liq3ea@163.com
Cc: marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 1/7/19 5:26 PM, Yuval Shaia wrote:
> On Thu, Jan 03, 2019 at 02:47:37PM +0100, Philippe Mathieu-Daudé wrote:
>> On 1/3/19 2:03 PM, Li Qiang wrote:
>>> Spotted by Coverity: CID 1398595
>>>
>>
>> Fixes: 2b05705dc8
>>
>>> Signed-off-by: Li Qiang <liq3ea@163.com>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>> ---
>>>  hw/rdma/vmw/pvrdma_qp_ops.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
>>> index 300471a4c9..584be2043e 100644
>>> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
>>> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
>>> @@ -168,6 +168,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>>>          sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
>>>          if (!sgid) {
>>>              pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
>>> +            g_free(comp_ctx);
>>>              return -EIO;
>>>          }
>>>          pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
>>> @@ -179,6 +180,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>>>          if (sgid_idx <= 0) {
>>>              pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
>>>                     wqe->hdr.wr.ud.av.gid_index);
>>> +            g_free(comp_ctx);
>>>              return -EIO;
>>>          }
> 
> Since comp_ctx is not used until the two checks are done we just can
> relocate the allocation & initialization right after the two checks.

Oops I missed this, thanks your suggestion is way cleaner!

Phil.
