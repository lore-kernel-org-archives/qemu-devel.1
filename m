Received: from eggs.gnu.org ([209.51.188.92]:57628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAwRj-00048u-Q0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAwRi-00015f-OM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:53:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hAwRi-00014u-HH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:53:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so11906038wro.5
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 05:53:49 -0700 (PDT)
References: <20190316223918.11917-1-philmd@redhat.com>
	<20190316223918.11917-2-philmd@redhat.com>
	<f199e63e-9d96-929c-7bbc-006fa5385e53@redhat.com>
	<f4edff28-ba4f-4b50-c992-69051a115b69@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <542a726f-cf64-418d-9dfa-3d04798fa454@redhat.com>
Date: Mon, 1 Apr 2019 14:53:46 +0200
MIME-Version: 1.0
In-Reply-To: <f4edff28-ba4f-4b50-c992-69051a115b69@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] hw/isa/Kconfig: PIIX4 southbridge
 requires USB UHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 3/25/19 5:55 AM, Thomas Huth wrote:
> On 25/03/2019 05.49, Thomas Huth wrote:
>> On 16/03/2019 23.39, Philippe Mathieu-Daudé wrote:
>>> This fixes when configuring with --without-default-devices:
>>>
>>>   $ qemu-system-mips64 -M malta --nodefaults -bios /dev/null
>>>   qemu-system-mips64: Unknown device 'piix4-usb-uhci' for bus 'PCI'
>>>   Aborted (core dumped)
>>>
>>>   (gdb) bt
>>>   #0  0x00007ffff5a4353f in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
>>>   #1  0x00007ffff5a2d895 in __GI_abort () at abort.c:79
>>>   #2  0x00005555558745c3 in qdev_create (bus=bus@entry=0x555556336260, name=name@entry=0x555555b13a4d "piix4-usb-uhci") at hw/core/qdev.c:131
>>>   #3  0x00005555558cb3e1 in pci_create_multifunction (bus=bus@entry=0x555556336260, devfn=devfn@entry=82, multifunction=multifunction@entry=false, name=name@entry=0x555555b13a4d "piix4-usb-uhci") at hw/pci/pci.c:2104
>>>   #4  0x00005555558cb88b in pci_create_simple_multifunction (name=name@entry=0x555555b13a4d "piix4-usb-uhci", multifunction=false, devfn=devfn@entry=82, bus=bus@entry=0x555556336260) at hw/pci/pci.c:2126
>>>   #5  0x00005555558cb88b in pci_create_simple (bus=bus@entry=0x555556336260, devfn=devfn@entry=82, name=name@entry=0x555555b13a4d "piix4-usb-uhci") at hw/pci/pci.c:2126
>>>   #6  0x000055555575ea38 in mips_malta_init (machine=0x555555ffe430) at hw/mips/mips_malta.c:1392
>>>   #7  0x000055555587bf2b in machine_run_board_init (machine=0x555555ffe430) at hw/core/machine.c:1030
>>>
>>> Fixes: 7c28b925b7e
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  hw/isa/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>>> index 57e09a0cb8..c942b47d03 100644
>>> --- a/hw/isa/Kconfig
>>> +++ b/hw/isa/Kconfig
>>> @@ -29,6 +29,7 @@ config PIIX4
>>>      # For historical reasons, SuperIO devices are created in the board
>>>      # for PIIX4.
>>>      select ISA_BUS
>>> +    select USB_UHCI
>>
>> The UHCI controller is not instantiated by hw/isa/piix4.c, but by
>> hw/mips/mips_malta.c as far as I can see. And you can use the "pc"
>> machine also without uhci. So I think this patch is wrong, the select
>> should be done by "MALTA" instead.
> 
> Ah, never mind, I mixed up piix3-usb-uhci (used by "pc") and
> piix4-usb-uhci (used by "malta"). ... So this UHCI is part of the
> chipset? Then I think your patch is fine.

Yes, UHCI is introduced in the PIIX3 chipset. In another series
(postponed to 4.1) PIIX4 inherit of PIIX3 features.
Meanwhile, this patch is a quick fix for 4.0.

Thanks,

Phil.
