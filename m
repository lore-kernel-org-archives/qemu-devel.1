Received: from eggs.gnu.org ([2001:4830:134:3::10]:48433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4po-0006Iz-10
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4pn-0000oe-Am
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:58:52 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:36051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC4pn-0000nn-5a
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:58:51 -0400
Received: by mail-oi0-x232.google.com with SMTP id v2-v6so1834437oif.3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:58:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180219114332.70443-9-marcel@redhat.com>
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-9-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 15:58:30 +0100
Message-ID: <CAFEAcA_jBt9tUU1jgObPQCp=x0YOguRz8RX=TVHjONSFPjNveA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
>
> First PVRDMA sub-module - implementation of the PVRDMA device.
> - PVRDMA commands such as create CQ and create MR.
> - Data path QP operations - post_send and post_recv.
> - Completion handler.

> +void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
> +{
> +    RdmaRmCQ *cq;
> +
> +    cq = rdma_rm_get_cq(dev_res, cq_handle);
> +    if (!cq) {
> +        pr_dbg("Invalid CQ# %d\n", cq_handle);
> +    }
> +
> +    rdma_backend_poll_cq(dev_res, &cq->backend_cq);
> +}

Coverity CID 1390586: we check for cq being NULL, but then
go ahead and use it anyway. If a NULL cq is a possible
situation we should handle it correctly (early return?
return an error value that the caller has to handle?
something else?); if it is not possible then we should
use assert rather than an if().

thanks
-- PMM
