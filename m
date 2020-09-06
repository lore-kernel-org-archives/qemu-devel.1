Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D65C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BB220757
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2dkmEpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BB220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEluE-0003yX-Uz
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 00:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEltK-0002r5-TT
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:02:58 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEltI-0005VE-K3
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:02:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id m15so1827691pls.8
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 21:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F/yrApjoieedPs4WcscGvUC363fGK8G23iY++bTYdgE=;
 b=l2dkmEpZsjqcHGt4C0xrTxC7E3zLVKk8+LXfF6lxIqn2fv6dUFn/JIGDYKsRt0MxKC
 6LfxZFppnJthDaJbX3wHp19Cth5/VwK64RruP0nnLIuEuEDlj5w31V8FTtl8t+FOmp7t
 +V1CIIlQN4iKz414Ux0SuZ1yv5uEm6ehOKksIegQ3mDTXCGgimPtQ08pZaHNMAjViVNf
 yUTelo0E6uNzjMXaHR3a0rvMYiIYf/IZ7jzkzIZo/YUHUAk0R1MgnU99QcbioqBkhhua
 tCv0o6stg0rGKZsFhgXWW2Q/S3UpZU3FlvqJkzSvyXY+MrN2eDeD/CO8A4fe+CjOesh3
 NjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F/yrApjoieedPs4WcscGvUC363fGK8G23iY++bTYdgE=;
 b=kKl7J7JWOuSaMvFH+ANUPetqANEwSKRF79aPy9hnr3Ad5B2RzOgdYVWGIESrPgu9Fg
 S16gw1t2+nVXygKbQ8bSa+7SBtfyhAc2uZu0iIUF4uHCkaek0KrWjDFeU8FWNuQi9mvo
 JdWffxleC0K/cVv0IrT5m7zBp6XEzPbcblTVut3BK40dMk/ral1aTEq1vMW8FVyL38CA
 3IWXQDvFM6XSVUbzfkXrd0yhwTgcKFt1ETXOfXr9bTXUHYxINppk9EZ19MHNZqwwlx9f
 y/OiL6FIlEBpUhRRKCwuWc5WSDf3AERgegp2wgc1XBQl7UYpU97u4W57dZ+CmqdhkiWY
 +HTQ==
X-Gm-Message-State: AOAM531DfkvNLQIaOOxWNQrnANnLanrKxxmADO4au6QF42mBpVUe9EVb
 NrX0KZvvBtuh7q3AiXDV7fVYDg==
X-Google-Smtp-Source: ABdhPJzuEFBEVy0kE1sLzq9aOh1AskEocutFAogDOwN+f8aJgigAxV0u4Vo0qEzvPI5F8VYQmUX7/A==
X-Received: by 2002:a17:90b:f09:: with SMTP id
 br9mr14610755pjb.102.1599364975234; 
 Sat, 05 Sep 2020 21:02:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e1sm10906425pfn.78.2020.09.05.21.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 21:02:54 -0700 (PDT)
Subject: Re: [PATCH 11/13] dma: Let dma_memory_rw() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-12-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce74259a-b1f8-8f28-b496-5b422e502f17@linaro.org>
Date: Sat, 5 Sep 2020 21:02:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
> dma_memory_rw().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/pci/pci.h |  3 ++-
>  include/sysemu/dma.h | 11 ++++++-----
>  dma-helpers.c        |  3 ++-
>  hw/intc/spapr_xive.c |  3 ++-
>  hw/usb/hcd-ohci.c    | 10 ++++++----
>  5 files changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


