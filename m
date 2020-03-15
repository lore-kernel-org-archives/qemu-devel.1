Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22708C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD63D20575
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/Uwjvyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD63D20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDYPL-0001XI-00
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 14:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDYLn-0000iP-5f
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDYLl-0004mk-8O
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:51:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDYLj-0004h6-JP
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:51:00 -0400
Received: by mail-pg1-x543.google.com with SMTP id t24so8324791pgj.7
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NLl/x5daNVxkbMBOfemkryoDMVoJ0OZ6NQ0eRCfSaI4=;
 b=t/Uwjvynhxk6wz9Z58UvhqPFu81VwpRcreAcdSZz7DCnN5BxqAwEKyQdmucI+r8S9B
 Z/XKpJIinArueF5j3AobrXi0CAhN2Ybp3DR5FMuhqQXPv71XxeVLhnApPDlF/V3RwN0p
 Z3H0HAV0xYiF7ew1d0Yx9HU6MqDUsEMxYdGkCb8q4qkZHA9dvoNp2aCFnTvfTvEFadnb
 fkkjuPQVATTsSCI1/AlXyJuPonIvAReFKHO8jslrx5PZkDww1/kpQ7JOsu8TumXMsOot
 grX+w+0sDWRusEhYHxQ8kXrL4zAmieAZC/Xp/Snh7r/ed9mkKdonsEhMoKdc0ZvgOUsh
 FeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NLl/x5daNVxkbMBOfemkryoDMVoJ0OZ6NQ0eRCfSaI4=;
 b=CYqHPMs9ntvnWKMEMazO4R0gXudPDg4lo4GEtiycS/cYJZSKYhy5D4hYDEzmjeP7VK
 F5UfRNo9h65HGtP+IOjhi9sVf5bq0QF2RwYURNzXqbEq3MewSxA2fSzVLfc8XZz/TXi6
 EXZ2tg5n1eQ1Ma2a4ovnCIssAdK9hSfnCFzfRXW1neUBSlD2EdvVLJSEZx+EZLdgN2eE
 wD+mj2Dun6t8UGGFKjmfjBlGrVDiov2QVWwjEya0jQhmuAp2KQIDKakDwjj0eoQekA+X
 zE0iMrnbZwPGSRv7BXC08e77ctVqgNpjQFYORUuGwBCsLEGyAmtsx46Uk2j0A/npPrFN
 MPNg==
X-Gm-Message-State: ANhLgQ3wDMeYJDKMWrgas3galOT2CXaAarGldhvEemTU94LKkGFXjZ57
 FM0nAuIysqNhIuYVvtNFnN+z5A==
X-Google-Smtp-Source: ADFU+vucnNG+1DRo0M6rKdM0EgSgra8sx98KrsS2Y8hFJ6QBXRMYaZh7jhN2XpAteCmS2kMutWb4OQ==
X-Received: by 2002:a65:488d:: with SMTP id n13mr23005019pgs.91.1584298258128; 
 Sun, 15 Mar 2020 11:50:58 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p8sm6159482pff.26.2020.03.15.11.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 11:50:57 -0700 (PDT)
Subject: Re: [PATCH] target/rx/cpu: Use address_space_ldl() to read reset
 vector address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200315134859.9547-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8146c09d-48b5-f496-9c1c-f63908deb40b@linaro.org>
Date: Sun, 15 Mar 2020 11:50:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315134859.9547-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 6:48 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> The RX code flash is not a Masked ROM but a EEPROM (electrically
> erasable programmable flash memory).
> When implementing the flash hardware, the rom_ptr() returns NULL
> and the reset vector is not set.
> Instead, use the address_space ld/st API to fetch the reset vector
> address from the code flash.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Based-on: <20200315132810.7022-1-f4bug@amsat.org>
> 
> Same issue might occurs in Cortex-M arm_cpu_reset()
> ---
>  target/rx/cpu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

