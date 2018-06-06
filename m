Received: from eggs.gnu.org ([2001:4830:134:3::10]:37051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQdjt-0003zD-9E
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQdjs-0006q2-8I
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:04:57 -0400
References: <20180606190407.6005-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff5c4268-1d26-3e3e-3189-85c4d8b7715b@redhat.com>
Date: Wed, 6 Jun 2018 21:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180606190407.6005-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y8vpT2VJ0npAJbT8168tfsyqdE0webiid"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Fix 219's timing
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
--y8vpT2VJ0npAJbT8168tfsyqdE0webiid
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <ff5c4268-1d26-3e3e-3189-85c4d8b7715b@redhat.com>
Subject: Re: [PATCH v3] iotests: Fix 219's timing
References: <20180606190407.6005-1-mreitz@redhat.com>
In-Reply-To: <20180606190407.6005-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 21:04, Max Reitz wrote:
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

> assumes), keep querying it until it has.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v3: Keep querying until the job has advanced instead of waiting for a
>     fixed amount of time [Peter in v2, Eric in v1]
> ---
>  tests/qemu-iotests/219     | 27 +++++++++++++++++++++------
>  tests/qemu-iotests/219.out | 10 +++++-----
>  2 files changed, 26 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
> index 898a26eef0..1a0329c6a0 100755
> --- a/tests/qemu-iotests/219
> +++ b/tests/qemu-iotests/219
> @@ -20,6 +20,7 @@
>  # Check using the job-* QMP commands with block jobs
> =20
>  import iotests
> +import time

Urgh, now of course we don't need this any more...  Will send a v4.

Max


--y8vpT2VJ0npAJbT8168tfsyqdE0webiid
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYMFAACgkQ9AfbAGHV
z0Ca7Af/QQpAq6a1USK1AFD/ixqhxaHy0Hu+6pANI4WcCbtjYMpEcz9McRKDfXdK
XsQWeLRP62nVuhrrWfeW78JVtKPFueSAo8rUqjpy9ws/abHc1Pe4rov6HVe/wSpC
RB1E/Vo49h2AjSblgeubR6f4dJHrf4IlyTsi9uGJX0Z9J8zep87DWgzoa1scZyed
gS20oxFENXVGK7qH6YZIYoPTe9igmAXyl2vblZf8iT1yyQwYomVxC9LlOhvg5aon
EitOF546xRbMppMGC/9BgE5m7SqnHS21/pWcIFtPIUWOhO8ui9DdNW9HeMuJB6Y2
sHKRR62QOnDF07vR+B0KoxLyIpKw1Q==
=dA/+
-----END PGP SIGNATURE-----

--y8vpT2VJ0npAJbT8168tfsyqdE0webiid--
