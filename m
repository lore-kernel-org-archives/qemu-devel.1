Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84DCC43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584782073B
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXqlIx8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584782073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEleP-00006h-EZ
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 23:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElco-00067g-0e
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:45:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElcl-0003Yj-4F
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:45:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id h2so2944396plr.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t2VnuRpgNp/JrCV+HPg0YJnBxE1cK2hkQDvKZ7hGxfI=;
 b=qXqlIx8m2fGiZiZp/aJ3cCrMKdMVDosOHIWk2+vzObOwEmRI+dz+AmtMp4GbJRHt6B
 yaNMMKrmpQprkuue+ZSsFI3pfgpvrqoHzB2GtzKVLEXizuDR0vviTzWTEce8/HFd4SHQ
 QkxLui1Ode1cw3ga9zxtXlG2AtiSHYuzoUWmTvVSiEjIc3J0arQ2A6JXGEMMyL3rlyKU
 ufh1AQxbuU2H07Ajf0/TdZUorTeH38eGZDDNBtahM414E4eLuuzGg00sfYNPOvcEWpsO
 1yS4xmx8zf50IEFyOdZMshc7RG1r/WU2St4AhVUh2ULfwqXX7jvIjZqSFTzUMy6CCDjT
 4BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t2VnuRpgNp/JrCV+HPg0YJnBxE1cK2hkQDvKZ7hGxfI=;
 b=f6PLqwiovqTIGvuaJoHpKdCPdi55BJ8FIayjMS/sxw50qGJvKZStTFwAjhh2Pnz7WY
 DT+6ngXjVbpFfIXNPWY/qJriR8RYapSugIxXZ5bETySY/4M4knYKr4Y+UdsHkbC/S6Zq
 AtoT2CKkghpKB/Lzrs1mdsAAJvVjqpPJjS7o6qE+Hoo8pQnZrDCLVsSCeqcSyjqtCebZ
 xbAew/SkAqJLfugB6h8qJE66ch1STO5hxx3ykcwSS5oYBtbSnBF1uUl06KIQY8eGQHF/
 AovO4rmr66tgwBKwQy3ijRCdwgoZwbwNFOJjCfksGT1ivcEuiGA933Bbn/By6LZNRFJF
 yoAA==
X-Gm-Message-State: AOAM533oei1C/iaoyWwHSXR5CwqZg3DvdiLBQ9nQAKv0laqvEb61Vd43
 Oi4lybYrCFNHMrXqJaEaxqhGzQ==
X-Google-Smtp-Source: ABdhPJwO319ynbHEi1COkRvQfq+Sxsb3DJrgDW+lTb1LUzzJ7CUqSt3Do6nLkPfKrNc+hk3FrlXVvA==
X-Received: by 2002:a17:902:a9c2:: with SMTP id
 b2mr14583057plr.56.1599363949849; 
 Sat, 05 Sep 2020 20:45:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w6sm8812245pgr.82.2020.09.05.20.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:45:49 -0700 (PDT)
Subject: Re: [PATCH 02/13] docs/devel/loads-stores: Add regexp for DMA
 functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf52d63d-047e-42ac-5336-829ae3e9028c@linaro.org>
Date: Sat, 5 Sep 2020 20:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  docs/devel/loads-stores.rst | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


