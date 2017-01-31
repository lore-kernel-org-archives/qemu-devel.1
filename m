Received: from eggs.gnu.org ([2001:4830:134:3::10]:54326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYZxt-0005T7-EH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYZxp-0006Ib-AG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYZxp-0006IP-00
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:21 -0500
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
Date: Tue, 31 Jan 2017 09:03:10 -0600
MIME-Version: 1.0
In-Reply-To: <1485873796-15095-1-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LgRfrICQWRE6ldvp4RNtRKoa5OAlBxwVN"
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LgRfrICQWRE6ldvp4RNtRKoa5OAlBxwVN
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
Subject: Re: [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
In-Reply-To: <1485873796-15095-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 08:43 AM, Michael S. Tsirkin wrote:
> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
> if the C file including that header happens to have
> QEMU_BUILD_BUG_ON at the same line number.
>=20
> Fix using a widely available extension: __COUNTER__.

gcc 4.3 and later; clang documents it but doesn't say when it was added.

> If unavailable, provide a stub.

What fails in our build farm if we don't provide the stub? Can we just
require that our compiler is new enough to have __COUNTER__, or will
that break some of our existing targets?

>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index e0fb18b..bad25a9 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -89,8 +89,12 @@
>      struct { \
>          int:(x) ? -1 : 1; \
>      }
> +#ifdef __COUNTER__

Better would be:

#if defined __COUNTER__ && __COUNTER__ !=3D __COUNTER__

to ensure that it has the semantics we need (that's what gnulib's
LGPLv2+ verify.h uses).

>  #define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
> -    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
> +    glue(qemu_build_bug_on__, __COUNTER__) __attribute__((unused))

But I agree that this is the right change to make.

> +#else
> +#define QEMU_BUILD_BUG_ON(x)

This means we lose sanity checks on older compilers.  Gnulib documents
that on older compilers, you can use:

extern int (*dummy (void)) [sizeof (struct {...})];

coupled with -Wno-redundant-decls, which lets you redeclare the same
thing as many times as you want without any use of __LINE__ or
__COUNTER__.  On the other hand, I don't think we have to bend over
backwards for compilers that old (RHEL 6 is at gcc 4.4.7, but 4.3 has
__COUNTER__).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LgRfrICQWRE6ldvp4RNtRKoa5OAlBxwVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkKcvAAoJEKeha0olJ0Nqp4cH/37+IpgN0iSotwKPJllB4bds
KWsQkM1LXb30115JOSzuUHFgMIVTjAzZGvQXDoNy6fiFBOLXJTc7jptWyxcu0NZ3
ec/BnYu2CpZtGFrDXuFVi4IXuZAOcL84HTcITBLqX5avBfGjx/XLh1ljrymQImnt
Y1E/IoB2wrX1JhaVgBMEeQTjFczzMSso65EEp9YD9ZslZk5Obn4bQia/1Uj6ZW7R
3X55xe5Qt4ShqgdWfeOF9ActQoJjPzq/lH628vLxOLi4rufFKLEmjTvbcULVEfnB
J4VRCEWVozna/3YtGXwL9IYzdhSQr2YOeXL/tHZk3zyrZBuEPhdSG7YxyPOPvU4=
=oLHp
-----END PGP SIGNATURE-----

--LgRfrICQWRE6ldvp4RNtRKoa5OAlBxwVN--
