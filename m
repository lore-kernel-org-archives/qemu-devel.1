Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B67C433F1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB6A2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoq9zcZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB6A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2Mo-00084C-95
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2Lx-0007Dq-M5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:23:29 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2Lv-0000sp-O5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:23:29 -0400
Received: by mail-pl1-x643.google.com with SMTP id w17so4938674ply.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FAZRALAVelZfayfs/kDZEphQ5lb+MnNcx6ERHNbA2rY=;
 b=zoq9zcZulfMg8JBLo/lbHjQVNE15GT7ew9p6VsePMfd6YF6wiAi/jKn3/FXQIvSZoM
 xkKNoYNFWQLrpWApTc68MSua2armO+8joC3lL23Ypq5c4uWBf9SBCuxeUmg42WZCHSwp
 la7+j8Bzvx81zcpey3JZxGKXeFPGl0Xx6oiGPjdjkQynShOhlwNUPACQHpBJd9p6H1T9
 qloeWrNzxusFlsO4OqNkQdMXIc8+cyms2QwYU/ZjpCreeWCqx3+rL+jkO+dTaVwhnk6J
 BhadUOgtd2bKTphbzQOVPvclWGBLWbXEJbpOuTmrw58Xm/eoUbcrGnclYRjwj6LUE/Dq
 KBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FAZRALAVelZfayfs/kDZEphQ5lb+MnNcx6ERHNbA2rY=;
 b=sbMcwyVey5fwYGFH8pfTYmXMSghyx0iTl0loCkNgbqdZIz0BcSAJ/i5Yb1Lt3fI4fz
 j0upoqt+h6zVDyIas25Gt35z84n/dmEZjEZaiafIqC5xYQUxIYDRkJSij/L6R/LkgGQj
 neoNbNj4qF5zO01CNaPX/h8MKKsJdcGDvgop2xGZCr1T10VRI6+mAAZAW7Kh/4XpkJI/
 JXIn8o642Us5a38NM7F7UXD5CyPW1oft+/BNwk/EUX3Y6S//lIjNQHMqDkOnYIpGInSD
 vLsQ7xZk4DbLtPyZXLra5O00K5XoLzBuTnm+YMdufo5nSCSIj8BUvpGdjR8dqxXET9YW
 pmjw==
X-Gm-Message-State: AOAM5306vxwdzFV32KjCHDYAuJpzVKmomfltDr8mQ6DLslsNLVxo7Sg+
 UhCUB8Rl7WOqlEenGSxebqGl6w==
X-Google-Smtp-Source: ABdhPJyU9Y9cczW4MMuzkm8kooEr4h2gPIl49ASIMl2uIEB+OAc2Ug8y4TF/WmFEkkc6CpZpjUebKg==
X-Received: by 2002:a17:90b:124c:: with SMTP id
 gx12mr6990288pjb.191.1595615006252; 
 Fri, 24 Jul 2020 11:23:26 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 127sm6825952pgf.5.2020.07.24.11.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 11:23:24 -0700 (PDT)
Subject: Re: [PATCH v3 07/16] target/i386: floatx80: avoid compound literals
 in static initializers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200724064509.331-1-alex.bennee@linaro.org>
 <20200724064509.331-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f78654c-c511-48e7-4aa6-76070890664a@linaro.org>
Date: Fri, 24 Jul 2020 11:23:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724064509.331-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, f4bug@amsat.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, cota@braap.org,
 Joseph Myers <joseph@codesourcery.com>, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 11:45 PM, Alex Bennée wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> Quoting ISO C99 6.7.8p4, "All the expressions in an initializer for an
> object that has static storage duration shall be constant expressions or
> string literals".
> 
> The compound literal produced by the make_floatx80() macro is not such a
> constant expression, per 6.6p7-9. (An implementation may accept it,
> according to 6.6p10, but is not required to.)
> 
> Therefore using "floatx80_zero" and make_floatx80() for initializing
> "f2xm1_table" and "fpatan_table" is not portable. And gcc-4.8 in RHEL-7.6
> actually chokes on them:
> 
>> target/i386/fpu_helper.c:871:5: error: initializer element is not constant
>>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>>      ^
> We've had the make_floatx80_init() macro for this purpose since commit
> 3bf7e40ab914 ("softfloat: fix for C99", 2012-03-17), so let's use that
> macro again.
> 
> Fixes: eca30647fc07
> Fixes: ff57bb7b6326
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Joseph Myers <joseph@codesourcery.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Link: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.html
> Message-Id: <20200716144251.23004-1-lersek@redhat.com>
> Message-Id: <20200722062902.24509-8-alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h  |   1 +
>  target/i386/fpu_helper.c | 426 +++++++++++++++++++--------------------
>  2 files changed, 214 insertions(+), 213 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


