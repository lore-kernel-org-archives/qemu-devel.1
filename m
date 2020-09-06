Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD11C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D48620708
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tja8Xl8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D48620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEloX-0005Zu-Gq
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 23:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElnz-0004tS-CD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:57:27 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElnx-0004pg-TY
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:57:27 -0400
Received: by mail-pl1-x643.google.com with SMTP id x18so2933222pll.6
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RnqUtE4ljk8DtHfZkW5V5MIYZY7r2mGN0YOahYj8MCo=;
 b=tja8Xl8LEq2mkghIKXgo4a2qYj7UAdF9DnQ1ZGO35L8JjgYia2a0igWEM9hD6jbzFO
 dwz6lnVj4GK6fa6YBHrT3HqTRXfNzsB9Sj7/HWPKEiqnrawZX9aAjLZocKiuH0rtkqkN
 dWOL790Pf49SyBaigoQ6UXHSZKujKuZJd0rHO8A4mKFmXCB2dXH9tkKZOggj8kaKkOHg
 L9p+vHcWrIjH2JWQaLUUen0L306ca05an2DhM9NhJw9BcNYA32oY86kaTgwA+Z5KKIab
 slXv+6b2y/K/dECyTXMYA7F1hscbyeHAgl/OpSIHdnOjwIx1waNxiHzAATrXIArreH5X
 tWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RnqUtE4ljk8DtHfZkW5V5MIYZY7r2mGN0YOahYj8MCo=;
 b=KCQbRLUjFDnGGqafNfRUuXq4nPajCZ7v6XhRl9fFLVK6/uG907fvbl1T797biIfcGV
 lX/9zzrW2FRh3v14NAJrin2p+/w582JNfdgJ7a4tjkRYeYhNE3zR62nNWU0wsTy+PxWG
 g8AADuE9Zo2KGkSk4GHLaWrrTonIR2FDB2ev9yc20B+OtVRxy6OkCONNR/6DcI7aqQAQ
 IViqs3my4FMIUFye5XSoDsFh0DBPQWwLXYQt8K+/QHLr3agFENl+DG25T6HoJ926Z07W
 zjoqP7Ef56xgLNRMTGcZ6oPxrpd1C/21xmEWqyfqdHAbsKdQesxfXtql4SsrVzyamoVr
 XUKg==
X-Gm-Message-State: AOAM531GRFY0oup3Fpu/yP8ySInfm4ITTo5tBI+IrpYSYJF5lCAK8OhO
 Zv+rA3V9Hi5Le/g5/FRS2DTacA==
X-Google-Smtp-Source: ABdhPJwtBeVQqa4Fa0iQHSWFoqf0IhbeCGCx3CQUkHiLKauRbpTkoxUKyQvS6crZ5V7S0ht/0ne6+w==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr14823732pld.1.1599364644473; 
 Sat, 05 Sep 2020 20:57:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s9sm8665683pgm.40.2020.09.05.20.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:57:23 -0700 (PDT)
Subject: Re: [PATCH 05/13] dma: Let dma_memory_rw() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <67fa39bc-1eb4-50c8-2e96-2c399a42d642@linaro.org>
Date: Sat, 5 Sep 2020 20:57:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> address_space_rw() returns a MemTxResult type.
> Do not discard it, return it to the caller.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/dma.h | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


