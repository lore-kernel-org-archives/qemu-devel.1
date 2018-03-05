Received: from eggs.gnu.org ([2001:4830:134:3::10]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essbz-0003t3-OV
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essbt-0004vq-Ux
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:05:15 -0500
References: <20180305155926.25858-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ca82253e-0a7b-067b-59f5-e365d9b835f0@redhat.com>
Date: Mon, 5 Mar 2018 17:04:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180305155926.25858-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1iOqhsxqttqjqyo1UTvzD8o2u8yhOvRDi"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: fix 203 migration completion
 race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1iOqhsxqttqjqyo1UTvzD8o2u8yhOvRDi
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ca82253e-0a7b-067b-59f5-e365d9b835f0@redhat.com>
Subject: Re: [PATCH] qemu-iotests: fix 203 migration completion race
References: <20180305155926.25858-1-stefanha@redhat.com>
In-Reply-To: <20180305155926.25858-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-05 16:59, Stefan Hajnoczi wrote:
> There is a race between the test's 'query-migrate' QMP command after th=
e
> QMP 'STOP' event and completing the migration:
>=20
> The test case invokes 'query-migrate' upon receiving 'STOP'.  At this
> point the migration thread may still be in the process of completing.
> Therefore 'query-migrate' can return 'status': 'active' for a brief
> window of time instead of 'status': 'completed'.  This results in
> qemu-iotests 203 hanging.
>=20
> Solve the race by enabling the 'events' migration capability, which
> causes QEMU to emit migration-specific QMP events that do not suffer
> from this race condition.  Wait for the QMP 'MIGRATION' event with
> 'status': 'completed'.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/203     | 15 +++++++++++----
>  tests/qemu-iotests/203.out |  5 +++++
>  2 files changed, 16 insertions(+), 4 deletions(-)

So much for "the ppoll() dungeon"...

Thanks!

Reviewed-by: Max Reitz <mreitz@redhat.com>


--1iOqhsxqttqjqyo1UTvzD8o2u8yhOvRDi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqdaqQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvOwH/RwhQ4iVEYR5JwzixJfjg1nHWZ95nDgl
LOhsjt7hpuUrMtglK4P6mcAMPRkPPjswmAhAehzdDGlgZrMHSaXXcW6pulhWJfu1
ZJTR/VlsFtjqmLUXcKcXI1j+P1lNhnhFnOh7K/6ld0tc9Qw1Z6lzI3MRAn8wqsZc
j9776PX0tzM0TFX8bTlG4HvzMx0n/yJziNAfRNR6KhpxPgV0swvO+9ZaNikQ4Olz
yb/r/+ApWXMhoLs16yhMuAZ2J7bJEvwPsRNahluBgYCeyT/C+iJKWtxLtzWI8XC2
A1IGr0f/8B4UNm9i/iJmVjXpdYNiy5A7z24f46M0PU+02yLlQogNB/o=
=viGT
-----END PGP SIGNATURE-----

--1iOqhsxqttqjqyo1UTvzD8o2u8yhOvRDi--
