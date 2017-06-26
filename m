Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPShA-0003wa-R4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPSh7-0005CE-Pk
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPSh7-0005BV-GJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:00:41 -0400
Date: Mon, 26 Jun 2017 13:00:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626120031.GL495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
	<b107bc13f30e0b4a8ca8de1db178aef3fade9164.1498213152.git-series.knut.omang@oracle.com>
	<20170626102852.GH495@redhat.com>
	<1498478188.3341.41.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1498478188.3341.41.camel@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] sockets: factor out
 create_fast_reuse_socket
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

On Mon, Jun 26, 2017 at 01:56:28PM +0200, Knut Omang wrote:
> On Mon, 2017-06-26 at 11:28 +0100, Daniel P. Berrange wrote:
> > On Fri, Jun 23, 2017 at 12:31:06PM +0200, Knut Omang wrote:
> > > First refactoring step to prepare for fixing the problem
> > > exposed with the test-listen test in the previous commit
> > >=C2=A0
> > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > ---
> > >=C2=A0=C2=A0util/qemu-sockets.c | 24 +++++++++++++++++-------
> > >=C2=A0=C2=A01 file changed, 17 insertions(+), 7 deletions(-)
> > >=C2=A0
> > > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > > index 852773d..699e36c 100644
> > > --- a/util/qemu-sockets.c
> > > +++ b/util/qemu-sockets.c
> > > @@ -149,6 +149,20 @@ int inet_ai_family_from_address(InetSocketAddr=
ess *addr,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return PF_UNSPEC;
> > >=C2=A0=C2=A0}
> > >=C2=A0=C2=A0
> > > +static int create_fast_reuse_socket(struct addrinfo *e, Error **er=
rp)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0int slisten =3D qemu_socket(e->ai_family, =
e->ai_socktype, e->ai_protocol);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (slisten < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!e->ai_next) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0error_setg_errno(errp, errno, "Failed to create socket");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > I think that having this method sometimes report an error message, an=
d
> > sometimes not report an error message, depending on state of a variab=
le
> > used by the caller is rather unpleasant. I'd much rather see this
> > error message reporting remain in the caller.
>=20
> In principle I agree with you, but I think we do want to keep the detai=
ls=20
> of what the failure cause was by also propagating information about the=
 system=C2=A0
> call that failed.
>=20
> I considered this an acceptable trade-off in the name of performance as=
 well as
> readability at the=C2=A0next level.=C2=A0This is a fairly=C2=A0unlikely=
 case that one really does not
> have to worry too much about at the next level. Setting an error that d=
oes not get used
> for that special, unlikely case is not that bad. Doing it for all failu=
res would be=20
> a lot more unnecessary work.
>=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0socket_set_fast_reuse(slisten);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0return slisten;
> > > +}
> > > +
> > >=C2=A0=C2=A0static int inet_listen_saddr(InetSocketAddress *saddr,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int port_offset,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool update_addr,
> > > @@ -210,21 +224,17 @@ static int inet_listen_saddr(InetSocketAddres=
s *saddr,
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -=
1;
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=C2=A0=C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0/* create socket + bind */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0/* create socket + bind/listen */
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (e =3D res; e !=3D NULL; e =3D=
 e->ai_next) {
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0getnamei=
nfo((struct sockaddr*)e->ai_addr,e->ai_addrlen,
> > >=C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uaddr,=
INET6_ADDRSTRLEN,uport,32,
> > >=C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NI_NUM=
ERICHOST | NI_NUMERICSERV);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slisten =3D qemu_s=
ocket(e->ai_family, e->ai_socktype, e->ai_protocol);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slisten =3D create=
_fast_reuse_socket(e, &err);
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (slis=
ten < 0) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (!e->ai_next) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg_errno(errp, errno, "Failed to cr=
eate socket");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0}
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0continue;
> >=20
> > It isn't shown in this diff context, but at the end of the outer
> > loop we have
> >=20
> > =C2=A0=C2=A0=C2=A0error_setg_errno(errp, errno, "Failed to find avail=
able port");
> >=20
> > so IIUC, even this pre-existing code is wrong. If 'e->ai_next' is
> > NULL, we report an error message here. Then, we continue to the
> > next loop iteration, which causes use to terminate the loop
> > entirely. At which point we'll report another error message
> > over the top of the one we already have.=20
> >
> > So I think the error
> > reporting does still need refactoring, but not in the way it
> > is done here.
>=20
> I agree, a simple way to solve it would be to only set errp if no
> error has already been set.

I'd like to see each of the methods set the error unconditionally.
In the inet_socket_listen() method, we can use an then intermediate
Error variable on each iteration of the loop, and propagate to
the global variable at the end or discard it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
