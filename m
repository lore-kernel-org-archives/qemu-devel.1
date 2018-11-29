Received: from eggs.gnu.org ([2001:4830:134:3::10]:37097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPJK-0006rD-KO
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPJF-0007Fw-Lu
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:06 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:60835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSPJF-0007FN-EB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:01 -0500
Received: from player692.ha.ovh.net (unknown [10.109.159.123])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0FC39172980
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:36:59 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
	<20181129040917.GF14697@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8416d567-6e9e-6124-7b7c-a620429af8b5@kaod.org>
Date: Thu, 29 Nov 2018 17:36:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181129040917.GF14697@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/29/18 5:09 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:20AM +0100, C=E9dric Le Goater wrote:
>> This will be used to remove the MMIO regions of the POWER9 XIVE
>> interrupt controller when the sPAPR machine is reseted.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Since the code looks sane.
>=20
> Hoever, I think using memory_region_set_enabled() would be a better
> idea for our purposes than actually adding/deleting the subregion.

Yes and we might not need this one anymore.=20

Thanks,

C.

>> ---
>>  include/hw/sysbus.h |  1 +
>>  hw/core/sysbus.c    | 10 ++++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
>> index 0b59a3b8d605..bc641984b5da 100644
>> --- a/include/hw/sysbus.h
>> +++ b/include/hw/sysbus.h
>> @@ -92,6 +92,7 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev,=
 int n);
>>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
>>  void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
>>                               int priority);
>> +void sysbus_mmio_unmap(SysBusDevice *dev, int n);
>>  void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
>>                     MemoryRegion *mem);
>>  MemoryRegion *sysbus_address_space(SysBusDevice *dev);
>> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
>> index 7ac36ad3e707..09f202167dcb 100644
>> --- a/hw/core/sysbus.c
>> +++ b/hw/core/sysbus.c
>> @@ -153,6 +153,16 @@ static void sysbus_mmio_map_common(SysBusDevice *=
dev, int n, hwaddr addr,
>>      }
>>  }
>> =20
>> +void sysbus_mmio_unmap(SysBusDevice *dev, int n)
>> +{
>> +    assert(n >=3D 0 && n < dev->num_mmio);
>> +
>> +    if (dev->mmio[n].addr !=3D (hwaddr)-1) {
>> +        memory_region_del_subregion(get_system_memory(), dev->mmio[n]=
.memory);
>> +        dev->mmio[n].addr =3D (hwaddr)-1;
>> +    }
>> +}
>> +
>>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
>>  {
>>      sysbus_mmio_map_common(dev, n, addr, false, 0);
>=20
