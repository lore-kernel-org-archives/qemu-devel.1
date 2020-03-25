Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C78AC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CA920772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgaDxB18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CA920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3pS-00079K-E0
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3hr-0004Vk-9o
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3hp-0000mN-6p
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3hp-0000ls-2N
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKfeMW+u5W7VsDI3kchu8tRloDhAmzfwXqPKleg7QN4=;
 b=NgaDxB18ABOmWbA24FUCsOUyqlcGA1946qZXxvIZyW14arCL/iDw+wSv90YlUJYuAmj9N2
 a17sKZKldCqVhKnUo903E9yH7FRylmT56/a7+z3piMDPbCDcl/coEs/zsLEW5aJeuZkc9U
 /nmZrM76fXcgT5h1Q7af8Cg8QdELx5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-gXDC0mzBPZimy-4J62D95w-1; Wed, 25 Mar 2020 06:56:13 -0400
X-MC-Unique: gXDC0mzBPZimy-4J62D95w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 973DB1005514;
 Wed, 25 Mar 2020 10:56:11 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D4B3396;
 Wed, 25 Mar 2020 10:56:09 +0000 (UTC)
Message-ID: <1628398725459de502198f6f4fd6c9efd75adb3b.camel@redhat.com>
Subject: Re: [PATCH v6 27/42] nvme: add request mapping helper
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:56:08 +0200
In-Reply-To: <20200316142928.153431-28-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-28-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> Introduce the nvme_map helper to remove some noise in the main nvme_rw
> function.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3e9c2ed434c2..850087aac967 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -351,6 +351,15 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
>      return status;
>  }
>  
> +static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
> +                         QEMUIOVector *iov, size_t len, NvmeRequest *req)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +
> +    return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
> +}
> +
>  static void nvme_post_cqes(void *opaque)
>  {
>      NvmeCQueue *cq = opaque;
> @@ -534,8 +543,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>      NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
>      uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
> -    uint64_t prp1 = le64_to_cpu(rw->dptr.prp1);
> -    uint64_t prp2 = le64_to_cpu(rw->dptr.prp2);
>  
>      uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
>      uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
> @@ -552,7 +559,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
>          return NVME_LBA_RANGE | NVME_DNR;
>      }
>  
> -    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req)) {
> +    if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
>          block_acct_invalid(blk_get_stats(n->conf.blk), acct);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




