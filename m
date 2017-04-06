Received: from eggs.gnu.org ([2001:4830:134:3::10]:36050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw93z-0002pH-Cj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw93y-0006Wc-Cx
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:11:07 -0400
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-5-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8187ae38-68b0-15a3-23ea-6be56c083a80@redhat.com>
Date: Thu, 6 Apr 2017 10:10:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170406142527.25835-5-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dduAXajnwxSObVj2GO7V0h1MoHxmQ77ea"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dduAXajnwxSObVj2GO7V0h1MoHxmQ77ea
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8187ae38-68b0-15a3-23ea-6be56c083a80@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] block: Drain BH in
 bdrv_drained_begin
References: <20170406142527.25835-1-famz@redhat.com>
 <20170406142527.25835-5-famz@redhat.com>
In-Reply-To: <20170406142527.25835-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 09:25 AM, Fam Zheng wrote:
> During block job completion, nothing is preventing
> block_job_defer_to_main_loop_bh from being called in a nested
> aio_poll(), which is a trouble, such as in this code path:
>=20
>     qmp_block_commit
>       commit_active_start
>         bdrv_reopen
>           bdrv_reopen_multiple
>             bdrv_reopen_prepare
>               bdrv_flush
>                 aio_poll
>                   aio_bh_poll
>                     aio_bh_call
>                       block_job_defer_to_main_loop_bh
>                         stream_complete
>                           bdrv_reopen
>=20
> block_job_defer_to_main_loop_bh is the last step of the stream job,
> which should have been "paused" by the bdrv_drained_begin/end in
> bdrv_reopen_multiple, but it is not done because it's in the form of a
> main loop BH.
>=20
> Similar to why block jobs should be paused between drained_begin and
> drained_end, BHs they schedule must be excluded as well.  To achieve
> this, this patch forces draining the BH before leaving bdrv_drained_beg=
in().
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20

Nice writeup.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dduAXajnwxSObVj2GO7V0h1MoHxmQ77ea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5lp8AAoJEKeha0olJ0NqQXUH/0EYrqWfRhId7jddUXfhlVrL
YhFb2buuAl3kHy6gpURdVSu1ieE4oYilQpoQhoZBP3NO8MeYPLEGC/QIC5i/i8Cn
DKyHAK2guDl37QpVA1uMnzhlT/jsSCK5sx2l26GUEQJV5+cLWEpZ02pRsGic57UX
nKzACBRzgYP9A4919fyY6iOOJPm6/Dc7bzWXwscGbgkvQ/xY0KyI54Jcuqmn42p+
J2mBmHQpNueuNUi9WiJfmmyn45AGO5M4KEFmUffDEouTZf3PUx3XG3dLJ7NoLJD8
CO6Nw38z//yk71nsZA8zPag+GoyLVnXh2dc37G7dbUO97dCdQTfikqis3waz+Q8=
=PbNZ
-----END PGP SIGNATURE-----

--dduAXajnwxSObVj2GO7V0h1MoHxmQ77ea--
