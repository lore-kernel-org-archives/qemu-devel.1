Received: from eggs.gnu.org ([209.51.188.92]:59769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXRa-00065D-MN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXRZ-0007Vk-LY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hLXRZ-0007UP-D9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:25:29 -0400
References: <20190430181257.1265-1-driver1998@foxmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2f0fc78-f9ca-ae2c-d800-9b25d220b7dd@redhat.com>
Date: Tue, 30 Apr 2019 13:25:26 -0500
MIME-Version: 1.0
In-Reply-To: <20190430181257.1265-1-driver1998@foxmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warning
 in commands-win32.c, hit by clang.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv
From: Eric Blake <eblake@redhat.com>
To: Cao Jiaxi <driver1998@foxmail.com>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <b2f0fc78-f9ca-ae2c-d800-9b25d220b7dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warning
 in commands-win32.c, hit by clang.
References: <20190430181257.1265-1-driver1998@foxmail.com>
In-Reply-To: <20190430181257.1265-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 1:12 PM, Cao Jiaxi wrote:
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  qga/commands-win32.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

Can you paste the actual warning message you were getting?

>=20
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d40d61f605..4cdd2950bf 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -458,23 +458,24 @@ void qmp_guest_file_flush(int64_t handle, Error *=
*errp)
>  #ifdef CONFIG_QGA_NTDDSCSI
> =20
>  static STORAGE_BUS_TYPE win2qemu[] =3D {
> -    [BusTypeUnknown] =3D GUEST_DISK_BUS_TYPE_UNKNOWN,

> +    [BusTypeUnknown] =3D (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_UNKNOWN=
,

This adds lots of explicit casts. Are they actually necessary? Without
seeing the actual warning, it seems fishy to have to be this explicit.


> @@ -483,7 +484,7 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_T=
YPE bus)
>      if (bus >=3D ARRAY_SIZE(win2qemu) || (int)bus < 0) {
>          return GUEST_DISK_BUS_TYPE_UNKNOWN;
>      }
> -    return win2qemu[(int)bus];
> +    return (GuestDiskBusType)win2qemu[(int)bus];

Or is it complaining that GuestDiskBusType and STORAGE_BUS_TYPE are
distinct types, and that we are indeed cross-assigning between the two
enums because we intentionally want them to share values?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIkxYACgkQp6FrSiUn
Q2qvSQf/c0U5e7lgfwgoomKqIePk/5fdFoELN2yvvCIe5TWnwJCp7X1oqlPwxNUg
WAmgVNaPFL84K7tM7kqSFszfKoc/nLPbzLu/2WD/+5cGdBorP3Sgz140j9fxAlEI
CpSo8sIilCy1sw710fGheBs0evc3t4bfNNgvL5VeUj8D1Ji94fxQuhC0MpKO4agT
VGjqM2qMIX3bhnXoZ4cOn2jzQ3IHDqjo0hUYntTjZc65Qo0MESmEAOqS7cfhclfm
KP2cRf8Ss3wDct6H2DFyuWLQP1UV/LGqB6FfVJi82jjZibeQ1wghzlcIKElUt/cl
EtuF33767f4goDBl5wdQFRSFPE0x1g==
=IgVz
-----END PGP SIGNATURE-----

--4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv--
