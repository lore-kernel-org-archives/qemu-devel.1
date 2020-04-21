Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C6C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C166D2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnwcV5Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C166D2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnTo-000853-VP
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnSc-0006OS-GN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnSb-0007Tg-MT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQnSb-0007PJ-7U; Tue, 21 Apr 2020 03:36:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id i10so15223549wrv.10;
 Tue, 21 Apr 2020 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0I+i2uN+aZaaCg8jwY2o/kz42Z3W+x/KPcw1jFZ7pQ0=;
 b=JnwcV5XqoI79khPmZ23aHfEB2E0B4KhSwEp40ZBr3OE1xRHYDZ9ildvvtQyi5ZPMkv
 RY/1tsKnL54A5CpIgc2mCrgIddzc/ExqhzjFE+/QhjGL2DjzvBJ1+5xG+XX4ZCdMg0tY
 z87oLRF4DUmaUFtUHveMvWfBrTKh1Oke0EVq4B2ScbQevgh5mvxNDwRmo3hXdndCwYNX
 NG3CjXigVFZXj4P+LhtVko+edJpdu0NrMejanLhxX0RCSSaqsKH3lLX9p7fR1ndOBI9D
 cm1N7hipJiLQx2WXIhJ+6jfxaJqd2kxCbdrIJ4LU5Yp2FgXdhUZepD8MFqU7hkeztHrN
 GkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0I+i2uN+aZaaCg8jwY2o/kz42Z3W+x/KPcw1jFZ7pQ0=;
 b=UpOVQZxo5mxLon+RFnUmUR2SBjmihIO4oIxoNsR0S1YliXx3SRFYm+qmhkbFM7HpQF
 lzZKoXAgd4XYkz8ASyWrhQOU92AUZKkvF20FvujC9ApMI1lwgeXeGgmBNDJhQ4aNG0/i
 l/OA8bFbkQhA3bp6aeVSve4mReOBEunfflyeGdU+QbF1s1HwntdEVKqzQE/xtoKh7q1R
 4V5KYgckl754/+9NqPn3UeOQxv+jX5sqD7Krk4aobwIQ4dx/orMRGB19/xKDhq2KJGWY
 yxKcmGBG/c4gEF5hfK87ZX+AjRWxgOQvp+0/cw71oZF1Aq0hK2MSRSA14zvCS91ULk2Z
 7sew==
X-Gm-Message-State: AGi0PuarhJ0bh88RkoXQbQ7I888U8YjGM4y7MqvOnTe5PkbR8CTiKPw3
 qEjhyBCJYMLRN7mZSldfRx4=
X-Google-Smtp-Source: APiQypKIph2KcfmLpFYzERN0TCdXq2OgqCMIITuHJlqtClYnLDLL1pGplZxOo9XRjAaN7ZPQqVAb2Q==
X-Received: by 2002:adf:f30c:: with SMTP id i12mr23885882wro.426.1587454606849; 
 Tue, 21 Apr 2020 00:36:46 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t17sm2559941wro.2.2020.04.21.00.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 00:36:46 -0700 (PDT)
Subject: Re: [PATCH 3/4] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-4-peter.maydell@linaro.org>
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
Message-ID: <9b08f652-ddfd-c8ca-af0d-042824230253@amsat.org>
Date: Tue, 21 Apr 2020 09:36:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420212206.12776-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
> The kernel has different handling for syscalls with invalid
> numbers that are in the "arm-specific" range 0x9f0000 and up:
>  * 0x9f0000..0x9f07ff return -ENOSYS if not implemented
>  * other out of range syscalls cause a SIGILL
> (see the kernel's arch/arm/kernel/traps.c:arm_syscall())
> 
> Implement this distinction. (Note that our code doesn't look
> quite like the kernel's, because we have removed the
> 0x900000 prefix by this point, whereas the kernel retains
> it in arm_syscall().)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 025887d6b86..f042108b0be 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -332,10 +332,32 @@ void cpu_loop(CPUARMState *env)
>                              env->regs[0] = cpu_get_tls(env);
>                              break;
>                          default:
> -                            qemu_log_mask(LOG_UNIMP,
> -                                          "qemu: Unsupported ARM syscall: 0x%x\n",
> -                                          n);
> -                            env->regs[0] = -TARGET_ENOSYS;
> +                            if (n < 0xf0800) {
> +                                /*
> +                                 * Syscalls 0xf0000..0xf07ff (or 0x9f0000..
> +                                 * 0x9f07ff in OABI numbering) are defined
> +                                 * to return -ENOSYS rather than raising
> +                                 * SIGILL. Note that we have already
> +                                 * removed the 0x900000 prefix.
> +                                 */
> +                                qemu_log_mask(LOG_UNIMP,
> +                                    "qemu: Unsupported ARM syscall: 0x%x\n",
> +                                              n);
> +                                env->regs[0] = -TARGET_ENOSYS;
> +                            } else {
> +                                /* Otherwise SIGILL */
> +                                info.si_signo = TARGET_SIGILL;
> +                                info.si_errno = 0;
> +                                info.si_code = TARGET_ILL_ILLTRP;
> +                                info._sifields._sigfault._addr = env->regs[15];
> +                                if (env->thumb) {
> +                                    info._sifields._sigfault._addr -= 2;
> +                                } else {
> +                                    info._sifields._sigfault._addr -= 2;
> +                                }
> +                                queue_signal(env, info.si_signo,
> +                                             QEMU_SI_FAULT, &info);
> +                            }
>                              break;
>                          }
>                      } else {
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

