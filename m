Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D140C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC28020708
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgLi3lun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC28020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEln2-0004Jh-Kr
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 23:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElmO-0003j0-Iw
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:55:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElmL-0004cC-KC
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:55:48 -0400
Received: by mail-pf1-x444.google.com with SMTP id u128so6796052pfb.6
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YdXrO1KbN7EXdj5YuDbtxB+U8NJQK3EdmQqlnWXQJG0=;
 b=CgLi3lunG2cTb0bUyPkjcHXCMpw7WI2mbjHJTdvIwMnM0CRy3RZd52IYLG38NMt12d
 BX2td4oInGV64IXdJwUmkRieT93SzdIk9leGxJUu7uR+K0zlY/OdWQA7Qx1/Q1QpAr3U
 EuHZUl6HVoFyymPGSotJ4+vtCArYcEUfyCWR7ujFwFnfNj2xP7IfASAwWMBwsdy034Yj
 JmOaO5rTlsniZm7V79CO/eALCG5PCiD7smcND7X5MsOEl7haWzLNGc1fgMh8AO1nLWgW
 gL5QSLXRg6lXiJk7JvzVSTtTw6DQivXxbGK4BIvKTqXL0HqxMhWRUGYlnKzp/aHLodWI
 NKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YdXrO1KbN7EXdj5YuDbtxB+U8NJQK3EdmQqlnWXQJG0=;
 b=pIg94CtFA81uUJS4EiaQWPgQZxFDY1/ndW2wRQ1WKuK6S12syUHuhxVtL/A9SuLQRG
 OPq6U37lz/ciz5YdVrZxRtVhGR5cFYDjtybl1nboXE8U+qZXpKWuZAvDuh12bWLcn8vE
 pR+K2VpMwo7iXT/d2QJYEvlqVOAqlmrQhLKr/t7elt4SJjcjH/7fJ2IMX6TlCQk7V6tN
 YuIct7E9JRMaXepR0DkDK+LjAIhoSKUzQRahqlnMtxs+DxvsOHfaw0g5xcHxm8akv+lK
 RzQVNMn50GhsjM4Af90elEPF0+TuhMZUBD7zH91ez4/LaduYN3fhxz0sr1R0hdeCNAtt
 N8cg==
X-Gm-Message-State: AOAM53304Hwo74e9McJ1UvTqN4izQT7SxqZFEcrPEtbVTkmanZYrasPq
 g/AXkxnn6d0A5rHVxT0ZdJC18g==
X-Google-Smtp-Source: ABdhPJz28X/VvyrV02JpGSOTcLPviOHKo7L111CkzUSijkCEL0WSPL4JvieP0UB0nWBe5t+FeuxM2A==
X-Received: by 2002:aa7:9991:0:b029:13c:1611:6530 with SMTP id
 k17-20020aa799910000b029013c16116530mr13131399pfh.16.1599364543383; 
 Sat, 05 Sep 2020 20:55:43 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 8sm9043772pjx.14.2020.09.05.20.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:55:42 -0700 (PDT)
Subject: Re: [PATCH 04/13] dma: Let dma_memory_set() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7dd368a6-ec30-7b00-d54c-dad25c3d3d5b@linaro.org>
Date: Sat, 5 Sep 2020 20:55:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
> address_space_write() returns a MemTxResult type.
> Do not discard it, return it to the caller.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/dma.h | 15 ++++++++++++++-
>  dma-helpers.c        |  7 ++++---
>  2 files changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


