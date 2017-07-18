Received: from eggs.gnu.org ([2001:4830:134:3::10]:49041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXN3p-0004xz-5f
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXN3l-0007hW-V9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:36:49 -0400
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
	<20170630104632.27942-7-david@gibson.dropbear.id.au>
	<a189522d-c798-097d-b985-13e15f48db41@redhat.com>
	<20170718033708.GA3140@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ee35fa1b-b06e-6bc1-2e69-788ff2cad7ac@redhat.com>
Date: Tue, 18 Jul 2017 09:36:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170718033708.GA3140@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OIaBDIKKjxfoSbgvxq3Ied65CoKEjGXUQ"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 06/21] spapr: Add a "no HPT"
 encoding to HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, sbobroff@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OIaBDIKKjxfoSbgvxq3Ied65CoKEjGXUQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.07.2017 05:37, David Gibson wrote:
> On Mon, Jul 17, 2017 at 09:54:45PM +0200, Laurent Vivier wrote:
>> On 30/06/2017 12:46, David Gibson wrote:
>>> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>>>
>>> Add a "no HPT" encoding (using value -1) to the HTAB migration
>>> stream (in the place of HPT size) when the guest doesn't allocate HPT=
=2E
>>> This will help the target side to match target HPT with the source HP=
T
>>> and thus enable successful migration.
>>>
>>> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
>>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
>>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 52f4e72..f3e0b9b 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -1560,13 +1560,19 @@ static int htab_save_setup(QEMUFile *f, void =
*opaque)
>>>      sPAPRMachineState *spapr =3D opaque;
>>> =20
>>>      /* "Iteration" header */
>>> -    qemu_put_be32(f, spapr->htab_shift);
>>> +    if (!spapr->htab_shift) {
>>> +        qemu_put_be32(f, -1);
>>> +    } else {
>>> +        qemu_put_be32(f, spapr->htab_shift);
>>> +    }
>>> =20
>>>      if (spapr->htab) {
>>>          spapr->htab_save_index =3D 0;
>>>          spapr->htab_first_pass =3D true;
>>>      } else {
>>> -        assert(kvm_enabled());
>>> +        if (spapr->htab_shift) {
>>> +            assert(kvm_enabled());
>>> +        }
>>>      }
>>> =20
>>> =20
>>> @@ -1712,7 +1718,12 @@ static int htab_save_iterate(QEMUFile *f, void=
 *opaque)
>>>      int rc =3D 0;
>>> =20
>>>      /* Iteration header */
>>> -    qemu_put_be32(f, 0);
>>> +    if (!spapr->htab_shift) {
>>> +        qemu_put_be32(f, -1);
>>> +        return 0;
>>> +    } else {
>>> +        qemu_put_be32(f, 0);
>>> +    }
>>> =20
>>>      if (!spapr->htab) {
>>>          assert(kvm_enabled());
>>> @@ -1746,7 +1757,12 @@ static int htab_save_complete(QEMUFile *f, voi=
d *opaque)
>>>      int fd;
>>> =20
>>>      /* Iteration header */
>>> -    qemu_put_be32(f, 0);
>>> +    if (!spapr->htab_shift) {
>>> +        qemu_put_be32(f, -1);
>>> +        return 0;
>>> +    } else {
>>> +        qemu_put_be32(f, 0);
>>> +    }
>>> =20
>>>      if (!spapr->htab) {
>>>          int rc;
>>> @@ -1790,6 +1806,11 @@ static int htab_load(QEMUFile *f, void *opaque=
, int version_id)
>>> =20
>>>      section_hdr =3D qemu_get_be32(f);
>>> =20
>>> +    if (section_hdr =3D=3D -1) {
>>> +        spapr_free_hpt(spapr);
>>> +        return 0;
>>> +    }
>>> +
>>>      if (section_hdr) {
>>>          Error *local_err =3D NULL;
>>> =20
>>>
>>
>> It seems there is a bug in this patch: when using from QEMU console th=
e
>> command "savevm", it never stops and the qcow2 image grows without lim=
it.
>>
>> I think this is because htab_save_iterate() and htab_save_complete()
>> should mark the end of the sequence (the empty one, -1) by returning 1=

>> and not 0 (see kvmppc_save_htab()).
>=20
> Ah, yes, I think you're right.  The end condition is one of the subtle
> differences between the savevm and migration paths.
>=20
>> This fixes the problem for me:
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 970093e..fa01511 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1827,7 +1827,7 @@ static int htab_save_iterate(QEMUFile *f, void
>> *opaque)
>>      /* Iteration header */
>>      if (!spapr->htab_shift) {
>>          qemu_put_be32(f, -1);
>> -        return 0;
>> +        return 1;
>>      } else {
>>          qemu_put_be32(f, 0);
>>      }
>> @@ -1866,7 +1866,7 @@ static int htab_save_complete(QEMUFile *f, void
>> *opaque)
>>      /* Iteration header */
>>      if (!spapr->htab_shift) {
>>          qemu_put_be32(f, -1);
>> -        return 0;
>> +        return 1;
>>      } else {
>>          qemu_put_be32(f, 0);
>>      }
>=20
> Can you polish this up and submit for merge, please?

Could/should we maybe finally have proper #defines or an enum for these
return values? The raw numbers caused trouble in the past already, and
now they caused trouble again ... we should avoid to step into that trap
again in the future if possible.

 Thomas




--OIaBDIKKjxfoSbgvxq3Ied65CoKEjGXUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZbbqFAAoJEC7Z13T+cC21YkQQAJ0m29P1mDtiYLz3o4fG8+ej
hNLA304j64ua0w5fwz+N6sTb+tVB0UCE9ahCpC3XXfhXma92GVsi/DHvHFJB2KmS
J3JsEXmAsDky1bO4oI3pDDl3CY2psC3G52TOGTb2fM7m2c3cxUx7CUDsqIBvRxlj
LtQBREkX4IoZhVLbBk9U5ck2OO2ow1cqx1j8QPF46QFUsQwK0L+AqL38ExBfVFrR
8QO+WW3uBj5uVjapWiKtM6XERAHS8kvZAJ3aMOSZyAuTWt1DxX3ggshKgu9Ws4fo
w0xK3JXuLVQfsFtOm77tMzgbPO2DFr+eFjYao3XlwwzShF45RrXKtzD5etzCKgId
ep7mH9FJ0DTa2iIwtMlnODZKwgjPknzdqKSh3Ss0TS5Q+vVx3/58aUd0g45A5jHe
uisXsHNmAE8UuncTwNNfOSy7B3rDFVGUUZoFLqnrMXEwwLaLu+1JGbeyicPDOSRy
osq1FSZtoCpKIuOLpAzzgOQ+hVxX5Js6+Al84BcRz93fDOz2GWbhIhsNsKVFSe+1
gU5TA7SUKlgZFJPJzxiImoC4YOJ5Kva3ivsJyImbQSv2aCVznssCZ1lJc0ldv+uF
jKsb2SxKMan6REZfkNfY/UBIsEtlXEDvhmeSec4ulH2nHrdARLbvBhhU/eMrJzv9
plFTTDSHJmg+Bx1VNcyD
=qk9S
-----END PGP SIGNATURE-----

--OIaBDIKKjxfoSbgvxq3Ied65CoKEjGXUQ--
