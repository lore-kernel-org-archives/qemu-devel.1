Received: from eggs.gnu.org ([2001:4830:134:3::10]:56005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRFo-0004A3-Nz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRFl-0000Kb-Gi
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:21:28 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRFl-0000KR-BY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:21:25 -0400
Received: by mail-qt0-x22c.google.com with SMTP id s9-v6so5521867qtg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:21:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<20180313224719.4954-51-pbonzini@redhat.com>
	<20180601185139.GA25837@flamenco>
	<f3c45eff-634d-6187-8f65-624bce9d2e4e@redhat.com>
	<323c9978-2d21-cfec-a613-57f0c675531f@amsat.org>
	<76061b88-b9d5-8095-b60e-cbe53993113c@amsat.org>
Message-ID: <721b3d64-f43f-80c6-37da-567a05e0f0ac@amsat.org>
Date: Thu, 14 Jun 2018 09:21:20 -0300
MIME-Version: 1.0
In-Reply-To: <76061b88-b9d5-8095-b60e-cbe53993113c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 50/69] hw/alpha/dp264: Use the
 TYPE_SMC37C669_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

On 06/13/2018 02:17 PM, Philippe Mathieu-Daudé wrote:
> On 06/13/2018 01:35 PM, Philippe Mathieu-Daudé wrote:
>> On 06/13/2018 01:21 PM, Paolo Bonzini wrote:
>>> On 01/06/2018 20:51, Emilio G. Cota wrote:
>>>> On Tue, Mar 13, 2018 at 23:47:00 +0100, Paolo Bonzini wrote:
>>>>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> Message-Id: <20180308223946.26784-25-f4bug@amsat.org>
>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>> ---
>>>>>  default-configs/alpha-softmmu.mak |  3 +++
>>>>>  hw/alpha/dp264.c                  | 10 ++++------
>>>>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> This commit breaks alpha-softmmu bootup for me. I get no console
>>>> output whatsoever -- not even the green "Hello" when invoking
>>>> the alpha-softmmu binary with no arguments.
>>>>
>>>> Did anybody else notice this?
>>>
>>> Philippe, are you going to take a look?  I tested 2.12 and I get the
>>
>> Sure. Sorry I didn't notice earlier, my mail-filter demotes subject with
>> PULL :/
>>
>>> same result as latest mainline: nothing on the VGA and
>>>
>>> PCI: 00:00:0 class 0300 id 1013:00b8
>>> PCI:   region 0: 10000000
>>> PCI:   region 1: 12000000
>>> PCI: 00:01:0 class 0200 id 8086:100e
>>> PCI:   region 0: 12020000
>>> PCI:   region 1: 0000c000
>>> PCI: 00:02:0 class 0101 id 1095:0646
>>> PCI:   region 0: 0000c040
>>> PCI:   region 1: 0000c048
>>> PCI:   region 3: 0000c04c
>>>
>>> on the serial console, respectively for VGA/network/IDE.
> 
> Creating the Super I/O _before_ the VGA setup fixes this issue...
> 
> I suppose the problem is some ISA global variable? I'll keep digging.

Mark Cave-Ayland figured out yesterday than some VGA I/O space was
shadowed by the parallel device:

    ..
    00000801fc0002f8-00000801fc0002ff (prio 0, i/o): serial
    00000801fc0003b4-00000801fc0003b5 (prio 0, i/o): vga
    00000801fc0003ba-00000801fc0003ba (prio 0, i/o): vga
    00000801fc0003bc-00000801fc0003c3 (prio 0, i/o): parallel
                                  ^^^                ^^^^^^^^
    00000801fc0003c0-00000801fc0003cf (prio 0, i/o): vga
                 ^^^
    00000801fc0003d4-00000801fc0003d5 (prio 0, i/o): vga
    00000801fc0003da-00000801fc0003da (prio 0, i/o): vga
    00000801fc0003f1-00000801fc0003f5 (prio 0, i/o): fdc
    00000801fc0003f7-00000801fc0003f7 (prio 0, i/o): fdc

> 
> -- >8 --
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> @@ -83,6 +83,12 @@ static void clipper_init(MachineState *machine)
> 
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
> 
> +    /* 2 82C37 (dma) */
> +    isa_create_simple(isa_bus, "i82374");
> +
> +    /* Super I/O */
> +    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
> +
>      /* VGA setup.  Don't bother loading the bios.  */
>      pci_vga_init(pci_bus);
> 
> @@ -91,12 +97,6 @@ static void clipper_init(MachineState *machine)
>          pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
>      }
> 
> -    /* 2 82C37 (dma) */
> -    isa_create_simple(isa_bus, "i82374");
> -
> -    /* Super I/O */
> -    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
> -
>      /* IDE disk setup.  */
>      {
>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> 
