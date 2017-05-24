Received: from eggs.gnu.org ([2001:4830:134:3::10]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dDXvo-0001Xk-7L
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dDXvj-00079o-8t
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dDXvj-00079X-2L
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:10:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04AA37F6B3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:10:30 +0000 (UTC)
Date: Wed, 24 May 2017 11:10:21 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1509302139.20862844.1495638621196.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170510133255.GD4230@work-vm>
References: <20170509184900.GI2089@work-vm>
	<1833628273.9365810.1494355970259.JavaMail.zimbra@redhat.com>
	<20170510133255.GD4230@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: maxime coquelin <maxime.coquelin@redhat.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > HI
> >=20
> > ----- Original Message -----
> > > Hi,
> > >   libvhost-user.h defines:
> > >    VHOST_USER_INPUT_GET_CONFIG =3D 20,
> >=20
> > That slipped by mistake from my vhost-user-input series WIP, please sen=
d a
> > fix.
> > (luckily, this is only internal header for now)
>=20
> OK, just posted.
>=20
> However, I just spotted, or should I say gcc just spotted another issue:
>=20
>   CC      tests/vhost-user-bridge.o
> /home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warning:
> variables 'front' and 'iov' used in loop condition not modified in loop b=
ody
> [-Wfor-loop-analysis]
>     for (cur =3D front; front !=3D iov; cur++) {
>                       ^~~~~    ~~~
> 1 warning generated.
>=20
>=20
> static void
> iov_restore_front(struct iovec *front, struct iovec *iov, size_t bytes)
> {
>     struct iovec *cur;
>=20
>     for (cur =3D front; front !=3D iov; cur++) {
>         bytes -=3D cur->iov_len;
>     }
>=20
>     cur->iov_base -=3D bytes;
>     cur->iov_len +=3D bytes;
> }
>=20
> What's that actually intending to do?

It was meant to revert the effect of iov_discard_front()

The code should read:

for (cur =3D front; cur !=3D iov; cur++) {

In practice, it doesn't reach the loop since the front sg buffer is big eno=
ugh to discard the header..

Does that looks correct to you?


thanks

>=20
> Dave
>=20
> > thanks
> >=20
> > > while
> > >   vhost-user.c defines:
> > >    VHOST_USER_NET_SET_MTU =3D 20,
> > >=20
> > > who wins?
> > >=20
> > > Dave
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
