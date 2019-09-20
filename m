Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBF9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B7E2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLtQlko9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B7E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFPw-0003db-OQ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBFHu-00035b-75
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBFHt-0001i7-2F
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:33:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBFHs-0001gR-T7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:33:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so1666465wmd.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=u5JD/arwHx7yqdJ2TQdpKJ1SBfUXxtoSL6+sljSqECk=;
 b=ZLtQlko9iCwvTWVrxlJ97McsWBmIfEwXGt4Z9e2ZqcqeJfrbTv5Cn7X0c0XtIXh6mN
 pBAjbzBCEWxonJ+kpKyxWas1srb/5VHULRYvNrq/+rAxw/Mv4YeTL4+kWYYrK2LKOELT
 kSfhMGKxhu+Mw+GLn/XGiwb+gfFfy33nspFfFn+aXCz+Nj8bSBJxYqAXnIa+6usFJq05
 Zln8fV+lQZu5E47N0KI1k9uDq0kicE84d07xLwuOA2/Jr7FNJ5tXPAIaX37DfSdTVTN6
 /sP71XCdMyVqomUq9fgx5VWfWQtW7ZMQYJPNdlaOxG0bTQQfQkP5HscjWh5VJWu9dR9G
 zAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u5JD/arwHx7yqdJ2TQdpKJ1SBfUXxtoSL6+sljSqECk=;
 b=mCtpiQh25ZQAzmAd5i7TgENtLsKIYBo/PcgEjc9lkBUsXpTw+uOV/qzOSIfJ82hw3P
 L4nTo9Mng6GGZwJnXUV1IArAwCvCVxs2INPJKgq4IcTMrHEL7Q2MpIG71Xm31ETLEc6k
 rbcOB//2k0Rw9a/RLYe/2BVN/WdEkEByika0xFUTzouoX1zAWL4KSfSaC0Hd4RA3LUvs
 BlnXLi2X7k5CykUtIm5eig1x4V9E18HT09Uad7aBIhPm66Y+YaXTKdT/bNQDvbOX/lMC
 RUvqXy4RmE+WxK9T5b9f/YmvLSiObRFWPdNlu1vHcFL8QRdS3tAUSwW/ZTiPSBXe+iOL
 jzdA==
X-Gm-Message-State: APjAAAXEf5VMy29amRGAhiTEgqONiTPzq3HN8VoCOY7fNrhAcjrC9CHm
 MV2jiTT52f0xbAnvgL3XzaE=
X-Google-Smtp-Source: APXvYqymOnbamCBI+7D/veujaYxoPrkrEdjFo9RXY90z86QQDlx212LdsD2RazflP4rileCWAZ/FQA==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2855111wml.90.1568971991984; 
 Fri, 20 Sep 2019 02:33:11 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k24sm822953wmi.1.2019.09.20.02.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:33:11 -0700 (PDT)
Date: Fri, 20 Sep 2019 10:33:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [Qemu-devel] [PATCH v3 17/22] fuzz: add support for fork-based
 fuzzing.
Message-ID: <20190920093309.GK14365@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-18-alxndr@bu.edu>
 <20190919125416.GR3606@stefanha-x1.localdomain>
 <e90af06e25d1a98300002c5f6326307e4fd242d9.camel@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
In-Reply-To: <e90af06e25d1a98300002c5f6326307e4fd242d9.camel@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 02:01:53PM +0000, Oleinik, Alexander wrote:
> On Thu, 2019-09-19 at 13:54 +0100, Stefan Hajnoczi wrote:
> > On Wed, Sep 18, 2019 at 11:19:44PM +0000, Oleinik, Alexander wrote:
> > > diff --git a/exec.c b/exec.c
> > > index 235d6bc883..d3838f4ea4 100644
> > > --- a/exec.c
> > > +++ b/exec.c
> > > @@ -2295,7 +2295,9 @@ static void ram_block_add(RAMBlock
> > > *new_block, Error **errp, bool shared)
> > >          qemu_ram_setup_dump(new_block->host, new_block-
> > > >max_length);
> > >          qemu_madvise(new_block->host, new_block->max_length,
> > > QEMU_MADV_HUGEPAGE);
> > >          /* MADV_DONTFORK is also needed by KVM in absence of
> > > synchronous MMU */
> > > +#ifndef CONFIG_FUZZ /* This conflicts with fork-based fuzzing */
> > >          qemu_madvise(new_block->host, new_block->max_length,
> > > QEMU_MADV_DONTFORK);
> > > +#endif
> > >          ram_block_notify_add(new_block->host, new_block-
> > > >max_length);
> > >      }
> > >  }
> >=20
> > I didn't check Makefile changes but regular softmmu binaries should
> > continue to work with --enable-fuzzing so we cannot use #ifdef here.
> > Perhaps this should be a runtime check similar to qtest_enabled()
>=20
> Yes - I'll add a runtime check. The makefile requires a make clean
> between softmmu and fuzzer builds, since the ".o"s for the fuzzer build
> are compiled with fsanitize=3Dfuzzer(must be linked against libfuzzer).=
=20
> I can see that the #ifndef CONFIG_FUZZ is a proper softmmu builds with
> --enable-fuzzer are currently broken due to the ifndef CONFIG_FUZZ
> check.

In that case the fuzzer is a whole different make target and shouldn't
share .o files with *-softmmu/ build directories.

Stefan

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2EnNUACgkQnKSrs4Gr
c8hdYAgAhIvIdVQBR96/gCEGESWRBys4KJtU/Nte4t8ivUVbJMjcDTrchqpxHju8
m3f/QOq3eDN0e+iUMKae/etpkjIHQUzAazwdvioOXY+D+JbxjZKsJwrUtDJd/OCW
g457T5uuYin1kEj1qTvf91J0zd27+PiTw9zbqhDGkAL3LPfqpml4SSwNYaLsFM8E
9p2EDcHdUkTvTMyVKJEUAZcAJhmSc4MdHxJuzhZA0hiAkeCZXf0xHIKbypG3M0gd
araMmL8cOFUf90q55jmUhbC2oZb4lmdJZcYvFL1G3k7CL3yE8TtB5hXKbYvSgQjE
fyDAd6oPC3ry2YycIQWcEAsBajYJKA==
=X0fH
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--

