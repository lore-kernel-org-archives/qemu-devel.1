Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C96CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0930720675
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh31AZk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0930720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYowU-0005Iv-5k
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYovo-0004d1-Ru
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:48:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYovn-000894-KQ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:48:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id k12so25987940wmj.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=891iZvUpwGRA1oz8NWhj8csU+yCpmYSBi3rFbvdHNjc=;
 b=eh31AZk7d1HqHCjkKgKpr5OPQBphBL5GqNRz6R2ba4p6m4N6E1zg1XYtd24QcvO4Wt
 6IuiTM5SALApeGr3s/uR5cATy3IsDJYfp8Z3oW4XUyU8HH2+DyPn+r9WPmCLsMUIW1PF
 +qL108eFNQAGZB3czhFKWeUtiwCfIVYrIM/iGzcPga0V5eEMvDpZXZFyO4nhENe/NXUr
 Pv9aPw4/XPnAFOWyO2sZqKU7GYTTj93rlJMhUEOqqRolNfma5+b4ToXfPx4IGkepVaTn
 4Q5M4EUYRXn0+49w/bSm13SHw/oklxyKV6sZwqNI4ry7mYZlHhJBusUkcTNIeTuJNHIR
 BoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=891iZvUpwGRA1oz8NWhj8csU+yCpmYSBi3rFbvdHNjc=;
 b=pK3YMrwfbC2UXd1FgvooglVyeJjoFD/n7Alz32lttmEo2bSH5CdQdBH3jmNeabBQGM
 aIydLDJKrXxL59RqnAVnY6nGwrEAdhUJsxwWfhM/hEu3kcpeWUoG8Ih1ScBrMdXv3BaM
 FmHgVOb7tsZlDOD2Hj2LKOuFqxn3N+IaNhyzfZdI9/fR5bfE3l/jM+j3FNNRTecCVLFJ
 Dl4p81nZ0JSTp+ea9oegyjbFiX5PjSVoVvguESeKAt3BpmdhxMxpNSVDnrCLkgt+J03c
 p+8q0elCrPkAkUEd1xxJGMdoAskI62BWaQ89TGtc0+mtJ9xyVghBeD8u3HX65a10YAmX
 I4CA==
X-Gm-Message-State: AGi0PuY8OdItExEpTCpQE7DyrQyUnMv+y4L5uQRliZ9ntI2auvf4U6cc
 1HVMcZETCLt1GFOOTZktkxrASwgtujmWuR9qx3Y=
X-Google-Smtp-Source: APiQypIEvMX6R/pi6twxmGS0WU/Wg91byAL7+BxPhRz2j67n57JqkYBxPt3HHwI0nPsShUMqMte+ogbnh8SIcCaPXg4=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr46113798wmc.168.1589366886374; 
 Wed, 13 May 2020 03:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-2-git-send-email-chenhc@lemote.com>
 <CAHiYmc5zPT97Zxr6JTXY8dHTSU7aFC3EY6ODgULuex-xRYWCQA@mail.gmail.com>
 <CAAhV-H6bgF8McE7yR5JxXH=xSoGB3=wWJayym38WFCi=5XrNhg@mail.gmail.com>
In-Reply-To: <CAAhV-H6bgF8McE7yR5JxXH=xSoGB3=wWJayym38WFCi=5XrNhg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 13 May 2020 12:47:54 +0200
Message-ID: <CAHiYmc5i7JRwRXAwD8OXC4SzZ0zWhFiZ+cgFmrFa28g7Kk4BXg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips/mips_fulong2e: Set preferred page size to 16KB
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 13. =D0=BC=D0=B0=D1=98 2020. =D1=83 10:25 Huacai Chen <=
chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Hi, Aleksandar,
>
> On Wed, May 13, 2020 at 3:56 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> > =D1=81=D1=80=D0=B5, 8. =D0=B0=D0=BF=D1=80 2020. =D1=83 11:08 Huacai Che=
n <chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
> > >
> > > Loongson processor prefers 16KB page size in system emulator, so let'=
s
> > > define mc->minimum_page_bits to 14.
> > >
> > > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > ---
> >
> > Huacai, thanks for the efforts regarding this series! I will very
> > likely accept patches 1/3 and 2/3 from this series in my next MIPS
> > queue, but the possible problem is that I somehow can't find patch 3/3
> > from my series in my mailbox. (I think it also the case with the cover
> > letter.) Could you perhaps resend the whole series? I'm concerned that
> > patch 3/3 contains something important, and it would be a shame that
> > it is omitted, and 1/3 and 2/3 are accepted.
> Patch 3/3 is "Add myself as fulong2e co-maintainer", this is already
> done in your series, so maybe I needn't resend?
>

In that case, no need to resend, thanks!

Aleksandar

> Regards,
> Huacai
> >
> > For this patch:
> >
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> >
> > >  hw/mips/mips_fulong2e.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> > > index 5040afd..23897d7 100644
> > > --- a/hw/mips/mips_fulong2e.c
> > > +++ b/hw/mips/mips_fulong2e.c
> > > @@ -399,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineCla=
ss *mc)
> > >      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
> > >      mc->default_ram_size =3D 256 * MiB;
> > >      mc->default_ram_id =3D "fulong2e.ram";
> > > +    mc->minimum_page_bits =3D 14;
> > >  }
> > >
> > >  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> > > --
> > > 2.7.0
> > >

