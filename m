Received: from eggs.gnu.org ([209.51.188.92]:44533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gti51-00028w-0A
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gthze-0003oq-Du
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:01:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:53894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gthze-0003mW-2S
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:01:38 -0500
Date: Wed, 13 Feb 2019 01:01:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <db8d6d0b-4ea5-4f99-f054-d6a397f3e967@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1902130100260.68636@zero.eik.bme.hu>
References: <cover.1549857716.git.balaton@eik.bme.hu>
	<9f5f3187f0eff04efc2ec3639727a17bf8d36dce.1549857716.git.balaton@eik.bme.hu>
	<db8d6d0b-4ea5-4f99-f054-d6a397f3e967@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] mips_fulong2e: Add on-board graphics
 chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <zltjiangshi@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, 12 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/11/19 5:01 AM, BALATON Zoltan wrote:
>> Add (partial) emulation of the on-board GPU of the machine. This
>> allows the PMON2000 firmware to run and should also work with Linux
>> console but probably not with X yet.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> Depends on hw/display: Add basic ATI VGA emulation
>>
>>  hw/mips/mips_fulong2e.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>> index eec6fd02c8..68bd030fc1 100644
>> --- a/hw/mips/mips_fulong2e.c
>> +++ b/hw/mips/mips_fulong2e.c
>> @@ -287,6 +287,7 @@ static void mips_fulong2e_init(MachineState *machi=
ne)
>>      I2CBus *smbus;
>>      MIPSCPU *cpu;
>>      CPUMIPSState *env;
>> +    DeviceState *dev;
>>
>>      /* init CPUs */
>>      cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
>> @@ -347,6 +348,11 @@ static void mips_fulong2e_init(MachineState *mach=
ine)
>>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5=
],
>>                                 &smbus, &isa_bus);
>>
>> +    /* GPU */
>> +    dev =3D DEVICE(pci_create(pci_bus, -1, "ati-vga"));
>
> You missed in your cover:
> Based-on: 20190211040434.1C98674569F@zero.eik.bme.hu

I forgot what this was called, thanks for reminding. But patchew seems to=
=20
be down anyway.

Regards,
BALATON Zoltan

>
> Else testing we get:
> qemu-system-mips64el: Unknown device 'ati-vga' for bus 'PCI'
> Aborted (core dumped)
>
>> +    qdev_prop_set_uint16(dev, "device_id", 0x5159);
>> +    qdev_init_nofail(dev);
>> +
>>      /* Populate SPD eeprom data */
>>      spd_data =3D spd_data_generate(DDR, ram_size, &err);
>>      if (err) {
>>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>
