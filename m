Received: from eggs.gnu.org ([2001:4830:134:3::10]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgwM-00035m-Nw
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgwI-0005Du-ID
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:38:02 -0500
Date: Mon, 19 Nov 2018 10:37:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119103752.GH19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
	<08baf15a-7205-7a47-c806-dccadcaca291@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08baf15a-7205-7a47-c806-dccadcaca291@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Sat, Nov 17, 2018 at 03:31:34PM -0600, Eric Blake wrote:
> On 11/16/18 11:20 AM, Eric Blake wrote:
> > On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > > Add tests that validate it is possible to connect to an NBD server
> > > running TLS mode. Also test mis-matched TLS vs non-TLS connections
> > > correctly fail.
> > > ---
>=20
> > > +=3D=3D check TLS client to plain server fails =3D=3D
> > > +option negotiation failed: read failed: Unexpected end-of-file
> > > before all bytes were read
> >=20
> > Annoying message; I wonder if we can clean that up. But not this patc=
h's
> > problem.
> >=20
>=20
> Actually, I tracked this message down to using socat (which actually
> connects and then abruptly exits) when probing whether the socket is up=
 and
> listening.  That is, the message is being produced as a side effect of
> nbd_server_wait_for_tcp_socket rather than during the actual $QEMU_IMG
> command we are interested in testing.
>=20
>=20
> > > =C2=A0 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
> > > =C2=A0 function nbd_server_stop()
> > > @@ -62,3 +63,49 @@ function nbd_server_start_unix_socket()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $QEMU_NBD -v -t -k "$nbd_unix_socket=
" $@ &
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_server_wait_for_unix_socket $!
> > > =C2=A0 }
> > > +
> > > +function nbd_server_set_tcp_port()
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 for port in `seq 10809 10909`
> > > +=C2=A0=C2=A0=C2=A0 do
> > > +=C2=A0=C2=A0=C2=A0 socat TCP:$nbd_tcp_addr:$port STDIO < /dev/null=
 1>/dev/null 2>&1
> >=20
> > This is the first use of socat in iotests.=C2=A0 Might not be the mos=
t
> > portable, but I don't know if I have better ideas.
> > nbdkit.git/tests/test-ip.sh greps the output of 'ss -ltn' to locate f=
ree
> > ports, but I don't know if ss is any better than socat.
>=20
> So, I'm planning to squash this in, to use ss instead of socat, as foll=
ows:

Personally I prefer socat since it is more portable, per my previous
message.

> diff --git i/tests/qemu-iotests/233.out w/tests/qemu-iotests/233.out
> index eaa410c2703..eb4077f9fd7 100644
> --- i/tests/qemu-iotests/233.out
> +++ w/tests/qemu-iotests/233.out
> @@ -11,12 +11,10 @@ Generating a signed certificate...
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>=20
>  =3D=3D check TLS client to plain server fails =3D=3D
> -option negotiation failed: read failed: Unexpected end-of-file before =
all
> bytes were read
>  qemu-img: Could not open
> 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls-creds=3Dtls0': Denied b=
y server for
> option 5 (starttls)
>  server reported: TLS not configured
>=20
>  =3D=3D check plain client to TLS server fails =3D=3D
> -option negotiation failed: read failed: Unexpected end-of-file before =
all
> bytes were read
>  qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation requ=
ired
> before option 8 (structured reply)
>  server reported: Option 0x8 not permitted before TLS
>  write failed (error message): Unable to write to socket: Broken pipe
>=20
>=20
> Also, you have to sanitize 233.out to change 10809 into PORT, so the te=
st
> can still pass when it picked a different port.

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
