Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96110C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6252F20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2bWODtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffk8-0003JL-ON
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33262)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffh8-00019k-Aw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffh6-00015V-85
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:16:46 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffh4-00013h-Em
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:16:43 -0400
Received: by mail-io1-xd42.google.com with SMTP id n5so617542ioc.7
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dx2lht7d+fpEbam/34OcglhCnt6xwvhfA6Cl92IWUiY=;
 b=n2bWODtc3giQeHc6Mg3uju+ZBku0K5mBf+4TWpoaiQE7+ZyaFRZTN+9iM2UGbXT+lv
 kJ9tPl8x/3PuJMYJZYCjuHVl/BqntODdL8FQ5J/iLGDxk7ujuYnzSScqEsGf+jSNEMlX
 CkX5OzjpaDviGGjYqZfnNT/q0I4HxuJ3eFFWPCQnL3dYvLn9FjVd7/tsTnpZVXPRYgtM
 LD82Vhz2Z7D88M60yBu+tag2/pZEcimiOvAKo2m/JnxTGTP+75Z8h9gWcp7DQxFqHKyZ
 qf5WwkG38KHOz+RXFcRvtB0iCtFKVcK7cAq6TQ+vPswuK/51AP0peL9K8r1QOQxHIj7L
 8TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dx2lht7d+fpEbam/34OcglhCnt6xwvhfA6Cl92IWUiY=;
 b=mlCsKAUbdIRDVA0AJ2+voODB40s7G33IStERR2dOEnMOfic7wBdeR5ImmUJvllHawK
 XapTh4hZvV+oa+Wf7zrLvd9kbZayWjX19lTWxfjRsb585VJ62azFt2cIz+BdPOMTTTOy
 gaeTmBlnF3VyKvGKK/nYU5VglbtCBdxk4vO9Vwa4U+W4WrUTgSKRV6Y6jbqQAo9D190q
 QMFuT/43fYJWXULV8E7sKlJRuDUDvW4QZZQDJx3UMSLvUYenfsRhVYC6OVnmy0LpaW8G
 CouajP6tLaUz9DcmW8dexOR1Q3pVrdztfinXkkyM7eM2bXLJuyBtNwaxGvoz7Yq4WsAZ
 xAWQ==
X-Gm-Message-State: APjAAAVXwZusomwTOeRTUKJ50dKR4TqAgfv0SWaUEZVm7U/HC3HwL6gD
 8qLHcVProhax0MmQDXnWZDIBvYeKwcMLNnjb02g=
X-Google-Smtp-Source: APXvYqwmvNuZ0NJwOe0QKdoFd2BX2kBHYsfixuAYHSsVqVYHcRSLrdIMUTR68qbMVEASRU3nTr8blDpoZ+DkAz+oHXc=
X-Received: by 2002:a02:3f1d:: with SMTP id d29mr24861040jaa.116.1561447001029; 
 Tue, 25 Jun 2019 00:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-8-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-8-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:16:30 +0200
Message-ID: <CACXAS8CTbHN8LZSkb1Q4L2yGiQD=R-9vKnF6XeC8tVCUkk5PnA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH 7/9] hw/sparc/sun4m: Mark some devices as
 'unimplemented'
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> These devices are not slots on a bus, but real devices that
> we do not implement.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>


> ---
>  hw/sparc/sun4m.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index cc85598d5b..0df5a8edfc 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -42,6 +42,7 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/char/escc.h"
>  #include "hw/misc/empty_slot.h"
> +#include "hw/misc/unimp.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "trace.h"
> @@ -970,7 +971,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>      }
>
>      if (hwdef->sx_base) {
> -        empty_slot_init(hwdef->sx_base, 0x2000);
> +        create_unimplemented_device("sx", hwdef->sx_base, 0x2000);
>      }
>
>      nvram =3D m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1=
968, 8);
> @@ -1033,14 +1034,16 @@ static void sun4m_hw_init(const struct sun4m_hwde=
f *hwdef,
>      if (hwdef->dbri_base) {
>          /* ISDN chip with attached CS4215 audio codec */
>          /* prom space */
> -        empty_slot_init(hwdef->dbri_base+0x1000, 0x30);
> +        create_unimplemented_device("SUNW,DBRI.prom",
> +                                    hwdef->dbri_base + 0x1000, 0x30);
>          /* reg space */
> -        empty_slot_init(hwdef->dbri_base+0x10000, 0x100);
> +        create_unimplemented_device("SUNW,DBRI",
> +                                    hwdef->dbri_base + 0x10000, 0x100);
>      }
>
>      if (hwdef->bpp_base) {
>          /* parallel port */
> -        empty_slot_init(hwdef->bpp_base, 0x20);
> +        create_unimplemented_device("parallel", hwdef->bpp_base, 0x20);
>      }
>
>      initrd_size =3D 0;
> --
> 2.19.1
>


--
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

