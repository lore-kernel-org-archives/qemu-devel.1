Received: from eggs.gnu.org ([2001:4830:134:3::10]:53494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJS0c-0000EU-Q2
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 18:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJS0b-0008Bl-Q3
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 18:40:46 -0500
References: <20181019113424.25727-1-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d370d182-01c8-f4ab-ed63-207a9dc4c4d6@redhat.com>
Date: Mon, 5 Nov 2018 00:40:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181019113424.25727-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="89E3jVpF678JxOnCaKX6VlcFbReT4ibTP"
Subject: Re: [Qemu-devel] [PATCH] block: Make more block drivers
 compile-time configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jeff@codyprime.org, kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--89E3jVpF678JxOnCaKX6VlcFbReT4ibTP
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jeff@codyprime.org, kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <d370d182-01c8-f4ab-ed63-207a9dc4c4d6@redhat.com>
Subject: Re: [PATCH] block: Make more block drivers compile-time configurable
References: <20181019113424.25727-1-armbru@redhat.com>
In-Reply-To: <20181019113424.25727-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.18 13:34, Markus Armbruster wrote:
> From: Jeff Cody <jcody@redhat.com>
>=20
> This adds configure options to control the following block drivers:
>=20
> * Bochs
> * Cloop
> * Dmg
> * Qcow (V1)
> * Vdi
> * Vvfat
> * qed
> * parallels
> * sheepdog
>=20
> Each of these defaults to being enabled.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>=20
> Hmm, we got quite a few --enable-BLOCK-DRIVER now.  Perhaps a single
> list-valued option similar --target-list would be better.  Could be
> done on top.
>=20
>  block/Makefile.objs | 22 ++++++++---
>  configure           | 91 +++++++++++++++++++++++++++++++++++++++++++++=

>  2 files changed, 107 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index c8337bf186..1cad9fc4f1 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs

[...]

> @@ -45,7 +54,8 @@ gluster.o-libs     :=3D $(GLUSTERFS_LIBS)
>  vxhs.o-libs        :=3D $(VXHS_LIBS)
>  ssh.o-cflags       :=3D $(LIBSSH2_CFLAGS)
>  ssh.o-libs         :=3D $(LIBSSH2_LIBS)
> -block-obj-$(if $(CONFIG_BZIP2),m,n) +=3D dmg-bz2.o
> +block-obj-dmg-bz2$(if $(CONFIG_BZIP2),m,n) +=3D dmg-bz2.o
> +block-obj-$(CONFIG_DMG) +=3D $(block-obj-dmg-bz2-y)

This defines "block-obj-dmg-bz2m" or "block-obj-dmg-bz2n", so
"block-obj-dmg-bz2-y" is never defined (note both the missing hyphen and
the "m" vs. "y").

How about:

block-obj-dmg-bz2-$(CONFIG_BZIP2) +=3D dmg-bz2.o
block-obj-$(if $(CONFIG_DMG),m,n) +=3D $(block-obj-dmg-bz2-y)

Bonus point: The "+=3D" are naturally aligned!

(Fun fact on the side: I tried downloading some dmg image, but qemu
refused to open that.  ("sector count 409600 for chunk 4 is larger than
max (131072)" -- yeah, yeah, I know that I'm not the largest guy) -- but
you can test it just by replacing "dmg-bz2.o" by "does-not-exist.o", and
then make complains normally, but stops complaining with --disable-dmg
or --disable-bzip2.)

Max

>  dmg-bz2.o-libs     :=3D $(BZIP2_LIBS)
>  qcow.o-libs        :=3D -lz
>  linux-aio.o-libs   :=3D -laio


--89E3jVpF678JxOnCaKX6VlcFbReT4ibTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvfg2QACgkQ9AfbAGHV
z0CE7Qf/cWL4QBo7BocvbUSpM4MmAR00opyit6O9redTShm0vYfqE8QBNX6dy4Ii
nL87W0f0D6ysftqHmd0c1MUBLB60HE3LRtwwH3523aYo7z+mUcIlDiXp6n3JO49y
0YA5MMEYh8GpiYesOoPb/WOAJj6uQb8BTuqew5VizwFQxt5zzji5AjYW3kXazRji
/dAWUPwT8KkhwoMC3I+mUOUjUf7exbGHMdAzEK7BHrxlgnpo+odgVnElYTHp3Bqt
HrTVF4zUQCB7qUuQDV2P6M1OzcKVsyLMZWL5BDNwR0gzkD6uoT1pl/MuDRxfADIC
zQphEsOOTP6JcrZyMoYvW5M9nrQWCw==
=JSFK
-----END PGP SIGNATURE-----

--89E3jVpF678JxOnCaKX6VlcFbReT4ibTP--
