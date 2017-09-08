Received: from eggs.gnu.org ([2001:4830:134:3::10]:33874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJIv-00066E-HR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJIr-0000Y9-Ha
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqJIr-0000XW-BO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:26:37 -0400
Date: Fri, 8 Sep 2017 14:26:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908132633.GE32645@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908103011.25821-1-berrange@redhat.com>
	<20170908103011.25821-4-berrange@redhat.com>
	<70a0110b-8295-f0d1-a69c-29d83178d6e9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70a0110b-8295-f0d1-a69c-29d83178d6e9@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] io: use case insensitive check for
 Connection & Upgrade websock headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Brian Rak <brak@vultr.com>

On Fri, Sep 08, 2017 at 10:22:00AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 09/08/2017 07:30 AM, Daniel P. Berrange wrote:
> > When checking the value of the Connection and Upgrade HTTP headers
> > the websock RFC (6455) requires the comparison to be case insensitive=
.
> > The Connection value should be an exact match not a substring.
> >=20
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   io/channel-websock.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/io/channel-websock.c b/io/channel-websock.c
> > index aed7a6c9b3..ab332ec907 100644
> > --- a/io/channel-websock.c
> > +++ b/io/channel-websock.c
> > @@ -427,12 +427,12 @@ static void qio_channel_websock_handshake_proce=
ss(QIOChannelWebsock *ioc,
> >           goto bad_request;
> >       }
> > -    if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRAD=
E)) {
> > +    if (strcasecmp(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRAD=
E) !=3D 0) {
>=20
> Why not use g_ascii_strcasecmp() ?

Functionally it doesn't matter either way, but there's no usage of
g_ascii_strcasecmp in QEMU so I don't see a benefit to using that

>=20
> >           error_setg(errp, "No connection upgrade requested '%s'", co=
nnection);
> >           goto bad_request;
> >       }
> > -    if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)=
) {
> > +    if (strcasecmp(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET) !=
=3D 0) {
> >           error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
> >           goto bad_request;
> >       }
> >=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
