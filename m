Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53015C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A372075B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8/Vyqgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A372075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1FD-0003ej-Ml
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT1D5-0002ek-7h
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT1D3-0006MT-Id
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602760452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esQraE8Y/bNPkER3FVilbO9Rv53mg4avZhRLebUk/5g=;
 b=A8/Vyqgr/e9OSnOKm8jhfREnoa54S1IEQ0CZvHHVIGLBQCsSIbYqhZum0oXYfDVUJtaH06
 eWS7KLSsfxTaIvYjeSMb3LuzB4vXJ36INJ7mkPQ13W1MuDxAnwWXa7yQwOmvLJGnRab67J
 No/X4zEvGu3x80ElOhACnrrPPrLcwwA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-lRsPJ0X1PF2uLM8qbJy0nw-1; Thu, 15 Oct 2020 07:14:10 -0400
X-MC-Unique: lRsPJ0X1PF2uLM8qbJy0nw-1
Received: by mail-wm1-f71.google.com with SMTP id y83so1585798wmc.8
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 04:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=esQraE8Y/bNPkER3FVilbO9Rv53mg4avZhRLebUk/5g=;
 b=S6yAt6MbLGqcTb2mJmQABbNzgLszaaPCMnUlZkywaa0/jy7+RjJDQGTKeKEIKOf5or
 dWlIZgRltnbcf+2nApd9A+fHH468oYuyOpw3DHYrKLJFd78bvXGZAWxYvRS0xqRzAcIP
 EWeXv7zwba/lDI2dhttuailP1BIEyThcX4wB1Tch6SmuanBHgneCh2FPDwE7lgC8owOn
 nk4KXI8nmQwEAc1KvWbWJKoOFqB+FUT0Rm75JUPQBcESz7ObureIXNsUcYPm7d0wI20M
 V9pwn0K3RHh5L0M8cTzrk17m4nILLrvfier00+7iIJSeyvz7WB2WsY1jWBWiQfooRUYr
 32fg==
X-Gm-Message-State: AOAM530xyrxPVBbwoF9JWU+lwV6Y6loU51tstqOZr8BR7HIukQoEXfYN
 SfWDyp9g6nBH/KH7Pi1JBu3IVYvCOscLCo8pslK/qmZwvrzK8E1+p+zxnlCvtYNJ5RdH6EBcZQl
 2U2pZhuPHLLWB/3c=
X-Received: by 2002:a1c:60d5:: with SMTP id u204mr3610669wmb.46.1602760449604; 
 Thu, 15 Oct 2020 04:14:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTUqG28x5lucY4oFfdubtWtO8F/Nd/4VsJSArprgUjTQpnHwQBsgzwvUvk1fdBhPk12DwuPg==
X-Received: by 2002:a1c:60d5:: with SMTP id u204mr3610653wmb.46.1602760449399; 
 Thu, 15 Oct 2020 04:14:09 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v4sm3862967wmg.35.2020.10.15.04.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 04:14:08 -0700 (PDT)
Subject: Re: [PATCH 08/10] net/colo-compare.c: Change the timer clock type
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <20201014072555.12515-9-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a9c1cf2-ed54-d10f-0929-131e48e71aa8@redhat.com>
Date: Thu, 15 Oct 2020 13:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014072555.12515-9-chen.zhang@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:25 AM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> The virtual clock only runs during the emulation. It stops
> when the virtual machine is stopped.
> The host clock should be used for device models that emulate accurate
> real time sources. It will continue to run when the virtual machine
> is suspended. COLO need to know the host time here.
> 

Please add:

Fixes: dd321ecfc2e ("colo-compare: Use IOThread to Check old packet 
regularly and Process packets of the primary")
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Reported-by: Derek Su <dereksu@qnap.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index f4814c5f09..61c95fe7e9 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -899,7 +899,7 @@ static void check_old_packet_regular(void *opaque)
>   
>       /* if have old packet we will notify checkpoint */
>       colo_old_packet_check(s);
> -    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
>                 s->expired_scan_cycle);
>   }
>   
> @@ -933,10 +933,10 @@ static void colo_compare_timer_init(CompareState *s)
>   {
>       AioContext *ctx = iothread_get_aio_context(s->iothread);
>   
> -    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_VIRTUAL,
> +    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_HOST,
>                                   SCALE_MS, check_old_packet_regular,
>                                   s);
> -    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_HOST) +
>                 s->expired_scan_cycle);
>   }
>   
> 


