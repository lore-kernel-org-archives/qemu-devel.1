Received: from eggs.gnu.org ([209.51.188.92]:59980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gsCa7-0001Jm-Id
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gsCa5-0000X2-Ml
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gsCa3-0006WO-Db
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:01 -0500
References: <1548859550-32019-1-git-send-email-liam.merwick@oracle.com>
	<3b98dc38-fe11-87fb-d846-4001f64c0b33@linux.ibm.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <00ba3ef0-896a-81bd-6e89-1761e983881a@oracle.com>
Date: Fri, 8 Feb 2019 20:10:31 +0000
MIME-Version: 1.0
In-Reply-To: <3b98dc38-fe11-87fb-d846-4001f64c0b33@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm_tis: validate locality values don't
 overrun array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org, liam.merwick@oracle.com

Hi Stefan,

Thanks for the detailed explanations.

On 04/02/2019 18:05, Stefan Berger wrote:
> On 1/30/19 9:45 AM, Liam Merwick wrote:
>> Assert that various locality values don't exceed TPM_TIS_NUM_LOCALITIE=
S
>> by adding specific calls to assert(TPM_TIS_NUM_LOCALITIES(l)) in order
>> to help static code analysis.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>> =C2=A0 hw/tpm/tpm_tis.c | 5 +++++
>> =C2=A0 1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index fd6bb9b59a96..2267bd8c346f 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -241,6 +241,9 @@ static void tpm_tis_abort(TPMState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rw_offset =3D 0;
>> +=C2=A0=C2=A0=C2=A0 assert(TPM_TIS_IS_VALID_LOCTY(s->next_locty));
>=20
> There are 2 callers of tpm_tis_abort: tpm_tis_prep_abort and=20
> tpm_tis_request_completed. Both are checking s->next_locality already.=20
> The former in line 270
>=20
>  =C2=A0=C2=A0=C2=A0 assert(TPM_TIS_IS_VALID_LOCTY(newlocty));
>=20
>  =C2=A0=C2=A0=C2=A0 s->aborting_locty =3D locty; /* may also be TPM_TIS=
_NO_LOCALITY */
>  =C2=A0=C2=A0=C2=A0 s->next_locty =3D newlocty;=C2=A0 /* locality after=
 successful abort */
>=20
> and the latter in line 321:
>=20
>  =C2=A0=C2=A0=C2=A0 if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tis_abort(s);
>  =C2=A0=C2=A0=C2=A0 }
>=20
> So this check would be redundant.


Agreed.


>=20
>=20
>> +=C2=A0=C2=A0=C2=A0 assert(TPM_TIS_IS_VALID_LOCTY(s->aborting_locty));
>> +
>=20
> s->aborting_locty only serves as an index into the array in=20
> tpm_tis_abort and only under the condition
>=20
>  =C2=A0=C2=A0=C2=A0 if (s->aborting_locty =3D=3D s->next_locty) {
>=20
> As state above s->next_locty has been tested for being a valid locality=
=20
> already elsewhere and we don't need to test it another time. They way=20
> the code accesses this variable we do not need this check, either.=20
> Besides that there is this comment in the code in line 272, which would=
=20
> make this assert wrong.
>=20
>=20
>  =C2=A0=C2=A0=C2=A0 s->aborting_locty =3D locty; /* may also be TPM_TIS=
_NO_LOCALITY */
>=20
>=20

Indeed.

>=20
>=20
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_tpm_tis_abort(s->next_locty);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -531,6 +534,8 @@ static void tpm_tis_mmio_write(void *opaque,=20
>> hwaddr addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (size =3D=3D 1) ? 0xf=
f : ((size =3D=3D 2) ? 0xffff : ~0);
>> +=C2=A0=C2=A0=C2=A0 assert(TPM_TIS_IS_VALID_LOCTY(locty));
>> +
>=20
> We also do not need this check here since we are registering 0x5000=20
> bytes of MMIO space, which gives us addresses [0x0..0x4fff], from which=
=20
> we calculate the locality with a '>> 12':
>=20
> static uint8_t tpm_tis_locality_from_addr(hwaddr addr)
> {

In that case would it be good to add this check to enforce the address=20
range?

assert(addr < TPM_TIS_ADDR_SIZE);


>  =C2=A0=C2=A0=C2=A0 return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) &=
 0x7);
> }
>=20
> this is where we register the MMIO memory:
>=20
>  =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis=
_memory_ops,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s, "tpm-tis-mmio",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 TPM_TIS_NUM_LOCALITIES <<=20
> TPM_TIS_LOCALITY_SHIFT);
>=20
> The locality cannot be out-of-bounds.




 From staring at the code, I do have one other question - why does the=20
check of the lower localities below only check 'l < locty - 1' before=20
setting s->loc[locty] - it seems like s->loc[locty - 1] is skipped.


  627                 /* cancel any seize by a lower locality */
  628                 for (l =3D 0; l < locty - 1; l++) {
  629                     s->loc[l].access &=3D ~TPM_TIS_ACCESS_SEIZE;
  630                 }
  631
  632                 s->loc[locty].access |=3D TPM_TIS_ACCESS_SEIZE;


Regards,
Liam
