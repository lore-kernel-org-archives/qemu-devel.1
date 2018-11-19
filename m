Received: from eggs.gnu.org ([2001:4830:134:3::10]:53503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgvG-0001ry-VL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgvF-0003xQ-Hw
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:36:54 -0500
Date: Mon, 19 Nov 2018 10:36:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119103643.GG19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 16, 2018 at 11:20:26AM -0600, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > Add tests that validate it is possible to connect to an NBD server
> > running TLS mode. Also test mis-matched TLS vs non-TLS connections
> > correctly fail.
> > ---
> >   tests/qemu-iotests/233        | 99 ++++++++++++++++++++++++++++++++=
+++
> >   tests/qemu-iotests/233.out    | 33 ++++++++++++
> >   tests/qemu-iotests/common.nbd | 47 +++++++++++++++++
> >   tests/qemu-iotests/group      |  1 +
> >   4 files changed, 180 insertions(+)
> >   create mode 100755 tests/qemu-iotests/233
> >   create mode 100644 tests/qemu-iotests/233.out
>=20
> Adding tests is non-invasive, so I have no objection to taking the enti=
re
> series in 3.1.  Do you want me to touch up the nits I found earlier, or
> should I wait for a v2?

If you're happy to touch it up, that's fine with me.

> > +
> > +$QEMU_IMG info nbd://localhost:$nbd_tcp_port
> > +
> > +echo
> > +echo "=3D=3D check TLS works =3D=3D"
> > +$QEMU_IMG info --image-opts \
> > +    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclie=
nt,id=3Dtls0 \
> > +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=
=3Dtls0
>=20
> Is it also worth reading or even writing, to ensure that more than just=
 the
> handshake is working?

I was mostly interested in the handshake/cert stuff, but yes, we could
do some qemu-io testing too.

> > +
> > +echo
> > +echo "=3D=3D check TLS with different CA fails =3D=3D"
> > +$QEMU_IMG info --image-opts \
> > +    --object tls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclie=
nt,id=3Dtls0 \
> > +    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=
=3Dtls0
> > +
> > +# success, all done
>=20
> > +=3D=3D check TLS client to plain server fails =3D=3D
> > +option negotiation failed: read failed: Unexpected end-of-file befor=
e all bytes were read
>=20
> Annoying message; I wonder if we can clean that up. But not this patch'=
s
> problem.

This is a result of using the 'socat' check to poll for qemu-nbd
readiness. When socat finally succeeds in connecting & then drops
the conenction, qemu-nbd prints this message.  Personally I don't
think we need remove it unless we want to make qemu-nbd silently
by default when clients do unusual things.

> > +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809=
,tls-creds=3Dtls0': Denied by server for option 5 (starttls)
> > +server reported: TLS not configured
>=20
> This 2-line message is better (and as such, explains why I think the me=
ssage
> about early EOF should be silenced in this case).
>=20
> > +
> > +=3D=3D check plain client to TLS server fails =3D=3D
> > +option negotiation failed: read failed: Unexpected end-of-file befor=
e all bytes were read
> > +qemu-img: Could not open 'nbd://localhost:10809': TLS negotiation re=
quired before option 8 (structured reply)
> > +server reported: Option 0x8 not permitted before TLS
>=20
> Same story about a redundant message.

Again this was the socat polling.

>=20
> > +write failed (error message): Unable to write to socket: Broken pipe
>=20
> Hmm - is this the client complaining that it can't send more to the ser=
ver
> (that's a bug if the server hung up, since the protocol allows the clie=
nt to
> change its mind and try TLS after all), or the server complaining that =
the
> client hung up abruptly without sending NBD_OPT_ABORT? Qemu as client e=
ither
> tries TLS right away, or knows that if the server requires TLS and the
> client has no TLS credentials then the client will never succeed, so th=
e
> client gives up - but it SHOULD be giving up with NBD_OPT_ABORT rather =
than
> just disconnecting.  I'll have to play with that.  Doesn't impact your
> patch, but might spur a followup fix :)

I'm unclear if this message comes from the server or the client since
they are intermingled.


> > diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/commo=
n.nbd
> > index 61e9e90fee..0483ea7c55 100644
> > --- a/tests/qemu-iotests/common.nbd
> > +++ b/tests/qemu-iotests/common.nbd
> > @@ -20,6 +20,7 @@
> >   #
> >   nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
> > +nbd_tcp_addr=3D"127.0.0.1"
>=20
> Should this be in your earlier patch that created common.nbd? Maybe not=
, as
> it doesn't get used until the functions you add here for tcp support. S=
till,
> I wonder if we should split the addition of tcp support separate from t=
he
> new test.

Yeah, I wanted the earlier patch to be a plain refactor of existing
functionality, not adding anything new.

> >   nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
> >   function nbd_server_stop()
> > @@ -62,3 +63,49 @@ function nbd_server_start_unix_socket()
> >       $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &
> >       nbd_server_wait_for_unix_socket $!
> >   }
> > +
> > +function nbd_server_set_tcp_port()
> > +{
> > +    for port in `seq 10809 10909`
> > +    do
> > +	socat TCP:$nbd_tcp_addr:$port STDIO < /dev/null 1>/dev/null 2>&1
>=20
> This is the first use of socat in iotests.  Might not be the most porta=
ble,
> but I don't know if I have better ideas. nbdkit.git/tests/test-ip.sh gr=
eps
> the output of 'ss -ltn' to locate free ports, but I don't know if ss is=
 any
> better than socat.

'ss' is a Linux specific command IIUC since it is part of 'iproute',
while 'socat' is in fact available more or less everywhere:

  https://repology.org/metapackage/socat1/versions


> > +        if test $? !=3D 0
> > +	then
> > +	    nbd_tcp_port=3D$port

Opps, a stray <tab> here

> > +            return
> > +        fi
> > +    done
> > +
> > +    echo "Cannot find free TCP port for nbd in range 10809-10909"
> > +    exit 1
>=20
> Should we skip instead of fail in this case? Would we do well picking a
> larger port range?

Yes, we could simply skip. I figure 100 ports is fine, since tests are
normally run on a largely idle system.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
