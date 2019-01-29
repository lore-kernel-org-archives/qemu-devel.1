Received: from eggs.gnu.org ([209.51.188.92]:45417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1goNhS-0001AO-JK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1goNhR-0007JD-Sf
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:20:50 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:42369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1goNhR-0007Fu-NI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:20:49 -0500
Received: from player159.ha.ovh.net (unknown [10.109.160.76])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 01CAB1A5009
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:20:38 +0100 (CET)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-9-clg@kaod.org>
	<c916f6f3-7f5b-fa87-3343-f65cfc1da29e@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <043a5864-12b1-b384-247d-2e361c4ff009@kaod.org>
Date: Tue, 29 Jan 2019 08:20:31 +0100
MIME-Version: 1.0
In-Reply-To: <c916f6f3-7f5b-fa87-3343-f65cfc1da29e@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/13] spapr/rtas: modify
 spapr_rtas_register() to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 1/29/19 6:09 AM, Alexey Kardashevskiy wrote:
>=20
>=20
> On 08/01/2019 05:39, C=C3=A9dric Le Goater wrote:
>> Removing RTAS handlers will become necessary when the new pseries
>> machine supporting multiple interrupt mode is introduced.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h | 4 ++++
>>  hw/ppc/spapr_rtas.c    | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 9e01a5a12e4a..9a6d015b9cf5 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -657,6 +657,10 @@ typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, sP=
APRMachineState *sm,
>>                                uint32_t nargs, target_ulong args,
>>                                uint32_t nret, target_ulong rets);
>>  void spapr_rtas_register(int token, const char *name, spapr_rtas_fn f=
n);
>> +static inline void spapr_rtas_unregister(int token)
>> +{
>> +    spapr_rtas_register(token, NULL, NULL);
>> +}
>=20
> The new helper is not used anywhere.

ah yes. patch 10 should be introducing the helper in xics_kvm_disconnect(=
)

I am fixing that.

Thanks,

C.

>>  target_ulong spapr_rtas_call(PowerPCCPU *cpu, sPAPRMachineState *sm,
>>                               uint32_t token, uint32_t nargs, target_u=
long args,
>>                               uint32_t nret, target_ulong rets);
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index d6a0952154ac..e005d5d08151 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *na=
me, spapr_rtas_fn fn)
>> =20
>>      token -=3D RTAS_TOKEN_BASE;
>> =20
>> -    assert(!rtas_table[token].name);
>> +    assert(!name || !rtas_table[token].name);
>=20
>=20
> but allowing name=3D=3DNULL is.
>=20
>=20
>> =20
>>      rtas_table[token].name =3D name;
>>      rtas_table[token].fn =3D fn;
>>
>=20
