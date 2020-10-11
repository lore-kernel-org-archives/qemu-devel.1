Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A108C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 03:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C70720882
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 03:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEOEAprV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C70720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRSQt-0007lV-8x
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 23:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kRSPq-00071E-1r
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 23:52:58 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kRSPo-00016p-Gl
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 23:52:57 -0400
Received: by mail-lj1-x242.google.com with SMTP id c21so13465591ljn.13
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 20:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gaYp3Ol1OZtQgXFFfOCvTJPAcpr+iBj+rGyRVGzqvf4=;
 b=QEOEAprVkqxEqlmIigVbQDUMC/jtCmqzUgF47xtKWXCKTUwSMSJXm0MWsuSCTU9H1+
 oq0zG5lBEX9ZmtE1IhMIk8rjmsSqirzQ2iwAedhPxFNgPOq46G/ECKR0DI+ljee7l23D
 8Z9glytas5SPxrYoTuR3cjzJYq7zxXDQd8bN9yVkS1LH+2Rb/6y/WSsyNNqwEYSI9iN3
 bQvHKPEXeiUStPhngAFel80vkA/7/zbbPs+5wxeVBu40c/l0NOR9kc2jr+Mcr/n+M0lT
 3oN4PIhN/i+bagKUoZUjVI08r49y6TycPOUsBvfn+vlSy0D5o0EqagjPrdd/ZXHKapj3
 0v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gaYp3Ol1OZtQgXFFfOCvTJPAcpr+iBj+rGyRVGzqvf4=;
 b=OOdPoPYnw/Th4wxitc6nO4SOERV++6+sFnCO+kj1CwuQg8XhAEW9Y5UQ/wo7IIYRoR
 o4iG5OhqDGFu1y061I8VkImZcZocyD9LgUQ1MU5obcO9jGafZ0BXZFWF0RJFpN62pWjJ
 WCOMU1omdIgDH2RAduik+uoZxI32wVTvPRmlEUG72wIwptw1R8SlPvV3Sdg2tmLCV+fl
 7MCPIMSkmeRx6140x22FFY2HQc9VucuPQ1Qxm6kp5KkPY/++nM0arIRKhhQv3xfze1vr
 6HMhtPIMhRYqddSvu95s609lS0I5trS9V7HS2WQQkEq/MQRW9J+iYIAhoOby7YOT8JXH
 4oeQ==
X-Gm-Message-State: AOAM532iPc/PAIaa8NWj1JNa5BdNc5N8aWYysWwHwyiM2Dvbz70rBkt6
 E3YWoUYJeTbD+eDunfvwCnsmiw9I8gGmF2cR1ZE=
X-Google-Smtp-Source: ABdhPJxFtEPYWwRt55uxotr+EXPCZS6LMjwFvJO9IC69nJmZy25e5Z+s1w40sC4upv1XieGkGk14V+FdmDzNDBhuMCg=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr7624816ljl.104.1602388373485; 
 Sat, 10 Oct 2020 20:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201010204319.3119239-1-f4bug@amsat.org>
 <20201010204319.3119239-13-f4bug@amsat.org>
In-Reply-To: <20201010204319.3119239-13-f4bug@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Sun, 11 Oct 2020 11:52:41 +0800
Message-ID: <CABDp7Voq177fvHUJRXqrYtH2etqnKNmhYeVOZAForw=6oY5sTg@mail.gmail.com>
Subject: Re: [PATCH v3 12/20] hw/mips/r4k: Explicit CPU frequency is 200 MHz
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Sun, Oct 11, 2020 at 4:43 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Since its introduction in commit 6af0bf9c7c3,
> the 'r4k' machine runs at 200 MHz.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/r4k.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
> index 3487013a4a1..e64687b505a 100644
> --- a/hw/mips/r4k.c
> +++ b/hw/mips/r4k.c
> @@ -37,6 +37,7 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
>  #include "qemu/error-report.h"
> +#include "hw/qdev-clock.h"
>
>  #define MAX_IDE_BUS 2
>
> @@ -184,6 +185,7 @@ void mips_r4k_init(MachineState *machine)
>      int bios_size;
>      MIPSCPU *cpu;
>      CPUMIPSState *env;
> +    Clock *cpuclk;
>      ResetData *reset_info;
>      int i;
>      qemu_irq *i8259;
> @@ -193,7 +195,11 @@ void mips_r4k_init(MachineState *machine)
>      int be;
>
>      /* init CPUs */
> -    cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
> +    cpu =3D MIPS_CPU(object_new(machine->cpu_type));
> +    cpuclk =3D clock_new(OBJECT(machine), "cpu-refclk");
> +    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
> +    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);
Can we add a new parameter to cpu_create() and set the freq in the core cod=
e?

Huacai
>      env =3D &cpu->env;
>
>      reset_info =3D g_malloc0(sizeof(ResetData));
> --
> 2.26.2
>


--=20
Huacai Chen

