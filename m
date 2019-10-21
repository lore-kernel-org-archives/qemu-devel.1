Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51542064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ketX+tAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51542064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMayg-0003QZ-TJ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaxi-00027m-Uh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaxh-0000iE-UH
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:55:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMaxf-0000gh-Qd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:55:15 -0400
Received: by mail-pl1-x643.google.com with SMTP id q15so6895805pll.11
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9UbSfIMFuKKq3a4pLhCDfWyAOzaZGKUsvANG72m6zuc=;
 b=ketX+tAL3vdhBlaXcv4b/4WfFeOZO/BXdSaaZGCOMzY7b7kHmB4C2HxId9EyiF8P2J
 lArRAoy7Wk9GesbLRpoWcWP0qXSaujM4hqWeaSFJdGVOVvTMfm5DR3eL/vCy0FQrjQsb
 pLoPj+go2eXn+bEFrqj457qd95+33/f61LYA90vkQpPqGlZAyd1Y6cC3HJf4H46d7Crw
 SqWxRhqcBmPUojcYnbxtm5JreDKBAnnlVZ2VptPG9dzW5Fzs22kRS2/2ckpW8KlU5r3L
 HETi1mxg9ehamnZ7odLhWmKWswvtgbIqCx7kfxo1LwC5PuMiWpsWsntUsbIP3WrKeAFD
 DpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9UbSfIMFuKKq3a4pLhCDfWyAOzaZGKUsvANG72m6zuc=;
 b=G1c1pYMA0ZLxcwTyCOGW+d9e468Bwo0dqgJaKxLEbLkDpRcW3u8SBUHw+ELFPhJHW/
 kjdR70iUVsdGdBU6GXRz2mt9sXXPXBv5173TIEBTr7sINtBWxui6TQVePlDcXggi43ZL
 XC1hTeOTO/j6lqpBLti31xVxO6jUsIWyuW8qMtijAE1Nb3BHfSpzBEzoITy+tr1wJk2E
 9guYbcq0Mtq9pkWnGcL/I9OrE0wZBwIQi5mNNa7+FZZ+a5IXGtvcdutYxWGlppBpdJaz
 cJWkMdzpyrXWc61TlTx+FQk32tAwF/RDo8IcIe1Evu3B60F917cp5c1cvrO6kMO3s1mF
 BxZw==
X-Gm-Message-State: APjAAAXmfurNVmPy2Iw6eQZoevqMoiGnaLrMSkMpJVwW04683CSgLFV1
 ZStWZlE2vAjc0q0vhHnMSbKfTQ==
X-Google-Smtp-Source: APXvYqzXHbErkuWSm+htTg/Q8Fywjpxzs1wKnVPEgyjEQANRTNd5OQI0BockuZCrJVJ3gNROXkQ/NA==
X-Received: by 2002:a17:902:8b81:: with SMTP id
 ay1mr25839552plb.79.1571676913321; 
 Mon, 21 Oct 2019 09:55:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q13sm18761135pfn.150.2019.10.21.09.55.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:55:12 -0700 (PDT)
Subject: Re: [PATCH 03/21] hw/arm/collie: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <810674dd-6e82-5aa9-c183-f9800f87b559@linaro.org>
Date: Mon, 21 Oct 2019 09:55:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> The SDRAM is incorrectly created in the SA1110 SoC.
> Move its creation in the board code, this will later allow the
> board to have the QOM ownership of the RAM.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/collie.c    | 8 ++++++--
>  hw/arm/strongarm.c | 7 +------
>  hw/arm/strongarm.h | 4 +---
>  3 files changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



