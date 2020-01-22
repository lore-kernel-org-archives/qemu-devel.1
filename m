Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88372C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525F32253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/wZASxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525F32253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5FM-0004CW-HW
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 20:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iu5ET-0003VV-Gi
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iu5ES-0006rf-8h
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:55:01 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iu5ES-0006r8-4S
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:55:00 -0500
Received: by mail-io1-xd43.google.com with SMTP id m25so4992417ioo.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Tg/7O+sBX6tAdUTDDhUZdOUdKQ1MBUoYAmVdi/n7Q5s=;
 b=g/wZASxrH+bWzKjHx1Uw3aHX2bC94nGENPdUH1PJ264oanAxkDQDvkLedRtA12V91O
 UvS5PK9bCM246xTQdhwh8h8xjyZxanlpME5lTbTnrXsr1rkD7F+LLpZvkcG8L0dccdkm
 pRiAwWgYmx7ZWnCxFC4uUXJ0S5UlkdplZCY36ZVzotHs5nGlUYHUaSMtoxele5yMmICJ
 bjv7vEXhBz6iyq1vPWnXW09hBKTYiZjew5uX3SIX/DcXGwWIWSEWJo539dC49ApZW+ou
 8swTn51hastd9D78bSss2CUWnENKtfTxlhYL/x1G38GkN8SfEaNmcn8r2KsJypYZ7x+9
 1aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Tg/7O+sBX6tAdUTDDhUZdOUdKQ1MBUoYAmVdi/n7Q5s=;
 b=HECGHKd9ovSMoy4WFfXRP1NTGGH7fIKcChDN9VJTEv3RvWps6AYtEmOEsb/uQddTyD
 XqZuyjBbs3mm39fmaaEeWp+QjHhgSCX+o/JpaY9c7WrUpwX9vlJ/N0PBZM142ZSpY6Ce
 Rd6zm0oDGlqW851roallZ5uDsP9Pl8VgPeqjTXH/ENqxFq04ZHkToDxxAvoaj288fPtR
 a4vL/uxqlMNCh7u1LwE1W9E6fWeZb6PurvZ6GSWm0cbb3q7OWwqBWrZK3pjaK4853OKg
 rGZAhp7HLg7iIgcRMdPL30tK5Z/DoFcUNdmmYztYe5B7/9l7VRQHxV+ffUtrOdCMv46p
 LSoA==
X-Gm-Message-State: APjAAAVIhbl3TIJf9fLT034K3KFmVP8VIAVpWG+MGzj6d5Yf+qfbEXVv
 o//r4JwnDrq4xwllaOlK54PqWt3+Y9WW0ZWR6+k=
X-Google-Smtp-Source: APXvYqxSPVRDxK2CP7fXmqODxPPSvnY+uSw3Yxbs2ykByQUWs4CD39iF7eM+jzqNv/C+1kifvYUTmB2BqGEHRzDWq1k=
X-Received: by 2002:a5e:c606:: with SMTP id f6mr5354478iok.71.1579658099230;
 Tue, 21 Jan 2020 17:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20200121100732.28734-1-ianjiang.ict@gmail.com>
 <CAKmqyKNpg4j4nZU19TNtJPs-oypOq=9mHJaM0ios=MbppKYfwg@mail.gmail.com>
In-Reply-To: <CAKmqyKNpg4j4nZU19TNtJPs-oypOq=9mHJaM0ios=MbppKYfwg@mail.gmail.com>
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Wed, 22 Jan 2020 09:54:48 +0800
Message-ID: <CAMAD20mLZGr_zA341uT=D7p7=Jue+rxvfi9-bLKvOxVjNxK1iQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix bug in setting xPIE of CSR for MRET and SRET
 instructions
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just find that there is a previous patch at
https://github.com/palmer-dabbelt/qemu/commit/a37f21c27d3e2342c2080aafd4cfe=
7e949612428
--
Ian Jiang

Alistair Francis <alistair23@gmail.com> =E4=BA=8E2020=E5=B9=B41=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:48=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Jan 21, 2020 at 8:08 PM Ian Jiang <ianjiang.ict@gmail.com> wrote:
> >
> > According to the RISC-V specification, when executing an MRET or SRET
> > instruction, xPIE in mstatus or sstatus should be set to 1. The orginal
> > QEMU does not give the right operations.
> > This patch fix the problem.
> >
> > Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> >  target/riscv/op_helper.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index 331cc36232..e87c9115bc 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -93,7 +93,7 @@ target_ulong helper_sret(CPURISCVState *env, target_u=
long cpu_pc_deb)
> >          env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
> >          MSTATUS_SIE : MSTATUS_UIE << prev_priv,
> >          get_field(mstatus, MSTATUS_SPIE));
> > -    mstatus =3D set_field(mstatus, MSTATUS_SPIE, 0);
> > +    mstatus =3D set_field(mstatus, MSTATUS_SPIE, 1);
> >      mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
> >      riscv_cpu_set_mode(env, prev_priv);
> >      env->mstatus =3D mstatus;
> > @@ -118,7 +118,7 @@ target_ulong helper_mret(CPURISCVState *env, target=
_ulong cpu_pc_deb)
> >          env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
> >          MSTATUS_MIE : MSTATUS_UIE << prev_priv,
> >          get_field(mstatus, MSTATUS_MPIE));
> > -    mstatus =3D set_field(mstatus, MSTATUS_MPIE, 0);
> > +    mstatus =3D set_field(mstatus, MSTATUS_MPIE, 1);
> >      mstatus =3D set_field(mstatus, MSTATUS_MPP, PRV_U);
> >      riscv_cpu_set_mode(env, prev_priv);
> >      env->mstatus =3D mstatus;
> > --
> > 2.17.1
> >
> >

