Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E30C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB1B2064B
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0WPo3/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB1B2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kElrM-0000oj-GE
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 00:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElqS-0008PH-0p
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:00:00 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElqP-00057T-On
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:59:59 -0400
Received: by mail-pj1-x1043.google.com with SMTP id o16so5034794pjr.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5lybWbpOHe/PDWuXx4ITu7hdnEIIfq2Qd0mXlGdbAfk=;
 b=m0WPo3/zoh/ujdrUw5tueEGqrVuvEoneL1l6my7dBoD3rU5h2e+gaa205FgJ8952GJ
 08r5nfG0ZGP35uKitFukky+6ZuX3mMuvzjWcS1ct3l1f7yQ0l76s8WVgulOxr2riMdIq
 eItwwwWfim0Llat8RPPIcEStuoO4h9/b1QOMpz7S8BCyw4GNiSY83ST80CDL/ItEO0Oc
 QmEgFHwmtQtyZ5l4pFNK7N/hrj4R65icFQkNtskThCr4Y8Az8YRGSnvZQ0twQeW92O8z
 mhyNvaMZTM/X0uWt+yNlLZthYT3O0u3BZsqxCGCdxk3k7aRZ84cqyWN5qZ5l4xXYxSvq
 YF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5lybWbpOHe/PDWuXx4ITu7hdnEIIfq2Qd0mXlGdbAfk=;
 b=Y4kUq9k0tGXYPRSMUBP1x8qTrQgZRYEaw6BOnz4eOlfZ12jDAnGIMk5hc4LvfTyddJ
 +uv9nhCmLnV2+Ob4JltDud/1PGoGgwdjKrQY+dOAaiX2DtAcvAYT+HM4tSiAdCWHzLRD
 Q20213ePVWZidTqEsXyzd6fdTmjJ6oQP2YZBPSbX4w94INZj5oZnmt7tG/4NhokFl2TE
 GSfahWDzYcCp+0Dyfijjc2jy5X16BkMoMDOa/UMEmuuJc2oJC9jeYWURMlrVOCaqxstL
 fKqq02F0YGVKDFXZsZlKLljFugAnwtb1p7prC9/VjE2N2xlexQix9EsVlnz1IX+cbW7y
 j0vQ==
X-Gm-Message-State: AOAM530EGiuEoBJPVJEl3YUAHs8Nwx+d2yjJPMpPBaQBhm+bzdQDctE3
 ZAqK32TxDnX8G2ujoNUCpAqzLw==
X-Google-Smtp-Source: ABdhPJzBQHtR0vjDsv3ORxzhx2rh0mhv+lm3rW4IVT9Eol+2Aauif9RIaynsOGH4glbr3I+G+Qa/rg==
X-Received: by 2002:a17:90a:ad48:: with SMTP id
 w8mr14820945pjv.179.1599364796430; 
 Sat, 05 Sep 2020 20:59:56 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t5sm8710221pji.51.2020.09.05.20.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:59:55 -0700 (PDT)
Subject: Re: [PATCH 08/13] dma: Let dma_memory_valid() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-9-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5adab944-14a8-6f68-bbcc-92d193db554c@linaro.org>
Date: Sat, 5 Sep 2020 20:59:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 8:44 AM, Philippe Mathieu-Daudé wrote:
> Let devices specify transaction attributes when calling
> dma_memory_valid().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/ppc/spapr_vio.h | 2 +-
>  include/sysemu/dma.h       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


