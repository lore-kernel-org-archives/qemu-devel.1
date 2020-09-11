Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F55EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE57221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPb4cUMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE57221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGrmy-0002VR-Dj
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 18:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGrmO-0001vH-QI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:44:28 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGrmN-0000Pz-Aq
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:44:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id f2so5542214pgd.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QqTCp/aW0Z9Blzuv8kD89yYoCVf7YZhzsv7aZmb2IX4=;
 b=HPb4cUMz18VMHNsLr7BuqidAlU6IbO4UIwC40jEiLAwF7Mrqd7d8UBrnJL+KUhlWCM
 yPsuCzFR2rfT8+s5k0oFaoOiiCZ6BfxVpj4PE/mi6RcL4ZK1I1AxG9CLzi07FeoII2uO
 CLl5UirmnFmout7uEFBugEZ7m8L2AQC/bEAiuRVMUnzZen5XMfyf0nt/7ePvPZ/csbEk
 p1NE5Cy6Xr7alFLeQajlOiAfC0pSN7o+B+WtvDdEIJL81dI7QMaSdyBVuTdOi65t9oK0
 oTohMIsFzHttJ1yWScpkmQRKbBCzbzNC6kz2VVMzPdBaZnYOHcPF75fjTUCIaBMTyY4j
 5qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QqTCp/aW0Z9Blzuv8kD89yYoCVf7YZhzsv7aZmb2IX4=;
 b=eI3cRrtr0Kx+o6KhyDEV7j8Jl1gEFS52nIwh36tLMDqZfsexGiwvGf1qqzBbXJQU0i
 OxofAmiscsTU0vyYT1rNw3hcclQrGLXklnlZU/yeJpdI1x0/h4Y2AIKV14JWvJvFOYxQ
 rE+BbUn5HubfLHuHe2NjyRCTrnh2/E3fTBv+XIvSF3eWHGK+hci7twpOHGhSigWkNmQs
 GQZ31naxmlpD8NAF/6HzlM+/NhxWobFEmnZp2R30vFZPVQRtyv63Glw/bX6epOVyrZm3
 wBCFtdwnnUIsuKUQjynTgQlQWu9+/i4PI6vxvS1AAk6JYLyaL9mDyokd38FnQ8RaQokS
 aCYQ==
X-Gm-Message-State: AOAM533J29so0EFTn6+tk3lJD6jkSV+t/HyupzzX5WgiogJpEgVsVLgx
 FTOOF/Py1eKzFgvpOFCyGhU9gQ==
X-Google-Smtp-Source: ABdhPJzxDmIjA+OX83YnzwWUu0pTjoPeFg1MKqfpB7QyFijWt8KS4ft+biH0tAd4P/fe5mgPlmE/RQ==
X-Received: by 2002:a62:2a89:: with SMTP id q131mr4074632pfq.33.1599864265717; 
 Fri, 11 Sep 2020 15:44:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v69sm2607529pgd.61.2020.09.11.15.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 15:44:25 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
Date: Fri, 11 Sep 2020 15:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910205429.727766-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
> Some devices expose GPIO lines.
> 
> Add a GPIO qdev input to our LED device, so we can
> connect a GPIO output using qdev_connect_gpio_out().
> 
> When used with GPIOs, the intensity can only be either
> minium or maximum. This depends of the polarity of the
> GPIO (which can be inverted).
> Declare the GpioPolarity type to model the polarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/led.h  |  8 ++++++++
>  include/hw/qdev-core.h |  8 ++++++++
>  hw/misc/led.c          | 17 ++++++++++++++++-
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> index f5afaa34bfb..71c9b8c59bf 100644
> --- a/include/hw/misc/led.h
> +++ b/include/hw/misc/led.h
> @@ -38,10 +38,16 @@ typedef struct LEDState {
>      /* Public */
>  
>      uint8_t intensity_percent;
> +    qemu_irq irq;
>  
>      /* Properties */
>      char *description;
>      char *color;
> +    /*
> +     * When used with GPIO, the intensity at reset is related
> +     * to the GPIO polarity.
> +     */
> +    bool inverted_polarity;

Why are you not using the GpioPolarity enum that you added?


r~

