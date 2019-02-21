Received: from eggs.gnu.org ([209.51.188.92]:38611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwkf3-00073s-5M
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwkez-0007El-Dc
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:28:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gwkex-0007AW-Cq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:28:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37DFF66970
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:28:50 +0000 (UTC)
Date: Thu, 21 Feb 2019 09:28:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190221092841.GC17899@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190220182543.10623-1-berrange@redhat.com>
	<f304df7c-e0ba-042d-4ef7-d6492cb77569@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f304df7c-e0ba-042d-4ef7-d6492cb77569@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io: fix handling of EOF / error conditions
 in websock GSource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Feb 20, 2019 at 08:52:34PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 2/20/19 7:25 PM, Daniel P. Berrang=C3=A9 wrote:
> > We were never reporting the G_IO_HUP event when an end of file was hi=
t
> > on the websocket channel.
> >=20
> > We also ddn't report G_IO_ERR when we hit a fatal error processing th=
e
>=20
> "didn't report"
>=20
> > websocket protocol.
> >=20
> > The latter in particular meant that the chardev code would not notice
> > when an eof/error was encountered on the websocket channel, unless th=
e
> > guest OS happened to trigger a write operation.
> >=20
> > This meant that once the first client had quit, the chardev would nev=
er
> > listen to accept a new client.
> >=20
> > Fixes launchpad bug 1816819
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  io/channel-websock.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > index dc43dc6bb9..fc4c3dcaa5 100644
> > --- a/io/channel-websock.c
> > +++ b/io/channel-websock.c
> > @@ -1225,12 +1225,18 @@ qio_channel_websock_source_check(GSource *sou=
rce)
> >      QIOChannelWebsockSource *wsource =3D (QIOChannelWebsockSource *)=
source;
> >      GIOCondition cond =3D 0;
> > =20
> > -    if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
> > +    if (wsource->wioc->rawinput.offset) {
> >          cond |=3D G_IO_IN;
> >      }
> >      if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BU=
FFER) {
> >          cond |=3D G_IO_OUT;
> >      }
> > +    if (wsource->wioc->io_eof) {
> > +        cond |=3D G_IO_IN | G_IO_HUP;
>=20
> Shouldn't this be:
>=20
>            cond |=3D G_IO_HUP;

With regular poll() on FD I believe you typically get POLLIN | POLLHUP as
a pair.

>=20
> > +    }
> > +    if (wsource->wioc->io_err) {
> > +        cond |=3D G_IO_IN | G_IO_ERR;
>=20
> Ditto:
>=20
>            cond |=3D G_IO_ERR;

And I just followed the same practice here.

> > +    }
> > =20
> >      return cond & wsource->condition;

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
