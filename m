Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEC4C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CCD20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQNyYgrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CCD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8vn-0002n3-OQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jE8tp-0000os-4X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jE8tn-00050s-NP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:52:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49283)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jE8tn-0004w9-Fa
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baYbiTLUvmpMgbL/liGbx2WCu2YlHG5y6MudhjCcp58=;
 b=jQNyYgrcpzcsKHJgmegEwn/clojJkYaBjy4HzLnaC5E05JXAX1J8kWUcykf+PZMY+o/+Rs
 3CmUajAgm18Hsi1ZS6ETzweYf1oWEmzy29RGpYlHO5ysz88cgz5B23b00UzPqR1YKBKKsf
 MffFQlnhjuQmTFIgN62hMy1IKov8e2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-3uUmv9exMMqKCWSiNav8_A-1; Tue, 17 Mar 2020 05:52:31 -0400
X-MC-Unique: 3uUmv9exMMqKCWSiNav8_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA6E800D4E;
 Tue, 17 Mar 2020 09:52:30 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6E7C10027A3;
 Tue, 17 Mar 2020 09:52:23 +0000 (UTC)
Date: Tue, 17 Mar 2020 09:52:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
Message-ID: <20200317095222.GB492272@stefanha-x1.localdomain>
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
 <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
 <62dbe165-8311-71f0-fcf6-d020d7e93fd8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <62dbe165-8311-71f0-fcf6-d020d7e93fd8@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 01:15:35PM -0500, Eric Blake wrote:
> On 3/16/20 1:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 3/16/20 5:07 PM, Stefan Hajnoczi wrote:
> > > gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
> > > reports the following error:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migration/g=
lobal_state.o
> > > =C2=A0=C2=A0 In file included from /usr/include/string.h:495,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from /home/stefanha/qemu/incl=
ude/qemu/osdep.h:101,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from migration/global_state.c=
:13:
> > > =C2=A0=C2=A0 In function =E2=80=98strncpy=E2=80=99,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inlined from =E2=80=98global_sta=
te_store_running=E2=80=99 at
> > > migration/global_state.c:47:5:
> > > =C2=A0=C2=A0 /usr/include/bits/string_fortified.h:106:10: error:
> > > =E2=80=98__builtin_strncpy=E2=80=99 specified bound 100 equals destin=
ation size
> > > [-Werror=3Dstringop-truncation]
> > > =C2=A0=C2=A0=C2=A0=C2=A0 106 |=C2=A0=C2=A0 return __builtin___strncpy=
_chk (__dest, __src, __len,
> > > __bos (__dest));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >=20
> > > Use pstrcpy() instead of strncpy().=C2=A0 It is guaranteed to NUL-ter=
minate
> > > strings.
> >=20
> > There was a long discussion 1 year ago with it, and Eric suggested to
> > use strpadcpy after the assert() and I sent this patch:
> > https://www.mail-archive.com/qemu-block@nongnu.org/msg44925.html
> > Not sure what's best.
>=20
> strncpy() pads the tail, guaranteeing that for our fixed-size buffer, we
> guarantee the contents of all bytes in the buffer.  pstrcpy() does not (b=
ut
> pstrcpy() can be followed up with a memset() to emulate the remaining
> effects of strncpy() - at which point you have reimplemented strpadcpy).
>=20
> >=20
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > =C2=A0 migration/global_state.c | 4 ++--
> > > =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/migration/global_state.c b/migration/global_state.c
> > > index 25311479a4..cbe07f21a8 100644
> > > --- a/migration/global_state.c
> > > +++ b/migration/global_state.c
> > > @@ -44,8 +44,8 @@ void global_state_store_running(void)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *state =3D RunState_str(RUN=
_STATE_RUNNING);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(strlen(state) < sizeof(global_s=
tate.runstate));
> > > -=C2=A0=C2=A0=C2=A0 strncpy((char *)global_state.runstate,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state, =
sizeof(global_state.runstate));
> > > +=C2=A0=C2=A0=C2=A0 pstrcpy((char *)global_state.runstate,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
izeof(global_state.runstate), state);
>=20
> Can we guarantee that the padding bytes have been previously set to 0, or=
 do
> we need to go the extra mile with a memset() or strpadcpy() to guarantee
> that we have set the entire buffer?

I don't understand GlobalState:

1. You ask if runstate[] must be padded with NULs but neither
   global_state_store() nor register_global_state() do that.  Is it
   really necessary to pad runstate[]?

   If yes, is it safe for global_state_store() and
   register_global_state() to not pad runstate[]?

   If we decide the pad runstate[] to prevent information leaks to the
   migration destination then I think it should be done in the pre-save
   function so that it's guaranteed to happen no matter which of the 3
   functions that write runstate[] has been called.

2. There is a GlobalState::size field that is only written and then
   migrated but never read from what I can tell.  :?

Juan: Please clarify the above.  Thanks!

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5wndYACgkQnKSrs4Gr
c8jLdwf/aWQ5rpgOO/USLT/LHlzT3T6PgWdOqrSghDn/Vxoz6nPiEX4lPeuXdpIr
Yc7r+xHREYicoxFniUhf7eL8x5DfK226wN0ZZoGDb5q8UasauqpZbdyn5emXl5zt
ttaZZFkQ97jrifPlpTbfPCN90TNskkZxGOWmz7YB3mA3AfzToX4DyGG93gMx736P
nwu2ILp6sSXH33OUzVDSWv7iLO0w21CZzoO1LqzuK0Hp3u8Ai7/yQ2Pcin7Gh14/
utEZcXVKvCdd+ruaCthQTnIKDxZP3nzrqM9OFJJCQ4jxjAQ3K9Cl+xMlKEtsi0p0
tTFLDx3z+QKMLptUug/jZcKr/TzCUg==
=aql1
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--


