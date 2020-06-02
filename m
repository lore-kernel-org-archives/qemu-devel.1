Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1628FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A102072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGrID1o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A102072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg234-00068v-5t
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg22Q-0005iI-3R
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:12:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg22O-0007JI-Ic
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:12:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id q25so2155326wmj.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T899cc8EZKv0ujqIWiS10q7N0aaBRKKfPcvR/LnzgxE=;
 b=sGrID1o2+WU7PEt5pcbowr7Uxep6wM/IJCEG13UiYPGdSlza+sPMUIQs8kQ9JbUhhs
 7kdVzsgOGd63VALW5QK6Ye0/7KT3BAqd0k7pz3j86LBR2lEaoWan491bEgAmeB/BDXrz
 DBc8R55A3wVkYNtpEGIv9iO9Tbrs5fKPJgZ+/XLnDQcw+u8XQhKfgvOy2sXrQ+cTXJji
 cpfB6zHSTG+AX42YGTtTilhx/7tFGORvCZXqqidoJH6v6Lw2ZcE/qZqGOSxJ491pufzN
 EabaeTx0r5wUHgZiLoRJExANK4qODOwu+8WvTp3nmeeJWWSp9OMmDkf5J1cc2/hvY+tN
 vvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T899cc8EZKv0ujqIWiS10q7N0aaBRKKfPcvR/LnzgxE=;
 b=Zs505q5QqtzVCLGr1reLhysC73/R1g27grmA1l8KWXvbbTx9LwvTBm5Nv+o9zxSL+Y
 UBOb1VxGGRpjpeGkWjQ30I7eSWhe8Zji1DUdjOIJyO0cr/2jB61l31ywNJUxyWAj/wib
 DURSQnDirhbEIuozvakRMkHmbbHKU4FNwblwUHFayVwkVctRH80vJqhxqi1zIeBnv+lA
 4mQVQySBXTWoOACWUg2rqy5uTiprCNb7Rx7J6xFH2mF0Zskjl8t1NjiwDxM0j+WYgvmi
 QGY4Lk6qw0NbQ78yiBqEBeoIFH2jHig9KwPdAYN8hvx2iEHR2zc6rAbP1chbXkXAHAU0
 mm7w==
X-Gm-Message-State: AOAM530xE223X5MkIOtnrhnZ1WNZUHu46f4Q+OIflBwJXMy7vYZIm/Ik
 J383ECk9hwr3v2ua4KPnh9Q=
X-Google-Smtp-Source: ABdhPJywjyb3McSabKvhvmRdUQMDDU1VapP6+YX3KD3CTzeGuOZeO383ed0aQXxS+ojO5ylk/HGlHA==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr2787466wmj.143.1591085563116; 
 Tue, 02 Jun 2020 01:12:43 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l1sm2899103wrb.31.2020.06.02.01.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 01:12:42 -0700 (PDT)
Subject: Re: [PATCH for-5.1 V4 4/4] MAINTAINERS: Add myself as Loongson-3
 maintainer
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-5-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <740b3c2e-926e-27f2-e334-abed9aa87575@amsat.org>
Date: Tue, 2 Jun 2020 10:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1591065557-9174-5-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 4:39 AM, Huacai Chen wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0944d9c..c42a218 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1092,6 +1092,11 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>  
> +Loongson-3
> +M: Huacai Chen <chenhc@lemote.com>

Jiaxun Yang, do you mind being listed as reviewer here?

R: Jiaxun Yang <jiaxun.yang@flygoat.com>

At any rate:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +S: Maintained
> +F: hw/mips/mips_loongson3.c
> +
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> 

