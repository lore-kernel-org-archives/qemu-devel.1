Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E61C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F83E2074B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN9C3JFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F83E2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnfN-0007Su-5n
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQneA-0006C1-7H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQne9-0004O6-D1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:48:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQne9-0004Nq-0Q; Tue, 21 Apr 2020 03:48:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so15311842wrp.5;
 Tue, 21 Apr 2020 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ARY8md8kDV/6pR/vUEHOaG+riA8bBkDmxyOF7Yvl8EE=;
 b=FN9C3JFCNiLxY6TMWHEYWYrk+S533RX3QSiyUNzFHCOvx+X48MxGIQZRStvhoRpVro
 D9gHHtIH5uinggY+GC3aAybDLwRPDhRHRmzI0VuKA0FXOwn3RMwDdfiYpZEQnjSaRFf0
 i9faVt9ff4Vi4ntIUfBgAB7FrsgjFGqTc5N3ipSJBGsQqUQkZ376mtkp3HK95S8L2CCb
 CZ4NmfmzOY+x8iv5nYenOWlEXVk+U5wMd6MIIBryvb6ZyKcL04PjLmgxxIpOvpxj3TAZ
 XCRt/C4W/hEBSJPYPeQ1dREQo25mrxXexOjbGU6ySnIpma4vKXv2a2hOBSyML31Mv+YG
 4CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ARY8md8kDV/6pR/vUEHOaG+riA8bBkDmxyOF7Yvl8EE=;
 b=q+c79iLNy9J5O7Fl/EFq689qxB+YDn72RR82PIbfPzMOSMJytMDVKC0z4j/wxNDwd9
 //NX4EDMB7teX0g3OrPSolWs010XppA0DNcfcBABFZV27M5uPJUkBhr+Z7hUbfka+6DM
 6ue/7IpHpKa984nS6uv5XIu0ZGlnE6QZexlnI9pj8coGty1LZm6ZD8297ufhQQHXSxkC
 aYzwZ9CTYyUCr1yKTppwbw2EVT6FB9e0VlLchhq+Yv8Umw+Ky4KJALnyLJxfgJLNwFFN
 u2VwC827+CGMx2frqH/xSs0/huputEnFOfz1L63bfGra5PxXrugR9+M5mVIJbOAw3ZSb
 lgSg==
X-Gm-Message-State: AGi0PuYR+AnaZeUxGGytE6E3apSlv/fybxEN4h1gRZhbGul7kGAh5bYi
 E6hJPY6fcFaLpIQKEmfUlEI=
X-Google-Smtp-Source: APiQypIhdHeveHcVrKiVVH5ve+MT4l0rnq2AfdsiE4s0bmvvsMoIRHmDrUVjumJld4WF1QJ8CqgIZw==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr22091237wrr.131.1587455323233; 
 Tue, 21 Apr 2020 00:48:43 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p7sm2692753wrf.31.2020.04.21.00.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 00:48:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] linux-user/arm: BKPT should cause SIGTRAP, not be a
 syscall
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-2-peter.maydell@linaro.org>
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
Message-ID: <66f1e3c3-13f3-cf66-68e8-281260e420e7@amsat.org>
Date: Tue, 21 Apr 2020 09:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420212206.12776-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
> In linux-user/arm/cpu-loop.c we incorrectly treat EXCP_BKPT similarly
> to EXCP_SWI, which means that if the guest executes a BKPT insn then
> QEMU will perform a syscall for it (which syscall depends on what
> value happens to be in r7...). The correct behaviour is that the
> guest process should take a SIGTRAP.
> 
> This code has been like this (more or less) since commit
> 06c949e62a098f in 2006 which added BKPT in the first place.  This is
> probably because at the time the same code path was used to handle
> both Linux syscalls and semihosting calls, and (on M profile) BKPT
> with a suitable magic number is used for semihosting calls.  But
> these days we've moved handling of semihosting out to an entirely
> different codepath, so we can fix this bug by simply removing this
> handling of EXCP_BKPT and instead making it deliver a SIGTRAP like
> EXCP_DEBUG (as we do already on aarch64).
> 
> Reported-by: <omerg681@gmail.com>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1873898
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index cf618daa1ca..82d0dd3c312 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -295,32 +295,17 @@ void cpu_loop(CPUARMState *env)
>              }
>              break;
>          case EXCP_SWI:
> -        case EXCP_BKPT:
>              {
>                  env->eabi = 1;
>                  /* system call */
> -                if (trapnr == EXCP_BKPT) {
> -                    if (env->thumb) {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u16(insn, env->regs[15], env);
> -                        n = insn & 0xff;
> -                        env->regs[15] += 2;
> -                    } else {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u32(insn, env->regs[15], env);
> -                        n = (insn & 0xf) | ((insn >> 4) & 0xff0);
> -                        env->regs[15] += 4;
> -                    }
> +                if (env->thumb) {
> +                    /* FIXME - what to do if get_user() fails? */
> +                    get_user_code_u16(insn, env->regs[15] - 2, env);
> +                    n = insn & 0xff;
>                  } else {
> -                    if (env->thumb) {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u16(insn, env->regs[15] - 2, env);
> -                        n = insn & 0xff;
> -                    } else {
> -                        /* FIXME - what to do if get_user() fails? */
> -                        get_user_code_u32(insn, env->regs[15] - 4, env);
> -                        n = insn & 0xffffff;
> -                    }
> +                    /* FIXME - what to do if get_user() fails? */
> +                    get_user_code_u32(insn, env->regs[15] - 4, env);
> +                    n = insn & 0xffffff;
>                  }

I couldn't find a git-diff option to display this change in an obvious way.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>                  if (n == ARM_NR_cacheflush) {
> @@ -396,6 +381,7 @@ void cpu_loop(CPUARMState *env)
>              }
>              break;
>          case EXCP_DEBUG:
> +        case EXCP_BKPT:
>          excp_debug:
>              info.si_signo = TARGET_SIGTRAP;
>              info.si_errno = 0;
> 

