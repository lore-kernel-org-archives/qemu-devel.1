Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNF09-0000Vk-6M
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gNF08-0005mX-Aa
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:35:57 -0500
Date: Thu, 15 Nov 2018 10:35:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181115103526.GJ10900@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-2-berrange@redhat.com>
	<1baede2d-7113-be2c-62dd-9f5ce6425bb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1baede2d-7113-be2c-62dd-9f5ce6425bb1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Nov 05, 2018 at 04:41:09PM -0600, Eric Blake wrote:
> On 10/9/18 8:23 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Currently any client which can complete the TLS handshake is able to =
use
> > the NBD server. The server admin can turn on the 'verify-peer' option
> > for the x509 creds to require the client to provide a x509 certificat=
e.
> > This means the client will have to acquire a certificate from the CA
> > before they are permitted to use the NBD server. This is still a fair=
ly
> > low bar to cross.
> >=20
> > This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command wh=
ich
> > takes the ID of a previously added 'QAuthZ' object instance. This wil=
l
> > be used to validate the client's x509 distinguished name. Clients
> > failing the authorization check will not be permitted to use the NBD
> > server.
> >=20
> > For example to setup authorization that only allows connection from a=
 client
> > whose x509 certificate distinguished name is
> >=20
> >     CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3D=
GB
> >=20
> > use:
> >=20
> >    qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qe=
mutls,\
> >                      endpoint=3Dserver,verify-peer=3Dyes \
> >             --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.e=
xample.com,,\
> >                      O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB=
 \
>=20
> Missing shell quoting around the space in 'Example Org'. It's also fair=
ly
> obvious that actual shell commands can't have leading space between
> \-newline line continuations.

Yep, leading space is the tradeoff of sticking to sensible line length
while maintaining clarity.

>=20
> >             --tls-creds tls0 \
> >             --tls-authz authz0
> > 	   ....other qemu-nbd args...
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   include/block/nbd.h |  2 +-
> >   nbd/server.c        | 10 +++++-----
> >   qemu-nbd.c          | 13 ++++++++++++-
> >   qemu-nbd.texi       |  4 ++++
> >   4 files changed, 22 insertions(+), 7 deletions(-)
> >=20
>=20
> > +++ b/qemu-nbd.c
> > @@ -52,6 +52,7 @@
> >   #define QEMU_NBD_OPT_TLSCREDS      261
> >   #define QEMU_NBD_OPT_IMAGE_OPTS    262
> >   #define QEMU_NBD_OPT_FORK          263
> > +#define QEMU_NBD_OPT_TLSAUTHZ      264
>=20
> > @@ -532,6 +534,7 @@ int main(int argc, char **argv)
> >           { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS =
},
> >           { "trace", required_argument, NULL, 'T' },
> >           { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> > +        { "tls-authz", no_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
> >           { NULL, 0, NULL, 0 }
> >       };
>=20
> Missing a change to qemu-nbd --help to describe the new option.

Opps, yes.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
