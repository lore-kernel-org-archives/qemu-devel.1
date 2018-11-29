Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSII1-0007Yh-EE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gSIHq-0006r1-8g
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:07:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gSIHq-0006qd-0l
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:07:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AF45308403D
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:07:05 +0000 (UTC)
Date: Thu, 29 Nov 2018 10:07:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181129090701.lbyqnyw4u3s2bxxw@sirius.home.kraxel.org>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
	<20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
	<CAMxuvaywjHiBPLuaqhV1H_0XnariFHm=JLeo3fptSKLaZbFo9g@mail.gmail.com>
	<2135052047.46423828.1543480348695.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2135052047.46423828.1543480348695.JavaMail.zimbra@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Nov 29, 2018 at 03:32:28AM -0500, Frediano Ziglio wrote:
> > On Thu, Nov 29, 2018 at 12:09 PM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
> > >
> > > On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=E9 Lureau wrote=
:
> > > > Looking at chardev/spice.c code, I realize compilation was broken=
 for
> > > > a while with spice-server < 0.12.3. Let's bump required version
> > > > to 0.12.5, released May 19 2014, instead of adding more #ifdef.
> > >
> > > Oh, you did the 0.12.5 patch already.  Scratch my other reply then.
> > >
> > > > -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> > > > +  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
> > > >       $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
> > >
> > > I think we should adjust spice-protocol too to whatever 0.12.5 requ=
ires
> > > to build.
> > >
> >=20
> > Why not leave that responsibility to pkg-config, and only require in
> > qemu what is required there?
> >=20
> >=20
>=20
> That is remove explicit requirement in configure script?
> I can see that spice-core.h (spice-server, one of the mail include) is
> including spice-protocol headers.
> Looking at configure both are required so would make sense to check
> only spice-server, unless packaging has some bugs if you have spice-ser=
ver
> (devel) installed you also have spice-protocol.

seems the spice-protocol dep is there due to qemu itself needing it:

commit 358689fe299c306f1d81bea57a5067d0abb56699
Author: Michal Privoznik <mprivozn@redhat.com>
Date:   Fri Mar 1 08:43:18 2013 +0100

    configure: Require at least spice-protocol-0.12.3
   =20
    As of 5a49d3e9 we assume SPICE_PORT_EVENT_BREAK to be defined.
    However, it is defined not in 0.12.2 what we require now, but in
    0.12.3.  Therefore in order to prevent build failure we must
    adjust our minimal requirements.
   =20
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

That makes sense.  So, when spice-server 0.12.5 requires spice-protocol
0.12.8+ anyway I think we can savely drop the spice-protocol check.

cheers,
  Gerd
