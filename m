Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CAFC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04622466D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtGEVzi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04622466D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmQQ-0002UZ-Jm
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXmOw-0000iV-Qh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXmOr-0007if-0I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603895164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6tc/RRpKDA0RDKYI/5bfG7Z+6SY4Rb1OrbnJtQhG5c=;
 b=CtGEVzi4gB+OpkZ00GxuqMEmv02FVVqgBsxdg0XQyxuo2fa1jb76WuD32q0F6NNBH2O4iw
 1upMGUxwMU0CI9jcSJ226YhwoSJUHyOSXJnGBNDiE0JFi3ZSoejrAdu4sBLelJchzY8OjZ
 0DNBe9qNBOuYkA/mdbbNg0rz3Vh1mwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-0mVe-mDgNruJda8SI0uG0g-1; Wed, 28 Oct 2020 10:25:57 -0400
X-MC-Unique: 0mVe-mDgNruJda8SI0uG0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A58C9CC29;
 Wed, 28 Oct 2020 14:25:55 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31CEC5F9D6;
 Wed, 28 Oct 2020 14:25:51 +0000 (UTC)
Subject: Re: [PATCH 16/25] block/nvme: Simplify ADMIN queue access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-17-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <71e33050-c690-7c0e-9b83-3b6aff3d6c50@redhat.com>
Date: Wed, 28 Oct 2020 15:25:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-17-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> We don't need to dereference from BDRVNVMeState each time.
> Use a NVMeQueuePair pointer to the admin queue and use it.
double "use"
> The nvme_init() becomes easier to review, matching the style
> of nvme_add_io_queue().>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  block/nvme.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index d5df30ec074..2d3648694b0 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -699,6 +699,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>                       Error **errp)
>  {
>      BDRVNVMeState *s = bs->opaque;
> +    NVMeQueuePair *q;
>      AioContext *aio_context = bdrv_get_aio_context(bs);
>      int ret;
>      uint64_t cap;
> @@ -781,19 +782,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>  
>      /* Set up admin queue. */
>      s->queues = g_new(NVMeQueuePair *, 1);
> -    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
> -                                                          NVME_QUEUE_SIZE,
> -                                                          errp);
> -    if (!s->queues[INDEX_ADMIN]) {
> +    q = nvme_create_queue_pair(s, aio_context, 0, NVME_QUEUE_SIZE, errp);
> +    if (!q) {
>          ret = -EINVAL;
>          goto out;
>      }
> +    s->queues[INDEX_ADMIN] = q;
>      s->queue_count = 1;
>      QEMU_BUILD_BUG_ON((NVME_QUEUE_SIZE - 1) & 0xF000);
>      regs->aqa = cpu_to_le32(((NVME_QUEUE_SIZE - 1) << AQA_ACQS_SHIFT) |
>                              ((NVME_QUEUE_SIZE - 1) << AQA_ASQS_SHIFT));
> -    regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
> -    regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
> +    regs->asq = cpu_to_le64(q->sq.iova);
> +    regs->acq = cpu_to_le64(q->cq.iova);
>  
>      /* After setting up all control registers we can enable device now. */
>      regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
> 


