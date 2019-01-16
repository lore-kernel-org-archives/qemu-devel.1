Received: from eggs.gnu.org ([209.51.188.92]:37809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhUL-0003MO-OJ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhUJ-0008S0-H5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:27:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjhUJ-0008K8-6r
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:27:55 -0500
Date: Wed, 16 Jan 2019 09:27:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116092741.GB20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-2-berrange@redhat.com>
	<a53244ea-4ff3-c5d6-73b2-9f839b6b0195@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a53244ea-4ff3-c5d6-73b2-9f839b6b0195@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] chardev: fix validation of options
 for QMP created chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 16, 2019 at 06:07:41AM +0100, Thomas Huth wrote:
> On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
> > The TLS creds option is not valid with certain address types. The use=
r
> > config was only checked for errors when parsing legacy QemuOpts, thus
> > the user could pass unsupported values via QMP.
> >=20
> > Pull all code for validating options out into a new method
> > qmp_chardev_validate_socket, that is called from the main
> > qmp_chardev_open_socket method. This adds a missing check for rejecti=
ng
> > TLS creds with the vsock address type.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  chardev/char-socket.c | 92 +++++++++++++++++++++++++++++++----------=
--
> >  1 file changed, 66 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index eaa8e8b68f..6669acb35f 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -987,6 +987,65 @@ static gboolean socket_reconnect_timeout(gpointe=
r opaque)
> >      return false;
> >  }
> > =20
> > +
>=20
> Please remove the additional empty line.

Having two blanks lines between functions is intentional to
give visual separation.

> > +static bool qmp_chardev_validate_socket(ChardevSocket *sock,
> > +                                        SocketAddress *addr,
> > +                                        Error **errp)
> > +{
> > +    /* Validate any options which have a dependancy on address type =
*/
>=20
> I'd maybe rather write "dependency" which is AFAIK the more common
> spelling - but I'm not a native speaker, so feel free to ignore me here=
.
>=20
> > +    switch (addr->type) {
> > +    case SOCKET_ADDRESS_TYPE_FD:
> > +        if (sock->has_reconnect) {
> > +            error_setg(errp,
> > +                       "'reconnect' option is incompatible with "
> > +                       "'fd' address type");
> > +            return false;
> > +        }
> > +        if (sock->has_tls_creds &&
> > +            !(sock->has_server && sock->server)) {
> > +            error_setg(errp,
> > +                       "'tls_creds' option is incompatible with "
> > +                       "'fd' address type as client");
> > +            return false;
> > +        }
> > +        break;
> > +
> > +    case SOCKET_ADDRESS_TYPE_UNIX:
> > +        if (sock->has_tls_creds) {
> > +            error_setg(errp,
> > +                       "'tls_creds' option is incompatible with "
> > +                       "'unix' address type");
> > +            return false;
> > +        }
> > +        break;
> > +
> > +    case SOCKET_ADDRESS_TYPE_INET:
> > +        break;
>=20
> You could drop the empty case.

I preferred to explicitly list all cases, so it is clear what
needs to be handled here when further checks are added later.

>=20
> > +    case SOCKET_ADDRESS_TYPE_VSOCK:
> > +        if (sock->has_tls_creds) {
> > +            error_setg(errp,
> > +                       "'tls_creds' option is incompatible with "
> > +                       "'vsock' address type");
> > +            return false;
> > +        }
> > +

Opps, missing default.

> > +    default:
> > +        break;
>=20
> You could drop the empty default case.

If that is not there, then the compiler forces the
listing of SOCKET_ADDRESS_TYPE__MAX instead due
to -Wswitch


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
