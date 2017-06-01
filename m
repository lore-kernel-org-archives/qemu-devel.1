Received: from eggs.gnu.org ([2001:4830:134:3::10]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGTmN-00023G-1s
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGTmJ-0003Bj-Li
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:20:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGTmJ-0003BQ-Bt
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:20:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41F1C80F96
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 17:20:54 +0000 (UTC)
Date: Thu, 1 Jun 2017 18:20:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601172046.GJ2845@work-vm>
References: <20170509184900.GI2089@work-vm>
	<1833628273.9365810.1494355970259.JavaMail.zimbra@redhat.com>
	<20170510133255.GD4230@work-vm>
	<1509302139.20862844.1495638621196.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1509302139.20862844.1495638621196.JavaMail.zimbra@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] VhostUserRequest # 20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: maxime coquelin <maxime.coquelin@redhat.com>, qemu-devel@nongnu.org

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi
>=20
> ----- Original Message -----
> > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > HI
> > >=20
> > > ----- Original Message -----
> > > > Hi,
> > > >   libvhost-user.h defines:
> > > >    VHOST_USER_INPUT_GET_CONFIG =3D 20,
> > >=20
> > > That slipped by mistake from my vhost-user-input series WIP, please=
 send a
> > > fix.
> > > (luckily, this is only internal header for now)
> >=20
> > OK, just posted.
> >=20
> > However, I just spotted, or should I say gcc just spotted another iss=
ue:
> >=20
> >   CC      tests/vhost-user-bridge.o
> > /home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warn=
ing:
> > variables 'front' and 'iov' used in loop condition not modified in lo=
op body
> > [-Wfor-loop-analysis]
> >     for (cur =3D front; front !=3D iov; cur++) {
> >                       ^~~~~    ~~~
> > 1 warning generated.
> >=20
> >=20
> > static void
> > iov_restore_front(struct iovec *front, struct iovec *iov, size_t byte=
s)
> > {
> >     struct iovec *cur;
> >=20
> >     for (cur =3D front; front !=3D iov; cur++) {
> >         bytes -=3D cur->iov_len;
> >     }
> >=20
> >     cur->iov_base -=3D bytes;
> >     cur->iov_len +=3D bytes;
> > }
> >=20
> > What's that actually intending to do?
>=20
> It was meant to revert the effect of iov_discard_front()
>=20
> The code should read:
>=20
> for (cur =3D front; cur !=3D iov; cur++) {
>=20
> In practice, it doesn't reach the loop since the front sg buffer is big=
 enough to discard the header..
>=20
> Does that looks correct to you?

OK, so let me check if I understand;  it's supposed to be called with
'front' being the original struct iovec *, and 'bytes' being the number
of bytes you shaved off using iov_discard_front?
If so then yes I think that makes sense; a comment to explain that
would probably help.
A sanity check for bytes being >=3D0 after the loop might be worth it as
well.

Dave

>=20
>=20
> thanks
>=20
> >=20
> > Dave
> >=20
> > > thanks
> > >=20
> > > > while
> > > >   vhost-user.c defines:
> > > >    VHOST_USER_NET_SET_MTU =3D 20,
> > > >=20
> > > > who wins?
> > > >=20
> > > > Dave
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
