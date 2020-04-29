Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD3C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DD02070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1FyTiMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DD02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjcA-0004fy-Eh
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTjbN-0003nN-Rs
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTjbM-0006hx-3L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:06:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jTjbL-0006hf-Kf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:05:59 -0400
Received: by mail-io1-xd41.google.com with SMTP id b12so1545954ion.8
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g81phw6oJtqJnglgqTcT5AIqP8FwHyf6dydZz/9ZFjw=;
 b=k1FyTiMMCAfn17dcfEGReEY2+pCPPcZFV30vmhtIW0mW8Q1KvrR87gbJ48MhfLiiGe
 kH4iMNQ1tDIl0pCUZ4jXhQQlc9w59v3HqzMeyKalvDJxEvg88nCb0LfuJwg5aj2uhrIl
 K9DxV1wLR5j/bCrN6Y0NMO27gbFDInvjh2aqtIvIqHkY/FYU1cwT9dYoJi4c3DS+tIlg
 t2Ai71D/1gA06nYBdVH1Q9rO7MeVcqc4FcPUZkemvNOhJUqXMGMLhNYPGY8B/4JaL505
 baVogiJts765hydkyE21s5Y1y5dl4+hX6DIhc0qe57qNNnVyDbY2becZ+YrhB87XXFCA
 0FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g81phw6oJtqJnglgqTcT5AIqP8FwHyf6dydZz/9ZFjw=;
 b=qGhGkC/Oyvon8+pjkI01A+nUr4U2sZxgjE7nsNPsUes6ctkPyK/+ptTHepwVInDmp4
 lbGLd83ZsWCnnAI+Yw0SWzHB91P+MoDs25vjYzOTEb5SPjD80D54HSZO5I1Ie3URNM/x
 5/Qb694e4L03drUcUIYNpXGpgdVfjYKE0mmlTvhybTVWYPL3szZ9lLWbv1HCiW7auITO
 gP1NpZPhyqwKPMOWeHFDSUI3Oy1Z7lYTvDFMJHAcKN61WIML1ycKMobkyaWT4UGtpKbk
 0/P1cB0skFj+j/kDeu92DumgnXTZXU4c3duHh6GJgD6lTY6vuXOz/xp6UUbj8Sl4YDyj
 r8MA==
X-Gm-Message-State: AGi0PuZlJYFwSmzTxWjqktxN1sjUjmcHPo79VahMf5CMi/6y36vvm8hu
 gmY/jjvRLtSQXqGKhGP/TRdvzXeOBVUFWxirVfg=
X-Google-Smtp-Source: APiQypKmbnfu31asVWO2mKQh4lBZsM56SyjPB5H+L/6mzIWaTmPMJwsfzJ45uyxzge6E9Yepd+EFdFjttKmk+WmW5hY=
X-Received: by 2002:a02:966a:: with SMTP id c97mr29776479jai.106.1588154758116; 
 Wed, 29 Apr 2020 03:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-3-git-send-email-chenhc@lemote.com>
 <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
 <CABDp7Voe_WJwa6J9W-rQdSRHMx+u=46tfd9ufEdAkE36e59_FQ@mail.gmail.com>
 <CAHiYmc5R8icimeJ3i=E-8_uUWpRMUUH67xZKFk04CrjgXKHgcQ@mail.gmail.com>
 <CAAhV-H6tTU0jLfFFotrfCE_4sQKB0UEhKbxoGQrOhqzVBvo35g@mail.gmail.com>
 <9d7b79c9-8d95-93ef-e0c3-ddccf5b46a84@amsat.org>
In-Reply-To: <9d7b79c9-8d95-93ef-e0c3-ddccf5b46a84@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 29 Apr 2020 18:13:28 +0800
Message-ID: <CAAhV-H5zPRR6LQUjKvoZFO3e9H5kP4G7GL0Uj15WTTJy6021Vw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Apr 29, 2020 at 5:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 4/29/20 3:52 AM, Huacai Chen wrote:
> > Hi, Philippe and Aleksandar,
> >
> > I'm not refusing to change my patch, but I have two questions:
> > 1, Why we should identify Loongson-3 to deliver IP3? It seems that
> > deliver all IPs (IP2~IP7) unconditionally is harmless as well.
> > 2, How to identify Loongson-3 by Config6/Config7? Loongson-3 is not
> > the only processor which has Config6/Config7.
> Please don't top-post on technical lists, it makes the conversation
> harder to follow.
>
> This code is modelling the device, not KVM.
>
> Commit b1bd8b28cca is not very verbose. I wonder why not delivering all
> IRQs to kvm_mips_set_interrupt, that would make this patch simpler.
>
> I think the problem in QEMU MIPS IRQ delivery is one implementation is
> in cpu_mips_irq_request() while another one (vectored IRQ) in
> cpu_mips_hw_interrupts_pending (see 138afb024bb) and KVM is also in the
> middle.
I think the previous code only deliver IP2 is because KVM/MIPS only
use IP2 for external interrupts, but now I have changed KVM/MIPS as
well, please see:
https://patchwork.kernel.org/patch/11507591/

>
> And I see you selected CP0C3_VInt in the R4 definition... so what is
> delivered here?
CP0C3_VInt just indicates the capability, kernel of Loongson-3 doesn't use =
VINT.

>
> >
> > Huacai
> >
> > On Wed, Apr 29, 2020 at 2:58 AM Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> >>
> >> =D1=83=D1=82=D0=BE, 28. =D0=B0=D0=BF=D1=80 2020. =D1=83 10:21 chen hua=
cai <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
> >>>
> >>> Hi, Philippe,
> >>>
> >>> On Mon, Apr 27, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
> >>>>
> >>>> On 4/27/20 11:33 AM, Huacai Chen wrote:
> >>>>> Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch =
add
> >>>>> IP2 delivery as well, because Loongson-3 based machine use both IRQ=
2
>
> "IP3 delivery as well"?
Sorry, this is my fault.

>
> >>>>> (CPU's IP2) and IRQ3 (CPU's IP3).
> >>>>>
> >>>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >>>>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>>>> ---
> >>>>>   hw/mips/mips_int.c | 6 ++----
> >>>>>   1 file changed, 2 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> >>>>> index 796730b..5526219 100644
> >>>>> --- a/hw/mips/mips_int.c
> >>>>> +++ b/hw/mips/mips_int.c
> >>>>> @@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, =
int irq, int level)
> >>>>>       if (level) {
> >>>>>           env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
> >>>>>
> >>>>> -        if (kvm_enabled() && irq =3D=3D 2) {
> >>>>> +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> >>>>
> >>>> Shouldn't we check env->CP0_Config6 (or Config7) has the required
> >>>> feature first?
> >>> I'm sorry that I can't understand IRQ delivery has something to do
> >>> with Config6/Config7, to identify Loongson-3?
> >>>
> >>
> >> Obviously, yes.
> >>
> >> Thanks,
> >> Aleksandar
> >>
> >>
> >>>>
> >>>>>               kvm_mips_set_interrupt(cpu, irq, level);
> >>>>> -        }
> >>>>>
> >>>>>       } else {
> >>>>>           env->CP0_Cause &=3D ~(1 << (irq + CP0Ca_IP));
> >>>>>
> >>>>> -        if (kvm_enabled() && irq =3D=3D 2) {
> >>>>> +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> >>>>>               kvm_mips_set_interrupt(cpu, irq, level);
> >>>>> -        }
> >>>>>       }
> >>>>>
> >>>>>       if (env->CP0_Cause & CP0Ca_IP_mask) {
> >>>>>
> >>>
> >>>
> >>>
> >>> --
> >>> Huacai Chen
> >

