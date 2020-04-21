Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CDAC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEC92074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1zo8Fek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEC92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnen-0006Yx-9f
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnUx-00020L-B1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnUw-0002dF-Qe
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:39:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnUw-0002Xt-9u; Tue, 21 Apr 2020 03:39:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id u16so2461480wmc.5;
 Tue, 21 Apr 2020 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/MQG4xsj6uyqf1WR9HI/UGL2KbiMtfmovPkUPXitTwc=;
 b=s1zo8FekJ1efuOSUoEqcRkQU2n5oubFA1FnFJb6LLP3g3tPp8vweBO9iKRUfzcohsa
 7aqgbMzKBiZEjhjKrSWk0nnb6MbYexCxYnHU5IojT8jCZ3UYjuwKlSfKjX6UpDkrUlWE
 Mry1bzF2rOF4+RS1ZNewNDbTOgHXBmcgAl+0xgWjGqvPZCGtsJYbZJvDUslNGSVqfV6M
 GDQEGmXuLo/ZOQ+l5CQT7B27FgFCargE85sRj19h5GISu7Ju4Q8gGJwC1MwEdzm9y3Q1
 oT3/Lq6L0qaKGNX0iNpbSvETlDROn17LPvTMi0DZY0T9RpNBVvubEJJ9Yg8ZCGoC/0Lh
 qWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/MQG4xsj6uyqf1WR9HI/UGL2KbiMtfmovPkUPXitTwc=;
 b=Ry6c1vY7/kPxnAjgqQLjnPGFEJtIwhzJBlhPf3yj+Fud9wKs1EejNIZ5iBdrDYP13X
 q29BBs3X4kZc0OzJth8Z9pHYl0DFCwaF8gBQOZAdzDhHutuM+dQHCi2LqypmKnkCJts3
 9buU+oHPIkyVMjTGE8WKm5PtX2w0+D5e4WzJ60pid8ifqN+FhLITaEK2jW2xHqeg1Hh6
 KrJQY5+bQqNH5NSEIOgwadYk2TFGtO+nn6N7VDQOJZj/7KUKv3rr7TGQh+VRCAJbBuz9
 Sqb6NPDNXKFEh+XGMw0fQqoSGKTmtO5VJcye6DurA6p8kRuZMYh5A/iYj2n+9ei5ik9T
 7NnQ==
X-Gm-Message-State: AGi0PuagNazJj3TuWvH2pagcxGq6Sf6d/LuFlvGuE83rwFoaKw2EjNG0
 ewTFD1s9HSxmcNoXjWsZlAU=
X-Google-Smtp-Source: APiQypJ042gSOffZeIO1m2SV9/lTahIQEog2oxSDnye3v/dP4AMOie6BZSJFuTcZrceEnDiftpICzA==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr3340186wme.38.1587454752358; 
 Tue, 21 Apr 2020 00:39:12 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k23sm2339779wmi.46.2020.04.21.00.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 00:39:11 -0700 (PDT)
Subject: Re: [PATCH 2/4] linux-user/arm: Remove bogus SVC 0xf0002 handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ac5152f5-be5e-0c07-aa36-0ce326981bb7@amsat.org>
Date: Tue, 21 Apr 2020 09:39:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420212206.12776-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 11:22 PM, Peter Maydell wrote:
> We incorrectly treat SVC 0xf0002 as a cacheflush request (which is a
> NOP for QEMU).  This is the wrong syscall number, because in the
> svc-immediate OABI syscall numbers are all offset by the
> ARM_SYSCALL_BASE value and so the correct insn is SVC 0x9f0002.
> (This is handled further down in the code with the other Arm-specific
> syscalls like NR_breakpoint.)
> 
> When this code was initially added in commit 6f1f31c069b20611 in
> 2004, ARM_NR_cacheflush was defined as (ARM_SYSCALL_BASE + 0xf0000 + 2)
> so the value in the comparison took account of the extra 0x900000
> offset. In commit fbb4a2e371f2fa7 in 2008, the ARM_SYSCALL_BASE
> was removed from the definition of ARM_NR_cacheflush and handling
> for this group of syscalls was added below the point where we subtract
> ARM_SYSCALL_BASE from the SVC immediate value. However that commit
> forgot to remove the now-obsolete earlier handling code.

I imagine you wrote this patch wearing an archeologist hat =)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Remove the spurious ARM_NR_cacheflush condition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 82d0dd3c312..025887d6b86 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -308,9 +308,7 @@ void cpu_loop(CPUARMState *env)
>                      n = insn & 0xffffff;
>                  }
>  
> -                if (n == ARM_NR_cacheflush) {
> -                    /* nop */
> -                } else if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
> +                if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
>                      /* linux syscall */
>                      if (env->thumb || n == 0) {
>                          n = env->regs[7];
> 

