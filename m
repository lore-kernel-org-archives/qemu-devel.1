Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHgmN-0001Gv-KT
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 20:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHgmK-0003WK-Gc
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 20:58:15 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eHgmK-0003W6-7M
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 20:58:12 -0500
Received: by mail-pg0-x242.google.com with SMTP id m4so3430282pgc.4
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 17:58:12 -0800 (PST)
References: <20171122051552.3529-1-aik@ozlabs.ru>
	<20171122133952.GT2380@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3fde27e3-fb09-6084-a3e9-f98cfb4a527d@ozlabs.ru>
Date: Thu, 23 Nov 2017 12:58:06 +1100
MIME-Version: 1.0
In-Reply-To: <20171122133952.GT2380@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fau6clnQASFQPlKPjgVImasjucG3soUJB"
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow fallback to SPAPR
 TCE IOMMU v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fau6clnQASFQPlKPjgVImasjucG3soUJB
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Message-ID: <3fde27e3-fb09-6084-a3e9-f98cfb4a527d@ozlabs.ru>
Subject: Re: [PATCH qemu] vfio/spapr: Allow fallback to SPAPR TCE IOMMU v1
References: <20171122051552.3529-1-aik@ozlabs.ru>
 <20171122133952.GT2380@umbus.fritz.box>
In-Reply-To: <20171122133952.GT2380@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/11/17 00:39, David Gibson wrote:
> On Wed, Nov 22, 2017 at 04:15:52PM +1100, Alexey Kardashevskiy wrote:
>> The vfio_iommu_spapr_tce driver always advertises v1 and v2 IOMMU supp=
ort,
>> however PR KVM (a special version of KVM designed to work in
>> a paravirtualized system; these days used for nested virtualizaion) on=
ly
>> supports the "pseries" platform which does not support v2. Since there=
 is
>> no way to choose the IOMMU version in QEMU, it fails to start.
>>
>> This adds a fallback to the v1 IOMMU if v2 cannot be used.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> The fallback itself isn't a bad idea, but your commit message contains
> several inaccurracies.  KVM PR is not particularly designed to work in
> a paravirtualized system, and it doesn't only support the pseries
> platform (as guest *or* host).  It's actually a lot more general than
> KVM HV - just slow, not that well tested and missing a number of
> features that no-one's bothered to port to it.

Well, true. I kinda tried to give an example of how this may be useful an=
d
exaggerated a bit, plus my ignorance :) I'll repost if Alex does not have=

objections otherwise.



>=20
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


--fau6clnQASFQPlKPjgVImasjucG3soUJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAloWKy4OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILndTw/+OftNH0mCnHvGely/pcfomunyFHIidLAuc5cb
pktcWQTxaLVdS6Y3BF55mdErUo66xnP63ubxi3R1vuH+P0qvI5GohwghW+kgnh+e
Z59CrAeQMt67Qj0iNllJJ/1B9z93tujUG19FNIwvLcQQggSJ3Mnpw1Ga3z4PLokz
X9Kd44CkbmwDhrdtNHm8LLn5h+LBa+VbNdvK0f3a6nBgKVZ1FqgFWhLDulsVkrsG
pXo5suf0uVGLDP+8zRNBZgKoSKXMp5JcmxlB/2CSiZqg2Dt9LGQXZkqAfj7PMI7t
GSucklVdWR8mfMSY+uJrN0JS/Fv71Lt4rWqXFTOeThUOr41J6BSGRptkpNtd28WT
HzyjXjPIwe6pS0PO00vFbd113lkVyptIC2OF4FXKNruTzsvRRvgpuFdH1hVzcG0N
CsbbLCugdz0RHDk2sXeDoGw2G61XQ7a8N6lldigauy1Af3c7zZQxs1Jo57PcDKlK
T/JVjapnM4WUiOUXwQxeSpgY17Vh3FSao4kRUxGvYXN7JS87sj6sYcm9sgeP+X8Y
O10fIqQoFLIY4dca6XgveGcjYxgqHbTSiMpb4bLu/nTD+9+nVe4TBb+RIhZpDLxm
1MpLgwmrVQvLnxDwhZIJTTpAhj8dGJWvvbfXBkDovVBBk6/g+thj1Aqd+oiQvWue
ue6TEfg=
=ktqd
-----END PGP SIGNATURE-----

--fau6clnQASFQPlKPjgVImasjucG3soUJB--
