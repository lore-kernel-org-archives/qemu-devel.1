Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7B3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554CF20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVm9XA6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554CF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97Va-00010g-Ju
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k97V2-0000WO-7d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:54:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38908
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k97Uy-0002hd-A1
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzYKg/Xi9neR9QR5pB/5O68chDUCFIZu2ppSHPZExL8=;
 b=RVm9XA6Kj+MexCQ2L5z9BfeR/4M912HO/BafspkJM2l+ID0ArcZ0pZIVDCDPKcyhX5qDTh
 +tnnCSHdUbFJ1SwIfB7F/3LGGlavF4TKKEfT8ERg28aU3WFH8bh1ND1KTtbsxdGY0Kl05U
 othkcbQzTS65Z4ZsehEFqen+H2jPROQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-bxnv4i38M6Oq5sTtqRclvQ-1; Fri, 21 Aug 2020 09:54:25 -0400
X-MC-Unique: bxnv4i38M6Oq5sTtqRclvQ-1
Received: by mail-wm1-f70.google.com with SMTP id q23so605383wmj.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yzYKg/Xi9neR9QR5pB/5O68chDUCFIZu2ppSHPZExL8=;
 b=KUCq8hs944Ts/AiDcvd+2s6F82/zrwKgCXHVg7rV5FQ0OvtH70WNBpWG9QxDD4mCCS
 YC0/G41SFL4uEZ8wCYQc5lMXUQ7p9+C2ebPJ/kbM+PpbcN65U5uVotGzsfAMF8nlm6nR
 5cjoALEVlKEkZp3OKVOYybeqyPo8LW/P18YvjJl0XR1y//FzYGTo1+lUAVzxfNh25XSo
 pSAHUZa2784dMmkQXBbcYgrbUWfeVLlE8WF+pgml2RsFBnxJjT/3w/JAVkXRwKUNRJqD
 EBSW2S7OuNO+c/X6Cpcp4RmtimLDfuRGYZzMqdkjvvzBgYd679988IdkLJ4LuQEctIM3
 dRuA==
X-Gm-Message-State: AOAM531pdLvYak8elt/UYU0ndvUNq9Zl++HsQA5GB9h+umiWWZmHtes+
 WQneA5gr8fjwSLzwt0AKTJlcQCPC6PgMjD85SR8dJIUaw5+VRnKcgzw8b/U7zeT5qVyrfZVoiA6
 bzPGeGpvN9Q/oEBQ=
X-Received: by 2002:a7b:c4ce:: with SMTP id g14mr3507586wmk.51.1598018063878; 
 Fri, 21 Aug 2020 06:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzye/MKeJj+SWIxJlf/FcVb6KUsS2Hvpm11B7GyFo7D+aMYRz9GKS6uzNecuFXBOlZW9zAnSw==
X-Received: by 2002:a7b:c4ce:: with SMTP id g14mr3507567wmk.51.1598018063622; 
 Fri, 21 Aug 2020 06:54:23 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id u6sm4154661wrn.95.2020.08.21.06.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:54:23 -0700 (PDT)
Date: Fri, 21 Aug 2020 15:54:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 03/15] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
Message-ID: <20200821135420.2qnsae7vphlgnt4e@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-4-philmd@redhat.com>
 <20200821094458.fqspisyyl4xxibas@steredhat>
 <755ff4b4-1dc1-175f-f424-76c33d3de507@redhat.com>
MIME-Version: 1.0
In-Reply-To: <755ff4b4-1dc1-175f-f424-76c33d3de507@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 03:36:47PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/21/20 11:44 AM, Stefano Garzarella wrote:
> > On Thu, Aug 20, 2020 at 06:58:49PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
> >> As nvme_create_queue_pair() is allowed to fail, replace the
> >> alloc() calls by try_alloc() to avoid aborting QEMU.
> >>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> >> ---
> >>  block/nvme.c | 12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/nvme.c b/block/nvme.c
> >> index 8c30a5fee28..e1893b4e792 100644
> >> --- a/block/nvme.c
> >> +++ b/block/nvme.c
> >> @@ -213,14 +213,22 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
> >>      int i, r;
> >>      BDRVNVMeState *s = bs->opaque;
> >>      Error *local_err = NULL;
> >> -    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
> >> +    NVMeQueuePair *q;
> >>      uint64_t prp_list_iova;
> >>  
> >> +    q = g_try_new0(NVMeQueuePair, 1);
> >> +    if (!q) {
> >> +        return NULL;
> >> +    }
> >> +    q->prp_list_pages = qemu_try_blockalign0(bs,
> >> +                                          s->page_size * NVME_QUEUE_SIZE);
> > 
> > Here you use NVME_QUEUE_SIZE instead of NVME_NUM_REQS, is that an
> > intentional change?
> 
> No... Thanks for spotting this, I missed it because git didn't
> emit any warning while rebasing on top of "block/nvme: support nested
> aio_poll".
> This value has been changed in 1086e95da17 ("block/nvme: switch to a
> NVMeRequest freelist").
> 
> Good catch!
> I'll respin (after reviewing the 'nested aio_poll' changes).

Cool, with that fixed the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> > 
> > Maybe is not an issue, sice NVME_QUEUE_SIZE is bigger than
> > NVME_NUM_REQS, but we should mention in the commit message.
> > 
> > Thanks,
> > Stefano
> > 
> >> +    if (!q->prp_list_pages) {
> >> +        goto fail;
> >> +    }
> >>      qemu_mutex_init(&q->lock);
> >>      q->s = s;
> >>      q->index = idx;
> >>      qemu_co_queue_init(&q->free_req_queue);
> >> -    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_NUM_REQS);
> >>      q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
> >>                                    nvme_process_completion_bh, q);
> >>      r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
> >> -- 
> >> 2.26.2
> >>
> >>
> > 
> 


