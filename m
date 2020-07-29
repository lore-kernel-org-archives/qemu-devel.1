Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58B72075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjOYIlBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B72075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qBp-0001eZ-7a
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qBB-00019W-Od
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:47:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0qB9-0007LD-5M
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596044865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLNFcz203D3sa7+/R9waVUGSQXSI1qN5MyfrQteXq8c=;
 b=MjOYIlBZSXbRqHlZDzzQk65cLWHxADujjKxa95J/S8TpnV4YhQ+BZ7oBwXRainKw5Vv45S
 21EcQMXwD5aDCnVy6nhTBbwBtviXAXZ9wm66gNbfLHbT4YNwAkTBAd0SwHI2yqp1ZDqnTY
 fOKnY/FdupyYWA3xxzDlWK9UlhnPzfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-kZ5S9uSCOkC1cxEnePGgTQ-1; Wed, 29 Jul 2020 13:47:42 -0400
X-MC-Unique: kZ5S9uSCOkC1cxEnePGgTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EB308064AE;
 Wed, 29 Jul 2020 17:47:41 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF6B579CF3;
 Wed, 29 Jul 2020 17:47:38 +0000 (UTC)
Message-ID: <1878330443116667e7394dac111976f8697408fe.camel@redhat.com>
Subject: Re: [PATCH 12/16] hw/block/nvme: refactor NvmeRequest clearing
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Date: Wed, 29 Jul 2020 20:47:37 +0300
In-Reply-To: <20200720113748.322965-13-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-13-its@irrelevant.dk>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-07-20 at 13:37 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Move clearing of the structure from "clear before use" to "clear
> after use".
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index e2932239c661..431f26c2f589 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -209,6 +209,11 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
>      }
>  }
>  
> +static void nvme_req_clear(NvmeRequest *req)
> +{
> +    memset(&req->cqe, 0x0, sizeof(req->cqe));
> +}
> +
>  static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
>                                    size_t len)
>  {
> @@ -458,6 +463,7 @@ static void nvme_post_cqes(void *opaque)
>          nvme_inc_cq_tail(cq);
>          pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
>              sizeof(req->cqe));
> +        nvme_req_clear(req);

Don't we need some barrier here to avoid reordering the writes?
pci_dma_write does seem to include a barrier prior to the write it does
but not afterward.

Also what is the motivation of switching the order?
I think somewhat that it is a good thing to clear a buffer,
before it is setup.


>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
>      if (cq->tail != cq->head) {
> @@ -1601,7 +1607,6 @@ static void nvme_process_sq(void *opaque)
>          req = QTAILQ_FIRST(&sq->req_list);
>          QTAILQ_REMOVE(&sq->req_list, req, entry);
>          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
> -        memset(&req->cqe, 0, sizeof(req->cqe));
>          req->cqe.cid = cmd.cid;
>  
>          status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :


Best regards,
	Maxim Levitsky


