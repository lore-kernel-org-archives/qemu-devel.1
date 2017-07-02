Received: from eggs.gnu.org ([2001:4830:134:3::10]:33159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dRYKx-0005G4-2r
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 02:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dRYKt-0001eZ-UB
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 02:26:27 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:23955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dRYKt-0001aP-JZ
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 02:26:23 -0400
Message-ID: <1498976774.2946.79.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Sun, 02 Jul 2017 08:26:14 +0200
In-Reply-To: <20170626102852.GH495@redhat.com>
References: <cover.050aaed1de4cecd4ba9a4dc6576d1d148a8a9004.1498213152.git-series.knut.omang@oracle.com>
	<b107bc13f30e0b4a8ca8de1db178aef3fade9164.1498213152.git-series.knut.omang@oracle.com>
	<20170626102852.GH495@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Mon, 2017-06-26 at 11:28 +0100, Daniel P. Berrange wrote:
> On Fri, Jun 23, 2017 at 12:31:06PM +0200, Knut Omang wrote:
> >=20
> > First refactoring step to prepare for fixing the problem
> > exposed with the test-listen test in the previous commit
> >=20
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> > =C2=A0util/qemu-sockets.c | 24 +++++++++++++++++-------
> > =C2=A01 file changed, 17 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 852773d..699e36c 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -149,6 +149,20 @@ int inet_ai_family_from_address(InetSocketAddress
> > *addr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return PF_UNSPEC;
> > =C2=A0}
> > =C2=A0
> > +static int create_fast_reuse_socket(struct addrinfo *e, Error **errp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0int slisten =3D qemu_socket(e->ai_family, e->a=
i_socktype, e-
> > >ai_protocol);
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (slisten < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!e->ai_next) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0error_setg_errno(errp, errno, "Failed to create socket");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> I think that having this method sometimes report an error message, and
> sometimes not report an error message, depending on state of a variable
> used by the caller is rather unpleasant. I'd much rather see this
> error message reporting remain in the caller.
>
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0socket_set_fast_reuse(slisten);
> > +=C2=A0=C2=A0=C2=A0=C2=A0return slisten;
> > +}
> > +
> > =C2=A0static int inet_listen_saddr(InetSocketAddress *saddr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int port_offset,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool update_addr,
> > @@ -210,21 +224,17 @@ static int inet_listen_saddr(InetSocketAddress *s=
addr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0/* create socket + bind */
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* create socket + bind/listen */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (e =3D res; e !=3D NULL; e =3D e->ai_=
next) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0getnameinfo((stru=
ct sockaddr*)e->ai_addr,e->ai_addrlen,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uaddr,INET6_ADD=
RSTRLEN,uport,32,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NI_NUMERICHOST =
| NI_NUMERICSERV);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slisten =3D qemu_socke=
t(e->ai_family, e->ai_socktype, e-
> > >ai_protocol);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slisten =3D create_fas=
t_reuse_socket(e, &err);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (slisten < 0) =
{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (!e->ai_next) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg_errno(errp, errno, "Failed to create =
socket");
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0continue;
>=20
> It isn't shown in this diff context, but at the end of the outer
> loop we have
>=20
> =C2=A0=C2=A0=C2=A0error_setg_errno(errp, errno, "Failed to find available=
 port");
>=20
> so IIUC, even this pre-existing code is wrong. If 'e->ai_next' is
> NULL, we report an error message here. Then, we continue to the
> next loop iteration, which causes use to terminate the loop
> entirely. At which point we'll report another error message
> over the top of the one we already have. So I think the error
> reporting does still need refactoring, but not in the way it
> is done here.

Yes, I did scratch my head about this but I tried to keep the original sema=
ntics
to avoid mixing unrelated changes.

With the split into separate refactoring commits we are beyond that anyway.

I'll have a second look at it..

Thanks,
Knut

>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0socket_set_fast_reuse(=
slisten);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port_min =3D inet=
_getport(e);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0port_max =3D sadd=
r->has_to ? saddr->to + port_offset : port_min;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (p =3D port_m=
in; p <=3D port_max; p++) {
>=20
> Regards,
> Daniel
