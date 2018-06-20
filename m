Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVeMB-00073a-KT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVeMA-00036w-Md
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:45:11 -0400
Date: Wed, 20 Jun 2018 15:45:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180620144500.GN2549@work-vm>
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-2-berrange@redhat.com>
	<20180620142252.GM2549@work-vm> <20180620142644.GR3441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180620142644.GR3441@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Jun 20, 2018 at 03:22:53PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > From: "Daniel P. Berrange" <berrange@redhat.com>
> > >=20
> > > Currently any client which can complete the TLS handshake is able t=
o use
> > > the NBD server. The server admin can turn on the 'verify-peer' opti=
on
> > > for the x509 creds to require the client to provide a x509 certific=
ate.
> > > This means the client will have to acquire a certificate from the C=
A
> > > before they are permitted to use the NBD server. This is still a fa=
irly
> > > low bar to cross.
> > >=20
> > > This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command =
which
> > > takes the ID of a previously added 'QAuthZ' object instance. This w=
ill
> > > be used to validate the client's x509 distinguished name. Clients
> > > failing the authorization check will not be permitted to use the NB=
D
> > > server.
> > >=20
> > > For example to setup authorization that only allows connection from=
 a client
> > > whose x509 certificate distinguished name is
> > >=20
> > >    CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=
=3DGB
> > >=20
> > > use:
> > >=20
> > >   qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/q=
emutls,\
> > >                     endpoint=3Dserver,verify-peer=3Dyes \
> > >            --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.=
example.com,,\
> > >                     O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DG=
B \
> >=20
> > I'm confused about how that gets parsed, what differentiates the ,s
> > that separate the arguments (e.g. ,id=3D  ,identity=3D) and the ,s th=
at
> > separate the options within the identity string (e.g. the ,ST=3DLondo=
n)
>=20
> That's why I've doubled up - eg ',,' must be used when you need to
> include a literal ',' in a value without it being interpreted as
> starting a new option

OK, yeh I forgot about the obscure double-comma rule.

> > Would:
> >   --object authz-simple,identity=3DCN=3Dlaptop.example.com,,O=3DExamp=
le Org,,L=3DLondon,,ST=3DLondon,,C=3DGB,id=3Dauth0
> >=20
> > be equivalent?
>=20
> Yes

OK.

Dave

>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
