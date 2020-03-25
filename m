Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D774C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08FA206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNG/umQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08FA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Zr-0002gp-Sg
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Vn-0005wU-IU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Vm-0003hI-79
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Vm-0003fq-0U
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaMaxnW2Ugv3SeypvEVTmrYyltIOwTIbonZpA60CF8c=;
 b=YNG/umQ8wUjgZ2hPwQcLGK9QEHciqAie+rgCP74ehvdo7DPQup5CtaF2jk9nOqJkJbgJIW
 2Upvd0uyWquRvnVBX1+HyhDoEuuvzen/avi4Hgm4Siv2/wFidLTajeoc5jUe3+pkr1eT4p
 9K0Mp7uBK4eqtibzwdheUb8i9tHJlf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-aHnV6E6JOcqeEqsD2EHktg-1; Wed, 25 Mar 2020 06:43:44 -0400
X-MC-Unique: aHnV6E6JOcqeEqsD2EHktg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 699FF8010C8;
 Wed, 25 Mar 2020 10:43:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 510801001DD8;
 Wed, 25 Mar 2020 10:43:41 +0000 (UTC)
Message-ID: <250f6a203ee6db8f8f6b7232e555758a0a4be3a4.camel@redhat.com>
Subject: Re: [PATCH v6 19/42] nvme: enforce valid queue creation sequence
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:43:40 +0200
In-Reply-To: <20200316142928.153431-20-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-20-its@irrelevant.dk>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> Support returning Command Sequence Error if Set Features on Number of
> Queues is called after queues have been created.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 7 +++++++
>  hw/block/nvme.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 007f8817f101..b40d27cddc46 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -881,6 +881,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>      cq = g_malloc0(sizeof(*cq));
>      nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
>          NVME_CQ_FLAGS_IEN(qflags));
> +
> +    n->qs_created = true;
Very minor nitpick, maybe it is worth mentioning in a comment,
why this is only needed in CQ creation, as you explained to me.


>      return NVME_SUCCESS; 
>  }
>  
> @@ -1194,6 +1196,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> +        if (n->qs_created) {
> +            return NVME_CMD_SEQ_ERROR | NVME_DNR;
> +        }
> +
>          /*
>           * NVMe v1.3, Section 5.21.1.7: 0xffff is not an allowed value for NCQR
>           * and NSQR.
> @@ -1332,6 +1338,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>  
>      n->aer_queued = 0;
>      n->outstanding_aers = 0;
> +    n->qs_created = false;
>  
>      blk_flush(n->conf.blk);
>      n->bar.cc = 0;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index b709a8bb8d40..b4d1738a3d0a 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -99,6 +99,7 @@ typedef struct NvmeCtrl {
>      BlockConf    conf;
>      NvmeParams   params;
>  
> +    bool        qs_created;
>      uint32_t    page_size;
>      uint16_t    page_bits;
>      uint16_t    max_prp_ents;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky





