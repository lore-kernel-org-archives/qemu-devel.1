Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D3C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040A02084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Go5Z/TEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040A02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriSa-0002uD-5S
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iriRv-0002L8-Jc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iriRt-0003lT-LJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:11:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iriRt-0003kq-Hy
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579093864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghYAhUlcaHszEgi7Olz7AZkocCBLSOKwcNeMAplEE6Y=;
 b=Go5Z/TEbSGWCN0JfjJaxKeiUeE4zPC0E/hEmPlLIZCWE1DtyCLpCcuGPUklZrW91fTc8z5
 nseIU0LnGPKk+SZnX43j0ijIEpSNmZASpZAri3g9506Ocsk+MOZm2yJG6GnwZ9UV9xsvUb
 yizvzCl5KAR29dvp/at966krhv7ZBj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-SnfsodPeN7Kb1hUBf3ro-Q-1; Wed, 15 Jan 2020 08:11:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so8055821wrr.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 05:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ghYAhUlcaHszEgi7Olz7AZkocCBLSOKwcNeMAplEE6Y=;
 b=Rcl9B1KnPNCMM09S2Ra0zkR104NADe6y3DAXPf0GCjjjjqbL1qtjkRWmV8Ceolp13v
 0zw0Ba5r3XeJv6iujahfl661+/4v+w6QcHWwrQqaZBAfsZw7LQA0C2TA0BI/UUbzcVgZ
 yctXvbkJq4AqCTK8wpwUGnmzZWw2yji28Wr8dNjHyOa9vOzV3sDnkGStuo77cL6UJ1pH
 ayjRY2+gm61/Aytgzv4nWzQzArjft2sMrfm5/vYtQSY0AdvDNxpuBbTIqrSVW2n97mXF
 q8gdaTI/Uuw5dwGyDeGp91gkoslRy1PyAyV9vnZfzuabEmaL3UlklNj6pTaTD9gUZa3L
 B2Nw==
X-Gm-Message-State: APjAAAU5+1C5/hgxaUccvES4XJncqTMopkEIh0vkfgoLeOpQblPU/epp
 usN0GaPtlV4H7AnBSnuiApzFh6Vo+CqSSeYQnx3xGwdKUUP2Fg9Vi28f5IWmsc01sfP06tv+yt/
 MobIArsK4oREtEMY=
X-Received: by 2002:adf:ca07:: with SMTP id o7mr31919189wrh.49.1579093860480; 
 Wed, 15 Jan 2020 05:11:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqnKdC2op8Nz78/c73+WtSnksMAoS8in5OTnxsS56+zdlXSNY7IcGLmlyAw5N4xnMK/hQlIA==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr31919159wrh.49.1579093860158; 
 Wed, 15 Jan 2020 05:11:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id z124sm25421666wmc.20.2020.01.15.05.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 05:10:59 -0800 (PST)
Subject: Re: [PATCH] hw/input: Do not enable CONFIG_PCKBD by default
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200115113748.24757-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0552e1f-1e05-c761-d69a-b73f7bd0a118@redhat.com>
Date: Wed, 15 Jan 2020 14:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200115113748.24757-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: SnfsodPeN7Kb1hUBf3ro-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Philippe Mathieu-Daude <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/20 12:37, Thomas Huth wrote:
> The i8042 device is part of the chipset of a machine, so it should
> be selected by the machines or chipsets (e.g. SuperIO chipsets),
> and not be enabled by default.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/input/Kconfig | 1 -
>  hw/isa/Kconfig   | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/input/Kconfig b/hw/input/Kconfig
> index 287f08887b..a2f25725be 100644
> --- a/hw/input/Kconfig
> +++ b/hw/input/Kconfig
> @@ -7,7 +7,6 @@ config LM832X
>  
>  config PCKBD
>      bool
> -    default y
>      select PS2
>      depends on ISA_BUS
>  
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 8a38813cc1..c7f07854f7 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -16,6 +16,7 @@ config I82378
>  config ISA_SUPERIO
>      bool
>      select ISA_BUS
> +    select PCKBD
>  
>  config PC87312
>      bool
> 

Since you CCed qemu-trivial,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


