Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC74BC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8754220714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzyuzSxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8754220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3tN-0004ES-Oa
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3jn-0007W9-4M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3jl-00062A-Uw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3jl-00060d-Ok
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEf67qOn04bsT22Xj9XM3+mSUtOxOtkZ1Fpnuf4BOrk=;
 b=dzyuzSxBUXWDHoV4r6oV01AXA8tVYnAfWh1/g7tbiIgwF7F6soPCmvLbaEtVLzx5Ah350Z
 Gw4Vq8Z7hUxqjoXOf8Cw0joi+WGPn0zfre2lOXyGxhoYP6+lh0uDaf0+PJDnC2kvyONWy9
 BFBZJSBNPrf87JkhaPT+x2UBo5eXF/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-enrSU1f9PjOu1nmU0OxYGA-1; Wed, 25 Mar 2020 06:58:15 -0400
X-MC-Unique: enrSU1f9PjOu1nmU0OxYGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E59E1851C29;
 Wed, 25 Mar 2020 10:58:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 846585C241;
 Wed, 25 Mar 2020 10:58:12 +0000 (UTC)
Message-ID: <486bcf991becd2b059ea43f8dd2db72891104495.camel@redhat.com>
Subject: Re: [PATCH v6 33/42] nvme: use preallocated qsg/iov in nvme_dma_prp
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:58:11 +0200
In-Reply-To: <20200316142928.153431-34-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-34-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since clean up of the request qsg/iov has been moved to the common
> nvme_enqueue_req_completion function, there is no need to use a stack
> allocated qsg/iov in nvme_dma_prp.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 817384e3b1a9..15ca2417af04 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -321,45 +321,39 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>                               uint64_t prp1, uint64_t prp2, DMADirection dir,
>                               NvmeRequest *req)
>  {
> -    QEMUSGList qsg;
> -    QEMUIOVector iov;
>      uint16_t status = NVME_SUCCESS;
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
>              trace_nvme_dev_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> -
> -        qemu_sglist_destroy(&qsg);
>      } else {
>          size_t bytes;
>  
>          if (dir == DMA_DIRECTION_TO_DEVICE) {
> -            bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
> +            bytes = qemu_iovec_to_buf(&req->iov, 0, ptr, len);
>          } else {
> -            bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
> +            bytes = qemu_iovec_from_buf(&req->iov, 0, ptr, len);
>          }
>  
>          if (unlikely(bytes != len)) {
>              trace_nvme_dev_err_invalid_dma();
>              status = NVME_INVALID_FIELD | NVME_DNR;
>          }
> -
> -        qemu_iovec_destroy(&iov);
>      }
>  
>      return status;
Only minor changes from the previous version,
so 
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky






