Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213AC43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5741420757
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muYf3MN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5741420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kElsn-00021v-EV
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 00:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElrB-0000qU-PW
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:00:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElr6-0005Bt-SZ
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:00:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id a8so2948456plm.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 21:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BqgMualDv57fOos3mfS0fAxCz8frh8Smz0o2lIy1Rxc=;
 b=muYf3MN+s7hIbLpkM0s6/hvlfbOQ8THCWWg5FHNgU2B9zmS9bRuEl5OceFPr9ScTgs
 S1wrFp/RUwn/mpL+zPR6TOX9XaayyBypDk6NpH/umek1o35B+fgKS/AR2N3DDQXo5RCQ
 vco+RqS2DL2faYAZ6IlX5+iolU3XR7GYk1xZPn60QkUz5Jr15I1/VzPxz82Y4cej54Kw
 Th4MTpQyyxW9Rz35NMD11tvKKlyy30qwcNGt8oCoaNm2u/1YN4r9cN93bG2VczU1GrB+
 lZlKPl8KEjEYLsLa1Hj5O3EkLUAkqZZ63/e2H5fXOdktbscKUlRUQnVwuARn797BvvGP
 BD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BqgMualDv57fOos3mfS0fAxCz8frh8Smz0o2lIy1Rxc=;
 b=NdBAkMRw8M8LuYTKd0jRPUDK+LNsVfaqh9l3kK70pTauKuHdphFyP46gIa4KeqECvl
 gpMgk2iUV5UGfFJAPnoq1qU32eUGMVMWxg/GqWJvA5Hx3vDmP0lDdWrJRCzW64hdxuCo
 NtoSTCqkJYfmYVpIOJP3gmiVw5skjdoAgF03ucW/LQNPsTsR+spVCUe/Gkd/qg1W32NG
 97w1FXu7WkcaWDk4bfq8xD1Bq9VQLoFUU7vDtASZOcY+AR8Bgpp1Shtg9kEXe9NoUL7B
 JGYcWWsXpY7ddTDzuqDxqkcNpqEU2E5DvQaKATjkCZqk4x+lISVkj3P6zEWm+J1Poc1A
 W+NQ==
X-Gm-Message-State: AOAM530ubwVsGY1zuP2IgeJxdaQcL71GRvKc68ImKiZsBl6z7dWmvErm
 WRY7PbN7RmdwKnS+FUJqpemhUQ==
X-Google-Smtp-Source: ABdhPJyMdBVDYshJY8UytZafu91UkSV2Hzy/pLppnb+z0Huj/sHx9Ef/gF0IVjnICDzqId2x8zxEcw==
X-Received: by 2002:a17:902:988f:: with SMTP id
 s15mr14698750plp.26.1599364839449; 
 Sat, 05 Sep 2020 21:00:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h14sm10514702pfe.67.2020.09.05.21.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 21:00:38 -0700 (PDT)
Subject: Re: [PATCH 09/13] dma: Let dma_memory_set() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-10-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b780bd3-ddb3-b493-00c2-e980860ea98c@linaro.org>
Date: Sat, 5 Sep 2020 21:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
> dma_memory_set().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/ppc/spapr_vio.h | 3 ++-
>  include/sysemu/dma.h       | 3 ++-
>  dma-helpers.c              | 5 ++---
>  hw/nvram/fw_cfg.c          | 3 ++-
>  4 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


