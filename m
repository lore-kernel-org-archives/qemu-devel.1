Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18244C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EEB206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYq8WkW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EEB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVDZ-0004uy-N8
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVCe-0003bf-Em
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:56:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVCc-0006s9-Cz
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589529377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odyDP/WPHS0++wIIxGlV1OCfgY8XMDET2qw3D5WmGJE=;
 b=JYq8WkW21r/3sm8DJHci4ZGQ5TvIFg/8pEAHSF0kPdcw/mq9Vk5E9/E7TQ5ZOr4yzmbgTP
 WIsXo/e6OUwiFgOxYcF2nNlfpjQ2TT5aHGIu8/d1f8B8HtynuK0KOp00YP9FyLbAeDXldn
 o6q8bVEyHVz9P9zarSUr+9NYoyvtDDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-rlMw7fWeN1K3TU33VUCIBQ-1; Fri, 15 May 2020 03:56:15 -0400
X-MC-Unique: rlMw7fWeN1K3TU33VUCIBQ-1
Received: by mail-wm1-f69.google.com with SMTP id w189so787060wmg.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=odyDP/WPHS0++wIIxGlV1OCfgY8XMDET2qw3D5WmGJE=;
 b=W9I9w/4cqCSYWLNBbSBYQhlM9slT4DlMyhLiLUwuNBoZJF7Zc9PEPYp7mgrOoH8U1V
 yyeS26RLUnL5PmQQnfEs8GiwPpEJmITBF0/oIn/h8ZWR/N6yL1JUCsCKLgoqrf+HYgoc
 DkT7G0GDgn+rwQVjSPnoGFmhnNHoD+ABfClGDc7ndfZAX8iMSdM554E1dFrCwlBejCzE
 xYzn1isnV0wznV131IqthQ4o7Vw2D0ITk938o4zFQyros/YJPPHOM37ZxDu1uKhm9a1v
 G2Gmuk3ygmkHHaZi7yb6uZx6Nhx2mIwKDvmcuD7X+syMt6pWVAduI/FYVCa1MtZ1HKap
 qrYQ==
X-Gm-Message-State: AOAM5314GV3D/Ixcb+iZo5JTPTbxsyc8f8OrvKzl8uY2Mq4/tihA33J4
 iERT/1jEfoscWxgO/4IUP0t+hM/yyZ68zkvhIcNukcbiofCtdUReCWhprHngJp9HvgAJilTKfn0
 a4KbfA4XD6RILbWw=
X-Received: by 2002:adf:a35c:: with SMTP id d28mr2686538wrb.37.1589529373867; 
 Fri, 15 May 2020 00:56:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysaQaVWVtFS4rgy3uAO31mHxjJ9ti1Hn2ibJ3KdktVbIud+o/ZlZjXQDgU/8gRURxg+S0Kzg==
X-Received: by 2002:adf:a35c:: with SMTP id d28mr2686514wrb.37.1589529373550; 
 Fri, 15 May 2020 00:56:13 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm2453549wma.35.2020.05.15.00.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:56:13 -0700 (PDT)
Subject: Re: [PATCH 5/5] docs/system: Document Musca boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a94c5a6-cbf3-184e-40f3-25b18052dfa6@redhat.com>
Date: Fri, 15 May 2020 09:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507151819.28444-6-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 5:18 PM, Peter Maydell wrote:
> Provide a minimal documentation of the Musca boards.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/arm/musca.rst  | 31 +++++++++++++++++++++++++++++++
>   docs/system/target-arm.rst |  1 +
>   MAINTAINERS                |  1 +
>   3 files changed, 33 insertions(+)
>   create mode 100644 docs/system/arm/musca.rst
> 
> diff --git a/docs/system/arm/musca.rst b/docs/system/arm/musca.rst
> new file mode 100644
> index 00000000000..8375c5008d5
> --- /dev/null
> +++ b/docs/system/arm/musca.rst
> @@ -0,0 +1,31 @@
> +Arm Musca boards (``musca-a``, ``musca-b1``)
> +============================================
> +
> +The Arm Musca development boards are a reference implementation
> +of a system using the SSE-200 subsystem for embedded.

Maybe nitpicking, but this sentence seems unfinished.

" ... for embedded [?]."

Maybe triplicate "systems" again?

> They are
> +dual Cortex-M33 systems.
> +
> +QEMU provides models of the A and B1 variants of this board.
> +
> +Unimplemented devices:
> +
> +- SPI
> +- |I2C|
> +- |I2S|
> +- PWM
> +- QSPI
> +- Timer
> +- SCC
> +- GPIO
> +- eFlash
> +- MHU
> +- PVT
> +- SDIO
> +- CryptoCell
> +
> +Note that (like the real hardware) the Musca-A machine is
> +asymmetric: CPU 0 does not have the FPU or DSP extensions,
> +but CPU 1 does. Also like the real hardware, the memory maps
> +for the A and B1 variants differ significantly, so guest
> +software must be built for the right variant.
> +
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 15bcf9f81f0..1b86b93c346 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -72,6 +72,7 @@ undocumented; you can get a complete list by running
>   
>      arm/integratorcp
>      arm/mps2
> +   arm/musca
>      arm/realview
>      arm/versatile
>      arm/vexpress
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea7bdd359e0..f8e0fdb4ef2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -706,6 +706,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/arm/musca.c
> +F: docs/system/arm/musca.rst
>   
>   Musicpal
>   M: Jan Kiszka <jan.kiszka@web.de>
> 


