Received: from eggs.gnu.org ([209.51.188.92]:55702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1h3X-0002AY-NT
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1h3W-0003u0-Kd
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:38:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:48385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1h3V-0003nI-Sk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:38:38 -0500
Date: Thu, 7 Mar 2019 01:38:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1903070133170.66444@zero.eik.bme.hu>
References: <cover.1551902740.git.balaton@eik.bme.hu>
	<12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
	<c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5-resend 2/2] mips_fulong2e: Add on-board
 graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 7 Mar 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/6/19 9:05 PM, BALATON Zoltan wrote:
>> Add (partial) emulation of the on-board GPU of the machine. This
>> allows the PMON2000 firmware to run and should also work with Linux
>> console but probably not with X yet.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
>
> Mojibaked again :(

Sorry. Looks like my setup just can't handle your encoding. Maybe I need=20
an additional header to specify content encoding? Do you have a git confi=
g=20
to tell format-patch to generate that? Or have a way for maintainers to=20
correct this on merging automatically?

> Aleksandar, if you take this series, do you mind fixing with:

I think it should go via Gerd's tree together with the other patch.

Regards,
BALATON Zoltan

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Thanks!
>
> Phil.
>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>  hw/mips/mips_fulong2e.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>> index fbbc543eed..f877693766 100644
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
>> +    qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
>> +    qdev_init_nofail(dev);
>> +
>>      /* Populate SPD eeprom data */
>>      spd_data =3D spd_data_generate(DDR, ram_size, &err);
>>      if (err) {
>>
>
>
