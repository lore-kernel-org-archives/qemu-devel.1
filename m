Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FAC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551592468A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3QM7BrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551592468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXilo-0000jS-6i
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXik0-0007s7-So
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXijz-0008P6-8m
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603881097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtbgUWYGWVJvbVGx7kmU7XbjGEjsFXSjSuwgrESqdSA=;
 b=Z3QM7BrXdd9OxBzLQ/ptzfaWvciDpwIu8bcDLcO9+SrYPiq0gF+XLdM2Ke8eRo3F6rnxry
 0yTxV1ly/O8gDx8a+24+qnqFlfZBja4zv+riWjNAB5O4o8MG5CCVldWDmjjq/NEgAP0Xme
 h9p2+5wb5pIpZDT0+qUjK8CAxaHeNQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-7NiDB3iYPS-5aL-YYKgmEQ-1; Wed, 28 Oct 2020 06:31:33 -0400
X-MC-Unique: 7NiDB3iYPS-5aL-YYKgmEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A5B1842141;
 Wed, 28 Oct 2020 10:31:32 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC0CE5C1D7;
 Wed, 28 Oct 2020 10:31:26 +0000 (UTC)
Subject: Re: [PATCH 05/25] block/nvme: Trace nvme_poll_queue() per queue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-6-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a87ae9bd-8987-e8ab-1f1d-1e8ffd0af72f@redhat.com>
Date: Wed, 28 Oct 2020 11:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-6-philmd@redhat.com>
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
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hi,

On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
> As we want to enable multiple queues, report the event
> in each nvme_poll_queue() call, rather than once in
> the callback calling nvme_poll_queues().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  block/nvme.c       | 2 +-
>  block/trace-events | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 361b5772b7a..8d74401ae7a 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -594,6 +594,7 @@ static bool nvme_poll_queue(NVMeQueuePair *q)
>      const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
>      NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
>  
> +    trace_nvme_poll_queue(q->s, q->index);
>      /*
>       * Do an early check for completions. q->lock isn't needed because
>       * nvme_process_completion() only runs in the event loop thread and
> @@ -684,7 +685,6 @@ static bool nvme_poll_cb(void *opaque)
>      BDRVNVMeState *s = container_of(e, BDRVNVMeState,
>                                      irq_notifier[MSIX_SHARED_IRQ_IDX]);
>  
> -    trace_nvme_poll_cb(s);
>      return nvme_poll_queues(s);
>  }
>  
> diff --git a/block/trace-events b/block/trace-events
> index b90b07b15fa..86292f3312b 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -145,7 +145,7 @@ nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
>  nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
>  nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
>  nvme_handle_event(void *s) "s %p"
> -nvme_poll_cb(void *s) "s %p"
> +nvme_poll_queue(void *s, unsigned q_index) "s %p q #%u"
>  nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset 0x%"PRIx64" bytes %"PRId64" flags %d niov %d"
>  nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset 0x%"PRIx64" bytes %"PRId64" flags %d"
>  nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
> 


