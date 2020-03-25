Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC110C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7885F206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuTrIwww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7885F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3af-0003VC-Ih
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Uq-0004Ro-BM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Uo-0003GU-5B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Un-0003GH-W3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585132969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSsTUGqL7DYkABDQF5qBYjpt3mGVWuggNKCvDBp91Ic=;
 b=FuTrIwwwkfZnDa0OwCZxtxki3fQskuV8srJZ1E/vQbA6nrTeU2T2h0BILxfyQx5lwm5oDo
 UmeuWIyGgXnQhXxUEnIn54+zNbaGab2vLU8z/wW/7bjr3odegxjuaSDNWFlicnnK41+NoR
 fgTwCXxPJkZ85BqMRJ5s8IBwLgduUf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-4vzHxHR-MoiA4TNtrHwX3g-1; Wed, 25 Mar 2020 06:42:47 -0400
X-MC-Unique: 4vzHxHR-MoiA4TNtrHwX3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E166107ACCC;
 Wed, 25 Mar 2020 10:42:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 277545C241;
 Wed, 25 Mar 2020 10:42:43 +0000 (UTC)
Message-ID: <c1bb24e518a670a2053c4050ad73740053f13931.camel@redhat.com>
Subject: Re: [PATCH v6 16/42] nvme: make sure ncqr and nsqr is valid
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Date: Wed, 25 Mar 2020 12:42:43 +0200
In-Reply-To: <20200316142928.153431-17-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-17-its@irrelevant.dk>
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
> 0xffff is not an allowed value for NCQR and NSQR in Set Features on
> Number of Queues.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/block/nvme.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 85c7c86b35f0..e56142c4ea99 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1155,6 +1155,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> +        /*
> +         * NVMe v1.3, Section 5.21.1.7: 0xffff is not an allowed value for NCQR
> +         * and NSQR.
> +         */
> +        if ((dw11 & 0xffff) == 0xffff || ((dw11 >> 16) & 0xffff) == 0xffff) {
> +            return NVME_INVALID_FIELD | NVME_DNR;
> +        }
> +
>          trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
>                                      ((dw11 >> 16) & 0xFFFF) + 1,
>                                      n->params.max_ioqpairs,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




