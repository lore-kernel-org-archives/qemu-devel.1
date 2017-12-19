Received: from eggs.gnu.org ([2001:4830:134:3::10]:48464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRFAI-00033h-Nt
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRFAD-0005XT-HP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:30:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRFAD-0005VA-7I
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:30:21 -0500
Date: Tue, 19 Dec 2017 10:30:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171219103011.GB32479@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219002105.Horde.McUB5OjQ4CcwjyzfFEIWM2V@www.quantumachine.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219002105.Horde.McUB5OjQ4CcwjyzfFEIWM2V@www.quantumachine.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sockets: Fix test for DragonFly BSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antonio Huete =?utf-8?Q?Jim=C3=A9nez?= <tuxillo@quantumachine.net>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com

On Tue, Dec 19, 2017 at 12:21:05AM +0000, Antonio Huete Jim=C3=A9nez wrot=
e:
> From f57cdc7ec2d5a5e906fa8b795eeede2d7b66aa56 Mon Sep 17 00:00:00 2001
> From: Antonio Huete Jimenez <tuxillo@quantumachine.net>
> Date: Fri, 15 Dec 2017 01:08:10 +0100
> Subject: [PATCH] sockets: Fix test for DragonFly BSD
>=20
> DragonFly BSD does not implement AI_V4MAPPED for its getaddrinfo() so
> probe and discard that flag instead of aborting the test.
>=20
> Test that fails:
>     ERROR:tests/test-char.c:448:char_udp_test_internal: 'chr' should no=
t be
> NULL
>=20
> Signed-off-by: Antonio Huete Jimenez <tuxillo@quantumachine.net>
> ---
>  util/qemu-sockets.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index af4f01211a..5a9c55c303 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -43,6 +43,8 @@
>  # define AI_NUMERICSERV 0
>  #endif
>=20
> +int useV4Mapped =3D 1;
> +
>=20
>  static int inet_getport(struct addrinfo *e)
>  {
> @@ -383,7 +385,6 @@ static struct addrinfo
> *inet_parse_connect_saddr(InetSocketAddress *saddr,
>      struct addrinfo ai, *res;
>      int rc;
>      Error *err =3D NULL;
> -    static int useV4Mapped =3D 1;
>=20
>      memset(&ai, 0, sizeof(ai));
>=20
> @@ -474,7 +475,11 @@ static int inet_dgram_saddr(InetSocketAddress *sra=
ddr,
>=20
>      /* lookup peer addr */
>      memset(&ai,0, sizeof(ai));
> -    ai.ai_flags =3D AI_CANONNAME | AI_V4MAPPED | AI_ADDRCONFIG;
> +    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
> +    if (atomic_read(&useV4Mapped)) {
> +        ai.ai_flags |=3D AI_V4MAPPED;
> +    }
> +
>      ai.ai_family =3D inet_ai_family_from_address(sraddr, &err);
>      ai.ai_socktype =3D SOCK_DGRAM;
>=20
> @@ -493,7 +498,21 @@ static int inet_dgram_saddr(InetSocketAddress *sra=
ddr,
>          goto err;
>      }
>=20
> -    if ((rc =3D getaddrinfo(addr, port, &ai, &peer)) !=3D 0) {
> +    /* lookup */
> +    rc =3D getaddrinfo(addr, port, &ai, &peer);
> +
> +    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
> +     * then don't implement it in their getaddrinfo(). Detect
> +     * this and retry without the flag since that's preferrable
> +     * to a fatal error
> +     */
> +    if (rc =3D=3D EAI_BADFLAGS &&
> +        (ai.ai_flags & AI_V4MAPPED)) {
> +        atomic_set(&useV4Mapped, 0);
> +        ai.ai_flags &=3D ~AI_V4MAPPED;
> +        rc =3D getaddrinfo(addr, port, &ai, &peer);
> +    }

Rather than duplicating this repeated calls to getaddrinfo in multiple
methods, I think it would be better to define a wrapper method. ie
create a  'qemu_getaddrinfo()' method in this file that does the magic
re-try without AI_V4MAPPED. Export it in include/qemu/sockets.h too.

Then call that from all places in QEMU that currently use getaddrinfo()
directly - there are 5 in this file, another in io/dns-resolver.c,
and some more in net/ & test/. That way we are't going to mistakely
reintroduce the bug in other places later.

We should probably also move the #ifdef AI_*   code into qemu/sockets.h
too, so we can remove the duplication in test suites.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
