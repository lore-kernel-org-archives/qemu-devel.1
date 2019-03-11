Received: from eggs.gnu.org ([209.51.188.92]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h39CU-0004vA-Go
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3929-0000d3-1o
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:43:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3928-0000cf-RL
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:43:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so2633517wma.0
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 17:43:12 -0700 (PDT)
References: <cover.1552152100.git.balaton@eik.bme.hu>
	<da6370b22e0352ee803d25d68a62ff32eebf06e2.1552152100.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5191334-6fdf-c160-203f-a6bee5f0384a@redhat.com>
Date: Mon, 11 Mar 2019 01:43:09 +0100
MIME-Version: 1.0
In-Reply-To: <da6370b22e0352ee803d25d68a62ff32eebf06e2.1552152100.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 2/2] mips_fulong2e: Add on-board
 graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/9/19 6:21 PM, BALATON Zoltan wrote:
> Add (partial) emulation of the on-board GPU of the machine. This
> allows the PMON2000 firmware to run and should also work with Linux
> console but probably not with X yet.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> Tested-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>

Mojibaked again :(

I guess this is the last respin and this series will be applied,
so to the maintainer: Can you fix using:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Zoltan if you have to respin, please simply use:

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>

> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
> v7:
> - set vgamem_mb explicitely to match board instead of relying on default
> 
>  hw/mips/mips_fulong2e.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index fbbc543eed..2bdb766ed1 100644
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
> @@ -347,6 +348,12 @@ static void mips_fulong2e_init(MachineState *machine)
>      vt82c686b_southbridge_init(pci_bus, FULONG2E_VIA_SLOT, env->irq[5],
>                                 &smbus, &isa_bus);
>  
> +    /* GPU */
> +    dev = DEVICE(pci_create(pci_bus, -1, "ati-vga"));
> +    qdev_prop_set_uint32(dev, "vgamem_mb", 16);
> +    qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
> +    qdev_init_nofail(dev);
> +
>      /* Populate SPD eeprom data */
>      spd_data = spd_data_generate(DDR, ram_size, &err);
>      if (err) {
> 
