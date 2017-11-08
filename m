Received: from eggs.gnu.org ([2001:4830:134:3::10]:53240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@advancedtelematic.com>) id 1eCPz0-0003qp-6A
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@advancedtelematic.com>) id 1eCPyw-0000N5-5G
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:01:30 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton@advancedtelematic.com>)
	id 1eCPyv-0000MN-TT
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:01:26 -0500
Received: by mail-wm0-x241.google.com with SMTP id s66so10183238wmf.5
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 05:01:25 -0800 (PST)
References: <cb94e9b2-d7c6-68ab-bb25-42f7d8113e03@advancedtelematic.com>
	<CAEUhbmVTaJmL1jG8aBPPcJ-d+vKba8xhLgc=+7Fd8HHUvVW+-Q@mail.gmail.com>
From: Anton Gerasimov <anton@advancedtelematic.com>
Message-ID: <9b2efc90-3b0e-b13b-27bb-117473c8b41b@advancedtelematic.com>
Date: Wed, 8 Nov 2017 13:59:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAEUhbmVTaJmL1jG8aBPPcJ-d+vKba8xhLgc=+7Fd8HHUvVW+-Q@mail.gmail.com>
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
To: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: qemu-devel@nongnu.org

To whoever might be interested: I've bisected qemu and the breaking
commit is 208fa0e43645edd0b0d8f838857dfc79daff40a8 (pc: make 'pc.rom'
readonly when machine has PCI enabled). It's just three lines added,
I'll paste the whole patch here. Not quite sure what can we do here though.


  diff --git a/hw/i386/pc.c b/hw/i386/pc.c
  index 22e16031b0..59435390ba 100644
  --- a/hw/i386/pc.c
  +++ b/hw/i386/pc.c
  @@ -1443,6 +1443,9 @@ void pc_memory_init(PCMachineState *pcms,
       option_rom_mr = g_malloc(sizeof(*option_rom_mr));
       memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                              &error_fatal);
  +    if (pcmc->pci_enabled) {
  +        memory_region_set_readonly(option_rom_mr, true);
  +    }
       memory_region_add_subregion_overlap(rom_memory,
                                           PC_ROM_MIN_VGA,
                                           option_rom_mr,


Thanks,
Anton


On 11/06/2017 02:55 AM, Bin Meng wrote:
> +QEMU dev list
>
> On Fri, Nov 3, 2017 at 10:07 PM, Anton Gerasimov
> <anton@advancedtelematic.com> wrote:
>> Hi all,
>>
>> I'm trying to use u-boot (v2017.01) with qemu-system-x86_64 v2.10.0 and
>> run into a "trying to execute code outside of RAM or ROM at xxxxx"
>> issue. It happens both when I build and use u-boot as a bios and as EFI
>> payload, just the addresses in the error message are different. On qemu
>> v2.5.0 at least EFI option works fine.
>>
>> I understand that it can be (and probably is) a QEMU issue, but maybe
>> someone on the list already encountered it and knows a workaround or has
>> successfully used u-boot with QEMU >=2.10.0 and can share their experience.
>>
> Yes, I just tested latest U-Boot x86 ROM image with QEMU 2.9.1 and
> 2.10.1. The same U-Boot ROM image boots with 2.9.1 but not with
> 2.10.1.
>
> I built U-Boot as follows:
>
> $ make qemu-x86_defconfig
> $ make
>
> Does anyone have any hints?
>
> Regards,
> Bin


-- 
Anton Gerasimov, ATS Advanced Telematic Systems GmbH
Kantstrasse 162, 10623 Berlin
Managing Directors: Dirk Pöschl, Armin G. Schmidt
Register Court: HRB 151501 B, Amtsgericht Charlottenburg
