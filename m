Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A3C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5D720731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN3Gu3o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5D720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTirL-00073v-2R
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTiqW-0006IW-T1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTiqT-0003hb-Ig
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:17:36 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:45010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jTiqT-0003hC-4h
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:17:33 -0400
Received: by mail-il1-x144.google.com with SMTP id s10so1692320iln.11
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JQv0s1MBmIMYp06KxABP2Ziek6OxnbYJCcwA8mcJiKM=;
 b=ZN3Gu3o78mEs9ESVVoALTfY5Azer7Ctk+luQnzPI2JsgKgWFuIhAwmGf8HJNW0U1i9
 yGvXTH7y/T+1MXIpvycA8FQzQQydyrbdSa/hHwCJaEDXe9eiOziH+dTkKQP0gJSJTQUL
 ab5udWN5bjXVtMUK0Tdg15ED8jIBP5TPGgMbEqCVz4GYgHTUFhb/Pu9EYrh8X5TYVavZ
 DxiFmEGXOUPllOtDnDH173qvieNCkogYiAeKgK4jpe/hohInW+mgWI+9NifA5ocHrUB+
 jdYvN1bDiXTmIbTP+xgkgz4DUIpv/B9Jx7o4S5Q0JrfcFyozn5Zd07qJcq/+O61NpSql
 Sy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JQv0s1MBmIMYp06KxABP2Ziek6OxnbYJCcwA8mcJiKM=;
 b=FpnTySFbACGr7/+sLkcL+SgwcPxq+yPhpbLzbft9gxkmK/U7ocVMobtMUhrcCI0tds
 GqmNQqcf+5oqGGdk0H2hJCnZIgtXwEdfO4B6bdop/jRB5dIDpB8/3Otu93Yq+k1gOfSy
 xuAjmewDfkVoNDXNNoBbW1XY+SR+nTvjDgKZombZZq9DqRu+uC3cPum/j5sn71ZpuwMH
 iBpoP76By9yMjCkF2X9b/+ZfI0Av6UcDR4ciWA4eLclrxeg+FDqsHEJrUgQfc1AsItgw
 DiMCbcYpUpWIaWxuxSXX8lfOAliYuJAAk29JYECBqKxGigmvPUj5TQ8PmHE9j9Xg7LkF
 3wzQ==
X-Gm-Message-State: AGi0Pua/tndqpFYRoVpgDQY8Rq14B8Ukugld9HKdPzcVDAilefyHyC1Z
 25Op/m7Kjha99DiFkqOfaQQCTU8t8Eo0/cjwbOo=
X-Google-Smtp-Source: APiQypKOzC914zTCsF7zXs3DLCYqg013LaYOIfFp7GhzZXP3AOBW8BTk2SWRgZDgIvBs3GMckW+vYSQ5U6snmUuq5Vk=
X-Received: by 2002:a92:cece:: with SMTP id z14mr29324172ilq.147.1588151851854; 
 Wed, 29 Apr 2020 02:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-4-git-send-email-chenhc@lemote.com>
 <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
 <CABDp7Vq-YX0LWU3iM=oygpcKzoS8cmXG6mvTQ5Gm_PbQsQMAgw@mail.gmail.com>
 <CAHiYmc6zFjBtgXRv=8+dqnbDtZqKqiwSDwEi0wKqJmJnys_y0g@mail.gmail.com>
 <CAAhV-H6NFV7hbaOp8BwPck3FWm5ZHBpuoA9FDmN6tby5LcoTeg@mail.gmail.com>
 <a791f90b-a2a5-6665-59b5-212f98c7afc8@amsat.org>
 <CAAhV-H7NS_KCTuYQYvZeseNEZh56FBFz97kEj4KK-NsBDMJotQ@mail.gmail.com>
 <a1b333c6-e9a0-aabc-9ec2-b9bcb2007211@amsat.org>
In-Reply-To: <a1b333c6-e9a0-aabc-9ec2-b9bcb2007211@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 29 Apr 2020 17:25:01 +0800
Message-ID: <CAAhV-H5_0Nn-omF+_+6T1mbtnFC-3VHTOgvAPfbc44Fnv0px_Q@mail.gmail.com>
Subject: Re: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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

I think that this CPU definition is for Guest, not for Host (Maybe I'm wron=
g?).

On Wed, Apr 29, 2020 at 4:58 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 4/29/20 10:27 AM, Huacai Chen wrote:
> > Hi, Philippe,
> >
> > The major differences of R3 and R4 are:
> > 1, R4 has complete MIPS VZ ASE (while R3 is incomplete), so very
> > usable for KVM host;
>
> So you need to set CP0C3_VZ.
If the definition is for Guest, I think CP0C3_VZ should not be set in
CP0_Config3, because only the Host can see VZ ASE.

>
> > 2, R4 has MSA ASE while R3 hasn't;
>
> So you need to set CP0C5_MSAEn.
I have already set CP0C5_MSAEn CP0_Config5_rw_bitmask, but I don't
think it should be set in CP0_Config5 because MSA is disabled by
default.

>
> > 3, R4 has cpucfg, rdcsr and wrcsr instructions (similar to cpuid,
> > rdmsr and wrmsr in X86).
>
> OK, these are not implemented.
>
> [...]
>
> >>>>>>> diff --git a/target/mips/translate_init.inc.c b/target/mips/trans=
late_init.inc.c
> >>>>>>> index 6d145a9..a32412d 100644
> >>>>>>> --- a/target/mips/translate_init.inc.c
> >>>>>>> +++ b/target/mips/translate_init.inc.c
> >>>>>>> @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =3D
> >>>>>>>            .mmu_type =3D MMU_TYPE_R4000,
> >>>>>>>        },
> >>>>>>>        {
> >>>>>>> +        .name =3D "Loongson-3A",
> >>>>>>> +        .CP0_PRid =3D 0x14C000,
> >>>>>>> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache lin=
e size.  */
> >>>>>>> +        .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2=
 << CP0C0_AT) |
> >>>>>>> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> >>>>>>> +        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 <<=
 CP0C1_MMU) |
> >>>>>>> +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 <<=
 CP0C1_IA) |
> >>>>>>> +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 <<=
 CP0C1_DA) |
> >>>>>>> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 <<=
 CP0C1_EP),
> >>>>>>> +        .CP0_Config2 =3D MIPS_CONFIG2,
> >>>>>>> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << =
CP0C3_MSAP) |
> >>>>>>> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 <<=
 CP0C3_ULRI) |
> >>>>>>> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 =
<< CP0C3_VInt),
> >>>>>>> +        .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << =
CP0C4_IE) |
> >>>>>>> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExis=
t),
> >>>>>>> +        .CP0_Config4_rw_bitmask =3D 0,
> >>>>>>> +        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_NFExists) | =
(1 << 18),
> >>>>>>> +        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_K) | (1 << CP0C5=
_CV) |
> >>>>>>> +                                  (1 << CP0C5_MSAEn) | (1 << CP0=
C5_UFE) |
> >>>>>>> +                                  (1 << CP0C5_FRE) | (1 << CP0C5=
_SBRI),
> >>>>>>> +        .CP0_Config6 =3D (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU)=
 | (1 << CP0C6_SFBEN) |
> >>>>>>> +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPRE=
F) | (1 << CP0C6_DATAPREF),
> >>>>>>> +        .CP0_Config6_rw_bitmask =3D (1 << CP0C6_BPPASS) | (0x3f =
<< CP0C6_KPOS) |
> >>>>>>> +                                  (1 << CP0C6_KE) | (1 << CP0C6_=
VTLBONLY) | (1 << CP0C6_LASX) |
> >>>>>>> +                                  (1 << CP0C6_SSEN) | (1 << CP0C=
6_DISDRTIME) |
> >>>>>>> +                                  (1 << CP0C6_PIXNUEN) | (1 << C=
P0C6_SCRAND) |
> >>>>>>> +                                  (1 << CP0C6_LLEXCEN) | (1 << C=
P0C6_DISVC) |
> >>>>>>> +                                  (1 << CP0C6_VCLRU) | (1 << CP0=
C6_DCLRU) |
> >>>>>>> +                                  (1 << CP0C6_PIXUEN) | (1 << CP=
0C6_DISBLKLYEN) |
> >>>>>>> +                                  (1 << CP0C6_UMEMUALEN) | (1 <<=
 CP0C6_SFBEN) |
> >>>>>>> +                                  (1 << CP0C6_FLTINT) | (1 << CP=
0C6_VLTINT) |
> >>>>>>> +                                  (1 << CP0C6_DISBTB) | (3 << CP=
0C6_STPREFCTL) |
> >>>>>>> +                                  (1 << CP0C6_INSTPREF) | (1 << =
CP0C6_DATAPREF),
> >>>>>>> +        .CP0_Config7 =3D 0,
> >>>>>>> +        .CP0_Config7_rw_bitmask =3D (1 << CP0C7_NAPCGEN) | (1 <<=
 CP0C7_UNIMUEN) | \
> >>>>>>> +                                  (1 << CP0C7_VFPUCGEN),
> >>>>>>> +        .CP0_LLAddr_rw_bitmask =3D 1,
> >>>>>>> +        .SYNCI_Step =3D 16,
> >>>>>>> +        .CCRes =3D 2,
> >>>>>>> +        .CP0_Status_rw_bitmask =3D 0x7DDBFFFF,
> >>>>>>> +        .CP0_PageGrain_rw_bitmask =3D (1U << CP0PG_RIE) | (1 << =
CP0PG_XIE) |
> >>>>>>> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
> >>>>>>> +        .CP1_fcr0 =3D (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (=
0x1 << FCR0_F64),
> >>>>>>> +        .CP1_fcr31 =3D 0,
> >>>>>>> +        .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
> >>>>>>> +        .SEGBITS =3D 48,
> >>>>>>> +        .PABITS =3D 48,
> >>>>>>> +        .insn_flags =3D CPU_LOONGSON3A,
> >>>>>>> +        .mmu_type =3D MMU_TYPE_R4000,
> >>>>>>> +    },
> >>>>>>> +    {
> >>>>>>>            /* A generic CPU providing MIPS64 DSP R2 ASE features.
> >>>>>>>               FIXME: Eventually this should be replaced by a real=
 CPU model. */
> >>>>>>>            .name =3D "mips64dspr2",
> >>>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Huacai Chen
> >>>
> >

