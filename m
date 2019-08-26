Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA49C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 18:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32C320850
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 18:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4hXoAnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32C320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2JYB-0001PG-0u
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 14:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i2JWw-0000vR-Ff
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i2JWv-0006u3-62
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:15:50 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:43995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i2JWu-0006sj-HF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:15:49 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n205so6953303ywb.10
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w/HBVRuZfoNKh596k6db3h7AINZMBeQ28GGogj0c3zs=;
 b=K4hXoAnDMHfjzDu4BpCpaZ7OV6l9HAUuqPpLioHDMyTeuaLzuc1fSjslz6gdUrY/Ur
 TYmVG7wh8P/5gCPIPBSTLKQU8Hv7q39aEJ4IKF82Z31N/YXXxk2oUUUrEilEaDaoSHjl
 a2JYeesJsYjkFjxCguOdsUWTdC9akqZWw+kocKN9LfCyfCn7dBwFe+LUkY0keEUsEtnS
 OU41rin1MGM8YshkDrE8oFnvu7muBDzyaOq7v4X8yXvRm4RiXAB62InF/Ta6GstHpHzW
 kgn1IU6DFfqqq/XkO+/uUw9ATCew1y5sEBdzWFdsEcqEKxpvAiRN+X0X22Is1PfeuHo0
 iniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w/HBVRuZfoNKh596k6db3h7AINZMBeQ28GGogj0c3zs=;
 b=ggtGGG8L9lRYuCx62icZiJ+iWOMOVZjIflcE4fUfysqh6c5dcPlMIaOd9amq6ZJV6B
 Wysj7Hv2g+klx4W91zSYmHVWm7Zc9dvMOTS8vXiVpsTm4AlnsP1YAQSq1pzNeXL6Q6aY
 caJgBWNKVcXYQHgTcGYg9noQ3GeM12IadV7UVWg1hALDxndSyWtLNT47sdMZNJEo9HTx
 9AKC3NxfV1RWc8kaFWfu7tvJ1c9QrkzXSXLjyaukUFK1ksgGEgplKzP1dGmZqjtsNXgh
 b7Z5rN9nB5O/998zEq8oBAPtLNya4l7E+iQcEeppcD+GhtzrFuV/zSPWlmbBNBJ/UKDW
 rIAA==
X-Gm-Message-State: APjAAAX22J/AbqN/iV19KXjnhv1zUHALNsFYVC7kRjnOHBXivm3FLYRy
 XTZcInTOKvXcQtgPrDXiCmF7FDAckVkpfheJ79thNPeB
X-Google-Smtp-Source: APXvYqzLzIalddLjYPk+TaocVJ7iuFjVUXk4qledmwThMMp3Rcx6g0iE9Fa5vLN9ijZkvVYvIziuyC6dnthBmck6vB0=
X-Received: by 2002:a0d:d4c4:: with SMTP id
 w187mr13977666ywd.409.1566843346655; 
 Mon, 26 Aug 2019 11:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190825221704.1574-1-jcmvbkbc@gmail.com>
 <b61d9c3e-6bfc-c26e-6552-858071fc280b@vivier.eu>
In-Reply-To: <b61d9c3e-6bfc-c26e-6552-858071fc280b@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 26 Aug 2019 11:15:35 -0700
Message-ID: <CAMo8BfJ8yxxFoy+Fzz-wga-baqqtSP2GRHhCwZUgXbnBpuDurQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: linux-user: add call0 ABI
 support
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 3:27 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 26/08/2019 =C3=A0 00:17, Max Filippov a =C3=A9crit :
> > Xtensa binaries built for call0 ABI don't rotate register window on
> > function calls and returns. Invocation of signal handlers from the
> > kernel is therefore different in windowed and call0 ABIs.
> > There's currently no way to determine xtensa ELF binary ABI from the
> > binary itself. Provide an environment variable QEMU_XTENSA_ABI_CALL0 an=
d
> > use it to initialize PS.WOE in xtensa_cpu_reset. Check this flag in
> > setup_rt_frame to determine how a signal should be delivered.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  linux-user/xtensa/signal.c | 25 +++++++++++++++++--------
> >  target/xtensa/cpu.c        | 22 ++++++++++++++++++----
> >  2 files changed, 35 insertions(+), 12 deletions(-)
> >
> > diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
> > index 8d54ef3ae34b..590f0313ffe9 100644
> > --- a/linux-user/xtensa/signal.c
> > +++ b/linux-user/xtensa/signal.c
> > @@ -134,6 +134,8 @@ void setup_rt_frame(int sig, struct target_sigactio=
n *ka,
> >      abi_ulong frame_addr;
> >      struct target_rt_sigframe *frame;
> >      uint32_t ra;
> > +    bool abi_call0;
> > +    unsigned base;
> >      int i;
> >
> >      frame_addr =3D get_sigframe(ka, env, sizeof(*frame));
> > @@ -182,20 +184,27 @@ void setup_rt_frame(int sig, struct target_sigact=
ion *ka,
> >          __put_user(0x00, &frame->retcode[5]);
> >  #endif
> >      }
> > -    env->sregs[PS] =3D PS_UM | (3 << PS_RING_SHIFT);
> > -    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGI=
STER)) {
> > -        env->sregs[PS] |=3D PS_WOE | (1 << PS_CALLINC_SHIFT);
> > -    }
> >      memset(env->regs, 0, sizeof(env->regs));
> >      env->pc =3D ka->_sa_handler;
> >      env->regs[1] =3D frame_addr;
> >      env->sregs[WINDOW_BASE] =3D 0;
> >      env->sregs[WINDOW_START] =3D 1;
> >
> > -    env->regs[4] =3D (ra & 0x3fffffff) | 0x40000000;
> > -    env->regs[6] =3D sig;
> > -    env->regs[7] =3D frame_addr + offsetof(struct target_rt_sigframe, =
info);
> > -    env->regs[8] =3D frame_addr + offsetof(struct target_rt_sigframe, =
uc);
> > +    abi_call0 =3D (env->sregs[PS] & PS_WOE) =3D=3D 0;
>
> Is this safe to rely on content of sregs[PS]?

It should be: PS is a privileged register, PS.WOE can only
be changed explicitly and windowed registers are not supposed to work
when PS.WOE is cleared.

> Why don't you use xtensa_abi_call0()?

I actually used it in early version of this change, but then
decided that PS.WOE might be a better indicator for the call0 ABI.

> > +    env->sregs[PS] =3D PS_UM | (3 << PS_RING_SHIFT);
> > +
> > +    if (abi_call0) {
> > +        base =3D 0;
> > +        env->regs[base] =3D ra;
> > +    } else {
> > +        env->sregs[PS] |=3D PS_WOE | (1 << PS_CALLINC_SHIFT);
> > +        base =3D 4;
> > +        env->regs[base] =3D (ra & 0x3fffffff) | 0x40000000;
> > +    }
> > +    env->regs[base + 2] =3D sig;
> > +    env->regs[base + 3] =3D frame_addr + offsetof(struct target_rt_sig=
frame,
> > +                                                info);
> > +    env->regs[base + 4] =3D frame_addr + offsetof(struct target_rt_sig=
frame, uc);
> >      unlock_user_struct(frame, frame_addr, 1);
> >      return;
> >
> > diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> > index 76db1741a796..791c061880e7 100644
> > --- a/target/xtensa/cpu.c
> > +++ b/target/xtensa/cpu.c
> > @@ -53,6 +53,18 @@ static bool xtensa_cpu_has_work(CPUState *cs)
> >  #endif
> >  }
> >
> > +#ifdef CONFIG_USER_ONLY
> > +static int xtensa_abi_call0(void)
> > +{
> > +    static int abi_call0 =3D -1;
> > +
> > +    if (abi_call0 =3D=3D -1) {
> > +        abi_call0 =3D getenv("QEMU_XTENSA_ABI_CALL0") !=3D NULL;
>
> Wouldn't it be cleaner to add this in the arg_table[] in
> linux-user/main.c and then use directly the variable?

Probably. Will do so in v2.

--=20
Thanks.
-- Max

