Received: from eggs.gnu.org ([2001:4830:134:3::10]:38099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRNA-00012D-OX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRN8-0004Ck-6h
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:47:11 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-8-mreitz@redhat.com>
	<14120cdc-1517-f9af-9f35-3c78b4f634a9@redhat.com>
	<20181015235752.GK31060@habkost.net>
	<0287ec2e-9ab7-2fd3-4abf-1c84a97f0e07@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <454c0ced-e3d9-e447-9e2b-ef8badb808d1@redhat.com>
Date: Fri, 19 Oct 2018 11:46:59 +0200
MIME-Version: 1.0
In-Reply-To: <0287ec2e-9ab7-2fd3-4abf-1c84a97f0e07@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0s4ROCvcsss7lZnCLTyxvJ48ehcnhsAAR"
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in
 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0s4ROCvcsss7lZnCLTyxvJ48ehcnhsAAR
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <454c0ced-e3d9-e447-9e2b-ef8badb808d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in 169
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-8-mreitz@redhat.com>
 <14120cdc-1517-f9af-9f35-3c78b4f634a9@redhat.com>
 <20181015235752.GK31060@habkost.net>
 <0287ec2e-9ab7-2fd3-4abf-1c84a97f0e07@redhat.com>
In-Reply-To: <0287ec2e-9ab7-2fd3-4abf-1c84a97f0e07@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 03:01, Cleber Rosa wrote:
>=20
>=20
> On 10/15/18 7:57 PM, Eduardo Habkost wrote:
>> On Mon, Oct 15, 2018 at 07:38:45PM -0400, Cleber Rosa wrote:
>>>
>>>
>>> On 10/15/18 10:14 AM, Max Reitz wrote:
>>>> iotest 169 uses the 'new' module to add methods to a class.  This mo=
dule
>>>> no longer exists in Python 3.  Instead, we can use a lambda.  Best o=
f
>>>> all, this works in 2.7 just as well.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/169 | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>>>> index f243db9955..e5614b159d 100755
>>>> --- a/tests/qemu-iotests/169
>>>> +++ b/tests/qemu-iotests/169
>>>> @@ -23,7 +23,6 @@ import iotests
>>>>  import time
>>>>  import itertools
>>>>  import operator
>>>> -import new
>>>>  from iotests import qemu_img
>>>> =20
>>>> =20
>>>> @@ -144,7 +143,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCa=
se):
>>>> =20
>>>>  def inject_test_case(klass, name, method, *args, **kwargs):
>>>>      mc =3D operator.methodcaller(method, *args, **kwargs)
>>>> -    setattr(klass, 'test_' + name, new.instancemethod(mc, None, kla=
ss))
>>>> +    setattr(klass, 'test_' + name, lambda self: mc(self))
>>>> =20
>>>>  for cmb in list(itertools.product((True, False), repeat=3D4)):
>>>>      name =3D ('_' if cmb[0] else '_not_') + 'persistent_'
>>>>
>>>
>>> This can be simplified with:
>>>
>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>>> index e5614b159d..2199f14ae7 100755
>>> --- a/tests/qemu-iotests/169
>>> +++ b/tests/qemu-iotests/169
>>> @@ -22,7 +22,6 @@ import os
>>>  import iotests
>>>  import time
>>>  import itertools
>>> -import operator
>>>  from iotests import qemu_img
>>>
>>>
>>> @@ -141,18 +140,15 @@ class TestDirtyBitmapMigration(iotests.QMPTestC=
ase):
>>>              self.check_bitmap(self.vm_b, sha256 if persistent else F=
alse)
>>>
>>>
>>> -def inject_test_case(klass, name, method, *args, **kwargs):
>>> -    mc =3D operator.methodcaller(method, *args, **kwargs)
>>> -    setattr(klass, 'test_' + name, lambda self: mc(self))
>>> -
>>>  for cmb in list(itertools.product((True, False), repeat=3D4)):
>>>      name =3D ('_' if cmb[0] else '_not_') + 'persistent_'
>>>      name +=3D ('_' if cmb[1] else '_not_') + 'migbitmap_'
>>>      name +=3D '_online' if cmb[2] else '_offline'
>>>      name +=3D '_shared' if cmb[3] else '_nonshared'
>>>
>>> -    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migrat=
ion',
>>> -                     *list(cmb))
>>> +    setattr(TestDirtyBitmapMigration, 'test_' + name,
>>> +            lambda self: TestDirtyBitmapMigration.do_test_migration(=

>>> +                self, *list(cmb)))
>>
>> I'm not fond of the long multi-line lambda expression, but I love
>> that you got rid of operator.methodcaller().  :)
>>
>> However, this doesn't seem to work: `*list(cmb)` will be
>> evaluated only when the lambda is called, and `cmb` will be
>> always `(False, False, False, False)`.
>>
>> I was going to suggest defining a nested function inside
>> inject_test_case() to replace operator.methodcaller(), but then I
>> thought it was not worth it.
>>
>=20
> You're right! I missed that.  Anyway, another possibility:
>=20
> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> index e5614b159d..cd0d9c289c 100755
> --- a/tests/qemu-iotests/169
> +++ b/tests/qemu-iotests/169
> @@ -22,7 +22,7 @@ import os
>  import iotests
>  import time
>  import itertools
> -import operator
> +import functools
>  from iotests import qemu_img
>=20
>=20
> @@ -140,20 +140,15 @@ class TestDirtyBitmapMigration(iotests.QMPTestCas=
e):
>              self.vm_b.launch()
>              self.check_bitmap(self.vm_b, sha256 if persistent else Fal=
se)
>=20
> -
> -def inject_test_case(klass, name, method, *args, **kwargs):
> -    mc =3D operator.methodcaller(method, *args, **kwargs)
> -    setattr(klass, 'test_' + name, lambda self: mc(self))
> -
> -for cmb in list(itertools.product((True, False), repeat=3D4)):
> +for cmb in itertools.product((True, False), repeat=3D4):
>      name =3D ('_' if cmb[0] else '_not_') + 'persistent_'
>      name +=3D ('_' if cmb[1] else '_not_') + 'migbitmap_'
>      name +=3D '_online' if cmb[2] else '_offline'
>      name +=3D '_shared' if cmb[3] else '_nonshared'
>=20
> -    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migratio=
n',
> -                     *list(cmb))
> -
> +    test =3D
> functools.partialmethod(TestDirtyBitmapMigration.do_test_migration,
> +                                   *cmb)
> +    setattr(TestDirtyBitmapMigration, 'test_' + name, test)

I'm not sure how that is any simpler, though (apart from the inlining). :=
-)

I mean, my personal goal is not to touch this beyond what I need to
because it's black magic to me anyway, so I'm happy with what works.

Max


--0s4ROCvcsss7lZnCLTyxvJ48ehcnhsAAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJqBMACgkQ9AfbAGHV
z0C18Qf9F0eQjI9p+NtmZnMWzbWLR9kw8ZX01nQu8KHELIaEKfKPRoBxZI91RxgF
mtqz17fnK3XULyZGAyfNxbAq5KF9gJqAu6FnMmY5/ihXY9M4iYlAwFTFugER2ENX
dIHDTXOweRl4xpxWd1L6SKFMRibXIQ81YhA6zgZVCwfBEtUfnDGZo/RR6gtu+HOR
k836iDNbU2DKGfdfQMof/End6PJJoo+ed7e9dxoYHiWdIX3FSzrQqs2BHNzidamQ
dYxsIjaBSZvfamBFWo+51K0pPhXV22SjGiCfgs8ZmAkxTL4HS5sFzYeY4SS0MWNJ
wjn11i6gNk+02DHSbJvP0AIMFoERtQ==
=u+AU
-----END PGP SIGNATURE-----

--0s4ROCvcsss7lZnCLTyxvJ48ehcnhsAAR--
