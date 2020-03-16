Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E43C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDF520663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYRRn6Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDF520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrjj-0007PZ-1q
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vfazio@gmail.com>) id 1jDddQ-0006OP-5R
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vfazio@gmail.com>) id 1jDddN-0007jD-6X
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:29:34 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vfazio@gmail.com>)
 id 1jDddM-0007XN-VH; Sun, 15 Mar 2020 20:29:33 -0400
Received: by mail-ed1-x543.google.com with SMTP id b21so9584702edy.9;
 Sun, 15 Mar 2020 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4ZbYphjZfXVF1533ZbXdDhT49U8OBqjrcyxFroiuUP4=;
 b=MYRRn6TbDSpZ1NQgqZeIqblEChgzIYRKCUxccmTv/nua4iXs8IkzCCHKqpP7mF7lIE
 94i0DCZlazCc7IoT7SvnxKacxVGIeBk8FALHZ8mgl/kV6UfLC9e2dMxqhUzP3GSuy+MQ
 J+wypkMXvrbM/jjUPJQk52NFXuZIaeV/je0y3WjmnglVM61t1rapsViyMauWdoIkg6Sh
 5wRU0Dkeew19kwycLZT6qX/LKbYnkE8qDWxxHl/BbjNwOuCpzJlLy/wfb3cx1ffbV49+
 oFIuOastKI9R/iOPGQ5BmtMHAZwkOuTBmtjsu5t7NgMr2IVeEhADqBpy7eMjcmv+0fuC
 c47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4ZbYphjZfXVF1533ZbXdDhT49U8OBqjrcyxFroiuUP4=;
 b=Pt7fi6pAMnigXEewxmfRDfH6iejIuhVVfCW+AKi0M9qqsBmtGFcUJFqCVjdyn3DOI8
 0mEh6jxcvqLo7aAyivNw3fCH6zGtLX4DWgBd3j8jkeRg8dg5dRkk3YK2dxfPRPF0BCVm
 2R3kP9y/G6/5h0Nv0uJzirdlvA58S38gPc+/uJENISxw5hm53LjOCLgsiXrhPTtdEve4
 +SyN6RzSAhecOtzuGJIHKXuhlzdlo5882aBQ9fClqgMQUOxy0XkWtcuqHtYt+Su8iT+o
 SzjIgi16BnR6ClwL6sk0z0e8CNbYUv/wDaz4HrqRq2IuFhu8vab6kB5Z9fAcg9cCX1/q
 h7Ag==
X-Gm-Message-State: ANhLgQ1ePUPxY6/vPWcuAVJgZ9toGMuEDg8KsRR/H/XIb8iQaIgHO4C7
 SrhXqDkfwz7ntsys82mH5iE1IBfbUDw+ZssPWVw=
X-Google-Smtp-Source: ADFU+vs8YnXrfDGn7kN+b0+iaJozhJhjQyFw0z6nurbBjwbK/ZmtXkZVqdpiqttluhy2cXSTOcxEPXOFX15/fdn688I=
X-Received: by 2002:a05:6402:b8c:: with SMTP id
 cf12mr14741807edb.322.1584318567485; 
 Sun, 15 Mar 2020 17:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200315155202.13107-1-vfazio@xes-inc.com>
 <346e47c8-4a80-860c-ec55-e38d2021d63d@vivier.eu>
In-Reply-To: <346e47c8-4a80-860c-ec55-e38d2021d63d@vivier.eu>
From: Vincent Fazio <vfazio@gmail.com>
Date: Sun, 15 Mar 2020 19:29:04 -0500
Message-ID: <CAOrEah5Fq7Kp9wF_4Vtb4Qfcdm0gtwin_5b_ft7h7my+RnTOWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/ppc: fix ELFv2 signal handler endianness
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
X-Mailman-Approved-At: Mon, 16 Mar 2020 10:26:18 -0400
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
Cc: Vincent Fazio <vfazio@xes-inc.com>, qemu-trivial@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent,

On Sun, Mar 15, 2020 at 1:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 15/03/2020 =C3=A0 16:52, Vincent Fazio a =C3=A9crit :
> > From: Vincent Fazio <vfazio@gmail.com>
> >
> > In ELFv2, function pointers are entry points and are in host endianness=
.
>
> "host endianness" is misleading here. "target endianness" is better.

I do want to clarify here. In a mixed endian scenario (my test case
was an x86 host and e5500 PPC BE target), the function pointers are in
host endianness (little endian) so that the virtual address can be
dereferenced by the host for the target instructions to be translated.

>
> >
> > Previously, the signal handler would be swapped if the target CPU was a
> > different endianness than the host. This would cause a SIGSEGV when
> > attempting to translate the opcode pointed to by the swapped address.
>
> This is correct.
>
> >  Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fault.
> >  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/incl=
ude/qemu/bswap.h:351
> >  351        __builtin_memcpy(&r, ptr, sizeof(r));
> >
> >  #0  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/=
include/qemu/bswap.h:351
> >  #1  0x00000000600a92fe in ldl_be_p (ptr=3D0x4c2c061000000000) at qemu/=
include/qemu/bswap.h:449
> >  #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/exec/tra=
nslator.h:201
> >  #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/ppc/tra=
nslate.c:7856
> >  #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/translator=
.c:102
> >
> > Now, no swap is performed and execution continues properly.
> >
> > Signed-off-by: Vincent Fazio <vfazio@gmail.com>
> > ---
> >  linux-user/ppc/signal.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> > index 5b82af6cb6..c7f6455170 100644
> > --- a/linux-user/ppc/signal.c
> > +++ b/linux-user/ppc/signal.c
> > @@ -567,9 +567,13 @@ void setup_rt_frame(int sig, struct target_sigacti=
on *ka,
> >          env->nip =3D tswapl(handler->entry);
> >          env->gpr[2] =3D tswapl(handler->toc);
> >      } else {
> > -        /* ELFv2 PPC64 function pointers are entry points, but R12
> > -         * must also be set */
> > -        env->nip =3D tswapl((target_ulong) ka->_sa_handler);
> > +        /*
> > +         * ELFv2 PPC64 function pointers are entry points and are in h=
ost
> > +         * endianness so should not to be swapped.
>
> "target endianness"
>
> > +         *
> > +         * Note: R12 must also be set.
> > +         */
> > +        env->nip =3D (target_ulong) ka->_sa_handler;
>
> The cast is not needed: nip and _sa_handler are abi_ulong.

I'll drop this in v2

>
> >          env->gpr[12] =3D env->nip;
> >      }
> >  #else
> >
>
> If you repost with the fix I've reported above you can add my:
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>

I'll hold off on reposting until the endianness wording is figured out.

> Thanks,
> Laurent

Thanks,
-Vincent

