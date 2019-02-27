Received: from eggs.gnu.org ([209.51.188.92]:59572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz1c6-00035H-CF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz1c0-0005Y6-Hc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 10:59:16 -0500
Date: Wed, 27 Feb 2019 15:58:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227155828.GO31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227115152.1906-1-berrange@redhat.com>
	<20190227115152.1906-2-berrange@redhat.com>
	<61c14d41-362e-b6ba-be62-b360c215a98b@redhat.com>
	<20190227153331.GL31688@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227153331.GL31688@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qemu-nbd: add support for
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 27, 2019 at 03:33:31PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 27, 2019 at 08:25:20AM -0600, Eric Blake wrote:
> > On 2/27/19 5:51 AM, Daniel P. Berrang=C3=A9 wrote:
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
> > > escape the commas in the name and use:
> > >=20
> > >   qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/q=
emutls,\
> > >                     endpoint=3Dserver,verify-peer=3Dyes \
> > >            --object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop=
.example.com,,\
> > >                      O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3D=
GB' \
> > >            --tls-creds tls0 \
> > >            --tls-authz authz0 \
> > > 	   ....other qemu-nbd args...
> > >=20
> > > NB: a real shell command line would not have leading whitespace aft=
er
> > > the line continuation, it is just included here for clarity.


> > >  echo "=3D=3D check TLS works =3D=3D"
> > > -obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=
=3Dtls0
> > > -$QEMU_IMG info --image-opts --object $obj \
> > > +obj1=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0
> > > +obj2=3Dtls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,i=
d=3Dtls0
> > > +$QEMU_IMG info --image-opts --object $obj1 \
> > >      driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cre=
ds=3Dtls0 \
> > >      2>&1 | sed "s/$nbd_tcp_port/PORT/g"
> > > -$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj =
\
> > > +$QEMU_IMG info --image-opts --object $obj2 \
> > > +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cre=
ds=3Dtls0 \
> > > +    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
> > > +$QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --object $obj1=
 \
> > >      --tls-creds=3Dtls0
> >=20
> > It looks like you have both a positive and negative test that a qemu-=
img
> > client can only connect with the right auth, but only a positive test
> > for a qemu-nbd --list client.  Should we also duplicate the
> > QEMU_NBD_PROG line to use $obj2 for a negative test?
>=20
> I can look at that

On reflection I don't think that's needed. This is a server side feature =
we
are validating. As such it is sufficient to validate with any client app
supporting TLS. IOW, qemu-img is sufficient to prove the server side feat=
ure
is working correctly.

>=20
> >=20
> > > =20
> > >  echo
> > > @@ -117,6 +122,26 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m=
 1m' --image-opts \
> > > =20
> > >  $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filt=
er_qemu_io
> > > =20
> > > +echo
> > > +echo "=3D=3D check TLS with authorization =3D=3D"
> > > +
> > > +nbd_server_stop
> > > +
> > > +nbd_server_start_tcp_socket \
> > > +    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dse=
rver,id=3Dtls0,verify-peer=3Dyes \
> > > +    --object "authz-simple,identity=3DCN=3Dlocalhost,,O=3DCthulu D=
ark Lord Enterprises client1,,L=3DR'lyeh,,C=3DSouth Pacific,id=3Dauthz0" =
\
> > > +    --tls-authz authz0 \
> > > +    --tls-creds tls0 \
> > > +    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
> > > +
> > > +$QEMU_IMG info --image-opts \
> > > +    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dcl=
ient,id=3Dtls0 \
> > > +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cre=
ds=3Dtls0
> > > +
> > > +$QEMU_IMG info --image-opts \
> > > +    --object tls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dcl=
ient,id=3Dtls0 \
> > > +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-cre=
ds=3Dtls0
> >=20
> > Similarly, do we want --list testing here?
>=20
> I'll have a look.

For same reason as above, we don't need to repeat with qemu-nbd --list

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
