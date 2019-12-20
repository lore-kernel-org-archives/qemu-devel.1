Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB8C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C9C218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNApn62q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C9C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiI7u-0002Pl-K4
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiI6o-0001Qx-By
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiI6m-0003ra-JO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiI6m-0003qo-7X
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576847659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBYx9WFLeIYn+FFEhPeEsZGnlTxj8xihn400E9yN9vQ=;
 b=SNApn62qU0N9NRuu3nSZ1GtOP/R7EEK0AsxgKYpKtKCTY/fibGnvgFa1OJTr0UsRFrJlWL
 XlR5BejpDQoZjMOfORkjEXRFI1s1/QYQwcKNkrTLETuf3e6jjPEue6nVNE5IF7lJ/EFeN1
 OV4MdhuT5+IfyuZa8A9EllMJXSVBNls=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-fv7WwmruMBaxSfLazJZ2Ow-1; Fri, 20 Dec 2019 08:14:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id q26so2017602wmq.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sBYx9WFLeIYn+FFEhPeEsZGnlTxj8xihn400E9yN9vQ=;
 b=hRjiWQsqI+GbrSUyVc0GqAGS9wlfyyGXF/LLP66Jajy5YFfAFd3VEqoT0GaM4mROpE
 DHc0az9ry5iQ6UZVfVaJJV50UM2cBhOMAbdP+/W3BggssDtqXvp+qrYs8XkMZKP2T1fm
 uHbNgOFt5f0uEBKmCQVBxnJwlEpnGmQ5rA607crice3jFTd/q2a4i3+HRJCADozI5q8p
 FXAXuVbVVH4r+jVpKH4+Hy2bl9+EWXQE2Kl82sOaU613FTy16oCcP4A/SwG0pqPFokeU
 Bo3nWiboBTHSc5pX4uZH7gbDidw9y6Gru288Ji5u/uj1W9ktyK83kg6pAhhK6eb0c2RA
 opVA==
X-Gm-Message-State: APjAAAWTmCj+x6+iLfwqpCuHJ4ORnN7/4JHg8nI9uW07lA5n7D9HwJfj
 HqrU5zVBVaksL3XWa1Qq2rMNnI4xocgLfEGd6DXuZhCGli98YJLFlWr1DYe9MXnap0arQXwKKHu
 tOAHzKCEyYXAZNWE=
X-Received: by 2002:adf:f58a:: with SMTP id f10mr15951109wro.105.1576847656352; 
 Fri, 20 Dec 2019 05:14:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgU+gs1My088Z3209sy2APWuWxRnGLFjcUlslLFkskUWB8rydUXdU6AyD/O5tssiCxeDZJ5A==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr15951082wro.105.1576847656131; 
 Fri, 20 Dec 2019 05:14:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id e18sm9776371wrr.95.2019.12.20.05.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 05:14:15 -0800 (PST)
Subject: Re: [PATCH] replay: check other timers for icount limit
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <157675958855.14346.18049977447896411847.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea2791a7-c280-3798-d246-a7bda57377fe@redhat.com>
Date: Fri, 20 Dec 2019 14:14:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157675958855.14346.18049977447896411847.stgit@pasha-Precision-3630-Tower>
Content-Language: en-US
X-MC-Unique: fv7WwmruMBaxSfLazJZ2Ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/12/19 13:46, Pavel Dovgalyuk wrote:
> Record/replay can stall when there are no virtual devices that generate
> events - it just uses all the time for vCPU thread. Therefore main loop
> has to wait too much for the vCPU thread, because they are synchronized
> in rr mode.
> This patch does not let creating too long vCPU executions without
> interrupting to main loop. It checks realtime timers that always exits
> to control user input.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  cpus.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index 63bda152f5..7dba4fa414 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1388,6 +1388,10 @@ static int64_t tcg_get_icount_limit(void)
>           */
>          deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
>                                                QEMU_TIMER_ATTR_ALL);
> +        /* Check realtime timers, because they help with input processing */
> +        deadline = qemu_soonest_timeout(deadline,
> +                qemu_clock_deadline_ns_all(QEMU_CLOCK_REALTIME,
> +                                           QEMU_TIMER_ATTR_ALL));
>  
>          /* Maintain prior (possibly buggy) behaviour where if no deadline
>           * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
> 

Queued, thanks.

Paolo


