Received: from eggs.gnu.org ([2001:4830:134:3::10]:43359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVe4V-0003nc-CJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVe4U-0005CF-28
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:26:55 -0400
Date: Wed, 20 Jun 2018 15:26:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620142644.GR3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-2-berrange@redhat.com>
	<20180620142252.GM2549@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180620142252.GM2549@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Jun 20, 2018 at 03:22:53PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
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
> >    CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3D=
GB
> >=20
> > use:
> >=20
> >   qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qem=
utls,\
> >                     endpoint=3Dserver,verify-peer=3Dyes \
> >            --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.ex=
ample.com,,\
> >                     O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB =
\
>=20
> I'm confused about how that gets parsed, what differentiates the ,s
> that separate the arguments (e.g. ,id=3D  ,identity=3D) and the ,s that
> separate the options within the identity string (e.g. the ,ST=3DLondon)

That's why I've doubled up - eg ',,' must be used when you need to
include a literal ',' in a value without it being interpreted as
starting a new option

> Would:
>   --object authz-simple,identity=3DCN=3Dlaptop.example.com,,O=3DExample=
 Org,,L=3DLondon,,ST=3DLondon,,C=3DGB,id=3Dauth0
>=20
> be equivalent?

Yes


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
