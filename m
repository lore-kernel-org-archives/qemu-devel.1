Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F25EC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44784206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM6bIJ2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44784206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTig-0002hs-BK
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHThv-000259-22
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHTht-0002SK-UN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:09:50 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:37007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHTht-0002S0-Qk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:09:49 -0400
Received: by mail-yb1-xb41.google.com with SMTP id z125so4708894ybc.4
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ddr5Al70vUzB+KYP1WXeVhBnDvU6Y6cu1I5Fz4+jeO4=;
 b=oM6bIJ2UgOzWJs1+zyNl1Rla6fsu8Nwc4ZKuWQIXqWkz2JFgTyOvtgqwINrit0nOZT
 daAGzY2SCHCJT31exGWNarEnAYKRMxk0UumDL7l3sJXDUC7Ifg7+P4/cjHsQtbnXMXvH
 8VguJ1JcXExl5jHaKRCMxrvDYkLynshwDgakZRPAjZrQGxEDah/3K9j+A/UStDm4/Gtd
 0D9AYB4SaNk6bS6tZIEoSH8K5Qyt7tKxuQuoO/sdAXtdSsRRZdToBNFQhDQ8Mlp9AExQ
 sAJIwKoqh/9a0olcZXCmfbVAt4fd9vZ33CnALj6uKGvBccwi//LoPW48OJoLRAVaCCkr
 czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ddr5Al70vUzB+KYP1WXeVhBnDvU6Y6cu1I5Fz4+jeO4=;
 b=DENRgvUaYkTE7Uv4DXFeh8oA+nG4re0mlSbwbp7wf3ze0S/k28Kqu3DNgE/uZfDHJs
 AuyKWT1bjTUOkrtUG60f440aZIetjMMZjcEO64qz97IpzjrCnJ3PMi++GU1yJANjlm+J
 4ZleIBHRYE7XWf8l9PYumIHJfA1LnHSLtcge/TFoUcfpnRk7nG53bYLm5kybLWZ66o2c
 GDlp/NjTtkFUPFChP+um8RV4IsXL+pjajL0QhGJbztXeAou1pgeMyh3GSDW0cpf8mx+E
 hTvXT6194BwsVgW5Q0Ia3V/MDRWZmE2KONmP3pXPGHuzEh05Dxev251iTqF3Irf+UtUy
 3LUA==
X-Gm-Message-State: APjAAAVtelCfasxh8EEEFAUzCsdwVyx/kmvvNLIoKMy7ptd87rXpMipy
 jIOZJGR4yvOVBfuG3jQZOHHEOw==
X-Google-Smtp-Source: APXvYqyIEDWv2w3MIOTpDHsSSwfxxJ30kHEQeCh23AUYqs9JEM1IZxdnYPRHK4671pKANxFC7/2xpQ==
X-Received: by 2002:a25:da46:: with SMTP id n67mr11244684ybf.467.1570457388996; 
 Mon, 07 Oct 2019 07:09:48 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id y63sm3689519ywg.5.2019.10.07.07.09.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 07:09:48 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 04/15] target/arm/arm-semi: Make
 semihosting code hand out its own file descriptors
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <842d1592-1cda-2c58-93bc-ed6391d093b1@linaro.org>
Date: Mon, 7 Oct 2019 10:09:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 7:15 AM, Peter Maydell wrote:
> Currently the Arm semihosting code returns the guest file descriptors
> (handles) which are simply the fd values from the host OS or the
> remote gdbstub. Part of the semihosting 2.0 specification requires
> that we implement special handling of opening a ":semihosting-features"
> filename. Guest fds which result from opening the special file
> won't correspond to host fds, so to ensure that we don't end up
> with duplicate fds we need to have QEMU code control the allocation
> of the fd values we give the guest.
> 
> Add in an abstraction layer which lets us allocate new guest FD
> values, and translate from a guest FD value back to the host one.
> This also fixes an odd hole where a semihosting guest could
> use the semihosting API to read, write or close file descriptors
> that it had never allocated but which were being used by QEMU itself.
> (This isn't a security hole, because enabling semihosting permits
> the guest to do arbitrary file access to the whole host filesystem,
> and so should only be done if the guest is completely trusted.)
> 
> Currently the only kind of guest fd is one which maps to a
> host fd, but in a following commit we will add one which maps
> to the :semihosting-features magic data.
> 
> If the guest is migrated with an open semihosting file descriptor
> then subsequent attempts to use the fd will all fail; this is
> not a change from the previous situation (where the host fd
> being used on the source end would not be re-opened on the
> destination end).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Change since v1: we mustn't treat the return value of
> arm_gdb_syscall() as being the new fd from gdb, as in
> softmmu mode it is not. So we need a custom callback for open
> that can update the guestfd association.
> ---
>  target/arm/arm-semi.c | 232 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 216 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


