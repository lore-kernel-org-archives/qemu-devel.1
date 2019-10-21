Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14AA20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2bD0PqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14AA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbdV-0008IG-SD
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbYZ-0002XB-TY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbYY-0007No-NA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:33:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbYY-0007NU-FI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:33:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id f14so8205002pgi.9
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XQgliv5W/yujWnRU/ia+DZImKA+7XrFz78aqwlCCCLs=;
 b=E2bD0PqQ+lHzfS4tDl6X/R9xw4N3CVG4YmPVvb/jckCPfu5htExHkhTi4X0TTp3icO
 VxqFhlRYwCiDicg67FvY7M7X0xMt+RVHRirA7oTNe1FVifjdxJ2M/qhjsu6XQh5X+UR5
 mRV+bNeYHs5H+uFyFKtSjfzJSJRAphYaRAQNZHYjrt5LcL/FfVPsdTv9GpwoAx2jofF5
 Or89L3hSTxpn+UoIwvaz6sxOO3bIa8N8/a0pCsvrUhwYIPZ6n48P/C/HLOSEDoWQ1UeN
 51xt+encP9BgBNxmMxDylyIyTDmavOLDLx17vT3xJFqboXubn858DbazoqbnZuSf1uPH
 vEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XQgliv5W/yujWnRU/ia+DZImKA+7XrFz78aqwlCCCLs=;
 b=WHSAyoPY8PJqf0COauwgTRWPmojKG5IWZsWqTXiJXgCqKlAWSpDv+QQ10NUH9K5W2d
 fJzIH2d9f+RvapZ52DWI7Jw5UTH3TDYcOat/VtXoUtdCWV9E33p+/DoxjwRqkFC6379v
 334Tplnd+nChTFe1Gn8urTA3NONH83TdeKdDUyuQd1KO9LHWZ+WInFCvFuEsxP1bVu0l
 KlCranKtxKlCGe7IJk40Ml9A3ugqhR0eAPVUQ8YSLnL56+BSjQNVnuEo623WWfpo0IPA
 YtQQvd++3GnDQjypDWKUc1IgbBuPy63oLDwZsYbbKFg7w1KRkabn6GSbcOSMHWswp0Zd
 5fNA==
X-Gm-Message-State: APjAAAVmsBTBn7lOdvU5/LS64CbGcFHOPEICA0/VCwH+u8+r8m6vm27Q
 4NySuVHZnOJTE5pKED3qtYSjiQ==
X-Google-Smtp-Source: APXvYqy877oGOzyimJCL3Q5zUplxvjelzWYWgO3Y/0diE3SCocZYvWYnY4mCr0ZhcPLMwvEYi6aiwA==
X-Received: by 2002:a63:1720:: with SMTP id x32mr9104324pgl.278.1571679201316; 
 Mon, 21 Oct 2019 10:33:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p66sm18147940pfg.127.2019.10.21.10.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:33:20 -0700 (PDT)
Subject: Re: [PATCH 19/21] hw/ppc: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-20-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c52898e4-f26a-58be-6765-b708e9d7e879@linaro.org>
Date: Mon, 21 Oct 2019 10:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-20-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/ppc/e500.c          | 3 ++-
>  hw/ppc/mac_newworld.c  | 3 ++-
>  hw/ppc/mac_oldworld.c  | 2 +-
>  hw/ppc/pnv.c           | 2 +-
>  hw/ppc/ppc405_boards.c | 6 +++---
>  hw/ppc/prep.c          | 3 ++-
>  hw/ppc/spapr.c         | 2 +-
>  hw/ppc/virtex_ml507.c  | 2 +-
>  8 files changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

