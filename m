Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70847C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FC522CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T147OV8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FC522CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0R3I-0006pT-EU
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0R2Y-00060T-MT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0R2X-0007wY-Bu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:52:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0R2X-0007vf-5N
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:52:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id k18so2126093otr.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qbLWvaQWmApgFoeFFUNjQGURzMZAbz3AkYdZfv321Yo=;
 b=T147OV8TF7UYadSr7aJeCiH5LJXrK1kfDhJb2NefzneHEBMK8K1suweqljgcQ0fzg2
 BeRgpuew7LOofMwLzIDoulVK8GA2MvjLTMu02lT/Vohd+JiB+3MvEeQ7VLf15ZWyIwCo
 Q6JjPL51rO5CUdZz6OcDnWy73r9YH0FuFZM2HAIt34DptMcxI//8VId3Tl5eNGjVCCN5
 rUiRwNHpOymqiEfansL2T9DYoAzJkIVhjiXO8S4w/wGNvODAP145Rx+chIOHgaIG/L/y
 MoZpD+pbxLZ8kkCceGz4BmxALEEBIvOlOlDsJ2nclLshKrWC+Ln2Q2iSkqzQL+Gp4o9Z
 eGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qbLWvaQWmApgFoeFFUNjQGURzMZAbz3AkYdZfv321Yo=;
 b=FhSFSKSqNpKBGfQmcIOMhSLNg/tDHyM/OJrJN1aXoTwg+iPqe1e4xqzOe+myHlbx5o
 ViAQmRudqWTqGWI9itWjlsy8gAbEZ9PD4jWZWTU8nWIbNLjKbkavuonP/NTa3x2/qgm/
 gWgoFJFd1b3tn62w086JTz8TaHuV6SmMgwQKJ52xAmNK7xMyfkuC13x+3Cq0xM+etCwg
 Rb+/g4hp/It/10KpYK0tweVD4MD7wx6+kNn/S1NYU21oXdTKDBnQ/zZtR1dp3RNLSJcM
 DqTgdGBDBkuskB7vD2ZtKHaBB/Vvb0SYzief/XS5Htn1wl1VCUDp7uZnJzkCtRF7MTGa
 cdrA==
X-Gm-Message-State: APjAAAV5B7d23h9EFZ0TH1VlMRsRg9B0wTFc4Yny+3+eraAjvTgJLwlW
 busKiki+6llocaOz1MWXtMwL74g0mmtph4HQT8XcuQ==
X-Google-Smtp-Source: APXvYqyZlCFCpmgW5Y5qGAApx5CTUwmHA4r3OkhQr+sqXNqK4LlKu0TArLY7+hK4onOfo9VHWw4IkPdetqdqEX3swjI=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr22097879otp.232.1566395559712; 
 Wed, 21 Aug 2019 06:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821133932.7428-1-aurelien@aurel32.net>
In-Reply-To: <20190821133932.7428-1-aurelien@aurel32.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Aug 2019 14:52:28 +0100
Message-ID: <CAFEAcA-YEeYEkLW1AL_dgqoANFnfpqJu=XSAkVBctNOh1i=kcw@mail.gmail.com>
To: Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] target/alpha: fix tlb_fill trap_arg2 value
 for instruction fetch
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
Cc: Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 14:42, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Commit e41c94529740cc26 ("target/alpha: Convert to CPUClass::tlb_fill")
> slightly changed the way the trap_arg2 value is computed in case of TLB
> fill. The type of the variable used in the ternary operator has been
> changed from an int to an enum. This causes the -1 value to not be
> sign-extended to 64-bit in case of an instruction fetch. The trap_arg2
> ends up with 0xffffffff instead of 0xffffffffffffffff. Fix that by
> changing the -1 into -1LL.
>
> This fixes the execution of user space processes in qemu-system-alpha.
>
> Fixes: e41c94529740cc26
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/alpha/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 93b8e788b1..9e9d880c1a 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -283,7 +283,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>          cs->exception_index = EXCP_MMFAULT;
>          env->trap_arg0 = addr;
>          env->trap_arg1 = fail;
> -        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
> +        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1LL : access_type);
>          cpu_loop_exit_restore(cs, retaddr);
>      }

Oops. Thanks for the catch.

Maybe we should not rely directly on the value of the access_type
enum to set trap_arg2 at all (ie just go for a switch on access_type and
set env->trap_arg2 to the right h/w value in the three cases)?

thanks
-- PMM

