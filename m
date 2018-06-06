Received: from eggs.gnu.org ([2001:4830:134:3::10]:60549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQdKb-0007CL-Iz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQdKa-0001pF-NF
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:38:49 -0400
References: <20180606183738.31688-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d5dacb26-c01c-2beb-229e-6f42ffb0faf1@redhat.com>
Date: Wed, 6 Jun 2018 20:38:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180606183738.31688-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4HKzUx0Efvgp0vSPG4hrXaqBdUISTDFah"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4HKzUx0Efvgp0vSPG4hrXaqBdUISTDFah
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <d5dacb26-c01c-2beb-229e-6f42ffb0faf1@redhat.com>
Subject: Re: [PATCH] iotests: Fix 219's timing
References: <20180606183738.31688-1-mreitz@redhat.com>
In-Reply-To: <20180606183738.31688-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 20:37, Max Reitz wrote:
> 219 has two issues that may lead to sporadic failure, both of which are=

> the result of issuing query-jobs too early after a job has been
> modified.  This can then lead to different results based on whether the=

> modification has taken effect already or not.
>=20
> First, query-jobs is issued right after the job has been created.
> Besides its current progress possibly being in any random state (which
> has already been taken care of), its total progress too is basically
> arbitrary, because the job may not yet have been able to determine it.
> This patch addresses this by just filtering the total progress, like
> what has been done for the current progress already.  However, for more=

> clarity, the filtering is changed to replace the values by a string
> 'FILTERED' instead of deleting them.
>=20
> Secondly, query-jobs is issued right after a job has been resumed.  The=

> job may or may not yet have had the time to actually perform any I/O,
> and thus its current progress may or may not have advanced.  To make
> sure it has indeed advanced (which is what the reference output already=

> assumes), insert a sleep of 100 ms before query-jobs is invoked.  With =
a
> slice time of 100 ms, a buffer size of 64 kB and a speed of 256 kB/s,
> this should be the right amount of time to let the job advance by
> exactly 64 kB.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Changed the query-jobs progress filtering [Eric]
> ---
>  tests/qemu-iotests/219     | 12 ++++++++----
>  tests/qemu-iotests/219.out | 10 +++++-----
>  2 files changed, 13 insertions(+), 9 deletions(-)

Oops, forgot the "v2" tag.  Forgive me.

Max


--4HKzUx0Efvgp0vSPG4hrXaqBdUISTDFah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYKi4ACgkQ9AfbAGHV
z0BqGwgAoa/Nr53Qa4uNwQgDpr7iWNXyZrBRdQoH/p3ByZNFmjlGnHZp3SeMAjhx
Bmt8ChQD1KbKf/A5uvRty3WLtpejfl6UZmhfDvKZ2tyjMoUtYfiBDHmYQQGi2hxn
Jh3ANu8JDB/MIDV3joUi1tCxFvNvnaYg59809m1asZO/iJeOWbaxy5eAuXPK5Ehf
NXwlEDKW+6SlQXzcLLl8BYcpbtrNuv6JsnnHjuRMZmE79ba9h7wUkfYY5mvER9hV
YrXpjeOIVPZrzfg5L9mNqk9e3od1kgq5cjN6V05CXLUvAuSJzTjFLUPVK3e6kEK8
sRANYL4jNLWB3sN6TemvPfpDpO81zQ==
=7m9x
-----END PGP SIGNATURE-----

--4HKzUx0Efvgp0vSPG4hrXaqBdUISTDFah--
