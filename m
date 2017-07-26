Received: from eggs.gnu.org ([2001:4830:134:3::10]:50387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daOWp-0000lw-8O
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daOWm-0006Z7-KI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1daOWm-0006WA-92
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:47:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC40267C4F
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:38:56 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
References: <20170726150446.20381-1-otubo@redhat.com>
	<4339cf29-69cd-773d-2912-741cf9bd4da7@redhat.com>
Message-ID: <14421c4e-fdbd-e969-cfca-6b0c3e155c8f@redhat.com>
Date: Wed, 26 Jul 2017 11:38:50 -0400
MIME-Version: 1.0
In-Reply-To: <4339cf29-69cd-773d-2912-741cf9bd4da7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ESmojpxBb18QuwA5j3IoJd75nksliuDIf"
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESmojpxBb18QuwA5j3IoJd75nksliuDIf
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Message-ID: <14421c4e-fdbd-e969-cfca-6b0c3e155c8f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
References: <20170726150446.20381-1-otubo@redhat.com>
 <4339cf29-69cd-773d-2912-741cf9bd4da7@redhat.com>
In-Reply-To: <4339cf29-69cd-773d-2912-741cf9bd4da7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/26/2017 11:28 AM, Cleber Rosa wrote:
>=20
>=20
> On 07/26/2017 11:04 AM, Eduardo Otubo wrote:
>> Starting qemu-system-unicore32 without the -kernel parameter results i=
n
>> an assert() returns false and aborts qemu. This patch replaces it with=
 a
>> proper error message followed by exit(1).
>>
>> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
>> ---
>>  hw/unicore32/puv3.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
>> index e9d1a60b6f..ff62efb4df 100644
>> --- a/hw/unicore32/puv3.c
>> +++ b/hw/unicore32/puv3.c
>> @@ -92,7 +92,10 @@ static void puv3_load_kernel(const char *kernel_fil=
ename)
>>      if (kernel_filename =3D=3D NULL && qtest_enabled()) {
>>          return;
>>      }
>> -    assert(kernel_filename !=3D NULL);
>> +    if (kernel_filename =3D=3D NULL) {
>> +        error_report("kernel parameter cannot be empty");
>> +        exit(1);
>> +    }
>> =20
>=20
> How do you actually trigger this?  There's already appropriate command
> line options handling in vl.c, which all targets (I tried) incorporate.=

> For unicore32:
>=20

Oh my, I misread your commit message.  I see this is actually triggered
*without* -kernel, and not without a parameter.

- Cleber.

> $ ./unicore32-softmmu/qemu-system-unicore32 -kernel
> qemu-system-unicore32: -kernel: requires an argument
>=20
> I also see what I believe is proper handling with invalid kernels (or
> empty options):
>=20
> $ ./unicore32-softmmu/qemu-system-unicore32 -kernel ''
> qemu-system-unicore32: Load kernel error: ''
>=20
> Regards,
> - Cleber.
>=20
>>      /* only zImage format supported */
>>      size =3D load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
>>
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--ESmojpxBb18QuwA5j3IoJd75nksliuDIf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZeLeKAAoJEGV+jTOl8gnzov8P/2qkTwmJj2mUAzyjkDcp29qJ
kYxFAuiPrBgR1d1ocASUxU/Xwqn/7Vot4tmEQ77Cd/EYOKi3ormPIUb2oTK0RMG2
PG7brxA0O+WYHQQ6sRK2tXgfCOYm4gYEmGp3GdoiIfAAYlCd8yp4dqIqgQJoSXkB
XYdds7QowzB32jO+Z9TsZ+Z+nCqIsowc8R3xbSdEXoxUuIIYaXEAj7aErudCPS7L
9/DZzuLLZQO/EqFQTnbW/nJZaSy/WfoE/wULHYNY+Wo4b088x4W9RHgc6m9NecrQ
jlZgP2PUUqwEMBr0Smrh9t7hm5sunPtQRLAqu8jWCMkVy5Mb7fxnTQlm9gm4VmU+
tjNiPDGfCLpPLXDYyMlzDGNyF/vtCqVpsw0Ajlg60Oed3qemryw3b+8+Pgrvzcnz
/sJq1IsyrKVEHMNW7uivPeCoeaLj6y/4Kr6x4+e+rhAmi3GZc0irOQG3TtyM76PP
xWx7QNnEhc5zFZMivtaCvn+HHs8QdwtDnxJMUDdIVcoj5R0ZMIFY+j57az3lDOM2
qEHyTwF0HT7xnvCB40LSxGzeLBwU9UlOqThOfkFVzAOxhiQPxx9IXz1zcIN6Rqc3
i915Rsei9HtnVscZnDME2PBNJyDc+0TlhjHGeI1T5f/jzbxoPPrlPSxntOn5Pdx1
n3fIoqqwd7LH0EPxyt17
=tj3l
-----END PGP SIGNATURE-----

--ESmojpxBb18QuwA5j3IoJd75nksliuDIf--
