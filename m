Received: from eggs.gnu.org ([2001:4830:134:3::10]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOglC-0003hC-R6
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOglB-00057z-QJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:26:30 -0500
Date: Mon, 19 Nov 2018 10:26:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119102623.GE19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-5-berrange@redhat.com>
	<8b3037a5-0a6d-c530-6d2d-2d9d8a3ca36e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b3037a5-0a6d-c530-6d2d-2d9d8a3ca36e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] tests: check if qemu-nbd is still
 alive before waiting
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

On Fri, Nov 16, 2018 at 10:24:54AM -0600, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > If the qemu-nbd UNIX socket has not shown up, the tests will sleep a =
bit
> > and then check again repeatedly for upto 30 seconds. This is pointles=
s
>=20
> s/upto/up to/
>=20
> > if the qemu-nbd process has quit due to an error, so check whether th=
e
> > pid is still alive before waiting and retrying.
>=20
> "But our tests are perfect and qemu-nbd never fails" :)

Well the key benefit for this is actually people writing new tests,
like me with this series, who continually screw up the argv syntax
to qemu-nbd and don't want to wait 30 seconds for it to fail :)

> Yes, this makes sense.  Not 3.1 material on its own (after all, our
> testsuite isn't showing such failures, so we aren't wasting that time a=
t the
> moment) - but worth including if the later patches end up in 3.1.
>=20
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   tests/qemu-iotests/common.nbd | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> >=20
> > diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/commo=
n.nbd
> > index f920a578f1..61e9e90fee 100644
> > --- a/tests/qemu-iotests/common.nbd
> > +++ b/tests/qemu-iotests/common.nbd
> > @@ -37,11 +37,19 @@ function nbd_server_stop()
> >   function nbd_server_wait_for_unix_socket()
> >   {
> > +    pid=3D$1
> > +
> >       for ((i =3D 0; i < 300; i++))
> >       do
> >           if [ -r "$nbd_unix_socket" ]; then
> >               return
> >           fi
> > +        kill -s 0 $pid 2>/dev/null
> > +        if test $? !=3D 0
> > +        then
> > +            echo "qemu-nbd unexpectedly quit"
> > +            exit 1
>=20
> Maybe the echo should be redirected to stderr.  But we aren't consisten=
tly
> doing that in other tests (_init_error does it, but other spots in chec=
k are
> not), so I'm not changing it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
