Received: from eggs.gnu.org ([2001:4830:134:3::10]:53315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyw5h-0001Wt-DV
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyw5e-00021z-Ax
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:00:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-18-mark.cave-ayland@ilande.co.uk>
	<20180321032924.GP3905@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
Date: Thu, 22 Mar 2018 06:00:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180321032924.GP3905@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="75UOQ7RmO4HTLx0o1DIl0tTK7xlMwgZkP"
Subject: Re: [Qemu-devel] [PATCH 17/19] uninorth: create new uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--75UOQ7RmO4HTLx0o1DIl0tTK7xlMwgZkP
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 17/19] uninorth: create new uninorth device
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
 <20180306203103.25563-18-mark.cave-ayland@ilande.co.uk>
 <20180321032924.GP3905@umbus.fritz.box>
In-Reply-To: <20180321032924.GP3905@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 03/21/2018 12:29 AM, David Gibson wrote:
> On Tue, Mar 06, 2018 at 08:31:01PM +0000, Mark Cave-Ayland wrote:
>> Commit 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" added a=
 TODO
>> which was to convert the uninorth registers hack to a proper device. M=
ove
>> these registers to a new uninorth device, removing the old hacks from
>> mac_newworld.c.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/pci-host/trace-events       |  2 ++
>>  hw/pci-host/uninorth.c         | 58 +++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/ppc/mac_newworld.c          | 41 +++++------------------------
>>  hw/ppc/trace-events            |  4 ---
>>  include/hw/pci-host/uninorth.h | 11 ++++++++
>>  5 files changed, 77 insertions(+), 39 deletions(-)
>>
>> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
>> index 341a87a702..dd7a398e96 100644
>> --- a/hw/pci-host/trace-events
>> +++ b/hw/pci-host/trace-events
>> @@ -18,3 +18,5 @@ unin_set_irq(int irq_num, int level) "setting INT %d=
 =3D %d"
>>  unin_get_config_reg(uint32_t reg, uint32_t addr, uint32_t retval) "co=
nverted config space accessor 0x%"PRIx32 "/0x%"PRIx32 " -> 0x%"PRIx32
>>  unin_data_write(uint64_t addr, unsigned len, uint64_t val) "write add=
r 0x%"PRIx64 " len %d val 0x%"PRIx64
>>  unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr =
0x%"PRIx64 " len %d val 0x%"PRIx64
>> +unin_write(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx64 " val=3D=
0x%"PRIx64
>> +unin_read(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx64 " val=3D=
0x%"PRIx64
>> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
>> index fada0ffd5f..dbfad01d9d 100644
>> --- a/hw/pci-host/uninorth.c
>> +++ b/hw/pci-host/uninorth.c
>> @@ -519,6 +519,62 @@ static const TypeInfo pci_unin_internal_info =3D =
{
>>      .class_init    =3D pci_unin_internal_class_init,
>>  };
>> =20
>> +/* UniN device */
>> +static void unin_write(void *opaque, hwaddr addr, uint64_t value,
>> +                       unsigned size)
>> +{
>> +    trace_unin_write(addr, value);
>> +    if (addr =3D=3D 0x0) {
>> +        *(int *)opaque =3D value;

This looks a dirty insecure optimization...

I see this is code motion, can you clean up using UNINState:

        UNINState *s =3D UNI_NORTH(obj);

        ...
            s->token =3D value;

>> +    }
>> +}
>> +
>> +static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    uint32_t value;
>> +
>> +    value =3D 0;
>> +    switch (addr) {
>> +    case 0:
>> +        value =3D *(int *)opaque;

Same,

>> +    }
>> +
>> +    trace_unin_read(addr, value);
>> +
>> +    return value;
>> +}
>> +
>> +static const MemoryRegionOps unin_ops =3D {
>> +    .read =3D unin_read,
>> +    .write =3D unin_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>=20
> DEVICE_NATIVE_ENDIAN is almost always wrong.  I'm pretty sure it
> should be DEVICE_BIG_ENDIAN.  I realize this is just a code motion,
> but while you're making a proper device of it, you might as well fix
> this to.
>=20
>> +};
>> +
>> +static void unin_init(Object *obj)
>> +{
>> +    UNINState *s =3D UNI_NORTH(obj);
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> +
>> +    memory_region_init_io(&s->mem, obj, &unin_ops, &s->token, "unin",=
 0x1000);

And here:

    memory_region_init_io(&s->mem, obj, &unin_ops, s, "unin", 0x1000);

>> +
>> +    sysbus_init_mmio(sbd, &s->mem);
>> +}
>> +
>> +static void unin_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>> +}
>> +
>> +static const TypeInfo unin_info =3D {
>> +    .name          =3D TYPE_UNI_NORTH,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(UNINState),
>> +    .instance_init =3D unin_init,
>> +    .class_init    =3D unin_class_init,
>> +};
>> +
>>  static void unin_register_types(void)
>>  {
>>      type_register_static(&unin_main_pci_host_info);
>> @@ -530,6 +586,8 @@ static void unin_register_types(void)
>>      type_register_static(&pci_u3_agp_info);
>>      type_register_static(&pci_unin_agp_info);
>>      type_register_static(&pci_unin_internal_info);
>> +
>> +    type_register_static(&unin_info);
>>  }
>> =20
>>  type_init(unin_register_types)
>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>> index ae0de4e36e..2fcb101982 100644
>> --- a/hw/ppc/mac_newworld.c
>> +++ b/hw/ppc/mac_newworld.c
>> @@ -83,36 +83,6 @@
>> =20
>>  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>> =20
>> -/* UniN device */
>> -static void unin_write(void *opaque, hwaddr addr, uint64_t value,
>> -                       unsigned size)
>> -{
>> -    trace_mac99_uninorth_write(addr, value);
>> -    if (addr =3D=3D 0x0) {
>> -        *(int*)opaque =3D value;
>> -    }
>> -}
>> -
>> -static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>> -{
>> -    uint32_t value;
>> -
>> -    value =3D 0;
>> -    switch (addr) {
>> -    case 0:
>> -        value =3D *(int*)opaque;
>> -    }
>> -
>> -    trace_mac99_uninorth_read(addr, value);
>> -
>> -    return value;
>> -}
>> -
>> -static const MemoryRegionOps unin_ops =3D {
>> -    .read =3D unin_read,
>> -    .write =3D unin_write,
>> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> -};
>> =20
>>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>                              Error **errp)
>> @@ -146,7 +116,6 @@ static void ppc_core99_init(MachineState *machine)=

>>      CPUPPCState *env =3D NULL;
>>      char *filename;
>>      qemu_irq *pic, **openpic_irqs;
>> -    MemoryRegion *unin_memory =3D g_new(MemoryRegion, 1);
>>      int linux_boot, i, j, k;
>>      MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Mem=
oryRegion, 1);
>>      hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
>> @@ -165,7 +134,6 @@ static void ppc_core99_init(MachineState *machine)=

>>      int machine_arch;
>>      SysBusDevice *s;
>>      DeviceState *dev, *pic_dev;
>> -    int *token =3D g_new(int, 1);
>>      hwaddr nvram_addr =3D 0xFFF04000;
>>      uint64_t tbfreq;
>> =20
>> @@ -273,9 +241,12 @@ static void ppc_core99_init(MachineState *machine=
)
>>          }
>>      }
>> =20
>> -    /* UniN init: XXX should be a real device */
>> -    memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin"=
, 0x1000);
>> -    memory_region_add_subregion(get_system_memory(), 0xf8000000, unin=
_memory);
>> +    /* UniN init */
>> +    dev =3D qdev_create(NULL, TYPE_UNI_NORTH);
>> +    qdev_init_nofail(dev);
>> +    s =3D SYS_BUS_DEVICE(dev);
>> +    memory_region_add_subregion(get_system_memory(), 0xf8000000,
>> +                                sysbus_mmio_get_region(s, 0));
>> =20
>>      openpic_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
>>      openpic_irqs[0] =3D
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index 66ec7eda6e..dc5e65aee9 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -92,10 +92,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "re=
ad addr=3D0x%x val=3D0x%x"
>>  rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=3D0x%x v=
al=3D0x%x"
>>  rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=3D0x%x v=
al=3D0x%x"
>> =20
>> -# hw/ppc/mac_newworld.c
>> -mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx=
64 " val=3D0x%"PRIx64
>> -mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx6=
4 " val=3D0x%"PRIx64
>> -
>>  # hw/ppc/ppc4xx_pci.c
>>  ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x =
irq %d -> %d"
>>  ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
>> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/unin=
orth.h
>> index d1424b165a..b0eb093e72 100644
>> --- a/include/hw/pci-host/uninorth.h
>> +++ b/include/hw/pci-host/uninorth.h
>> @@ -51,4 +51,15 @@ typedef struct UNINHostState {
>>      MemoryRegion pci_io;
>>  } UNINHostState;
>> =20
>> +typedef struct UNINState {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion mem;
>> +    int token[1];

having 'token' being 'int' type also looks weird.

Maybe target_ulong is better?

>> +} UNINState;
>> +
>> +#define TYPE_UNI_NORTH "uni-north"
>> +#define UNI_NORTH(obj) \
>> +    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH)
>> +
>>  #endif /* UNINORTH_H */
>=20

Regards,

Phil.


--75UOQ7RmO4HTLx0o1DIl0tTK7xlMwgZkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlqzcMAACgkQ4+MsLN6t
wN7h0g/+N/vka/HaUxl4xJR27w0FK3tzMiEBQmSG0S1moHGLowcSC2NbOyZP7kAO
5rORs2ZrORnisHMZQlaLYiDLEC1if9MOms08zTp2CKn9mdQIw7y8f5RtC4+oF0fV
FHjZmvZ8Ddzka6TlAi6+9DayAuBxflgDATiXdfCrNZaO1RLeMhLIjKRkc5lVigoz
+Uh/70HDZ1RV9hCyQnyucRDHP+QsWk/s0GcwW0+89drTqv0ZzKlwtwFlLi2a2RZV
D7vRYjvm4cMGdwbumb+AdFZvh4EpNScSVKVeTULqcH7HBd59ySorQQ+b+YEESPyc
QLxc+hn+KOTrMe+VUoRiU448p0+Kq9Zx+v8gRilfjuwzs29TfWJ+zPFNdUObPVEX
AhPSMm0EgC7hOdzlTrEwH84lsdtq+JhF6yvvA3sGn2sUX0cw3NriCtOaWuTgT6ng
bpOTwNYDZfrCww64DvGiFh8CPmZtkYX5PbnTLfTve2N+O+0t/sOayV6FhUL9lNti
QLZd35x2cmKmEh8Q8CzpHFsNohBYTj6JdGnC2RsLkcNcEBsU5rLh/FL2Q/mGaw2d
2qx8NJj8IwA/UWiAROFkLsKzQZZq308xiKvJyIgxNC5qWch/YLsqHZm7hVlZeveZ
Jk5pnZTSzts+WLnZHJ8Rp74NOU/Nd2bHg9LQOW9RPy3jWzI3uGs=
=9aRi
-----END PGP SIGNATURE-----

--75UOQ7RmO4HTLx0o1DIl0tTK7xlMwgZkP--
