Received: from eggs.gnu.org ([2001:4830:134:3::10]:33354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebBE1-0007pi-1a
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebBDw-0006Fk-99
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:19:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ebBDv-0006Et-VN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 15:19:16 -0500
References: <20180115115309.23982-1-quintela@redhat.com>
	<20180115115309.23982-10-quintela@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <215cfa8f-1f2d-1155-bd0b-17ecd10c4c61@redhat.com>
Date: Mon, 15 Jan 2018 21:19:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180115115309.23982-10-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OzDCvEBQZJ0zY1m5DfPerm33csZKtqVbs"
Subject: Re: [Qemu-devel] [PULL 09/27] migration: calculate vCPU blocktime
 on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OzDCvEBQZJ0zY1m5DfPerm33csZKtqVbs
From: Max Reitz <mreitz@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>
Message-ID: <215cfa8f-1f2d-1155-bd0b-17ecd10c4c61@redhat.com>
Subject: Re: [Qemu-devel] [PULL 09/27] migration: calculate vCPU blocktime on
 dst side
References: <20180115115309.23982-1-quintela@redhat.com>
 <20180115115309.23982-10-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-10-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-15 12:52, Juan Quintela wrote:
> From: Alexey Perevalov <a.perevalov@samsung.com>
>=20
> This patch provides blocktime calculation per vCPU,
> as a summary and as a overlapped value for all vCPUs.
>=20
> This approach was suggested by Peter Xu, as an improvements of
> previous approch where QEMU kept tree with faulted page address and cpu=
s bitmask
> in it. Now QEMU is keeping array with faulted page address as value and=
 vCPU
> as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps=

> list for blocktime per vCPU (could be traced with page_fault_addr)
>=20
> Blocktime will not calculated if postcopy_blocktime field of
> MigrationIncomingState wasn't initialized.
>=20
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/postcopy-ram.c | 143 +++++++++++++++++++++++++++++++++++++++=
+++++++-
>  migration/trace-events   |   5 +-
>  2 files changed, 146 insertions(+), 2 deletions(-)

For me, this breaks compilation with clang -m32:

  LINK    x86_64-softmmu/qemu-system-x86_64
=2E./migration/postcopy-ram.o: In function `mark_postcopy_blocktime_begin=
':
/home/maxx/projects/qemu/migration/postcopy-ram.c:599: undefined
reference to `__atomic_exchange_8'
/home/maxx/projects/qemu/migration/postcopy-ram.c:600: undefined
reference to `__atomic_exchange_8'
/home/maxx/projects/qemu/migration/postcopy-ram.c:609: undefined
reference to `__atomic_exchange_8'
=2E./migration/postcopy-ram.o: In function `mark_postcopy_blocktime_end':=

/home/maxx/projects/qemu/migration/postcopy-ram.c:665: undefined
reference to `__atomic_fetch_add_8'
/home/maxx/projects/qemu/migration/postcopy-ram.c:686: undefined
reference to `__atomic_fetch_add_8'

Am I doing something wrong?

Max


--OzDCvEBQZJ0zY1m5DfPerm33csZKtqVbs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpdDL4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjcIH+gKgs7JMyTyBJeNgIWonXdUMLVcJbnkF
RACIICQb0Fx3b3iI1iwb90SeQcpCCJajwn9GEfhseVmZz1rlE5XC26l+he3Y8tq7
yE0nt+269arwjzxqa+haajMKwYNbV0PEXQLC66XqDJT/9kC1/HB6dnJYnSk76pRN
WRShPbWoAgBnWraPX8eYwZpUBBCEbIshdpKuwvEcv1SlslWR6QaRKo7akGYxIpN/
NHzRj5TYk0XWZDCaWMN1CiI8kZCvBhv4hLKzbll2TsOGGsVRBwuQzd5BfhoFJEqU
JmS0Y/LkGmrXP8+NqhzSrnSixGhErx7P2sa+fUxa+Lnd33bfjQDJiAI=
=5kcH
-----END PGP SIGNATURE-----

--OzDCvEBQZJ0zY1m5DfPerm33csZKtqVbs--
