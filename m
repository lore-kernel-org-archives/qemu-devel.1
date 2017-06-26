Received: from eggs.gnu.org ([2001:4830:134:3::10]:43812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPTST-0006QP-5L
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPTSP-0006ve-EJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPTSP-0006vL-5B
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:49:33 -0400
Date: Mon, 26 Jun 2017 13:49:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626124922.GO495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
	<51d7f54d100e9dedecf6dc65691ca65adfc8394f.1498213152.git-series.knut.omang@oracle.com>
	<20170626102254.GG495@redhat.com>
	<1498480368.3341.43.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498480368.3341.43.camel@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/4] sockets: Handle race condition
 between binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Mon, Jun 26, 2017 at 02:32:48PM +0200, Knut Omang wrote:
> On Mon, 2017-06-26 at 11:22 +0100, Daniel P. Berrange wrote:
> > On Fri, Jun 23, 2017 at 12:31:08PM +0200, Knut Omang wrote:
> > > If an offset of ports is specified to the inet_listen_saddr functio=
n(),
> > > and two or more processes tries to bind from these ports at the sam=
e time,
> > > occasionally more than one process may be able to bind to the same
> > > port. The condition is detected by listen() but too late to avoid a=
 failure.
> > >=C2=A0
> > > This function is called by socket_listen() and used
> > > by all socket listening code in QEMU, so all cases where any form o=
f dynamic
> > > port selection is used should be subject to this issue.
> > >=C2=A0
> > > Add code to close and re-establish the socket when this
> > > condition is observed, hiding the race condition from the user.
> > >=C2=A0
> > > This has been developed and tested by means of the
> > > test-listen unit test in the previous commit.
> > > Enable the test for make check now that it passes.
> > >=C2=A0
> > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> > > Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> > > Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> > > ---
> > >=C2=A0=C2=A0tests/Makefile.include |=C2=A0=C2=A02 +-
> > >=C2=A0=C2=A0util/qemu-sockets.c=C2=A0=C2=A0=C2=A0=C2=A0| 68 ++++++++=
++++++++++++++++++++++++-----------
> > >=C2=A0=C2=A02 files changed, 53 insertions(+), 17 deletions(-)
> > >=C2=A0
> > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > index 22bb97e..c38f94e 100644
> > > --- a/tests/Makefile.include
> > > +++ b/tests/Makefile.include
> > > @@ -127,7 +127,7 @@ check-unit-y +=3D tests/test-bufferiszero$(EXES=
UF)
> > >=C2=A0=C2=A0gcov-files-check-bufferiszero-y =3D util/bufferiszero.c
> > >=C2=A0=C2=A0check-unit-y +=3D tests/test-uuid$(EXESUF)
> > >=C2=A0=C2=A0check-unit-y +=3D tests/ptimer-test$(EXESUF)
> > > -#check-unit-y +=3D tests/test-listen$(EXESUF)
> > > +check-unit-y +=3D tests/test-listen$(EXESUF)
> > >=C2=A0=C2=A0gcov-files-ptimer-test-y =3D hw/core/ptimer.c
> > >=C2=A0=C2=A0check-unit-y +=3D tests/test-qapi-util$(EXESUF)
> > >=C2=A0=C2=A0gcov-files-test-qapi-util-y =3D qapi/qapi-util.c
> > > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > > index 48b9319..7b118b4 100644
> > > --- a/util/qemu-sockets.c
> > > +++ b/util/qemu-sockets.c
> > > @@ -201,6 +201,42 @@ static int try_bind(int socket, InetSocketAddr=
ess *saddr, struct
> > addrinfo *e)
> > >=C2=A0=C2=A0#endif
> > >=C2=A0=C2=A0}
> > >=C2=A0=C2=A0
> > > +static int try_bind_listen(int *socket, InetSocketAddress *saddr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0struct addrinfo *e, int port, Error **errp)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0int s =3D *socket;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0inet_setport(e, port);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0ret =3D try_bind(s, saddr, e);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (errno !=3D EAD=
DRINUSE) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0error_setg_errno(errp, errno, "Failed to bind socket");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return errno;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (listen(s, 1) =3D=3D 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (errno =3D=3D EADDRINUSE) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* We got to bind =
the socket to a port but someone else managed
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* to bind to=
 the same port and beat us to listen on it!
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Recreate t=
he socket and return EADDRINUSE to preserve the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* expected s=
tate by the caller:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0closesocket(s);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s =3D create_fast_=
reuse_socket(e, errp);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (s < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return errno;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*socket =3D s;
> >=20
> > I don't really like this at all - if we need to close + recreate the
> > socket, IMHO that should remain the job of the caller, since it owns
> > the socket FD ultimately.
>=20
> Normally I would agree, but this is a very unlikely situation.=C2=A0I c=
onsidered moving the
> complexity out to the caller, even to recreate for every call, but foun=
d those solutions
> to be inferior as they do not in any way confine the problem, and cause=
 the handling of
> the common cases to be much less readable. It's going to be some trade-=
offs here.
>=20
> As long as the caller is aware of (by the reference call) that the sock=
et in use may
> change, this is in my view a clean (as clean as possible) abstraction t=
hat simplifies the
> logic at the next level. My intention is to make the common, good case =
as readable as
> possible and hide some of the complexity of these=20
> unlikely error scenarios inside the new functions - divide and conquer.=
.
>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0errno =3D EADDRINU=
SE;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return errno;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0error_setg_errno(errp, errno, "Failed to l=
isten on socket");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0return errno;
> > > +}
> > > +
> > >=C2=A0=C2=A0static int inet_listen_saddr(InetSocketAddress *saddr,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int port_offset,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool update_addr,
> > > @@ -210,7 +246,9 @@ static int inet_listen_saddr(InetSocketAddress =
*saddr,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char port[33];
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char uaddr[INET6_ADDRSTRLEN+1];
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char uport[33];
> > > -=C2=A0=C2=A0=C2=A0=C2=A0int slisten, rc, port_min, port_max, p;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0int rc, port_min, port_max, p;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0int slisten =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0int saved_errno =3D 0;
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error *err =3D NULL;
> > >=C2=A0=C2=A0
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(&ai,0, sizeof(ai));
> > > @@ -276,28 +314,26 @@ static int inet_listen_saddr(InetSocketAddres=
s *saddr,
> >=20
> > Just above this line is the original 'create_fast_reuse_socket' call.
> >=20
> > I'd suggest that we push that call down into the body of the loop
> > below:
> >=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port_min=
 =3D inet_getport(e);
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port_max=
 =3D saddr->has_to ? saddr->to + port_offset : port_min;
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (p =3D=
 port_min; p <=3D port_max; p++) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0inet_setport(e, p);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (try_bind(slisten, saddr, e) >=3D 0) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto listen;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0}
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (p =3D=3D port_max) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!e->ai_next) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg_errno(er=
rp, errno, "Failed to bind socket");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0int eno =3D try_bind_listen(&slisten, saddr, e, p, &err);
> >=20
> > Which would mean try_bind_listen no longer needs the magic to close +
> > recreate the socket.
> >=20
> > The only cost of doing this is that you end up closing + recreating t=
he
> > socket after bind hits EADDRINUSE, as well as after listen() hits it.
>=20
> The problem with this approach in my opinion is that one has to underst=
and the
> fix for the problem I am trying to solve here in order to read the main=
 code,=C2=A0
> even though this is a very special case. Everyone reading the code woul=
d ask themselves
> the question 'why do they recreate the socket here?' and then be forced=
 to ready the
> details of try_bind_listen anyway, or we would need additional comments=
.

That's easily solved by adding a comment

  /* We recreate the socket FD on each iteration because
     if bind succeeds & listen fails, we can't bind
     again on the same socket FD */

> The idea behind the abstractions I have used here is to hide the detail=
s inside functions,
> but leave them with an as clean as possible (although not ideal) interf=
ace that=20
> makes the overall logic more readable.

I think the result is actually harder to understand, because of the
peculiar way the function closes & reopens the socket FD belonging
to the caller, and the error handling is really very unclear and
buggy as a result too.

> > I think that's acceptable tradeoff for simpler code, since this is no=
t
> > a performance critical operation.
>=20
> Also should we perhaps worry about any side effects of creating and clo=
sing a lot of
> sockets unnecessary?

What side effects ? I don't think there are any - since this is server
side, not client side, we're not leaving any state around in timed waits
or similar.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
