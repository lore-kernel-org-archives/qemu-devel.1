Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA15C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE522051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwfmdBpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE522051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jED34-0003Dz-QK
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jED0C-0007pp-3k
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jED0A-0003Dr-O5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:15:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jED0A-00038E-Ic
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584454525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1VcOwvrJWGs7mnvIBl8y7D8WspTsa8UI7TF/EKHtbEU=;
 b=PwfmdBpGP62TA4hPVKYF2pubfNnA0Oi7Pg1wa+O4CvOsRLjcm1UU3FWfKwZSsEi399LWUQ
 mmUn1k6ahzWIhIKNT9sIE2X7s1u944yd3srWccAs5FG+5mZEKXzR3PKy7kBYWAD0Z1oDaK
 w+Q/DFqBcbl4yZmNLxQZz8QikLfKJlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-t5T3ULv3O6qwk9JKwBfV_w-1; Tue, 17 Mar 2020 10:15:23 -0400
X-MC-Unique: t5T3ULv3O6qwk9JKwBfV_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31483800D53;
 Tue, 17 Mar 2020 14:15:22 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C28AA9352B;
 Tue, 17 Mar 2020 14:15:14 +0000 (UTC)
Date: Tue, 17 Mar 2020 14:15:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/2] migration: avoid suspicious strncpy() use
Message-ID: <20200317141513.GA517094@stefanha-x1.localdomain>
References: <20200316160702.478964-1-stefanha@redhat.com>
 <20200316160702.478964-2-stefanha@redhat.com>
 <24d36e90-5880-02ad-fa24-761eb3d9074f@redhat.com>
 <62dbe165-8311-71f0-fcf6-d020d7e93fd8@redhat.com>
 <20200317095222.GB492272@stefanha-x1.localdomain>
 <87k13jl15p.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <87k13jl15p.fsf@secure.laptop>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 11:35:14AM +0100, Juan Quintela wrote:
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Mon, Mar 16, 2020 at 01:15:35PM -0500, Eric Blake wrote:
> >> On 3/16/20 1:09 PM, Philippe Mathieu-Daud=E9 wrote:
> >> > On 3/16/20 5:07 PM, Stefan Hajnoczi wrote:
> >>=20
> >> >=20
> >> > >=20
> >> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > > ---
> >> > > =A0 migration/global_state.c | 4 ++--
> >> > > =A0 1 file changed, 2 insertions(+), 2 deletions(-)
> >> > >=20
> >> > > diff --git a/migration/global_state.c b/migration/global_state.c
> >> > > index 25311479a4..cbe07f21a8 100644
> >> > > --- a/migration/global_state.c
> >> > > +++ b/migration/global_state.c
> >> > > @@ -44,8 +44,8 @@ void global_state_store_running(void)
> >> > > =A0 {
> >> > > =A0=A0=A0=A0=A0 const char *state =3D RunState_str(RUN_STATE_RUNNI=
NG);
> >> > > =A0=A0=A0=A0=A0 assert(strlen(state) < sizeof(global_state.runstat=
e));
> >> > > -=A0=A0=A0 strncpy((char *)global_state.runstate,
> >> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state, sizeof(global_state.runstat=
e));
> >> > > +=A0=A0=A0 pstrcpy((char *)global_state.runstate,
> >> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(global_state.runstate), =
state);
> >>=20
> >> Can we guarantee that the padding bytes have been previously set to 0,=
 or do
> >> we need to go the extra mile with a memset() or strpadcpy() to guarant=
ee
> >> that we have set the entire buffer?
> >
> > I don't understand GlobalState:
>=20
> Welcome to the club O:-)
>=20
> And I thought that with the reviewed-by I had finished here O:-)
>=20
> > 1. You ask if runstate[] must be padded with NULs but neither
> >    global_state_store() nor register_global_state() do that.  Is it
> >    really necessary to pad runstate[]?
> >
> >    If yes, is it safe for global_state_store() and
> >    register_global_state() to not pad runstate[]?
>=20
> it is an error.  All should be padded.
>=20
> >    If we decide the pad runstate[] to prevent information leaks to the
> >    migration destination then I think it should be done in the pre-save
> >    function so that it's guaranteed to happen no matter which of the 3
> >    functions that write runstate[] has been called.
>=20
> Ok.
> Taking a look at this.
>=20
> > 2. There is a GlobalState::size field that is only written and then
> >    migrated but never read from what I can tell.  :?
>=20
> Grrr.  It should be used, but it is not :-(
>=20
> What we have here:
> - A static buffer
>=20
>     uint8_t runstate[100];
>=20
> That is partially filled.
> size: is the size of that buffer that is filled.
>=20
> But, as we are using
>=20
>         VMSTATE_BUFFER(runstate, GlobalState),
>=20
> We are always sending/receiving the whole buffer.  THat is why we have
> trouble with padding.  What should we being doing?
>=20
> Sending just the size, the filled bytes, and making sure that there is
> enough space on destination.
>=20
> But we aren't donig that.  And at this point, I think that I am only
> going to fix the 1st part (always zero pad everything sent).
>=20
> For fixing the other bit, I need to do an incompatible change.
>=20
> > Juan: Please clarify the above.  Thanks!
>=20
> Thanks a lot.
>=20
> Later, Juan.
>=20
> PD: Why is it done this way?
>     Because at the moment, the problem was that qcow2 (as a system, not
>     as a device) didn't have a place where to plug pending requests.  So
>     I created this section that always exist, and anything that has not
>     a device associated can hang a subsection here.  Once that I created
>     it, nobody used it.
>     And now, just seing what you are telling, I didn't even used the
>     right approach.

Great, thanks for looking into this.

Could you base your patches on top of this series?  Then you can send
them all together in a single pull request.  That way we can be sure
that padding will be added even after switching to pstrcpy() in my
patch.

Thanks,
Stefan

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5w23EACgkQnKSrs4Gr
c8gGpggAoA+7MKGOgFzxTVdIjH67VJkEDuf8HmT1Sy8nZs2FF+bPV1FkHlmbkVuc
S947uRsWP6TdMV7JOzmg6Wtad3zv5fPwm6x1nOwAaUCxDi8lt1mXdVgXfYKeTOUd
K/NocN7ZO+jIvSDOvrZPvO29kEXHWdfO3D5kJPW+36aIfYhr+OE7FGJTgyS0kVAn
RroidwUbhKRujkDd0ekaGLsdYcwcuKaOobPLWg78VA5pSgMSAVVef+3zpKzEl34e
94dnJCvDdgwiS3AUupl9gpaoNYVzjREx5hKd0n2kvPijWMkNTd/wIFpkDIqChriq
gYTq1rVRKApOlREhsRYS2k2P+4yikA==
=QF/k
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


