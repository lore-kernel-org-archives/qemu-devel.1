Received: from eggs.gnu.org ([2001:4830:134:3::10]:33114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ePj9G-0006TG-VE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ePj9D-0005Ai-3T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:07:06 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ePj9C-00058n-V1
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:07:03 -0500
Received: by mail-it0-x243.google.com with SMTP id m11so28216345iti.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 22:07:02 -0800 (PST)
References: <20171212051619.24456-1-aik@ozlabs.ru>
	<20171215060126.GG7753@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d9039c99-aa83-5d2f-dd12-5b52a7cf8fc0@ozlabs.ru>
Date: Fri, 15 Dec 2017 17:06:55 +1100
MIME-Version: 1.0
In-Reply-To: <20171215060126.GG7753@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PP2osckN1DWBMieX6UENGQtS61gpqNVFj"
Subject: Re: [Qemu-devel] [PATCH qemu v2] vfio/spapr: Allow fallback to
 SPAPR TCE IOMMU v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PP2osckN1DWBMieX6UENGQtS61gpqNVFj
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <d9039c99-aa83-5d2f-dd12-5b52a7cf8fc0@ozlabs.ru>
Subject: Re: [PATCH qemu v2] vfio/spapr: Allow fallback to SPAPR TCE IOMMU v1
References: <20171212051619.24456-1-aik@ozlabs.ru>
 <20171215060126.GG7753@umbus.fritz.box>
In-Reply-To: <20171215060126.GG7753@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/12/17 17:01, David Gibson wrote:
> On Tue, Dec 12, 2017 at 04:16:19PM +1100, Alexey Kardashevskiy wrote:
>> The vfio_iommu_spapr_tce driver advertises kernel's support for
>> v1 and v2 IOMMU support, however it is not always possible to use
>> the requested IOMMU type. For example, a pseries host platform does no=
t
>> support dynamic DMA windows so v2 cannot initialize and QEMU fails to
>> start.
>>
>> This adds a fallback to the v1 IOMMU if v2 cannot be used.
>>
>> Fixes: 318f67ce1371 "vfio: spapr: Add DMA memory preregistering (SPAPR=
 IOMMU v2)"
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Alex, will you take this through your tree, or should I take it
> through mine?


It is already in upstream.

>=20
>> ---
>> Changes:
>> v2:
>> * updated commit log
>>
>> ---
>>  hw/vfio/common.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7b2924c..cd81cc9 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1040,6 +1040,11 @@ static int vfio_connect_container(VFIOGroup *gr=
oup, AddressSpace *as,
>>              v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
>>          ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
>>          if (ret) {
>> +            container->iommu_type =3D VFIO_SPAPR_TCE_IOMMU;
>> +            v2 =3D false;
>> +            ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);=

>> +        }
>> +        if (ret) {
>>              error_setg_errno(errp, errno, "failed to set iommu for co=
ntainer");
>>              ret =3D -errno;
>>              goto free_container_exit;
>=20


--=20
Alexey


--PP2osckN1DWBMieX6UENGQtS61gpqNVFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlozZn8OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILkZbQ/+Pvp8ZG5C97xTFMzc5jsnJ3pl/bX4pC9xAVKV
9529V+MWdmyjeuJKkOJQyIQnko30L9TeIW1w3P6f2vSDmr5APHxNcZHXLiPzK+/y
+SObnfF+xMG/BsInV0yJGmcnh5q8iZ1OZgYlMyPv1764Uy/bgJ61tij5asYI+YYX
dBz5NZwcC+aH5lYU5tN6GD66jCMh8QSVgiMg8Sq42xwT+fBnBVNPcFEEcmYXPQ5Y
w6ENYfLScHCZVH+hBEIpM6UymSR671HcaVVcfBgKvnBM7SeF9Mr3KjZjMjAuF/ZQ
kzALggHtKLokoGIIq0/PbDaJtNaP0WhACurdj5vWYRXjtYpIXuMHnzQoHpRwqpkr
l3rA+5gqme4r4MdR9+/jxfZT493F28yRQY7bDhF7PCdVBC1whqJlDq/2pnrBg3VK
GEX0lzTv5pZY8pCHEsKGVVjOiy//rsHCxBKXrfuXN7Y73SMf1fll0VcDWFYVWfT7
A1fLHwMUBIv+l9PPBdrktw6Yu3ZQhhEhWB3WagdISG90TqV+fX2KPIRUBkAzSGZj
8d1LY3+yu3Ndpu8HhbyKT+p1VrLVSi3LGSrI0llNV49w4mUDqPp9GysxP/xvHrUb
5pvGFyUI3K5KJcWGUJrzyBPI+68QYoPWW9zcJi5y+/45bKDJzXqUNfa4FXDLf3wa
iWxEF7Q=
=iUKM
-----END PGP SIGNATURE-----

--PP2osckN1DWBMieX6UENGQtS61gpqNVFj--
