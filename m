Received: from eggs.gnu.org ([2001:4830:134:3::10]:51913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZAQI-00073x-7h
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZAQ5-0003xf-8T
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:08:08 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:46318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZAQ4-0003tU-Vz
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:08:01 -0500
Received: from player698.ha.ovh.net (unknown [10.109.146.175])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A8A7E10D8AF
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 09:07:52 +0100 (CET)
References: <20181217223445.28594-1-clg@kaod.org>
	<20181217223445.28594-3-clg@kaod.org>
	<20181218022339.GD23604@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e441c825-ed91-0c36-f319-9e1a473ff2cb@kaod.org>
Date: Tue, 18 Dec 2018 09:07:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181218022339.GD23604@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 2/7] target/ppc: replace
 __builtin_ffssl() by the equivalent ctz routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/18/18 3:23 AM, David Gibson wrote:
> On Mon, Dec 17, 2018 at 11:34:40PM +0100, C=E9dric Le Goater wrote:
>> And remove the intermediate MASK_TO_LSH macro which does not add any v=
alue.
>>
>> This fixes a compile breakage on windows.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> It's an improvement over what's there, but it still leaves macros
> whose primary use would be for guest registers, but are typed
> according to host values, which doesn't make much sense.
>=20
> I think instead we should redefine your BE64 / BE32 variants in terms
> of the existing extract*() and deposit*() primitives, and get rid of
> the GETFIELD / SETFIELD macros.

I will get rid of the GETFIELD/SETFIELD macros and rewrite the BE64/BE32=20
variants but I won't use the extract*() and deposit*(). I prefer to keep
the same pattern, which is similar to shpc_get/set_status(). I will make=20
the code clearer with static inlines.=20

I don't really like the names also. what about xive_(get/set)_field(32/64=
) ? =20

C.
=20
>> ---
>>  target/ppc/cpu.h | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 527181c0f09f..f4ef4f214564 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -78,18 +78,21 @@
>>                                   PPC_BIT32(bs))
>>  #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_=
BIT8(bs))
>> =20
>> +/*
>> + * OPAL PPC bitmask field manipulation, used in XIVE, PHB3 and PHB4
>> + */
>>  #if HOST_LONG_BITS =3D=3D 32
>> -# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
>> +#  define GETFIELD(m, v)        (((v) & (m)) >> ctz32(m))
>> +#  define SETFIELD(m, v, val)                                   \
>> +    (((v) & ~(m)) | ((((typeof(v))(val)) << ctz32(m)) & (m)))
>>  #elif HOST_LONG_BITS =3D=3D 64
>> -# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>> +#  define GETFIELD(m, v)        (((v) & (m)) >> ctz64(m))
>> +#  define SETFIELD(m, v, val)                                   \
>> +    (((v) & ~(m)) | ((((typeof(v))(val)) << ctz64(m)) & (m)))
>>  #else
>>  # error Unknown sizeof long
>>  #endif
>> =20
>> -#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>> -#define SETFIELD(m, v, val)                             \
>> -        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)=
))
>> -
>>  /********************************************************************=
*********/
>>  /* Exception vectors definitions                                     =
        */
>>  enum {
>=20
