Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FACC31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DEA2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tC+meekW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DEA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd08f-00078U-Cm
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd07e-0006To-KY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd07d-0001c7-Ln
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:29:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd07d-0001a5-BT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:29:05 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so1893892pgj.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9Wz6MQyJCuB3y44HQbsIau5eV98wCB0waHFjsbiRv5Y=;
 b=tC+meekW+dRLgmkAxfC5PeECV2US8LjFqStc//T5rSpD00I2jqBAM3Pe0KLXM05hLR
 wbqr99dnN7XTqea2IJT837KSsWweyOPZPkNnp7o6bxVyW1mlSniwSGMipigEjEYMaKrr
 um1yMeHi49YYLY4zf3/DvrMaxCyNrZJb17EeCS4LKM6B5+Jxq8V5ziw9vSp2Yr+FzFUC
 BLhBo93VH3jB7AhE9LBnnlD9XDoaxH2puqLVPIPZ8rbejNu7wdkAS8DLSAu/Lxq2Vew0
 vOoEcpfKDIFfFcxpNsp923Vj/WmKQXuqFuWtvjLp34Isry6sSyF5uqTzCOhyqcwv083w
 wjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Wz6MQyJCuB3y44HQbsIau5eV98wCB0waHFjsbiRv5Y=;
 b=XnrqHv2X31gXgXCQlB/mM7KLuA6RWi6qkC3aXDBYpBJUUFSkNewEHILVTLun4rpgmV
 COfYxaWKOWH1/l0k4psj5fzqOQNLnV8hsyPsFQ6JkNv9PgmFROljXsUXsFDUM9zHHA+g
 +6hsQGWFGFlrqozu5GsIYZcl2+d173RReNlO7lF3/YIRueCfrTLXWY8eVXx4PtGRUqM/
 eoBH8lzWKRQkhAcby+AzhDti/VpMp50FXu3+Oy3Ut48R51PWy4QAtpcgQsOonZWjY9vB
 3LkuePBRH95dH+YqUrFcVfTZWsjGj5NgnZl0sQylGmaDq6X4EsoGuPv+nFrsazfqjwzY
 2fxQ==
X-Gm-Message-State: APjAAAU+JoK8JD/Pl6d9bCkv5tACHILVNMkKJdrdWFbw31EF35ND9Uey
 yQo7kyvY+2ayElAFBha1fFYE6w==
X-Google-Smtp-Source: APXvYqx8RqUxVjdJj5HH7wCZTx+2WVb8l0oS20j8ae+zl2VX4lNygfxe5gEpe0HZL/lqIJXE2tsfqA==
X-Received: by 2002:a17:90a:bf08:: with SMTP id
 c8mr1451438pjs.75.1560810544108; 
 Mon, 17 Jun 2019 15:29:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id h26sm21564112pfq.64.2019.06.17.15.29.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:29:03 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-27-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <690729fa-ffc9-179e-28a0-451aac89c6e5@linaro.org>
Date: Mon, 17 Jun 2019 15:28:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v3 26/50] target/arm: call
 qemu_plugin_insn_append
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> I considered using translator_ld* from arm_ldl_code
> et al. However, note that there's a helper that also calls
> arm_ldl_code, so we'd have to change that caller.

We should in fact change that caller.

Unfortunately, the SVC immediate copied into env->exception.syndrome is
truncated to 16 bits, which means that the aa32 0x123456 won't match.

However, it would be easy enough to create new EXCP_SWI_SEMIHOST, generate it
within translate*.c when the svc immediate matches.  Everywhere except
check_for_semihosting(), we'd treat the two exceptions the same.

The BKPT instruction is only used for semihosting by thumb (and maybe only
v7m?).  The exception syndrome does contain the entire 8-bit immediate, however
for consistency it might be convenient to create an EXCP_BKPT_SEMIHOST so that
all of the checks are always done at translation time.


r~

