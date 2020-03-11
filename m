Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47320C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC0E206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzD/4ngB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC0E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4mQ-00057U-7F
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC4l9-0003wt-E3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC4l8-0007XS-BJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:03:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC4l7-0007WD-P8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583946184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OjjBO6BUsmumRHc0czjCVCD2ryd4RETwVmiYJM/4GAk=;
 b=bzD/4ngBt7pAWWpZGRuUwlO71XUYWLQqAYxw01TDIEWTCsiIAOe6PSz+XayllA/C0Y7BWQ
 kJMnanjp79V4TA1dSMoqRy2uNIL11m1jcDJOoJ9dmk0VqOnnnTpaxA1VvKY/z88M+W3oZy
 86xeVFLIUHvWdrUqQlp+6vy0+BRqS8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-hFRbYC9KPCG60_vUez9bJw-1; Wed, 11 Mar 2020 13:03:01 -0400
X-MC-Unique: hFRbYC9KPCG60_vUez9bJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2848017CC;
 Wed, 11 Mar 2020 17:03:00 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA5E5D9E5;
 Wed, 11 Mar 2020 17:02:59 +0000 (UTC)
Date: Wed, 11 Mar 2020 17:02:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] thread: add lock guard macros
Message-ID: <20200311170258.GC281087@stefanha-x1.localdomain>
References: <20200311123624.277221-1-stefanha@redhat.com>
 <87d09jx7wm.fsf@dusky.pond.sub.org>
 <CABgObfaYwZmokcQHF7Hdr-1v4r1jT4cxF0WiHw_Fob-A1AOXkQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfaYwZmokcQHF7Hdr-1v4r1jT4cxF0WiHw_Fob-A1AOXkQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 04:06:02PM +0100, Paolo Bonzini wrote:
> Il mer 11 mar 2020, 15:50 Markus Armbruster <armbru@redhat.com> ha scritt=
o:
>=20
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >
> > > Lock guards automatically call qemu_(rec_)mutex_unlock() when returni=
ng
> > from a
> > > function or leaving leaving a lexical scope.  This simplifies code an=
d
> > > eliminates leaks (especially in error code paths).
> > >
> > > This series adds lock guards for QemuMutex and QemuRecMutex.  It does=
 not
> > > convert the entire tree but includes example conversions.
> >
> > I support the move towards automatic cleanup, but I'm wary of
> > incremental conversion.  Experience tells that outdated examples
> > invariably get copied / imitated, with incremental conversion strugglin=
g
> > to keep up.
> >
> > Are we resigned to having both kinds of mutex cleanup forever?
> >
>=20
> There are cases where the legibility benefits of guards are debatable, or
> they require more complex functionality in the guards (see my other answe=
r
> to Stefan). So, yes. We don't have that many mutexes so incremental
> conversion should be doable without taking forever.

I will add this to the BiteSizedTasks wiki page when the patch is
merged, together with guidelines on how to convert code (it requires
case-by-case evaluation and is not a simple mechanical change).

We will continue to have raw qemu_(rec_)mutex_lock/unlock() calls in
cases where a complex locking scheme is used or lock guards would make
the code less clear.

Stefan

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pGcIACgkQnKSrs4Gr
c8gNDAgAuc3a4GIivuiBj/tJfqeN6jQ8/EmsQhKaATXqAR32vkPPDzPZWnM1f0tH
Sa5JSJaOcKY9yuGLinpwIAkrqJsY9iso92QpwnU2QH6AcG6yLg1dtx2iQCIAlzAg
WVQt8m/PISVcokqQNdul7hEYi2YebY4rrdbd5Q7gkC5Oiq09g7FPXYlZRpBQjTjT
pkhUZ2v2FZs6nRLr7DQWArC3Kg2vSxofKHYayXVanlmlgzNuGYSzJl9zRS1M6KtM
C0RT2sCs3wa6nLnwrItoCIO9DBAEYTG0dk3vI1PaqOV3hHKa9uTAR9/C1j+gKTLT
mw1VbSKg4QXlD+N1bmAdBqMwjFa70g==
=qg3m
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--


