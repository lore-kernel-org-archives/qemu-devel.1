Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB6BC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1C920730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZftuVED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1C920730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQHu-0000vD-LF
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isQHI-0000Uw-UB
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isQHE-0002Nn-NR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:59:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60264
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isQHE-0002NQ-JD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579262339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1WupT6ecj+fEkonJfMMq0eKozXvvoyyW0KybizD4OQ=;
 b=TZftuVEDCzaP3tvO9svIyGfuGHQUUmIPWQCyRKLfB7EwzDhFADNhxjRSThMIZF83aOXeRT
 DP1GtBsaSKH+4aKWA3wlskFVGyBV2VMmGYyanrWHpEWa/Y5aFdKqzCKCPlUQBdDuyjXY2B
 hI20CpvowIARGVLXort8UtBTnQii+30=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-z6-HgOWHP3eoX5WudExZsA-1; Fri, 17 Jan 2020 06:58:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id h130so2174671wme.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 03:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E1WupT6ecj+fEkonJfMMq0eKozXvvoyyW0KybizD4OQ=;
 b=sXQBN0pMQ0qsrwaX3brVk78Pm7MC3xmHa6nXcVcntDpVs1RwvNQ2Rd1PouV3qpJcb8
 tFmPw5SXvdsQS0HFVBOFdMnZ3AxxnRmVR1RkNp1lFIfxNXWqlUfvB18882EsnWlJEnyK
 pAgf367L+wpfvHoi8dx70LjEiEq4PX6lIIbTb5zOkpfRC+QZioQhPRP+E4qLlbHf4c2x
 U9Xo7dZhbjhDDCHbOLA40IBbHaQVyZj94UCJSWz5/S3gbq0WterIYBAGP/DOrd5YXAFf
 cwCnJjZ4280PaDk9GHRV5N5pwBKE/i/4xhENCe7fR3+Kk5OyApSJprpo9I7SOU+M9/jn
 N4CQ==
X-Gm-Message-State: APjAAAXXMrCw9pBg6mramUGxEFageEq9v8jxT5RFZQQoMMSXWpZlYMVv
 22QhKWrrRFV9jAH4Gwytj+rmlLhoc0s0HIEVxZDo2JJQYx8kcCqb4AX9k7MLSCUUrDGk8EvsLO9
 mvmZgbwUh5A2hj40=
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr4332547wmg.92.1579262335735; 
 Fri, 17 Jan 2020 03:58:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6FQeSpF0PsLQsgl49hYy3tuNU0kZlLTLF2Osu5FPY04TG/5QV47+ojlV5r2mbrj4gpc59Mg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr4332534wmg.92.1579262335542; 
 Fri, 17 Jan 2020 03:58:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id f16sm33591858wrm.65.2020.01.17.03.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 03:58:54 -0800 (PST)
Subject: Re: [PATCH v2 0/4] vl: Fixes for cleanups to -accel
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200116210528.31953-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa4fb940-6ece-58e8-2c37-61a677906581@redhat.com>
Date: Fri, 17 Jan 2020 12:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200116210528.31953-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: z6-HgOWHP3eoX5WudExZsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/20 22:05, Richard Henderson wrote:
> Running qemu-system-foo with no options should not generate
> a warning for "invalid accelerator bar".
> 
> Changes in v2:
>   * Rebase on master, getting the free accel_list fix from upstream.
>     Re-word the resulting patch 2 to merely reduce the scope of the
>     local variables.
>   * Use g_str_has_suffix (ajb)
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>   vl: Remove unused variable in configure_accelerators
>   vl: Reduce scope of variables in configure_accelerators
>   vl: Remove useless test in configure_accelerators
>   vl: Only choose enabled accelerators in configure_accelerators
> 
>  vl.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


