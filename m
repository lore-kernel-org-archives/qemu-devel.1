Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21017C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21AB214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdqaD53X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21AB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j09qK-0004T4-4J
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j09pS-0003iy-EH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j09pQ-0002BW-90
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:02:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j09pQ-0002Al-4W
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581105735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uZ+D7dY/GX8By8JwO5Y4vlgMcNOxCZWNppvMVYCIgA=;
 b=YdqaD53XR420mDz9+Un/Am0pjBwgEqiqJkFV/hw2deghAkpjrq0oLJCG2PhL0BhxALHBux
 INkG9cNS3hLzZJFud5takX3gv6ORC6NcwXFDxs3UnBKLluPGWXa2yxi2kA203g8MMbQ1iD
 XaUwGKOpeRkcIUv32mUBBy8TJEMsKh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-2r-LoSmZO3WodoN-z_ZbOg-1; Fri, 07 Feb 2020 15:02:00 -0500
X-MC-Unique: 2r-LoSmZO3WodoN-z_ZbOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E14C10054E3;
 Fri,  7 Feb 2020 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-208.rdu2.redhat.com
 [10.10.123.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C59526558;
 Fri,  7 Feb 2020 20:01:58 +0000 (UTC)
Date: Fri, 7 Feb 2020 15:01:56 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 1/2] GitLab CI: avoid calling before_scripts on
 unintended jobs
Message-ID: <20200207200156.GE13258@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <c1e15e42-a155-6aea-35fc-72bcde0229bd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c1e15e42-a155-6aea-35fc-72bcde0229bd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 05:08:58PM +0100, Thomas Huth wrote:
> On 03/02/2020 04.23, Cleber Rosa wrote:
> > At this point it seems that all jobs depend on those steps, with
> > maybe the EDK2 jobs as exceptions.
> >=20
> > The jobs that will be added will not want those scripts to be
> > run, so let's move these steps to the appropriate jobs, while
> > still trying to avoid repetition.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  .gitlab-ci.yml | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 228783993e..d2c7d2198e 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -1,11 +1,10 @@
> >  include:
> >    - local: '/.gitlab-ci-edk2.yml'
> > =20
> > -before_script:
> > +build-system1:
> > + before_script: &before_scr_apt
> >   - apt-get update -qq
> >   - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev ge=
nisoimage
> > -
> > -build-system1:
> >   script:
> >   - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard=
-dev
> >        libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libv=
deplug-dev
>=20
> I'm not very familiar with these anchors yet, but would it maybe be
> possible to keep the "template" out of build-system1 ? Something like
> they show on https://docs.gitlab.com/ee/ci/yaml/#anchors ?
>

Me neither!  In fact, thanks for the link above (I simply replayed
something I did on another YAML file and validated it on the GitLab CI
linter).

> Anyway, patch is also fine for me in its current shape, so FWIW:
>=20
> Acked-by: Thomas Huth <thuth@redhat.com>

I'll check out the other possible approaches and let you know.

Thanks,
- Cleber.

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl49wjQACgkQZX6NM6Xy
CfNjRxAAzYvh2MGaxCDl90ShANho7Bl55YgvabZ70OSZCr4wPOU4NVExRiqOBGgl
8o4X3CPuqr0bDYqoTDYlA3pyq59ugNbapfaO/fkR4Fo1W3zjv3G9G61pnyWeu07V
w/tl5+ZRQ/tVIiewq2U9A9IGpAyAQmK+5hOUBTl29M5RlUI5Wg67JOcYq/YMwZdC
AU0us54mHcnFFG76Lcqb0Z8c5ZFyY41NhB9ach+ReSUwx+6CaZyGcWcXbfXjfoL6
YdjmzOREHJW/J1AV7wDLY3OjOvRbivCvCOPF9c9QSAYpBg5KVroBqTfwZ40X187o
f8RQAqLpZQJPOwejSVbmDQV+TnyqW0QGwoOVMFHSjBlxuufX8K9h6Uy6mMPEln0l
YAnDEy2AoxQaUqIDfxlxZ3enLIZDiYwHBppwE2sNTIAkrcg1yu2Wv0CvQ2/++Xj2
2wvBxX69H9k9KaFZEUoFpPLkG0ZdlIhXumvYq+seybrWbVNFD7d0gJSYmrXufQ/N
71m90wHSGBi3XaurTn71XxP0ipO3NAk4xgZluUnY1xibMewL2BtqIGYPz+P5UBic
+KOAG2LTkmTDAya3q20Won8IUmdT+VyR/a9DnDehIsXdnh2DxZO8Mspa++uoL1QW
e5Z5llUqUoEC+Io9VuoDfWZ/IcIn5EwWVfocjAUxtUW2UYvvjIM=
=utRJ
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--


