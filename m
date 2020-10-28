Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF2C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F7D2468A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOTWdAsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F7D2468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXilE-0008Pa-8F
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXihU-0006a4-U2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXihS-0007NQ-J5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603880941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmsAsbZKIgsEfTt+h1Mh0zCY7z+ijdeDxxHoHW4cio4=;
 b=aOTWdAszKDBjfyrPHP/MRLzZSEcZ1ybItIJmvHVIvsPAvY5V5TLjZeETwuu+pu+e2d4wT/
 7f06tM2njYJhrC1zlJ05NfKZbKnL4GPyxXZfaW2NJS5Zw1wVGBqjJooHtm8vlvyh6I/7kk
 XLIrOuDZCQXsJLzbPD26poaGkz+fEgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-HykTJhUIOl-Iu4RS5_okVQ-1; Wed, 28 Oct 2020 06:29:00 -0400
X-MC-Unique: HykTJhUIOl-Iu4RS5_okVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9897B1084C86;
 Wed, 28 Oct 2020 10:28:58 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35337196FE;
 Wed, 28 Oct 2020 10:28:53 +0000 (UTC)
Subject: Re: [PATCH 07/25] block/nvme: Trace queue pair creation/deletion
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-8-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0d728bf0-7d49-13bd-2279-1d551bfb19ac@redhat.com>
Date: Wed, 28 Oct 2020 11:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-8-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

Hi Philippe,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  block/nvme.c       | 3 +++
>  block/trace-events | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 29d2541b911..e95d59d3126 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -181,6 +181,7 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
>  
>  static void nvme_free_queue_pair(NVMeQueuePair *q)
>  {
> +    trace_nvme_free_queue_pair(q->index, q);
>      if (q->completion_bh) {
>          qemu_bh_delete(q->completion_bh);
>      }
> @@ -216,6 +217,8 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
>      if (!q) {
>          return NULL;
>      }
> +    trace_nvme_create_queue_pair(idx, q, size, aio_context,
> +                                 event_notifier_get_fd(s->irq_notifier));
>      q->prp_list_pages = qemu_try_memalign(s->page_size,
>                                            s->page_size * NVME_NUM_REQS);
>      if (!q->prp_list_pages) {
> diff --git a/block/trace-events b/block/trace-events
> index cc5e2b55cb5..f6a0f99df1a 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -155,6 +155,8 @@ nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset 0x%"PRIx64" byte
>  nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset 0x%"PRIx64" bytes %"PRId64" ret %d"
>  nvme_dma_map_flush(void *s) "s %p"
>  nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
> +nvme_create_queue_pair(unsigned q_index, void *q, unsigned size, void *aio_context, int fd) "index %u q %p size %u aioctx %p fd %d"
> +nvme_free_queue_pair(unsigned q_index, void *q) "index %u q %p"
>  nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
>  nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
>  nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
> 


