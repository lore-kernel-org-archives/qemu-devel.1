Received: from eggs.gnu.org ([2001:4830:134:3::10]:50850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYnoI-0004S9-0i
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYnoC-0004jZ-In
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:59:29 -0500
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:55552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gYnoC-0004Vt-5D
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:59:24 -0500
Received: from player738.ha.ovh.net (unknown [10.109.160.5])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6AE2020B081
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 08:59:16 +0100 (CET)
References: <20181215184222.15127-1-clg@kaod.org>
	<20181217045022.GB5597@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fe0dab0a-42a9-1a54-eb3d-57f6ab5a4ceb@kaod.org>
Date: Mon, 17 Dec 2018 08:58:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181217045022.GB5597@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix compilation breakage on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 12/17/18 5:50 AM, David Gibson wrote:
> On Sat, Dec 15, 2018 at 07:42:22PM +0100, C=E9dric Le Goater wrote:
>> Fix the PPC_BIT definitions to use ULL instead in UL and replace
>> __builtin_ffssl() by the equivalent ctz routines.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Compile tested with --cross-prefix=3Dx86_64-w64-mingw32-. When I have
>>  some more time, I might try runtime on windows also.
>=20
> Which version of the mingw compiler do you have?  As I've noted
> elsewhere, I haven't been able to reproduce the problem with the mingw
> in Fedora 29.

I have :

	mingw64-gcc-7.3.0-1.fc28.x86_64

>>  The PPC compile failures have been there for a while (pre 2.12) and
>>  the MASK_TO_LSH macro was not used until the XIVE definitions were
>>  introduced.
>>
>>  I let you guys decide on how you want to proceed, but I think it is
>>  safe to merge this patch as a prereq of the pull request.
>>
>>  Thanks,
>>
>>  C.
>>
>>  target/ppc/cpu.h | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index ab68abe8a23c..a3d3e91eb4ce 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -70,18 +70,18 @@
>>  #define PPC_ELF_MACHINE     EM_PPC
>>  #endif
>> =20
>> -#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
>> -#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
>> -#define PPC_BIT8(bit)           (0x80UL >> (bit))
>> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
>> +#define PPC_BIT32(bit)          (0x80000000ULL >> (bit))
>> +#define PPC_BIT8(bit)           (0x80ULL >> (bit))
>=20
> We shouldn't need the ULL for the 32-bit and (especially) 8-bit
> versions.
>=20
>>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BI=
T(bs))
>>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>>                                   PPC_BIT32(bs))
>>  #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_=
BIT8(bs))
>> =20
>>  #if HOST_LONG_BITS =3D=3D 32
>> -# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
>> +# define MASK_TO_LSH(m)          ctz32(m)
>>  #elif HOST_LONG_BITS =3D=3D 64
>> -# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>> +# define MASK_TO_LSH(m)          ctz64(m)
>=20
> Having another look at this, this seems bogus: we're defining an
> interface that's only correct on a *host long*.  But when we use it
> we're almost certain to be working on guest values with a fixed size,
> so using this wrapper just adds confusion.
>=20
> I'm not really seeing any reason to use MASK_TO_LSH() rather than
> using ctz32() and ctz64() explicitly.

Does that mean you think we should define GETFIELD32/64 and=20
SETFIELD32/64 macros ?=20

or should we use the extract32/64 and deposit32/64 helpers instead ? =20
That's a bigger change but may be a better one. =20

Also, in the definitions above, only PPC_BIT() needs to use a ULL.


C.
