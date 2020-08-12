Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D624C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFF320781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9eg6aBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFF320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5umq-0002ZY-DK
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ulc-000106-Sx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:42:25 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:39840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ula-00041I-Pa
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:42:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id v15so1410945pgh.6
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u7BM2p5+FEA0d8s/HZAHAVuYnzAPBWAFYsCbsMv++3w=;
 b=O9eg6aBhWrHnARr9rkmQBoyCuKwcVhrcMyEXkQ9iiQ9qFfckDXe2dqAP0iEhBTzBkn
 YQ9nyR8BUNnfNgrr/egG2TYkrrl6AecLBG1mMDfy/XY69/+6idYfJh8WK6yb0aDw/6FS
 /M7HmAOEVvrUjKJJxIvpwZQezNT+E2469X/AabWcfp0EETQJIVkNjKX/I4fIl2Jkx0IH
 mDCImgMVdxH7wl3PYqPJaGiUy79fOLuayatFAvFzbAN27heNUPkkxTlIr085omjmAVYH
 eBnM3YWwh/kgmiKCkLE6FO/Xqm/3TKNpyNpmH37hav0zUUbPk6Biep22j0n6stFXwkP5
 sLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u7BM2p5+FEA0d8s/HZAHAVuYnzAPBWAFYsCbsMv++3w=;
 b=QGM8hNjAsSBLhfRomGDGspeydsQbZ0lK0Zm7YkYwjFix9Vp9f75qhyJKe5PLRdCfaa
 sPQzUTtfasiVkONuvijd7/mIi97pqa23LP2E2V16SVAcp364XS0w7vSGalY3e/pQYTU7
 /Ao9MojRfiIBZNh0wEgpzpVg/rFGjGIbDEqiTFnbosp+QtuCdDywExcgHVoaVIpAe3Dz
 HcsqY+IYKgaxUnJValbDYV5cFaTj18sW+pdoSQioblRKIHjYwiCuODCldEFNMU+FWCe6
 dtOAlBj/kROlElqEmNpYU0jY3HpxiuLEk6WQ+QqDBIS32FPENAeTPjbH23NIVVgFalDB
 R4GA==
X-Gm-Message-State: AOAM533f6Z08/pEyaTTl1V3WxUnomQUBacfp7k2Bk2FKOV9BBKnfFp+p
 0Kd/op4ehoWdqkzJ0kdf/PKGIA==
X-Google-Smtp-Source: ABdhPJwWcyHFijdnawXtblspEgA4GBN//wgMyuHwjDkTxzh6aT7Uomw8zlqLlbhHmjTmcikuO1aH9g==
X-Received: by 2002:a05:6a00:81:: with SMTP id c1mr618343pfj.189.1597254141529; 
 Wed, 12 Aug 2020 10:42:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j10sm3007746pff.171.2020.08.12.10.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:42:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 2/4] hw/char/serial: Remove old DEBUG_SERIAL
 commented code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806130340.17316-1-f4bug@amsat.org>
 <20200806130340.17316-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <750a1691-5926-1917-5a26-81a73044a24b@linaro.org>
Date: Wed, 12 Aug 2020 10:42:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806130340.17316-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 6:03 AM, Philippe Mathieu-Daudé wrote:
> All useful DPRINTF() calls have been converted to trace
> events.  Remove a pointless one in the IOEventHandler,
> and drop the DEBUG_SERIAL ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/char/serial.c | 11 -----------
>  1 file changed, 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

