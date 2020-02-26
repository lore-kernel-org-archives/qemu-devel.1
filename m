Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C78C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B025121D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfyGLRA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B025121D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xx9-00038I-Uz
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6xwR-0002YZ-6A
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6xwN-0004kr-4y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:45:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6xwN-0004hw-1d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582728334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlVXF2tk1qgD8ay0foIDoyXWCm75nANb9zMd0kEiJDc=;
 b=cfyGLRA2hcU/peZmgfmvn8jMd/txnj7gMCroM3Kv+0M2ikxVg+KmRrQ6tMEWuzUAZpH11n
 FMQ8dWAwGnqOr30aqsiQVW5gmd6/xjysDeRTkjYlcMWn3k3QOy6oNZLG7XaqHJ3xMRliry
 i14W1ceg01KUsuM5u1B+MvyLEMnhgD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-sXoOkyq4M4OKUo4ufgTqQg-1; Wed, 26 Feb 2020 09:45:30 -0500
X-MC-Unique: sXoOkyq4M4OKUo4ufgTqQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EA0418A5517;
 Wed, 26 Feb 2020 14:45:29 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 451D18C086;
 Wed, 26 Feb 2020 14:45:27 +0000 (UTC)
Date: Wed, 26 Feb 2020 15:45:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: Sudden slowdown of ARM emulation in master
Message-ID: <20200226154525.5c4c0ac9@redhat.com>
In-Reply-To: <87k149xwqw.fsf@linaro.org>
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <20200226101948.786be4b0@redhat.com>
 <CAFEAcA80K+h-nkiHrh15mmgomBaqDpdhRwb34zwKqF31dp3KDw@mail.gmail.com>
 <87k149xwqw.fsf@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 14:13:11 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Wed, 26 Feb 2020 at 09:19, Igor Mammedov <imammedo@redhat.com> wrote=
: =20
> >>
> >> On Wed, 26 Feb 2020 00:07:55 +0100
> >> Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> >> =20
> >> > Hello Igor and Paolo, =20
> >>
> >> does following hack solves issue?
> >>
> >> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> >> index a08ab11f65..ab2448c5aa 100644
> >> --- a/accel/tcg/translate-all.c
> >> +++ b/accel/tcg/translate-all.c
> >> @@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t t=
b_size)
> >>          /* ??? If we relax the requirement that CONFIG_USER_ONLY use =
the
> >>             static buffer, we could size this on RESERVED_VA, on the t=
ext
> >>             segment size of the executable, or continue to use the def=
ault.  */
> >> -        tb_size =3D (unsigned long)(ram_size / 4);
> >> +        tb_size =3D MAX_CODE_GEN_BUFFER_SIZE;
> >>  #endif
> >>      }
> >>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) { =20
> >
> > Cc'ing Richard to ask: does it still make sense for TCG
> > to pick a codegen buffer size based on the guest RAM size? =20
>=20
> Arguably you would never get more than ram_size * tcg gen overhead of
> active TBs at any one point although you can come up with pathological
> patterns where only a subset of pages are flushed in and out at a time.
>=20
> However the backing for the code is mmap'ed anyway so surely the kernel
> can work out the kinks here. We will never allocate more than the code
> generator can generate jumps for anyway.
>=20
> Looking at the SoftMMU version of alloc_code_gen_buffer it looks like
> everything now falls under the:
>=20
>   # if defined(__PIE__) || defined(__PIC__)
>=20
> leg so there is a bunch of code to be deleted there. The remaining
> question is what to do for linux-user because there is a bit more logic
> to deal with some corner cases on the static code generation buffer.
>=20
> I'd be tempted to rename DEFAULT_CODE_GEN_BUFFER_SIZE to
> SMALL_CODE_GEN_BUFFER_SIZE and only bother with a static allocation for
> 32 bit linux-user hosts. Otherwise why not default to
> MAX_CODE_GEN_BUFFER_SIZE on 64 bit systems and let the kernel deal with
> it?

*-user call
  tcg_exec_init(0);
which in in the end results in
  DEFAULT_CODE_GEN_BUFFER_SIZE -> DEFAULT_CODE_GEN_BUFFER_SIZE_1

so for *-user cases we can just always call
   code_gen_alloc(DEFAULT_CODE_GEN_BUFFER_SIZE)

> > (We should fix the regression anyway, but it surprised me
> > slightly to find a config detail of the guest machine being
> > used here.)
> >
> > thanks
> > -- PMM =20
>=20
>=20


