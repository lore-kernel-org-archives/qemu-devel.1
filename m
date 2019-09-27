Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE88C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BD1217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdN8WHhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BD1217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuC8-0004DE-JO
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDtjF-0006l6-06
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDtjC-0000tE-MF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:08:23 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDtjB-0000kS-E8; Fri, 27 Sep 2019 13:08:22 -0400
Received: by mail-lj1-x242.google.com with SMTP id n14so3188484ljj.10;
 Fri, 27 Sep 2019 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BNZ9/jzgFwq2n6gPnPFU7S0cvpQwajJQs4sOkLU8R5w=;
 b=CdN8WHhupNlVVNDUt9GWeyW0Emd2q//V1yxv7ErjPDk0xaBQx9VdGqQXf9Bt9e8vCM
 vz56DSVCaIUupew6oD3DvADWQNXQWFYPFqJbDjxPRK3eFwZ7ST/WDv3NPzHoIVqIxvAk
 TNzG+iupSuWG8I8sS4xn+OcmBjQNovcmSOBCouR/M5quIgRa4Nu1QWoSNOstuCPGpfVR
 Zgnq3fF+LuGcajpnx+7O8y03EHpwd5ZE4II93BGfxyZ3Z7EnsSok1zkSeqT+U1htKclX
 hFcfzXnmCJeZX7K2e5tdfx8j4IFpItODQsYvjAvW0BBEfvlTzwAOQ2afUGe9AyQoYywZ
 YAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BNZ9/jzgFwq2n6gPnPFU7S0cvpQwajJQs4sOkLU8R5w=;
 b=EeelrXEnfNVMMjVqwVxBfvL3aCc8z7QnncU4YoVfOcShb2VwVNfQKZdzCwbAZivEPv
 73pplPMbP/zuf4McqqOzcTpC4Uh6efZzoeh6h+YBm9+BHbORyDYi0IzjkbS6Wcdma21g
 Xinx+KKnCWoHhA+kAWV0Eh5pYaTRLcsg8ECyAF4TxmhXJiNSLNS+8rUqdAANQfoklizD
 IpGy0U9YBWPicAaGxoUWdVRv04ipk0vr61aqKm1pZ5AAY1PFq74yaPygHzY3QjyW2HNe
 2oqF4L0FhitoN5h2NPCYuhBeqnlC1r6T0ca93JuFeVzIA2SlPoTeC2cpJtriov7XTRdo
 Ztaw==
X-Gm-Message-State: APjAAAWkc3T5rfnvhYpXZ234olE/y748AH8mPz3udQNZ9NqhDAaQIxDi
 bV/HVCTYXw5h8OMDavstHxcnaxQ76Sv5iqkfOZc=
X-Google-Smtp-Source: APXvYqyFKsverXPSm5hJ/MrAgQHNiwQ1shrY5pm3D4/tcNlSWoFIOPi5yibSBZg76oh5IDXrKQcm8CFthf/CzLICP6E=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr3765082ljg.119.1569604099431; 
 Fri, 27 Sep 2019 10:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
 <7ffed750-767a-40be-4ef1-d52aad93f2e5@redhat.com>
In-Reply-To: <7ffed750-767a-40be-4ef1-d52aad93f2e5@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 10:03:32 -0700
Message-ID: <CAKmqyKP4PEOY579+XfQWxJKzOpmaNu-e=vU45wf2_n6BUg0ZzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 2:10 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 9/27/19 2:45 AM, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/translate.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index adeddb85f6..537af0003e 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -810,7 +810,14 @@ static void riscv_tr_tb_stop(DisasContextBase *dcb=
ase, CPUState *cpu)
> >
> >  static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUStat=
e *cpu)
> >  {
> > +#ifndef CONFIG_USER_ONLY
> > +    RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
> > +    CPURISCVState *env =3D &rvcpu->env;
> > +#endif
> >      qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
> > +#ifndef CONFIG_USER_ONLY
> > +    qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->=
priv);
> > +#endif
>
> Nit: can be extracted as another function to reduce the ifdef'ry and
> simply use:
>
>        log_cpu_priv(cpu);
>
> >      log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
> >  }
> >
>
> With function previously defined:
>
> static void log_cpu_priv(const CPUState *cpu)
> {
> #ifndef CONFIG_USER_ONLY
>     RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
>     CPURISCVState *env =3D &rvcpu->env;
>
>     qemu_log("CPU: %d; priv: "TARGET_FMT_ld"\n", cpu->cpu_index, env->pri=
v);
> #endif
> }
>
> Anyway, fixing the typo in the patch subject:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks I have included your comment and Bin's comments in v2.

Alistair

>

