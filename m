Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVYhR-0004MK-09
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVYhP-0004YY-TJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:42:45 -0400
Date: Wed, 20 Jun 2018 09:42:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620084227.GC3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-2-berrange@redhat.com>
	<3e17406b-7910-5827-6239-ded1115bd0c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e17406b-7910-5827-6239-ded1115bd0c7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-nbd: add support for
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Jun 19, 2018 at 03:06:06PM -0500, Eric Blake wrote:
> On 06/15/2018 10:50 AM, Daniel P. Berrang=C3=A9 wrote:
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
> > whose x509 certificate distinguished name contains 'CN=3Dfred', you w=
ould
> > use:
> >=20
> >    qemu-nbd -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qem=
utls,\
> >                     endpoint=3Dserver,verify-peer=3Dyes \
> >             -object authz-simple,id=3Dauthz0,policy=3Ddeny,\
> > 	           rules.0.match=3D*CN=3Dfred,rules.0.policy=3Dallow \
>=20
> s/-object/--object/g
>=20
> >             -tls-creds tls0 \
> >             -tls-authz authz0
>=20
> s/-tls/--tls/g
>=20
> (qemu-nbd requires double-dash long-opts, -o means --offset except that
> 'bject' is not an offset; similarly for -t meaning --persistent)

Sigh, yes, just another reason for us to standardize on -- everywhere

> > +++ b/qemu-nbd.c
>=20
> > @@ -533,6 +535,7 @@ int main(int argc, char **argv)
> >           { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS =
},
> >           { "trace", required_argument, NULL, 'T' },
> >           { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> > +        { "tls-authz", no_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
>=20
> Not your fault, but worth sorting these alphabetically?
>=20
> Bummer that pre-patch, you could use '--tls' as an unambiguous abbrevia=
tion
> for --tls-creds; now it is an ambiguous prefix (you have to type --tls-=
c or
> --tls-a to get to the point of no ambiguity).  If we really cared, we c=
ould
> add:
>=20
> { "t", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
> { "tl", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
> { "tls", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
> { "tls-", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
>=20
> since getopt_long() no longer reports ambiguity if there is an exact ma=
tch
> to what is otherwise the common prefix of two ambiguous options. But I =
don't
> think backwards-compatibility on this front is worth worrying about
> (generally, scripts don't rely on getopt_long()'s unambiguous prefix
> handling).

Personally I think this is not worth worrying about. We've never document=
ed
ability to abbreviate nor ever promised they are stable. Abbreviations ar=
e
inherantly unstable as you illustrate, so if anything we should just docu=
ment
that you should never abbreviate args.

>=20
> > +++ b/qemu-nbd.texi
> > @@ -91,6 +91,10 @@ of the TLS credentials object previously created w=
ith the --object
> >   option.
> >   @item --fork
> >   Fork off the server process and exit the parent once the server is =
running.
> > +@item --tls-authz=3DID
> > +Specify the ID of a qauthz object previously created with the
>=20
> s/qauthz/authz-simple/ ?

No, qauthz is a QOM interface, which is implemented by many subclasses,
of which authz-simple is just one example.

> > +--object option. This will be used to authorize users who
> > +connect against their x509 distinguished name.
>=20
> Sounds like someone is "connecting against their name", rather than
> "authorizing against their name".  Better might be:
>=20
> This will be used to authorize connecting users against their x509
> distinguished name.

Ok

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
