Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@advancedtelematic.com>) id 1eDD5G-00008m-Ps
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@advancedtelematic.com>) id 1eDD5C-0005nY-Kn
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:27:14 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton@advancedtelematic.com>)
	id 1eDD5C-0005ms-Cm
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:27:10 -0500
Received: by mail-wm0-x241.google.com with SMTP id r68so6625065wmr.0
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:27:10 -0800 (PST)
From: Anton Gerasimov <anton@advancedtelematic.com>
References: <cb94e9b2-d7c6-68ab-bb25-42f7d8113e03@advancedtelematic.com>
	<CAEUhbmVTaJmL1jG8aBPPcJ-d+vKba8xhLgc=+7Fd8HHUvVW+-Q@mail.gmail.com>
	<9b2efc90-3b0e-b13b-27bb-117473c8b41b@advancedtelematic.com>
	<2fd2077a-9823-41e0-0deb-4142b20259d5@advancedtelematic.com>
	<CAEUhbmXJZnLZgx8b2ZHV1wfqZvO=agSsp0Yvi7FQQfV6MM1cnA@mail.gmail.com>
	<1cc32460-6067-0c1c-0182-eb17933293d9@advancedtelematic.com>
Message-ID: <ae876253-6a29-eacb-b990-860146a297b2@advancedtelematic.com>
Date: Fri, 10 Nov 2017 18:25:43 +0100
MIME-Version: 1.0
In-Reply-To: <1cc32460-6067-0c1c-0182-eb17933293d9@advancedtelematic.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [U-Boot] Support of latest qemux86-64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bin Meng <bmeng.cn@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, qemu-devel@nongnu.org

Yes, apparently 0xdfffc is in ROM area for QEMU (0xc0000 -- 0xe0000,
defined in include/hw/loader.h). The next thing to figure out is why
u-boot uses it as a stack area.

Best regards,
Anton Gerasimov

On 11/10/2017 06:04 PM, Anton Gerasimov wrote:
> New guess:
>
> in the most safe configuration of u-boot (CONFIG_SMP=n, lacpi disabled)
> with Igor's patch applied `qemu-system-i386 -bios /path/to/uboot.rom`
> fails on the first 'ret' instruction. GDB shows that memory at $esp
> (0xdfffc at the entrance to board_init_f_mem) and everything around it
> is zero despite 'call' and 'push' instructions executed. If you go one
> commit before the breaking one it works fine, stuff gets put onto stack.
> Could it that be that stack itself is in this 'readonly' area?
>
> Thanks,
> Anton Gerasimov
>
> On 11/09/2017 02:58 AM, Bin Meng wrote:
>> On Wed, Nov 8, 2017 at 9:05 PM, Anton Gerasimov
>> <anton@advancedtelematic.com> wrote:
>>> Adding Igor Mammedov to the loop.
>>>
>> Really add Igor Mammedov.
>>
>> Igor, can you help look at this?
>>
>>> On 11/08/2017 01:59 PM, Anton Gerasimov wrote:
>>>> To whoever might be interested: I've bisected qemu and the breaking
>>>> commit is 208fa0e43645edd0b0d8f838857dfc79daff40a8 (pc: make 'pc.rom'
>>>> readonly when machine has PCI enabled). It's just three lines added,
>>>> I'll paste the whole patch here. Not quite sure what can we do here though.
>>>>
>>>>
>>>>   diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>>   index 22e16031b0..59435390ba 100644
>>>>   --- a/hw/i386/pc.c
>>>>   +++ b/hw/i386/pc.c
>>>>   @@ -1443,6 +1443,9 @@ void pc_memory_init(PCMachineState *pcms,
>>>>        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>>>>        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>>>>                               &error_fatal);
>>>>   +    if (pcmc->pci_enabled) {
>>>>   +        memory_region_set_readonly(option_rom_mr, true);
>>>>   +    }
>>>>        memory_region_add_subregion_overlap(rom_memory,
>>>>                                            PC_ROM_MIN_VGA,
>>>>                                            option_rom_mr,
>>>>
>>>>
>> Regards,
>> Bin
>

-- 
Anton Gerasimov, ATS Advanced Telematic Systems GmbH
Kantstrasse 162, 10623 Berlin
Managing Directors: Dirk Pöschl, Armin G. Schmidt
Register Court: HRB 151501 B, Amtsgericht Charlottenburg
