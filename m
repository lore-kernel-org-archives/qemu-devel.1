Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3AFC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9BD20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv3qL77z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9BD20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2nd-00008a-3d
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hg2lV-0007hr-7o
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hg2lT-0001mT-TN
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:54:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hg2lT-0001k1-N2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:54:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id i8so1579798oth.10
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=LO9aJ/Ajxg5iceuxEQu40tKjmcJ4pleWTZmwrq0BNvY=;
 b=jv3qL77zffahNtYXLI87wOR2bzJIl10yN4zgnEApaB73EbbbSW0zplG1gqGT1+Oarb
 WV36uJm0xnGWQOwZyEGP6lCON1fGyVWAOpYGcHOW+zhcYmqR/p5GzF9KQ4HJ8dnvEqtv
 EPaQ2IdFRntkuGFAqF3jJr7vde4DgmWH20fJj7GIoBaOW3l4la0wFVUlQ6wjW1euIkpv
 eJ4h/crRl13+Mg4+iwkWPHpZbSoESLjKI0CxNrFRJ5j2u3fEY/uyMiOg11PYyjF+JJ3g
 fwsdx4cSBnBIHJ41mCKGuE2avUjWtopECFTnS34XhUJKJAFe1LBPi4pOkTq8x69xwZU2
 z0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=LO9aJ/Ajxg5iceuxEQu40tKjmcJ4pleWTZmwrq0BNvY=;
 b=Ke1GVLXOkRV8u7MIZdpB4NXO0e0DkWkxylFa0joIpjTaxy1KdRwKao0EQJFj/3+DQo
 cbFbIUilS/RQyFvtk13inY4DFluCycUwVp0oN4oCZlYjHPVTwhMJ4r0c6bzbTQQplrT1
 braKZDovOdw+G++i8FOoL9XjfJikTT3n8bvt2tHbgc7FkVfcIOtGRV+g8LcuvawP6x8T
 GEWpg57F4PEOw9mBLlrVgkMv4Jod4TBFMNFNGKu+8Ju3M5t9xk8g+GdSpp/feIS3qkfS
 vTrtZ3nX9p6oYCRvR1+v15pbmTcOueZ2/l2eIV+d+7oM34Ey1fYERWNBc/bc8QlNaPYW
 gTrw==
X-Gm-Message-State: APjAAAVdmanm6yzfqWrjWYtguN8tpNITg/g7l5IZ6SMFg2LLUW9e8DUu
 hYgfnF+AC+vKaKk/4oq5whmsg0H74IRzQENRAo32mA==
X-Google-Smtp-Source: APXvYqzMOTcQbx7hJpndG+Q8YPKDQleh2IDe0FrL+XUpiOcl0L6IYppxWUH9RHkGlTFil4NcupAJ1SnZRoJdkmVDdVM=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr2328770otr.295.1561535686042; 
 Wed, 26 Jun 2019 00:54:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 26 Jun 2019 00:54:45
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 26 Jun 2019 00:54:45
 -0700 (PDT)
In-Reply-To: <a45cb51c-68f0-f52e-17d0-a8926852c74c@vivier.eu>
References: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1560953834-29584-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <a45cb51c-68f0-f52e-17d0-a8926852c74c@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Jun 2019 09:54:45 +0200
Message-ID: <CAL1e-=iVBGniLxy28jbrLjz4uULBGdG6OaaoXHoZQd32B2zqGQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v12 5/5] linux-user: Fix flock structure
 for MIPS O64 ABI
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 19, 2019 6:34 PM, "Laurent Vivier" <laurent@vivier.eu> wrote:
>
> Le 19/06/2019 =C3=A0 16:17, Aleksandar Markovic a =C3=A9crit :
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Only MIPS O32 and N32 have special (different than other
> > architectures) definition of structure flock in kernel.
> >
> > Bring flock definition for MIPS O64 ABI to the correct state.
> >
> > Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  linux-user/generic/fcntl.h     | 2 +-
> >  linux-user/mips/target_fcntl.h | 4 ++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
> > index a775a49..1b48dde 100644
> > --- a/linux-user/generic/fcntl.h
> > +++ b/linux-user/generic/fcntl.h
> > @@ -129,7 +129,7 @@ struct target_flock {
> >      short l_whence;
> >      abi_long l_start;
> >      abi_long l_len;
> > -#if defined(TARGET_MIPS)
> > +#if defined(TARGET_MIPS) && (TARGET_ABI_BITS =3D=3D 32)
> >      abi_long l_sysid;
> >  #endif
> >      int l_pid;
> > diff --git a/linux-user/mips/target_fcntl.h
b/linux-user/mips/target_fcntl.h
> > index 000527c..795bba7 100644
> > --- a/linux-user/mips/target_fcntl.h
> > +++ b/linux-user/mips/target_fcntl.h
> > @@ -27,7 +27,11 @@
> >  #define TARGET_F_SETOWN        24       /*  for sockets. */
> >  #define TARGET_F_GETOWN        23       /*  for sockets. */
> >
> > +#if (TARGET_ABI_BITS =3D=3D 32)
> >  #define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
> > +#else
> > +#define TARGET_ARCH_FLOCK_PAD
> > +#endif
> >  #define TARGET_ARCH_FLOCK64_PAD
> >
> >  #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
> >
>
> The patch is correct, but I think it would be cleaner to introduce an
> "TARGET_HAVE_ARCH_STRUCT_FLOCK" as we have in the kernel for the mips
case.
>
> Thanks,
> Laurent
>

Do you mean we should do everything in a single patch, or do you ask me to
devise a separate restructuring/cleanup patch here?

Aleksandar
