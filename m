Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50926C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FB22333D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA7jsveZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FB22333D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3LKp-0001Aj-7e
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 11:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3LJN-0000O0-6D
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:26:37 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3LJI-0001qC-Ae
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:26:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so24619994pgh.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FzwtIdvDao/Wvsd9e4q80GAM7pBf7kP6S9fuZyiSD+c=;
 b=RA7jsveZyKVivvn/CSv7ZEGTYu5DvJ+2Vr4wcD7UbQ9XJCu5vCJyCu+vf6KlCbxQms
 Ch3U5PHAC8dz5/+ZdzDj2hJryJ3qiScMrcFtm6N+ScxqpIMmlvcWUwFNvNUsjtjSlf/W
 M88R+dTGB4g2ZXHJelTUqygjMTdjW+ttpIn5D5E3QonMy+AW/brXB9eO7rnHFOyp1iNJ
 Bp42Qd4NWUEz5ZKFjNnWO50vbSTOIt3HeVFE+mZnVG048CHCt5mPjPVRWMRuH7aik4Pz
 4JBli1iI9AoL2n6cjZ3hj2Ko8PB2uA6zgdi7PU1q8QKcaVV54TpmpjvzzDuKDjYZwlhP
 A11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FzwtIdvDao/Wvsd9e4q80GAM7pBf7kP6S9fuZyiSD+c=;
 b=T3jTDimoo+pCy/5YAOb06vZG1zbr3nAcV48+TzSF2k3bet5wXmVQcvyoRcNtOWeuD3
 H7pxxYxr/7RC233xsxVzrjpjfoplbYptUNJiy/KbXkamO9vr6VcaMYBn39z57Q5BBlf7
 /tqoCPJp7Fw8wV+xX0ASgF/AfBOnTavLBCjuhIuNuoOe7I1aKThE6YZWH1E0tMavsCmI
 YliCJj3Aik12hz8QX0Pe87fwYBH+Q098A2m3bxpDRI/7PRIdmpcRhVGbQS2SW92WZnEB
 KQByxd23QJkZFjnylmuTXB3+H2KVaSVoyxJDbGQjhUJukEj5Iw0WmHvPWYGhXkVQHkrg
 GMNw==
X-Gm-Message-State: AOAM532qMHU7GfGVeNeXmbqRRbMNeHxdYuS1tpMU6IXJLaCq6q/tYVLi
 +9mZgmT03knrwxsRSG9srmQuCw==
X-Google-Smtp-Source: ABdhPJyYkBlpsT+XdjumtReobUGBQh/vG7KEcEVIWWHPJ5qnyfC0aoguimYT2rfPhe08KwQQFA2oGQ==
X-Received: by 2002:a63:9246:: with SMTP id s6mr3350195pgn.22.1596641190676;
 Wed, 05 Aug 2020 08:26:30 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id mh14sm3396545pjb.23.2020.08.05.08.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 08:26:29 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.1?] target/arm: Fix Rt/Rt2 in ESR_ELx for copro
 traps from AArch32 to 64
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200804193903.31240-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e710d6bb-564d-88bb-aa60-894ddc1280c8@linaro.org>
Date: Wed, 5 Aug 2020 08:26:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804193903.31240-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: Marc Zyngier <maz@kernel.org>, Julien Freche <julien@bedrocksystems.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 12:39 PM, Peter Maydell wrote:
> When a coprocessor instruction in an  AArch32 guest traps to AArch32
> Hyp mode, the syndrome register (HSR) includes Rt and Rt2 fields
> which are simply copies of the Rt and Rt2 fields from the trapped
> instruction.  However, if the instruction is trapped from AArch32 to
> an AArch64 higher exception level, the Rt and Rt2 fields in the
> syndrome register (ESR_ELx) must be the AArch64 view of the register.
> This makes a difference if the AArch32 guest was in a mode other than
> User or System and it was using r13 or r14, or if it was in FIQ mode
> and using r8-r14.
> 
> We don't know at translate time which AArch32 CPU mode we are in, so
> we leave the values we generate in our prototype syndrome register
> value at translate time as the raw Rt/Rt2 from the instruction, and
> instead correct them to the AArch64 view when we find we need to take
> an exception from AArch32 to AArch64 with one of these syndrome
> values.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1879587
> Reported-by: Julien Freche <julien@bedrocksystems.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

