Received: from eggs.gnu.org ([2001:4830:134:3::10]:42043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC86i-0007ln-FB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC86e-0005rh-DA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:28:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1fC86e-0005rd-6z
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:28:28 -0400
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-9-marcel@redhat.com>
	<CAFEAcA_jBt9tUU1jgObPQCp=x0YOguRz8RX=TVHjONSFPjNveA@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <2d922865-eac9-5e0c-6997-ea17d8dd4607@redhat.com>
Date: Fri, 27 Apr 2018 21:28:15 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jBt9tUU1jgObPQCp=x0YOguRz8RX=TVHjONSFPjNveA@mail.gmail.com>
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

On 27/04/2018 17:58, Peter Maydell wrote:
> On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>
>> First PVRDMA sub-module - implementation of the PVRDMA device.
>> - PVRDMA commands such as create CQ and create MR.
>> - Data path QP operations - post_send and post_recv.
>> - Completion handler.
> 
>> +void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
>> +{
>> +    RdmaRmCQ *cq;
>> +
>> +    cq = rdma_rm_get_cq(dev_res, cq_handle);
>> +    if (!cq) {
>> +        pr_dbg("Invalid CQ# %d\n", cq_handle);
>> +    }
>> +
>> +    rdma_backend_poll_cq(dev_res, &cq->backend_cq);
>> +}
> 
> Coverity CID 1390586: we check for cq being NULL, but then
> go ahead and use it anyway. If a NULL cq is a possible
> situation we should handle it correctly (early return?
> return an error value that the caller has to handle?
> something else?); if it is not possible then we should
> use assert rather than an if().

The cq_handle is provided by the guest, the code assumes
a sane guest, which is not safe.

I will change the code to return early.

Thanks,
Marcel

> 
> thanks
> -- PMM
> 
