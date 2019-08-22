Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD29AC3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3A221848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nid+xQyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3A221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0asJ-0006Bk-Lv
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0are-0005kI-HL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ard-0005Ff-4R
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:22:06 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0arc-0005FK-UQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:22:05 -0400
Received: by mail-pf1-x443.google.com with SMTP id d85so2598834pfd.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2+GorFJiIIvPPj+ZxTdHoEdA13mFcot/VQvvNBL4Nec=;
 b=Nid+xQyNIq4C695rNBzyJDJQncO0OYVneQPNH3D+Kb9tm0ImPxT31Flk/EKN/jqTU3
 MiOyRIFy7RGQEsfgYdYwUs+rn6OY7H9BluX4I+TM1WS01g4BZBXTzfizOVA9EAl41t2b
 xcX5fwewntK6JiKilkKhDDbjS64LWSAt/sWLSzktD8pTREl2EPYCs0WNxhBjqq4uofKq
 uxWrQ/KBYAioNaSr5xn+Z+ztNpg5Y9TrUVlyEsPFJ8IZ/n0aQ94GJX+qRRoc4lx7AZ/L
 r3pzGLBgC5CDzmnobMvSTaI0pfzurAME0fsmSFlghxcJHn2JFrACo7tQHqlUKoaSks/3
 E4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2+GorFJiIIvPPj+ZxTdHoEdA13mFcot/VQvvNBL4Nec=;
 b=fqc8uwR/RGQ0HDRoYMqdWneTKzaMOvjcEbrxZ0XuVjtSHJsXJSn5az01LPxCxGDmvU
 sVeFdX0MVamKMcQcxJi3rQWGaVPQHgJ3J2I1RvpJb7JE5P+9jD/ZI7q3HxLfp6qFCmJX
 6mWQX2gz/Cy4EkSIf/fxP791/Pzg+IIQ2Wiwna0kB0HHT8Ybf6HTkdQn2vWlNRG/12Pd
 YBnZfSoSmWLajC3jJSiht3ZcZSNbQZdV77m2NMsSAZeYvVY3JRwwmdMpAG0QwuHv/OvX
 GhSZt4aWTMxvTROOuP2+WS1ccmlG2Wp9IgD2zwNifaZ8hyXmIOhSOqVRj1DNklzMyv/R
 V1hA==
X-Gm-Message-State: APjAAAWeiTi0YbIiH7EaLzYUSvJ44IndRQs0nve79FrZ9LHQQfKfgWtf
 ZJQHfeSwEJm0sQisYcPallX/nQ==
X-Google-Smtp-Source: APXvYqy6/mM3k60n5MlKTiboV2t5HBq/Zkz3nh5kfBIcQ6yPkDKJMNGhtjc9X/PaEm8yjeyWcpy7Og==
X-Received: by 2002:a17:90a:e502:: with SMTP id
 t2mr2651738pjy.104.1566433323428; 
 Wed, 21 Aug 2019 17:22:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a10sm34863895pfl.159.2019.08.21.17.22.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 17:22:02 -0700 (PDT)
To: Tony Nguyen <tony.nguyen.git@gmail.com>, qemu-devel@nongnu.org
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
 <00f837b07ebb2468af5254626cc6b2bf94ddab4b.1566397711.git.tony.nguyen.git@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <31c6129b-dd72-fc16-811e-0b0763459cc6@linaro.org>
Date: Wed, 21 Aug 2019 17:22:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00f837b07ebb2468af5254626cc6b2bf94ddab4b.1566397711.git.tony.nguyen.git@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v8 01/21] configure: Define
 TARGET_ALIGNED_ONLY in configure
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 8:08 AM, Tony Nguyen wrote:
> Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move
> defines out of target/foo/cpu.h into configure, as we do with
> TARGET_WORDS_BIGENDIAN, so that it is always defined early.
> 
> Poisoned TARGET_ALIGNED_ONLY to prevent use in common code.
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  configure             | 10 +++++++++-
>  include/exec/poison.h |  1 +
>  include/qom/cpu.h     |  2 +-
>  target/alpha/cpu.h    |  2 --
>  target/hppa/cpu.h     |  1 -
>  target/mips/cpu.h     |  2 --
>  target/sh4/cpu.h      |  2 --
>  target/sparc/cpu.h    |  2 --
>  target/xtensa/cpu.h   |  2 --
>  tcg/tcg.c             |  2 +-
>  tcg/tcg.h             |  8 +++++---
>  11 files changed, 17 insertions(+), 17 deletions(-)

You are going to have to fix your patch submission.

Applying: configure: Define TARGET_ALIGNED_ONLY in configure
error: patch failed: configure:7431
error: configure: patch does not apply
error: patch failed: include/exec/poison.h:35
error: include/exec/poison.h: patch does not apply
error: patch failed: include/qom/cpu.h:89
error: include/qom/cpu.h: patch does not apply
error: patch failed: target/alpha/cpu.h:23
error: target/alpha/cpu.h: patch does not apply
error: patch failed: target/hppa/cpu.h:30
error: target/hppa/cpu.h: patch does not apply
error: patch failed: target/mips/cpu.h:1
error: target/mips/cpu.h: patch does not apply
error: patch failed: target/sh4/cpu.h:23
error: target/sh4/cpu.h: patch does not apply
error: patch failed: target/sparc/cpu.h:5
error: target/sparc/cpu.h: patch does not apply
error: patch failed: target/xtensa/cpu.h:32
error: target/xtensa/cpu.h: patch does not apply
error: patch failed: tcg/tcg.c:1925
error: tcg/tcg.c: patch does not apply
error: patch failed: tcg/tcg.h:333
error: tcg/tcg.h: patch does not apply
Patch failed at 0001 configure: Define TARGET_ALIGNED_ONLY in configure

There are far too many errors for me to want to fix them up by hand.


r~

