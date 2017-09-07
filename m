Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpssa-0006yr-MN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpssV-0004TS-Ju
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpssV-0004TC-As
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:13:39 -0400
Date: Thu, 7 Sep 2017 10:13:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170907091333.GB30609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170906104043.30745-1-berrange@redhat.com>
	<20170906104043.30745-2-berrange@redhat.com>
	<dac64b67-0fcf-73c2-2371-377f0a3fbb48@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dac64b67-0fcf-73c2-2371-377f0a3fbb48@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/2] io: send proper HTTP response for
 websocket errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Brian Rak <brak@vultr.com>

On Wed, Sep 06, 2017 at 03:06:03PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 09/06/2017 07:40 AM, Daniel P. Berrange wrote:
> > When any error occurs while processing the websockets handshake,
> > QEMU just terminates the connection abruptly. This is in violation
> > of the HTTP specs and does not help the client understand what they
> > did wrong. This is particularly bad when the client gives the wrong
> > path, as a "404 Not Found" would be very helpful.
> >=20
> > Refactor the handshake code so that it always sends a response to
> > the client unless there was an I/O error.
> >=20
> > Fixes bug: #1715186
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   io/channel-websock.c | 179 ++++++++++++++++++++++++++++++++++++++--=
-----------
> >   1 file changed, 134 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > index 5a3badbec2..b9cc5a1371 100644
> > --- a/io/channel-websock.c
> > +++ b/io/channel-websock.c
> > @@ -44,13 +44,39 @@
> >   #define QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE "Upgrade"
> >   #define QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET "websocket"
> > -#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RESPONSE  \
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON \
> > +    "Server: QEMU VNC\r\n"                       \
> > +    "Date: %s\r\n"
>=20
> and
>         "Sec-WebSocket-Version: " \
>           QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "\r\n" \

This header is only supposed to be set in error responses,
not in the 101 response.

> or what about:
>=20
> #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON(conn)   \
>           "Server: QEMU VNC\r\n"                         \
>           "Date: %s\r\n"                                 \
>           "Connection: " conn "\r\n"                     \
>           "Sec-WebSocket-Version: "                      \
>             QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "\r\n"

I'm not a fan of parameterizing this - I think it is clearer
to see the full connection header inline below.

> > +
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK    \
> >       "HTTP/1.1 101 Switching Protocols\r\n"      \
> > +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON    \
> >       "Upgrade: websocket\r\n"                    \
> >       "Connection: Upgrade\r\n"                   \
> >       "Sec-WebSocket-Accept: %s\r\n"              \
> >       "Sec-WebSocket-Protocol: binary\r\n"        \
> >       "\r\n"
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \
> > +    "HTTP/1.1 404 Not Found\r\n"                    \
> > +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON        \
> > +    "Connection: close\r\n"                         \
> > +    "\r\n"
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST \
> > +    "HTTP/1.1 400 Bad Request\r\n"                    \
> > +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON          \
> > +    "Connection: close\r\n"                           \
> > +    "Sec-WebSocket-Version: 13\r\n"                   \
>=20
> drop
>=20
> > +    "\r\n"
>=20
> or with previous macro:
>=20
> #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST \
>     "HTTP/1.1 400 Bad Request\r\n"                    \
>     QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON("close") \
>     "\r\n"
>=20
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR \
> > +    "HTTP/1.1 500 Internal Server Error\r\n"         \
> > +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON         \
> > +    "Connection: close\r\n"                          \
> > +    "\r\n"
> > +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_TOO_LARGE  \
> > +    "HTTP/1.1 403 Request Entity Too Large\r\n"      \
> > +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON         \
> > +    "Connection: close\r\n"                          \
> > +    "\r\n"
> >   #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM "\r\n"
> >   #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_END "\r\n\r\n"
> >   #define QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "13"


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
