Received: from eggs.gnu.org ([2001:4830:134:3::10]:59755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f12B2-0005pG-Th
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f12B1-00029a-SJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:55:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f12B1-00025D-5k
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:55:07 -0400
Date: Wed, 28 Mar 2018 13:37:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180328023713.GH3510@umbus.fritz.box>
References: <20180327164141.19075-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4C6bbPZ6c/S1npyF"
Content-Disposition: inline
In-Reply-To: <20180327164141.19075-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, danielhb@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, dgibson@redhat.com


--4C6bbPZ6c/S1npyF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 12:41:41AM +0800, Fam Zheng wrote:
> Some backends report big max_io_sectors. Making min_io_size the same
> value in this case will make it impossible for guest to align memory,
> therefore the disk may not be usable at all.
>=20
> Do not enlarge them when they are zero.
>=20
> Reported-by: David Gibson <dgibson@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Tested-by: David Gibson <david@gibson.dropbear.id.au>

With this patch applied, I was able to successfully install a ppc64le
guest again.

>=20
> ---
>=20
> v2: Leave the values alone if zero. [Paolo]
>     At least we can consult block layer for a slightly more sensible
>     opt_io_size, but that's for another patch.
> ---
>  hw/scsi/scsi-disk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index f5ab767ab5..f8ed8cf2b4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -714,10 +714,12 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *r=
eq, uint8_t *outbuf)
> =20
>                  /* min_io_size and opt_io_size can't be greater than
>                   * max_io_sectors */
> -                min_io_size =3D
> -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> -                opt_io_size =3D
> -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> +                if (min_io_size) {
> +                    min_io_size =3D MIN(min_io_size, max_io_sectors);
> +                }
> +                if (opt_io_size) {
> +                    opt_io_size =3D MIN(opt_io_size, max_io_sectors);
> +                }
>              }
>              /* required VPD size with unmap support */
>              buflen =3D 0x40;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4C6bbPZ6c/S1npyF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq6/9gACgkQbDjKyiDZ
s5LlvRAAsf/ehvM59Il4yswp+8J+v0n0zIb3zrUrJyDTW+2c8+LXPR0XUrHGuv57
cN8lS2jrtg+RmJFBJzvGoQzXstbrSG+O+E1YoSze64TB1ork8c6ANfcXo9Ohj20x
XMRqOqNjst7udzHcblZss5BpBr2p78ZK9xsDd3rjZwVsbYoAC6DngARmi988UJZl
FkHRCSMP+QXN4Bg1ACjtSD9zcWha3pBw4GZnyv01gvvwiHnkc26Vr5WBoqL2ZRjp
WlDtgAYl1g8oE6bXCbI2J/dM1d5JRg4Vd11nAx4ADtI8lSHugCnqEBK5SBUB+jNJ
3iRH5op1MN5poKwcAXtzsPbaRhRniS+UynJovDoam5VTTZH/FZ/755xhdP+0aGbw
lR1Kf84iKcarIjj8CaVm+UJnICIY+/qiyBBIh1v8UamPKI+BjG+Uuw2sj3wm5zy+
0rGJ6AHNya8hs8Nb6RRwVfEY3axPKdmxx9xpak9Xxgq+wMvNA7bvnqerOLlJIka6
MIsF4Y5NrQop4YhCBDxNn33aRZCRXQ+ZuCJjVVwfT3CU7wwOBsEtkDXTxSiLu76e
Q7UeyZffELij+Z6yG3TsEDXUoQenNvLf6dmOFJ4jfAgim8umsGjzT15LRtxbg/o5
iyWbpqTM66+6mUDB95f43QncPpUKA5aLwis2yocdgZmQr8FzSL0=
=dnm5
-----END PGP SIGNATURE-----

--4C6bbPZ6c/S1npyF--
