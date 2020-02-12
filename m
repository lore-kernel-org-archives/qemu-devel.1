Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C1C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECE220675
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYCIdEPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECE220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1qYF-0001wM-Pr
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 06:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1qWt-0001Aj-96
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1qWs-0001Wz-9B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:50:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1qWs-0001WM-4b
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581508205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXYPfllzxmNpBcRmkiL0GoCu9+wh7z7VqGSsRcC724o=;
 b=iYCIdEPAuc1SANz8nXx3IqUcDbCghkz6H0/PviZgk72dzHFmB2e/+bIxldTDP4im4zptXd
 BIff90c1oS8hRrGEiRhggCoErlr/XvfmS1scJzoiL7x3DCKfjaD05ErVXkeUvmHjwzlifu
 r2AqLhqQmpM77b9q7LdBqHe2H02DsxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Ir6-swzMP9K3rpSu_dKjkw-1; Wed, 12 Feb 2020 06:50:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BB311005514;
 Wed, 12 Feb 2020 11:50:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9B9F19C69;
 Wed, 12 Feb 2020 11:49:59 +0000 (UTC)
Message-ID: <ba2bed5cd14c8eb2247e82c8da9ed3b6cd5ce58c.camel@redhat.com>
Subject: Re: [PATCH v5 18/26] nvme: use preallocated qsg/iov in nvme_dma_prp
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 13:49:48 +0200
In-Reply-To: <20200204095208.269131-19-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095227eucas1p2f23061d391e67f4d3bde8bab74d1e44b@eucas1p2.samsung.com>
 <20200204095208.269131-19-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Ir6-swzMP9K3rpSu_dKjkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> Since clean up of the request qsg/iov has been moved to the common
> nvme_enqueue_req_completion function, there is no need to use a
> stack allocated qsg/iov in nvme_dma_prp.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index e97da35c4ca1..f8c81b9e2202 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -298,23 +298,21 @@ unmap:
>  static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      uint64_t prp1, uint64_t prp2, DMADirection dir, NvmeRequest *req)
>  {
> -    QEMUSGList qsg;
> -    QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
>      size_t bytes;
>  
> -    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
> +    status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
>      if (status) {
>          return status;
>      }
>  
> -    if (qsg.nsg > 0) {
> +    if (req->qsg.nsg > 0) {
>          uint64_t residual;
>  
>          if (dir == DMA_DIRECTION_TO_DEVICE) {
> -            residual = dma_buf_write(ptr, len, &qsg);
> +            residual = dma_buf_write(ptr, len, &req->qsg);
>          } else {
> -            residual = dma_buf_read(ptr, len, &qsg);
> +            residual = dma_buf_read(ptr, len, &req->qsg);
>          }
>  
>          if (unlikely(residual)) {
> @@ -322,15 +320,13 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
>  
> -        qemu_sglist_destroy(&qsg);
> -
>          return status;
>      }
>  
>      if (dir == DMA_DIRECTION_TO_DEVICE) {
> -        bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
> +        bytes = qemu_iovec_to_buf(&req->iov, 0, ptr, len);
>      } else {
> -        bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
> +        bytes = qemu_iovec_from_buf(&req->iov, 0, ptr, len);
>      }
>  
>      if (unlikely(bytes != len)) {
> @@ -338,8 +334,6 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>          status = NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    qemu_iovec_destroy(&iov);
> -
>      return status;
>  }
>  


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


