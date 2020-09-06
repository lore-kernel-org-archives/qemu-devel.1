Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D2C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E09420757
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 04:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTO2s3B7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E09420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEltz-0003es-NY
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 00:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElsT-000242-1n
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:02:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElsK-0005Rg-Nr
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 00:02:04 -0400
Received: by mail-pl1-x644.google.com with SMTP id x18so2935937pll.6
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+FK3z7SEtHHMAHcUbWz3yY5WEnySEdB15eOW6FkW6Pk=;
 b=pTO2s3B740aWaEYgsDYQjq6N2JpqRdS7uvxP/5LRTU2vnjGq4qfHiTRI7QNeQM2DgX
 Ks6iJYPzZ9QRTB2/nw+SznP4R/NNxuAZQGtvEqHgMANlCQogMryrXHeoHXB4aApyxtSI
 SU4CmgAeOtdFkJPk1I2s5qDQt7ABtrNxtK6YxwV1RO5370E1mDayVKwBAg5j6m39Hnbx
 hfuaNctH1SadDOjG0bMy4C23R3xK/M2ZOUwG+q+dQ8531kgKrOSNK91dyD4Ktc+qtFMd
 kKL4o1qH9qfe/T6H4qNT0wkL5lcCSd3b3leSlw1QneyFVdx7L6l+abK2eD6GxvZyDbxT
 eRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+FK3z7SEtHHMAHcUbWz3yY5WEnySEdB15eOW6FkW6Pk=;
 b=eK+bMpt0dbG+RoQYPyR10hdiWa0JYyBwSvwYxphRoIwGVulytjHZ94BFnETb5dpMNv
 7NnyYhOok7rEGnLP/ULCbgRzNl6H9l/DEeq8ZsdiOaMFGgv5cD/dGzJhrd3FwWUHMCWf
 fYKv7lO4TTdoPigV+UbsCqZWJvZbKOPi45NSecHxNsLtyNUWH0ZLJKLhyKOJybiX5mR9
 A6jE2AUhSALO8Sxkp6zxAfdlEoXyjx/QCC+SXmiLKgi/ZcFKNKzeCNnMCtQUfycClOtb
 JYZ3p2IHhM03So6mHns/WquGcXlB1fImbxIGGMhhaMCXhlGiJjSGGKDt4PWv/TB1LkVA
 vH/w==
X-Gm-Message-State: AOAM5336EsJB9gSvZzRM5n29giV8+NsOctlZHKJaplTdZSSL76lOT6z/
 TeNlosW64PveOL8QmU96NYaMzQ==
X-Google-Smtp-Source: ABdhPJxvFya3IBbOR9LxF0EMe4DI38mKuccgDA+zzYacp3/e6hVxE4On4hdopOM1g7WbIKl3wDJ5AA==
X-Received: by 2002:a17:90a:de09:: with SMTP id
 m9mr14617064pjv.231.1599364915228; 
 Sat, 05 Sep 2020 21:01:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d12sm10924564pfn.146.2020.09.05.21.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 21:01:54 -0700 (PDT)
Subject: Re: [PATCH 10/13] dma: Let dma_memory_rw_relaxed() take MemTxAttrs
 argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-11-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a73f8e2-85d9-e6e8-255b-3644406352e5@linaro.org>
Date: Sat, 5 Sep 2020 21:01:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-11-philmd@redhat.com>
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
> We will add the MemTxAttrs argument to dma_memory_rw() in
> the next commit. Since dma_memory_rw_relaxed() is only used
> by dma_memory_rw(), modify it first in a separate commit to
> keep the next commit easier to review.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/dma.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


