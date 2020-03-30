Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE675C2D0EB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD71120733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeDIdefa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD71120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqG5-0006lt-Pc
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jIqFD-000698-4c
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jIqFB-0005Ad-JH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:58:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jIqFB-00058m-Cq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585558683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LSYTCOXGewJc/puhaBqVX2+f2x6tF1MwQCT8DVUrVg=;
 b=UeDIdefaEhJYctUwoa5ZZE5Il5GEno1mADcflv81TiQ/EXPzV0AMdwin2j9/6IIb7N+xkK
 B85WC+ex4du3O3pZLJyvpphdtfbeCbloJwiFvkC90iaBF2aTuE/abvcsRPT5isajyYMNY3
 JcNEAciMAw9vRMGWSMOvy/ItOktE9lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-sBPuQm_4PTOkK8hmxKDw_g-1; Mon, 30 Mar 2020 04:57:59 -0400
X-MC-Unique: sBPuQm_4PTOkK8hmxKDw_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19A901137840;
 Mon, 30 Mar 2020 08:57:58 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF399953DF;
 Mon, 30 Mar 2020 08:57:54 +0000 (UTC)
Date: Mon, 30 Mar 2020 09:57:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 00/74] per-CPU locks
Message-ID: <20200330085753.GB73285@stefanha-x1.localdomain>
References: <20200327051457.GA2815@t420>
 <8686a3e1-1a57-bfd3-11ec-b84d656bb0a0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8686a3e1-1a57-bfd3-11ec-b84d656bb0a0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Robert Foley <robert.foley@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 11:59:37AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/27/20 6:14 AM, Emilio G. Cota wrote:
> > (Apologies if I missed some Cc's; I was not Cc'ed in patch 0
> >   so I'm blindly crafting a reply.)
> >=20
> > On Thu, Mar 26, 2020 at 15:30:43 -0400, Robert Foley wrote:
> > > This is a continuation of the series created by Emilio Cota.
> > > We are picking up this patch set with the goal to apply
> > > any fixes or updates needed to get this accepted.
> >=20
> > Thanks for picking this up!
> >=20
> > > Listed below are the changes for this version of the patch,
> > > aside from the merge related changes.
> > >=20
> > > Changes for V8:
> > > - Fixed issue where in rr mode we could destroy the BQL twice.
> >=20
> > I remember doing little to no testing in record-replay mode, so
> > there should be more bugs hiding in there :-)
> >=20
> > > - Found/fixed bug that had been hit in testing previously during
> > > the last consideration of this patch.
> > >   We reproduced the issue hit in the qtest: bios-tables-test.
> > >   The issue was introduced by dropping the BQL, and found us
> > >   (very rarely) missing the condition variable wakeup in
> > >   qemu_tcg_rr_cpu_thread_fn().
> >=20
> > Aah, this one:
> >    https://patchwork.kernel.org/patch/10838149/#22516931
> > How did you identify the problem? Was it code inspection or using a too=
l
> > like rr? I remember this being hard to reproduce reliably.
> >=20
> > On a related note, I've done some work to get QEMU-system to work
> > under thread sanitizer, since tsan now supports our longjmp-based
> > coroutines (hurrah!). My idea was to integrate tsan in QEMU (i.e.
> > bring tsan warnings to 0) before (re)trying to merge the
> > per-CPU lock patchset; this would minimize the potential for
> > regressions, which from my personal viewpoint seems like a reasonable
> > thing to do especially now that I have little time to work on QEMU.
> >=20
> > If there's interest in doing the tsan work first, then I'd be
> > happy to send to the list as soon as this weekend the changes that
> > I have so far [1].
>=20
> I'm pretty sure Marc-Andr=E9 is interested (and also Stefan maybe), so Cc=
'ing
> them.

Yes, please!  tsan would be another good tool to have.

Stefan

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6BtJEACgkQnKSrs4Gr
c8g7IggAw9JMjm13/v0o/MTj0fHP5XlcGvgvDsBK469Z3cZ6BkfEJbdLG8Evkg+x
4Re18OoRAB0/ZmrCom9SBhCOFJhPutJGWxy18ktnMCRxx3fl79nvXbgXXTTzWX0+
9GoRblv+u/+21NSGrWyphH/PmuvIunyvXEAnLBsLyiWJsuiXIMYfaHDkkHw76lxG
/HqYjhCIFSBg2QPnrZiWBGHTJiwOJGxjME4GWgf76Zxnjb3bPSo9HRTBhbyjZ9A9
3utx2I9sL3sM001W+JSw4ExSt09doIw4ehKRap7ck7JKlWDxSdQxLfFHKveoyV9b
zl0/lmfAw3eVX2c6hvIcxpAeE3hnUQ==
=q5bA
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--


