Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ACDC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F2A206F1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiknRV8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F2A206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgIU-0007N8-Sw
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZg74-0006yy-MQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:07:34 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZg72-0003V5-V3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:07:34 -0500
Received: by mail-ej1-x641.google.com with SMTP id o9so18512169ejg.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k971elLantKjQPGZmun5ZxHqJWYx3OkNik+siF3ahlo=;
 b=RiknRV8b3/jZ9/ZFtC4F3BJriojPTHngEuco+aG0SwLpxpvr64yD6oW8c2jY+SrEiy
 vfUQXcqWmUTb9GL9K28gAC6UNLJ5z+QLmQ6bhxmCkfbqPI3htR1tV/KgTZCvFxWV+a34
 CdNTUzrOvbVPF4bd+zTbYyyW0sS8G2rSARZSOeB24uidwJP35e9UCga3dwb8GBummZhb
 /t5BtSb0umtGRGqe2TlJSsFL0+D+CaHknOUrNUWDeD6LkfMqN4oqQT+Sr1Mhv8TiT/p9
 yP28UnxiUSYsLE4U+G99WQccuerpvOssft/kdWngFg+4hutgh1PsykxDqhYF5wsnpXA7
 3B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k971elLantKjQPGZmun5ZxHqJWYx3OkNik+siF3ahlo=;
 b=QvUB0W7K7OCg4dXql9+yTbfEDzMNlr1G24pDXCzVBz8Vg8cRmIDTkEDNrnoNQ4dfSC
 n26pZsFG/eWnzaocmmQQDL5PyjigzdhMpYyp5xQYr4yeEhTHscoJ7w0Dd13genZlLBjq
 NESgqQPe+36QBY1yhISGRt8vUwvBKeSlbT/cbv0HaoYQaGop60p6pYqc2l/OSs/A1lZR
 Ay/4OfcLX87bwFpEF0JH8TnoKILqIM7kkXeeNEsKPJJ0MtMIevfh8sCpCZKz23qzTKgo
 P7o+l7j57ZdHQqdWjcLcLj3ngkupRTfTmlVbt33AScNIAghHhKEQJnMJk6Vrex3Cuxx2
 CiJw==
X-Gm-Message-State: AOAM5324ELLPef0G6iXqF5GhGNr/Fhyxh0x61Zg9ULrrQuxcX7OjtGSL
 vxGcBhIwltqJQD2IgTUUbZc=
X-Google-Smtp-Source: ABdhPJzEjx1NpjwKUEXFdjbyzo7wjrskISYh0mD/ubxEemt5pefmwzIEJcgrK8I283i3N+PRrbFmSQ==
X-Received: by 2002:a17:906:82c4:: with SMTP id
 a4mr6835670ejy.131.1604347651452; 
 Mon, 02 Nov 2020 12:07:31 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b21sm7518564ejg.93.2020.11.02.12.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 12:07:30 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2] hw/mips: Remove the 'r4k' machine
To: qemu-devel@nongnu.org
References: <20201102185041.2198130-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ccebd738-6e4f-08be-e43d-b47abe2541cb@amsat.org>
Date: Mon, 2 Nov 2020 21:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102185041.2198130-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 7:50 PM, Philippe Mathieu-Daudé wrote:
> We deprecated the support for the 'r4k' machine for the 5.0 release
> (commit d32dc61421), which means that our deprecation policy allows
> us to drop it in release 5.2. Remove the code.
> 
> To repeat the rationale from the deprecation note:
> - this virtual machine has no specification
> - the Linux kernel dropped support for it 10 years ago
> 
> Users are recommended to use the Malta board instead.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Fixed Header underline length (Richard)
> ---
>  docs/system/deprecated.rst                    |   4 +-
>  .../devices/mips-softmmu-common.mak           |   1 -
>  hw/mips/r4k.c                                 | 318 ------------------
>  MAINTAINERS                                   |   6 -
>  hw/mips/Kconfig                               |  13 -
>  hw/mips/meson.build                           |   1 -
>  6 files changed, 2 insertions(+), 341 deletions(-)
>  delete mode 100644 hw/mips/r4k.c
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0ebce37a191..2a16078a09b 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -327,8 +327,8 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>  System emulator machines
>  ------------------------
>  
> -mips ``r4k`` platform (since 5.0)
> -'''''''''''''''''''''''''''''''''
> +mips ``r4k`` platform (removed in 5.2)
> +''''''''''''''''''''''''''''''''''''''
>  
>  This machine type is very old and unmaintained. Users should use the ``malta``
>  machine type instead.

This is incorrect, I have to move it from "Deprecated features"
to "Recently removed features" section.

