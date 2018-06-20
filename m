Received: from eggs.gnu.org ([2001:4830:134:3::10]:37740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdiQ-0003xb-3d
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVdiO-0003Wv-PZ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:04:06 -0400
Date: Wed, 20 Jun 2018 15:03:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620140347.GO3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-2-berrange@redhat.com>
	<d25692fc-8aec-295b-6ca6-39d2e4f691c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d25692fc-8aec-295b-6ca6-39d2e4f691c3@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-nbd: add support for
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

On Wed, Jun 20, 2018 at 08:58:40AM -0500, Eric Blake wrote:
> On 06/20/2018 07:14 AM, Daniel P. Berrang=C3=A9 wrote:
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
>=20
> Is the space in O=3D intentional?

Yes it really does have a space, though perhaps for sake of
illustration I'll remove the space.

>=20
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
> you need shell quoting to preserve the space. Also, the indentation bre=
aks
> the intent that these long lines are single arguments, not separate
> arguments.

Yeah I'll definitely remove the space, because it just makes this
more confusing than needed.

I know the \ isn't really supposed to separate args, but I don't
see a nicer way to format it for a commit message while respecting
line length. I figured people would understand what I meant, but
the fact that I've indented the second line to vertically align.

>=20
> >             --tls-creds tls0 \
> >             --tls-authz authz0
> > 	   ....other qemu-nbd args...
>=20
> Is it also worth a sample command line using JSON syntax?

Probably overkill for the commit message IMHO.

>=20
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
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
