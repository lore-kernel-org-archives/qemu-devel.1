Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZv8-0003Xd-Dq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjZv7-0001lr-63
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:14:02 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea96afbe-4379-3e17-c0b6-6b615c170a2e@redhat.com>
Date: Thu, 2 Mar 2017 17:13:52 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E8bgd00ohhGOtbOg2vENnB9qeLRDTh4w4"
Subject: Re: [Qemu-devel] [PATCH 02/15] sheepdog: Fix error handling in
 sd_snapshot_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8bgd00ohhGOtbOg2vENnB9qeLRDTh4w4
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <ea96afbe-4379-3e17-c0b6-6b615c170a2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] sheepdog: Fix error handling in
 sd_snapshot_delete()
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> As a bdrv_snapshot_delete() method, sd_snapshot_delete() must set an
> error and return negative errno on failure.  It sometimes returns -1,
> and sometimes neglects to set an error.  It also prints error messages
> with error_report().  Fix all that.
>=20
> Moreover, its handling of an attempt to delete an nonexistent snapshot
> is wrong: it error_report()s and succeeds.  Fix it to set an error and
> return -ENOENT instead.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>=20

> @@ -2447,15 +2444,14 @@ static bool remove_objects(BDRVSheepdogState *s=
)
>                                      data_vdi_id[start_idx]),
>                             false, s->cache_flags);
>          if (ret < 0) {
> -            error_report("failed to discard snapshot inode.");
> -            result =3D false;
> +            error_setg(errp, "failed to discard snapshot inode.");

Lose the trailing '.'

With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--E8bgd00ohhGOtbOg2vENnB9qeLRDTh4w4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKcwAAoJEKeha0olJ0NqRBUH/1fBed21WxhCdQ80f24F8JBm
0dLt0HCUu78ky2Xffmb9zknrPUDMe14AbisU3wEvsASgk0Dc2TwGSP0kLcK4jejK
tdusv4EHH35w/DXNg+LQzznHSQr0HcHfCVhTF7bLG1FtGxmDRuMG0FIXK3ygYPjY
Q3NRH2udRevuiybcWbQJRWyyRcO7TBCE6udE+O7zNPvOTanWYbOxxvCXZgJ4LUzo
/bGEpDn98M/ShIDNBJi9aHUBE8QCU0CpjismE1IH4w2eLLHfimc7nvd1KGzGv0jY
iy/dohc8fRWaSRvQx+viZPLZq0nQM8B+YK7AFjTu93wZYw03/mI75JW1mZfGBaY=
=WxDh
-----END PGP SIGNATURE-----

--E8bgd00ohhGOtbOg2vENnB9qeLRDTh4w4--
