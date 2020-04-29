Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99966C83001
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 01:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5895A20737
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 01:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3LcdAoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5895A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTbnW-0001D0-Ei
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 21:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTbmp-0000ge-Mu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 21:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTbmo-0003XD-Sp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 21:45:19 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jTbmo-0003RP-Fg
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 21:45:18 -0400
Received: by mail-il1-x141.google.com with SMTP id b18so923994ilf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 18:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5vnWFyP8ZlAts97rFSJbLnjeEuuBarVQ038r/VwJHuI=;
 b=K3LcdAoYeBiGObDOp9hnXsjMEb3aWHu43mAqR+o6jLOiVVTsRLejw18ENW2VP6kLQY
 bZdIklgitzgZEW7VSfnhvQRF2fhNZhfCTTwRefBVI+e6mSB5+VVK4DVpCUlsI3GoJRdB
 ZMxDb/F3u0GZxTfxkaqQwoQUmC5Gm7xahTNuWnGxFkFUO4Libw9O8+83SyBf6iJKXCYy
 rlekDDW+eIapeWRFTjLpYirNGbiv7qRC4yD101i1Xunk5+hg2OZQXoRBAkHvq3XFjzXv
 XDAYdV1mQRsLTAdd86ry5bmrEFSZy4VL/WHDLAJ6Ad85aID60qybA5GSWYQpeGr1pBwR
 GJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5vnWFyP8ZlAts97rFSJbLnjeEuuBarVQ038r/VwJHuI=;
 b=EccAZ84g0C3UmWgj5sXYfbYyYxYhpc+whNDMNH0NYFmMmMZaCDLvpNmr06f4fjbT0V
 Z1YxBZ5u1D4m9qBKI6Ut6WUeXOKSN3SAeGAJJe2XQNFZiRLuUlAVg/i1OwR0MYfiIA4p
 73zP/Oy9vHplnaZX4q1jReudHPSVPCerHa+3lVwP1rHoaMS3Bvj68nNll1ZiumCddY9k
 o3Y93YMejSFYSyhYXiDAotTNS6S5QHC5p0ccAH0TbmCyiCrRSS+Ta+Rem5j7Ta+zWEl2
 nQDXkA9+/5SC2FrhmjFpGUdsH5NDO8QLIcEswwmbspywuaV9XD49AfukrlyV6wgUQChA
 03cA==
X-Gm-Message-State: AGi0PuYYPqNBGRzAWi10nRgeuiJbqFPfB3IaFPNEKT6NEzf6QR0mtlJ3
 g7meGiR8/2gU4mQksmIVBH77PJHx3lejY2OJycY=
X-Google-Smtp-Source: APiQypKO+qdErRrGwuiTG3aMlLEGw2ut3v6XQSwfHWtIK8r5jkv6NI5bFgjblwgvDB6XwiUcnu/98aUZz8Eernrcf7E=
X-Received: by 2002:a92:cece:: with SMTP id z14mr28232710ilq.147.1588124717321; 
 Tue, 28 Apr 2020 18:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-3-git-send-email-chenhc@lemote.com>
 <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
 <CABDp7Voe_WJwa6J9W-rQdSRHMx+u=46tfd9ufEdAkE36e59_FQ@mail.gmail.com>
 <CAHiYmc5R8icimeJ3i=E-8_uUWpRMUUH67xZKFk04CrjgXKHgcQ@mail.gmail.com>
In-Reply-To: <CAHiYmc5R8icimeJ3i=E-8_uUWpRMUUH67xZKFk04CrjgXKHgcQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 29 Apr 2020 09:52:47 +0800
Message-ID: <CAAhV-H6tTU0jLfFFotrfCE_4sQKB0UEhKbxoGQrOhqzVBvo35g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: chen huacai <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe and Aleksandar,

I'm not refusing to change my patch, but I have two questions:
1, Why we should identify Loongson-3 to deliver IP3? It seems that
deliver all IPs (IP2~IP7) unconditionally is harmless as well.
2, How to identify Loongson-3 by Config6/Config7? Loongson-3 is not
the only processor which has Config6/Config7.

Huacai

On Wed, Apr 29, 2020 at 2:58 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D1=83=D1=82=D0=BE, 28. =D0=B0=D0=BF=D1=80 2020. =D1=83 10:21 chen huacai=
 <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
> >
> > Hi, Philippe,
> >
> > On Mon, Apr 27, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> > >
> > > On 4/27/20 11:33 AM, Huacai Chen wrote:
> > > > Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch =
add
> > > > IP2 delivery as well, because Loongson-3 based machine use both IRQ=
2
> > > > (CPU's IP2) and IRQ3 (CPU's IP3).
> > > >
> > > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > ---
> > > >  hw/mips/mips_int.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> > > > index 796730b..5526219 100644
> > > > --- a/hw/mips/mips_int.c
> > > > +++ b/hw/mips/mips_int.c
> > > > @@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, =
int irq, int level)
> > > >      if (level) {
> > > >          env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
> > > >
> > > > -        if (kvm_enabled() && irq =3D=3D 2) {
> > > > +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> > >
> > > Shouldn't we check env->CP0_Config6 (or Config7) has the required
> > > feature first?
> > I'm sorry that I can't understand IRQ delivery has something to do
> > with Config6/Config7, to identify Loongson-3?
> >
>
> Obviously, yes.
>
> Thanks,
> Aleksandar
>
>
> > >
> > > >              kvm_mips_set_interrupt(cpu, irq, level);
> > > > -        }
> > > >
> > > >      } else {
> > > >          env->CP0_Cause &=3D ~(1 << (irq + CP0Ca_IP));
> > > >
> > > > -        if (kvm_enabled() && irq =3D=3D 2) {
> > > > +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> > > >              kvm_mips_set_interrupt(cpu, irq, level);
> > > > -        }
> > > >      }
> > > >
> > > >      if (env->CP0_Cause & CP0Ca_IP_mask) {
> > > >
> >
> >
> >
> > --
> > Huacai Chen

