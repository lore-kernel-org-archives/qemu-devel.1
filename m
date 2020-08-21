Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A315C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6952A20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbvRKvj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6952A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94Wt-0007sL-LJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k94DU-0001fe-VK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k94DO-0001XC-FS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZejmnbZ15jPkdA6DilS17pNMVEFhImwbB7OYg8dEuWw=;
 b=dbvRKvj4n0OzUQO06mt7dv7lWBoJ0UlUswRNBt0psDW375VkqlxsdBu1YvkbDpMLAqIATA
 RlrwsP8uB0F3VaUCAyDtjJBnxNOwKglDubUnDAiUIEwvfJaEcMgs+Q9bwnjpm9wdF/SP+d
 J5pjo3s8dKoHHM5L65RAhWM0lTIic7M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-DB0aW_0MPdO4-APCZD92qw-1; Fri, 21 Aug 2020 06:24:04 -0400
X-MC-Unique: DB0aW_0MPdO4-APCZD92qw-1
Received: by mail-wr1-f72.google.com with SMTP id 89so411997wrr.15
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 03:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QZRGaUfDp1IKr6Kru7sK9Zzdub+FNd3y+jD4LYTrtEo=;
 b=NsovsCNoIzW0IipobqMtZTzo4bFR2qqdi48NE24yj0DOe1v58gwUp1TmQUWRA5fhmH
 k2wevUW041KrUvLq8nlyRUCvIkBYmdnNSSBbgFI1sRMemsOLzbcbMoEHnsbE8X9LirSC
 RcMk/Qxm2a+frxDwE2wz8B1g9m1xH15OxcrynlDETkulXtmq59q0yuN6ffbAp6ODmbWy
 YiA3vBfOy60m8U9ecHvXt1euHUHZt806R255SU9EEmCqKWfZytAJ9E+UPoxgFg8fO73G
 67TXNdLvEAbyVJHV0a3NHRCpdsOm2iOF0pQ0PKTB/WoNakUJlKiUQlP08uSyBxTiAL37
 wwfg==
X-Gm-Message-State: AOAM532WtY5dMDQmakrAsBXGMQU9diWYUqIfeKLzIk0A5B0t4V+lmrjG
 dVPwFxE0cYJy1KywYIJNco8f4QxP89o3+5AkV+PrzLfImWXqf7nf9h1cBwvWG9iUNfMreMdWE1Y
 wedmmsFeC3Fvv4SU=
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr2447591wme.162.1598005442960; 
 Fri, 21 Aug 2020 03:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMpcxhZG/1Zoz2X0UKV/8g9SVEcj350h9FIhrLIzDnT0scwS24gTvZs+zwvh9bYclZBRfZiA==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr2447572wme.162.1598005442739; 
 Fri, 21 Aug 2020 03:24:02 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id u6sm3847399wmc.12.2020.08.21.03.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 03:24:02 -0700 (PDT)
Date: Fri, 21 Aug 2020 12:23:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 14/15] block/nvme: Extract nvme_poll_queue()
Message-ID: <20200821102353.pi4jk4phmqmzrhir@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-15-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820165901.1139109-15-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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

On Thu, Aug 20, 2020 at 06:59:00PM +0200, Philippe Mathieu-Daudé wrote:
> As we want to do per-queue polling, extract the nvme_poll_queue()
> method which operates on a single queue.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  block/nvme.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 1f67e888c84..a61e86a83eb 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -590,31 +590,41 @@ out:
>      qemu_vfree(id);
>  }
>  
> +static bool nvme_poll_queue(NVMeQueuePair *q)
> +{
> +    bool progress = false;
> +
> +    const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
> +    NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
> +
> +    /*
> +     * Do an early check for completions. q->lock isn't needed because
> +     * nvme_process_completion() only runs in the event loop thread and
> +     * cannot race with itself.
> +     */
> +    if ((le16_to_cpu(cqe->status) & 0x1) == q->cq_phase) {
> +        return false;
> +    }
> +
> +    qemu_mutex_lock(&q->lock);
> +    while (nvme_process_completion(q)) {
> +        /* Keep polling */
> +        progress = true;
> +    }
> +    qemu_mutex_unlock(&q->lock);
> +
> +    return progress;
> +}
> +
>  static bool nvme_poll_queues(BDRVNVMeState *s)
>  {
>      bool progress = false;
>      int i;
>  
>      for (i = 0; i < s->nr_queues; i++) {
> -        NVMeQueuePair *q = s->queues[i];
> -        const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
> -        NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
> -
> -        /*
> -         * Do an early check for completions. q->lock isn't needed because
> -         * nvme_process_completion() only runs in the event loop thread and
> -         * cannot race with itself.
> -         */
> -        if ((le16_to_cpu(cqe->status) & 0x1) == q->cq_phase) {
> -            continue;
> -        }
> -
> -        qemu_mutex_lock(&q->lock);
> -        while (nvme_process_completion(q)) {
> -            /* Keep polling */
> +        if (nvme_poll_queue(s->queues[i])) {
>              progress = true;
>          }
> -        qemu_mutex_unlock(&q->lock);
>      }
>      return progress;
>  }
> -- 
> 2.26.2
> 
> 


