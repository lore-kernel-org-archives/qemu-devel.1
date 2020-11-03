Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAD5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2233F20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuXN6CHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2233F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyAG-0003Qc-SO
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxku-0001nl-3z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:57:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxks-0005bH-8i
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:57:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id d142so4434230wmd.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ybIfCQaNpBAAV5pezI9c3M6GCaJUKwv+deZHERyIfyU=;
 b=SuXN6CHdVOz/kQ7lTR43THW914MYGvhxeHNaEh/mWGJ9+D9mfytJxVuPERh4cpXlZI
 c2Wz7s87h13p1YvHCsLEsDXIUIu3P/ALw97vQMP05HRWzMca1WcPz2thzyqWiAA0hRKs
 qEmtjXGDluO89F9yP2kP4zA1FFItjE1q0VcnXDck92FqrzLAH1ylsnA0Z2wqSszB40qm
 fgnKEVffnPEcK+YoIOTR/eahbCTxmctCSMvkhlqWzq1g5tl5XXXoxsUMR5UHWKg+cvnN
 k6g+ERguVI7xY1s4y6YohhGFnGJ5fhzNWxNB9tYHvJA4JD+Omk3q/k6+PW9MsgMaUtr6
 2f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ybIfCQaNpBAAV5pezI9c3M6GCaJUKwv+deZHERyIfyU=;
 b=ay1oZA9cgoAoiNz7NbI2uSkWJ1+jrMTXSHwMz8uBKKwaNKju019IWnZMfjzMp5vKGZ
 uBFtJ3T1bvD0UUop43IiRY48ic/UjrLUnKtZeJ0DvJpcQb8ddLQcfc2ywcNJBS386qi8
 fOHTjxA7YR/q1QDkaFQu36FZ2n/kQIlhL7sbKjPZyPKmMUrpV4EimjlCwIBq09Gylzkh
 nLNTUb46cXGWq+CJFh0eb0lhkAftX4wACNB/YT1qJ89RIQhYaL/3NrN8RmFhLI0VDwwj
 Vzq7H2wfdQtqLeEwdxr6RZT2KEmoVQavq61sdACFhr2yIX55j8fX1AfAA0TkjNTQI61/
 S6Bw==
X-Gm-Message-State: AOAM533e0JDhkJz42GW5DT/WiQlKYyvPBygqSjWTer05pcLxxQImrLTp
 WW6WYThzqrA71/J+X1glv3Y=
X-Google-Smtp-Source: ABdhPJzfokkrF8b7PJ3YLUpd46mvUFpMmeWIcJXzqd+QON2Apw1C4erWT95BeSxMnb2zvvOCJ9ICWQ==
X-Received: by 2002:a7b:c18d:: with SMTP id y13mr160181wmi.120.1604415468814; 
 Tue, 03 Nov 2020 06:57:48 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o4sm26153097wrv.8.2020.11.03.06.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:57:48 -0800 (PST)
Subject: Re: [PATCH V16 0/6] mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d5712aaf-b440-516b-2da2-f2ff639d09a1@amsat.org>
Date: Tue, 3 Nov 2020 15:57:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 11:25 AM, Huacai Chen wrote:
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
> 
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.

As this series missed the 5.2 release, I'll look at it
again in 2 or 3 weeks.

> Huacai Chen and Jiaxun Yang (8):
>  target/mips: Fix PageMask with variable page size
>  target/mips: Add unaligned access support for MIPS64R6 and Loongson-3
>  hw/mips: Implement fw_cfg_arch_key_name()
>  hw/mips: Add Loongson-3 boot parameter helpers
>  hw/mips: Add Loongson-3 machine support
>  docs/system: Update MIPS machine documentation
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  default-configs/devices/mips64el-softmmu.mak |   1 +
>  docs/system/target-mips.rst                  |  10 +
>  hw/mips/Kconfig                              |  12 +
>  hw/mips/fw_cfg.c                             |  35 ++
>  hw/mips/fw_cfg.h                             |  19 +
>  hw/mips/loongson3_bootp.c                    | 165 +++++++
>  hw/mips/loongson3_bootp.h                    | 241 +++++++++++
>  hw/mips/loongson3_virt.c                     | 614 +++++++++++++++++++++++++++
>  hw/mips/meson.build                          |   3 +-
>  target/mips/cp0_helper.c                     |  34 +-
>  target/mips/cpu.h                            |   1 +
>  target/mips/translate.c                      |   4 +-
>  12 files changed, 1130 insertions(+), 9 deletions(-)
>  create mode 100644 hw/mips/fw_cfg.c
>  create mode 100644 hw/mips/fw_cfg.h
>  create mode 100644 hw/mips/loongson3_bootp.c
>  create mode 100644 hw/mips/loongson3_bootp.h
>  create mode 100644 hw/mips/loongson3_virt.c
> --
> 2.7.0
> 

