Received: from eggs.gnu.org ([2001:4830:134:3::10]:57143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRBdA-000504-Ia
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRBd5-0006dW-MD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:44:00 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:47756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRBd5-0006cz-Fk
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:43:55 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 055D790D67
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:43:54 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-2-clg@kaod.org>
	<20171219044655.GJ4786@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <84ecf1fb-4a78-eb08-4ce8-672b2295ec78@kaod.org>
Date: Tue, 19 Dec 2017 07:43:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171219044655.GJ4786@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/19] dma-helpers: add a return value
 to store helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

On 12/19/2017 05:46 AM, David Gibson wrote:
> On Sat, Dec 09, 2017 at 09:43:20AM +0100, C=E9dric Le Goater wrote:
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Hrm.  I know I (indirectly) suggested this, but now that I see it, I'm
> thinking adding return values here but not on the read side (which
> would be awkward since they return the read values) seems like not a
> great idea.
>=20
> So I'm ok with just open coding the dma_memory_write()s after all.

OK. It's not a big change. Maybe I can use :

	ldl_phys(CPU(cpu)->as, ...)
	stl_phys(CPU(cpu)->as, ...)

in some cases, which would give us the correct ordering.=20

The Pnv model does a few more peek/poke in RAM to use the XIVE=20
structures which are larger, 8 * uint_64t for the XiveEQs and=20
16 for the XiveVPs.=20

Thanks,

C.

>=20
>> ---
>>  include/sysemu/dma.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
>> index c228c6651360..74a9558af39c 100644
>> --- a/include/sysemu/dma.h
>> +++ b/include/sysemu/dma.h
>> @@ -153,12 +153,12 @@ static inline void dma_memory_unmap(AddressSpace=
 *as,
>>          dma_memory_read(as, addr, &val, (_bits) / 8);                =
   \
>>          return _end##_bits##_to_cpu(val);                            =
   \
>>      }                                                                =
   \
>> -    static inline void st##_sname##_##_end##_dma(AddressSpace *as,   =
   \
>> +    static inline int st##_sname##_##_end##_dma(AddressSpace *as,    =
  \
>>                                                   dma_addr_t addr,    =
   \
>>                                                   uint##_bits##_t val)=
   \
>>      {                                                                =
   \
>>          val =3D cpu_to_##_end##_bits(val);                           =
     \
>> -        dma_memory_write(as, addr, &val, (_bits) / 8);               =
   \
>> +        return dma_memory_write(as, addr, &val, (_bits) / 8);        =
   \
>>      }
>> =20
>>  static inline uint8_t ldub_dma(AddressSpace *as, dma_addr_t addr)
>=20
