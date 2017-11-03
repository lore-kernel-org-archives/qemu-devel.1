Received: from eggs.gnu.org ([2001:4830:134:3::10]:56079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdL4-0001va-87
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAdL1-00074P-0n
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eAdL0-000742-Ns
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:52:50 -0400
Date: Fri, 3 Nov 2017 14:52:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171103145246.GK20155@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171102165629.Horde.3vL2RJXzulVHv5PiXG00Bz4@www.quantumachine.net>
	<20171102170903.GY32533@redhat.com>
	<20171102224710.Horde.un6xiancuv3-V_s6uvEtdpP@www.quantumachine.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171102224710.Horde.un6xiancuv3-V_s6uvEtdpP@www.quantumachine.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sockets: Normalize test for addrinfo flag
 AI_V4MAPPED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antonio Huete =?utf-8?Q?Jim=C3=A9nez?= <tuxillo@quantumachine.net>
Cc: qemu-devel@nongnu.org

On Thu, Nov 02, 2017 at 10:47:10PM +0000, Antonio Huete Jim=C3=A9nez wrot=
e:
>=20
> "Daniel P. Berrange" <berrange@redhat.com> escribi=C3=B3:
>=20
> > On Thu, Nov 02, 2017 at 04:56:29PM +0000, Antonio Huete Jim=C3=A9nez =
wrote:
> > > From 2b4d9d8cb617445af8f3b062f917dfea42dbdc27 Mon Sep 17 00:00:00 2=
001
> > > From: Antonio Huete Jimenez <tuxillo@quantumachine.net>
> > > Date: Thu, 2 Nov 2017 17:46:24 +0100
> > > Subject: [PATCH] sockets: Normalize test for addrinfo flag AI_V4MAP=
PED
> >=20
> > Can you explain why you're making this change....
>=20
> Hi Daniel,
>=20
> Thanks for reviewing the patch. I am trying to fix 'make check' for
> DragonFly BSD and this is the first issue I encountered.

Ok, it would be helpful if the commit msg could mention which test fails
without this fix, ideally with the actual error message (if one is given,
as opposed to an abort()).


> > > Signed-off-by: Antonio Huete Jimenez <tuxillo@quantumachine.net>
> > > ---
> > >  util/qemu-sockets.c | 54
> > > +++++++++++++++++++++++++++++++++--------------------
> > >  1 file changed, 34 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > > index b47fb45885..ce35b6a998 100644
> > > --- a/util/qemu-sockets.c
> > > +++ b/util/qemu-sockets.c
> > > @@ -44,7 +44,6 @@
> > >  # define AI_NUMERICSERV 0
> > >  #endif
> > >=20
> > > -
> > >  static int inet_getport(struct addrinfo *e)
> > >  {
> > >      struct sockaddr_in *i4;
> > > @@ -149,6 +148,31 @@ int
> > > inet_ai_family_from_address(InetSocketAddress *addr,
> > >      return PF_UNSPEC;
> > >  }
> > >=20
> > > +static int
> > > +check_ai_v4mapped(const char *host, const char *port, struct addri=
nfo *ai,
> > > +               struct addrinfo *res)
> > > +{
> > > +    static int useV4Mapped =3D -1;
> > > +    int rc;
> > > +
> > > +    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
> > > +     * then don't implement it in their getaddrinfo().
> > > +     * Unconditionally deselect AI_V4MAPPED option upon
> > > +     * getaddrinfo() failure, the next call to it will have to
> > > +     * do the error handling.
> > > +     */
> > > +    if (atomic_read(&useV4Mapped) =3D=3D -1) {
> > > +        rc =3D getaddrinfo(host, port, ai, &res);
> > > +        if (rc =3D=3D 0 && (ai->ai_flags & AI_V4MAPPED)) {
> > > +            atomic_set(&useV4Mapped, 1);
> > > +        } else {
> > > +            atomic_set(&useV4Mapped, 0);

This is treating every single failure of getaddrinfo as a sign to turn
off AI_V4MAPPED, which is really bad. I'm not a huge fan of doing the
extra getaddrinfo() call, even though it is protected behind the atomic
var. I'd prefer to just keep current style of checking the result after
the main call to getaddrinfo() - just extend that to the dgram case too.
A single 'static int useV4Mapped =3D 1' could still be used in the global
namespace though.

> > > +        }
> > > +    }
> > > +
> > > +    return useV4Mapped;
> > > +}
> > > +
> > >  static int create_fast_reuse_socket(struct addrinfo *e)
> > >  {
> > >      int slisten =3D qemu_socket(e->ai_family, e->ai_socktype,
> > > e->ai_protocol);
> > > @@ -378,14 +402,10 @@ static struct addrinfo
> > > *inet_parse_connect_saddr(InetSocketAddress *saddr,
> > >      struct addrinfo ai, *res;
> > >      int rc;
> > >      Error *err =3D NULL;
> > > -    static int useV4Mapped =3D 1;
> > >=20
> > >      memset(&ai, 0, sizeof(ai));
> > >=20
> > > -    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
> > > -    if (atomic_read(&useV4Mapped)) {
> > > -        ai.ai_flags |=3D AI_V4MAPPED;
> > > -    }
> > > +    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG | AI_V4MAPPED;
> > >      ai.ai_family =3D inet_ai_family_from_address(saddr, &err);
> > >      ai.ai_socktype =3D SOCK_STREAM;
> > >=20
> > > @@ -399,21 +419,11 @@ static struct addrinfo
> > > *inet_parse_connect_saddr(InetSocketAddress *saddr,
> > >          return NULL;
> > >      }
> > >=20
> > > -    /* lookup */
> > > -    rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res);
> > > -
> > > -    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
> > > -     * then don't implement it in their getaddrinfo(). Detect
> > > -     * this and retry without the flag since that's preferrable
> > > -     * to a fatal error
> > > -     */
> > > -    if (rc =3D=3D EAI_BADFLAGS &&
> > > -        (ai.ai_flags & AI_V4MAPPED)) {
> > > -        atomic_set(&useV4Mapped, 0);
> > > +    if ((check_ai_v4mapped(saddr->host, saddr->port, &ai, res)) =3D=
=3D 0) {
> > >          ai.ai_flags &=3D ~AI_V4MAPPED;
> > > -        rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res);
> > >      }
> > > -    if (rc !=3D 0) {
> > > +
> > > +    if ((rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res)) =
!=3D 0) {
> > >          error_setg(errp, "address resolution failed for %s:%s: %s"=
,
> > >                     saddr->host, saddr->port, gai_strerror(rc));
> > >          return NULL;
> > > @@ -469,7 +479,7 @@ static int inet_dgram_saddr(InetSocketAddress *=
sraddr,
> > >=20
> > >      /* lookup peer addr */
> > >      memset(&ai,0, sizeof(ai));
> > > -    ai.ai_flags =3D AI_CANONNAME | AI_V4MAPPED | AI_ADDRCONFIG;
> > > +    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG | AI_V4MAPPED;
> >=20
> > Gratuitous re-ordering of code with no functional change.
>=20
> Agree, can change it.
>=20
> >=20
> > >      ai.ai_family =3D inet_ai_family_from_address(sraddr, &err);
> > >      ai.ai_socktype =3D SOCK_DGRAM;
> > >=20
> > > @@ -488,6 +498,10 @@ static int inet_dgram_saddr(InetSocketAddress =
*sraddr,
> > >          goto err;
> > >      }
> > >=20
> > > +    if ((check_ai_v4mapped(addr, port, &ai, &peer)) =3D=3D 0) {
> > > +        ai.ai_flags &=3D ~AI_V4MAPPED;
> > > +    }
> > > +
> > >      if ((rc =3D getaddrinfo(addr, port, &ai, &peer)) !=3D 0) {
> > >          error_setg(errp, "address resolution failed for %s:%s: %s"=
, addr,
> > > port,
> > >                     gai_strerror(rc));

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
