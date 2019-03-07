Received: from eggs.gnu.org ([209.51.188.92]:54757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1gxq-0000uR-O4
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1gxp-0001JG-Pp
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:32:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1gxp-0001Iv-Jb
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:32:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so7596838wmg.4
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 16:32:44 -0800 (PST)
References: <cover.1551902740.git.balaton@eik.bme.hu>
	<12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
Date: Thu, 7 Mar 2019 01:32:41 +0100
MIME-Version: 1.0
In-Reply-To: <12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/6/19 9:05 PM, BALATON Zoltan wrote:
> Add (partial) emulation of the on-board GPU of the machine. This
> allows the PMON2000 firmware to run and should also work with Linux
> console but probably not with X yet.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> Tested-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>

Mojibaked again :(

Aleksandar, if you take this series, do you mind fixing with:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!

Phil.

> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/mips_fulong2e.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index fbbc543eed..f877693766 100644
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
> +    qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
> +    qdev_init_nofail(dev);
> +
>      /* Populate SPD eeprom data */
>      spd_data = spd_data_generate(DDR, ram_size, &err);
>      if (err) {
> 
