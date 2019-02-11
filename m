Received: from eggs.gnu.org ([209.51.188.92]:39383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLPV-0006ar-7w
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLPM-0005ta-Mx
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtLPG-0005jL-Nt
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so745796wrg.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:54:33 -0800 (PST)
References: <cover.1549857716.git.balaton@eik.bme.hu>
	<9f5f3187f0eff04efc2ec3639727a17bf8d36dce.1549857716.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db8d6d0b-4ea5-4f99-f054-d6a397f3e967@redhat.com>
Date: Tue, 12 Feb 2019 00:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <9f5f3187f0eff04efc2ec3639727a17bf8d36dce.1549857716.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Huacai Chen <zltjiangshi@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2/11/19 5:01 AM, BALATON Zoltan wrote:
> Add (partial) emulation of the on-board GPU of the machine. This
> allows the PMON2000 firmware to run and should also work with Linux
> console but probably not with X yet.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Depends on hw/display: Add basic ATI VGA emulation
> 
>  hw/mips/mips_fulong2e.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index eec6fd02c8..68bd030fc1 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -287,6 +287,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      I2CBus *smbus;
>      MIPSCPU *cpu;
>      CPUMIPSState *env;
> +    DeviceState *dev;
>  
>      /* init CPUs */
>      cpu = MIPS_CPU(cpu_create(machine->cpu_type));
> @@ -347,6 +348,11 @@ static void mips_fulong2e_init(MachineState *machine)
>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>                                 &smbus, &isa_bus);
>  
> +    /* GPU */
> +    dev = DEVICE(pci_create(pci_bus, -1, "ati-vga"));

You missed in your cover:
Based-on: 20190211040434.1C98674569F@zero.eik.bme.hu

Else testing we get:
qemu-system-mips64el: Unknown device 'ati-vga' for bus 'PCI'
Aborted (core dumped)

> +    qdev_prop_set_uint16(dev, "device_id", 0x5159);
> +    qdev_init_nofail(dev);
> +
>      /* Populate SPD eeprom data */
>      spd_data = spd_data_generate(DDR, ram_size, &err);
>      if (err) {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
