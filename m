Received: from eggs.gnu.org ([2001:4830:134:3::10]:39230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWU4y-0001kB-5T
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWU4t-0003Dz-Vl
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWU4t-0003DL-Ly
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:26:31 -0500
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131650eucas1p183c745b845ded5e02e842582bb44fd7b@eucas1p1.samsung.com>
	<1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64a69d83-c575-5bd2-66f4-5b88172418a2@redhat.com>
Date: Tue, 2 Jan 2018 15:26:19 -0600
MIME-Version: 1.0
In-Reply-To: <1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4pfvnRjDXp2cgMTuZNpI86PhXwfUlL6Du"
Subject: Re: [Qemu-devel] [PATCH v12 6/6] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4pfvnRjDXp2cgMTuZNpI86PhXwfUlL6Du
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com, i.maximets@samsung.com
Message-ID: <64a69d83-c575-5bd2-66f4-5b88172418a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 6/6] migration: add postcopy total
 blocktime into query-migrate
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
 <CGME20171030131650eucas1p183c745b845ded5e02e842582bb44fd7b@eucas1p1.samsung.com>
 <1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
> Postcopy total blocktime is available on destination side only.
> But query-migrate was possible only for source. This patch
> adds ability to call query-migrate on destination.
> To be able to see postcopy blocktime, need to request postcopy-blocktim=
e
> capability.

Why not display the stats unconditionally when they are available,
instead of having to set a capability knob to request them?

>=20
> The query-migrate command will show following sample result:
> {"return":
>     "postcopy-vcpu-blocktime": [115, 100],
>     "status": "completed",
>     "postcopy-blocktime": 100
> }}
>=20
> postcopy_vcpu_blocktime contains list, where the first item is the firs=
t
> vCPU in QEMU.
>=20
> This patch has a drawback, it combines states of incoming and
> outgoing migration. Ongoing migration state will overwrite incoming
> state. Looks like better to separate query-migrate for incoming and
> outgoing migration or add parameter to indicate type of migration.
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---

> +++ b/qapi/migration.json
> @@ -156,6 +156,13 @@
>  #              @status is 'failed'. Clients should not attempt to pars=
e the
>  #              error strings. (Since 2.7)
>  #
> +# @postcopy-blocktime: total time when all vCPU were blocked during po=
stcopy
> +#           live migration (Since 2.11)

2.12 now.

Should this mention the capability knob needed to enable this stat (or
else get rid of the capability knob and always expose this when possible)=
?

> +#
> +# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (S=
ince 2.11)

Also 2.12.

> +#
> +
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -167,7 +174,9 @@
>             '*downtime': 'int',
>             '*setup-time': 'int',
>             '*cpu-throttle-percentage': 'int',
> -           '*error-desc': 'str'} }
> +           '*error-desc': 'str',
> +           '*postcopy-blocktime' : 'int64',
> +           '*postcopy-vcpu-blocktime': ['int64']} }
> =20
>  ##
>  # @query-migrate:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4pfvnRjDXp2cgMTuZNpI86PhXwfUlL6Du
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL+PsACgkQp6FrSiUn
Q2rDAAf+JB72nqgwPXS4lCOJUdf0WJERvT0DcXruI2bx19mcqDoOFlQ4RpvUtvA8
H+tIaDFrZW9J2VXBujarmFhdTXzMa9mPqdwRf2vzmCUb3Gw0FPhZl6VrjHbF3cdK
OhooIii8Cj7L9kpZQ9HXQLk+wAzJdKJmH5/Yq6h1QLCuUmeZXlsYYseYiovQFUUO
NJM0AKwuZ4om/E6Z+fX8bjwyWf3/8SnaL4a/M6EIZ5VYVCkF0UCDZXFGbYcFYhmw
ty/nMVDyFksWPhnER5sNRThv5eSB9Ub/OtBuLiimPVaquE3BNSx/JGWOf1FL/C/j
oDfq2O6ai7+XvSvjaRcS4ingRVUZIQ==
=T39G
-----END PGP SIGNATURE-----

--4pfvnRjDXp2cgMTuZNpI86PhXwfUlL6Du--
