Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBFC2BB86
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B89620692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3uL+kWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B89620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNm70-0000SX-OZ
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1jNm6E-0007bH-3g
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1jNm6C-0003HV-SR
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:33:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>)
 id 1jNm6C-0003HG-Mf; Sun, 12 Apr 2020 19:33:12 -0400
Received: by mail-pf1-x442.google.com with SMTP id n10so3780124pff.3;
 Sun, 12 Apr 2020 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=phXCUNuj9LrRllA2EedbED7LHYuP4y9u3+mfpjFDGTE=;
 b=q3uL+kWevFRqM95kHt7nMEVDuRy/FJjWqmIJG314phsFFyqZ469x+h51f0vnBOJdiO
 FrLklWGGO25atekvEpcjTANLZIT8IPSCZppAog47YKyPW9icqt5jn/BPUpGoSBKL48G2
 M3lF0/MkkcecwtDWqGNkQwNaiUDCrym63yg20J+1T8iL1FBZsd15NSdeUVZxrYg2uGuj
 OYeesfTAIj2pa+IstPCQ0aPUVrpUNixC0ZrU+CqJ0lK124kqjsUjXzNY4h7QIDr+I0fn
 hgjKgtkXZGYWFfwzVHrMkTERugvRe7uy5si8Nl02uIq2Osg99GT7z1G6Vr/t484dKaWn
 CClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=phXCUNuj9LrRllA2EedbED7LHYuP4y9u3+mfpjFDGTE=;
 b=oto+jOJCLq2KNUymP10YYAR79sRRPIdUbzJxv28s6mPgLh4pfZEL8Qkaxh0IRRTwmw
 n19FZULI49mBsdWIUYNiSZJZqJvQjeLbXXY0/J84xOwkLtb6Dp+KdcR5tZYG6mgtvyox
 pwBwoTzG1+XvyGLXwT6LK5oazXN7KM8oy7CLFkPyPLVz6hvPyBpONuO8XMN9ae0O+54/
 maCpLBfoedAqyR6DPoZfZv7cVTZuoWrD7RLNHIjtntnbi8MrNbHKtFRWzbJFcTejMhxc
 D85ewVB7WNzAEvINNEVXL6lPOK5sV3o9q4QUK9pc993nwRft4JI0tNtLzjzzCjXqc2hb
 rToQ==
X-Gm-Message-State: AGi0PuaLTaLTvnysS033fCs9ehAyU6zcGYEyYprObLquszx4DisgrnVs
 FyMWocr4dNHiaFG83QNp1AIRRbeZ
X-Google-Smtp-Source: APiQypJYu6iY3dCq6vE6hf7mQnIrdq2MBsESe9vbx+UHtVxqJtOWtonUoF3Th8J9SuWN+WAQt79q3g==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr14414229pgg.229.1586734391508; 
 Sun, 12 Apr 2020 16:33:11 -0700 (PDT)
Received: from localhost (g19.222-224-154.ppp.wakwak.ne.jp. [222.224.154.19])
 by smtp.gmail.com with ESMTPSA id
 k21sm3962787pfg.114.2020.04.12.16.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 16:33:10 -0700 (PDT)
Date: Mon, 13 Apr 2020 08:33:08 +0900
From: Stafford Horne <shorne@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.0? 3/3] hw/openrisc/pic_cpu: Use qdev gpio rather
 than qemu_allocate_irqs()
Message-ID: <20200412233308.GS7926@lianli.shorne-pla.net>
References: <20200412212943.4117-1-f4bug@amsat.org>
 <20200412212943.4117-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200412212943.4117-4-f4bug@amsat.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 11:29:43PM +0200, Philippe Mathieu-Daudé wrote:
> Switch to using the qdev gpio API which is preferred over
> qemu_allocate_irqs(). Doing so we also stop leaking the
> allocated memory. One step to eventually deprecate and
> remove qemu_allocate_irqs() one day.
> 
> Patch created mechanically using spatch with this script
> inspired from commit d6ef883d9d7:
> 
>   @@
>   typedef qemu_irq;
>   identifier irqs, handler;
>   expression opaque, count, i;
>   @@
>   -   qemu_irq *irqs;
>       ...
>   -   irqs = qemu_allocate_irqs(handler, opaque, count);
>   +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
>       <+...
>   -   irqs[i]
>   +   qdev_get_gpio_in(DEVICE(opaque), i)
>       ...+>
>   ?-  g_free(irqs);
> 
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/openrisc/pic_cpu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
> index 36f9350830..4b0c92f842 100644
> --- a/hw/openrisc/pic_cpu.c
> +++ b/hw/openrisc/pic_cpu.c
> @@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, int irq, int level)
>  void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
>  {
>      int i;
> -    qemu_irq *qi;
> -    qi = qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS);
> +    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS);
>  
>      for (i = 0; i < NR_IRQS; i++) {
> -        cpu->env.irq[i] = qi[i];
> +        cpu->env.irq[i] = qdev_get_gpio_in(DEVICE(cpu), i);
>      }
>  }

This looks fine to me.

Why do you have the '5.0?' in the subject?

-Stafford

