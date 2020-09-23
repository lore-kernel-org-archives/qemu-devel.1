Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DCC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4719421D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/GUFLe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4719421D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6Yl-0003Ox-FJ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL6Vj-0001I2-Rj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL6Vi-0004cH-3K
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ep+u6XnycHy67yFzUUGNexLz9wB+eyo1e3s0AxyopaI=;
 b=L/GUFLe65EJ75ydvLMhDaqSnddbF0qXPs7EbcwRKXihzV7SulQ98Fs14Zbc+EUmt20hOg+
 CS+1nLit50ECE3aLMQlKgcmv8dpXUlWR6mtqgkwg/BYoq7lE4vg3cA9a7pgVO/JIiiqZbU
 /WCA0r/wrk98/qlzsvhrlw6r/R2wZyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-azV-mAAHNIKy7DV0vBCBog-1; Wed, 23 Sep 2020 11:16:40 -0400
X-MC-Unique: azV-mAAHNIKy7DV0vBCBog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A28801ABE;
 Wed, 23 Sep 2020 15:16:39 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 942565DA7C;
 Wed, 23 Sep 2020 15:16:38 +0000 (UTC)
Subject: Re: [PATCH 4/4] block/nbd: nbd_co_reconnect_loop(): don't connect if
 drained
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200903190301.367620-1-vsementsov@virtuozzo.com>
 <20200903190301.367620-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a6644fd9-57e6-beda-f95e-c60bc7ec7cc4@redhat.com>
Date: Wed, 23 Sep 2020 10:16:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903190301.367620-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 2:03 PM, Vladimir Sementsov-Ogievskiy wrote:
> In a recent commit 12c75e20a269ac we've improved
> nbd_co_reconnect_loop() to not make drain wait for additional sleep.
> Similarly, we shouldn't try to connect, if previous sleep was
> interrupted by drain begin, otherwise drain_begin will have to wait for
> the whole connection attempt.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/nbd.c b/block/nbd.c
> index caae0e6d31..4548046cd7 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -661,6 +661,9 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
>           } else {
>               qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
>                                         &s->connection_co_sleep_ns_state);
> +            if (s->drained) {
> +                continue;
> +            }
>               if (timeout < max_timeout) {
>                   timeout *= 2;
>               }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


