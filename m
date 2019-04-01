Received: from eggs.gnu.org ([209.51.188.92]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hArnV-0002tY-Vq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hArnU-0007DZ-Vz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:56:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hArnU-0007BA-NG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:56:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so10642769wrd.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 00:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190307165824.18059-1-berrange@redhat.com>
	<20190319112431.GI29713@redhat.com>
In-Reply-To: <20190319112431.GI29713@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 1 Apr 2019 09:55:47 +0200
Message-ID: <CAP+75-WZZvHwEZygBVjJAE+X0eb-1Kcuur2Ky3LdY7KDt89D2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] io: fix handling of EOF / error
 conditions in websock GSource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Mar 19, 2019 at 12:24 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> ping
>
> On Thu, Mar 07, 2019 at 04:58:24PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > We were never reporting the G_IO_HUP event when an end of file was hit
> > on the websocket channel.
> >
> > We also didn't report G_IO_ERR when we hit a fatal error processing the
> > websocket protocol.
> >
> > The latter in particular meant that the chardev code would not notice
> > when an eof/error was encountered on the websocket channel, unless the
> > guest OS happened to trigger a write operation.
> >
> > This meant that once the first client had quit, the chardev would never
> > listen to accept a new client.
> >
> > Fixes launchpad bug 1816819
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >
> > Changed in v2:
> >  - Fix typo
> >  - Remove use of G_IO_IN at same time as HUP/ERR since. It is
> >    not required since the websock source doesn't do a real
> >    poll itself.
> >
> >  io/channel-websock.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > index dc43dc6bb9..77d30f0e4a 100644
> > --- a/io/channel-websock.c
> > +++ b/io/channel-websock.c
> > @@ -1225,12 +1225,18 @@ qio_channel_websock_source_check(GSource *sourc=
e)
> >      QIOChannelWebsockSource *wsource =3D (QIOChannelWebsockSource *)so=
urce;
> >      GIOCondition cond =3D 0;
> >
> > -    if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
> > +    if (wsource->wioc->rawinput.offset) {
> >          cond |=3D G_IO_IN;
> >      }
> >      if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFF=
ER) {
> >          cond |=3D G_IO_OUT;
> >      }
> > +    if (wsource->wioc->io_eof) {
> > +        cond |=3D G_IO_HUP;
> > +    }
> > +    if (wsource->wioc->io_err) {
> > +        cond |=3D G_IO_ERR;
> > +    }
> >
> >      return cond & wsource->condition;
> >  }
> > --
> > 2.20.1
> >

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
