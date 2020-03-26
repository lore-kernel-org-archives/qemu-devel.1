Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA3320719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIfWr7+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA3320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaJ2-0002d1-UP
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaID-0001tp-86
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaIC-0008F1-0V
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:44:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaIB-0008DJ-PL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:43:59 -0400
Received: by mail-oi1-x241.google.com with SMTP id t25so7013740oij.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xvQuM1t+AMalZIyQmGqvVV5WcXOTpPBqjnsxou10UMI=;
 b=cIfWr7+79kzguSu2V3Sa46UNOBIRSKKuTOhRBj75G5/ncXWZgLWn6rHFUcm58jBz4n
 1NgfoyHMCGsDexQfb4jItOz9nsObsYWhblDWparPVYqQKl7OW40U+KOKc1yqrDzf+hJ2
 U5tPvoCplXbW9n3qzpsn85YX8FM8cRmU3oTG/f5YI84XeUlq1MEJBUw5cAm92XMi5P4T
 FhNnoRWoYb1Ymu8x+uqT2FK0zBNkGv5kvME1PDCjRIsxoYtmPc+cT1lntrSTcjAMOkK+
 yuIyku7CJnusz9cm9VAO480Nr/G+M5MHIyzvIrmFJ//PQl0AtwWEKPXKeUAXB+8I3VvM
 tfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xvQuM1t+AMalZIyQmGqvVV5WcXOTpPBqjnsxou10UMI=;
 b=ZIrWC7G91He5LdXIpZ0xZsmTVrT/mFu0YLD7r4Y8dkTf+uHNY/dJVC93eZgNlfcJDS
 8uxmXUZ7vteURYbqOinuupAfsIJRij17GX5AdPw0/9HJrdV1d929R0PKOL+mv4Bexm19
 0PuQUPaiCRqAYvga6vkRd2+OZxZlVDHiqavqfsLHhPR+Erxh6/gFKyTNzc+NEIL+6DsR
 WN3vJvQPxGtozhi1h9aCKXiDK1H0ZjoG2Pb1uDSWSCVow8igyWkn7PCqNG4cHxJWZWyx
 ilU7B2ukpDZSihXfWCTCbnhcBMJ8SVZc11PdXgeYLDbBuHOz2EQx78m8sfxns12mIGRT
 I7WQ==
X-Gm-Message-State: ANhLgQ0s+zrIoaoeKR1AeLTcssQC25ou5JsieIbBWcZtuFMkVktggSN1
 s180vDpv/xfwW4x2Z0zaRXeXzMN/DGQTO8mVLYPqeg==
X-Google-Smtp-Source: ADFU+vvC6zBAgiyeYk9FkMwdMbaDEAxouIAgJE1HYNnwchfSRgte/24c0UTVvCmGcnafcpmvKf5O1XPda63WUNjX0GE=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr1766287oij.48.1585259038796; 
 Thu, 26 Mar 2020 14:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-8-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:43:47 +0000
Message-ID: <CAFEAcA8X5_9G8i31A17DxZDagyHoVYQ7Ctsf5n_9weHqGM6ksA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 07/12] hw/mips/cps: Add missing error-propagation
 code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Patch created mechanically by running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --in-place --dir hw
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/cps.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>

>      /* Inter-Thread Communication Unit */
>      if (itu_present) {
>          sysbus_init_child_obj(OBJECT(dev), "itu", &s->itu, sizeof(s->itu=
),
>                                TYPE_MIPS_ITU);
>          object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &=
err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-pr=
esent",
>                                   &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          if (saar_present) {
>              s->itu.saar =3D &env->CP0_SAAR;
>          }
>          object_property_set_bool(OBJECT(&s->itu), true, "realized", &err=
);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          if (err !=3D NULL) {
>              error_propagate(errp, err);
>              return;
>          }

I think Coccinelle has been fooled here by the slightly non-idiomatic
use of "err !=3D NULL" in the guard and has inserted a duplicate
check...

>          memory_region_add_subregion(&s->container, 0,
>                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->itu=
), 0));
>      }
>
>      /* Cluster Power Controller */
>      sysbus_init_child_obj(OBJECT(dev), "cpc", &s->cpc, sizeof(s->cpc),
>                            TYPE_MIPS_CPC);
>      object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", &err=
);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->cpc), true, "realized", &err);
>      if (err !=3D NULL) {
>          error_propagate(errp, err);
>          return;
>      }

...but oddly it gets it right here and in a couple of other cases
in this patch.

thanks
-- PMM

