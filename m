Received: from eggs.gnu.org ([2001:4830:134:3::10]:50518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZatB-0002Oe-Gp
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZat7-0001a7-Tg
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:23:49 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60587
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gZat7-0001WR-GZ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:23:45 -0500
References: <20181216215210.29088-1-huth@tuxfamily.org>
	<alpine.BSF.2.21.9999.1812171247380.61996@zero.eik.bme.hu>
	<20181218212614.385f4b5b@thl530>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <74b7c248-163e-f4a0-c889-59648801e023@ilande.co.uk>
Date: Wed, 19 Dec 2018 12:23:31 +0000
MIME-Version: 1.0
In-Reply-To: <20181218212614.385f4b5b@thl530>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64: Create VGA device only if it
 has really been requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On 18/12/2018 20:26, Thomas Huth wrote:

> Am Mon, 17 Dec 2018 12:48:31 +0100 (CET)
> schrieb BALATON Zoltan <balaton@eik.bme.hu>:
> 
>> On Sun, 16 Dec 2018, Thomas Huth wrote:
>>> The sun4u/sun4v machine currently always creates a VGA device, even
>>> if the user started QEMU with "-nodefaults" or "-vga none". That's
>>> likely not what the users expect in this case, so add a check
>>> whether the VGA adapter has really been requested.
>>>
>>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>>> ---
>>> hw/sparc64/sun4u.c | 10 +++++++++-
>>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>> index f76b19e4e9..ce7236c322 100644
>>> --- a/hw/sparc64/sun4u.c
>>> +++ b/hw/sparc64/sun4u.c
>>> @@ -596,7 +596,15 @@ static void sun4uv_init(MemoryRegion
>>> *address_space_mem, qdev_connect_gpio_out_named(DEVICE(ebus),
>>> "isa-irq", 4, qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq",
>>> OBIO_SER_IRQ));
>>>
>>> -    pci_dev = pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
>>> +    switch (vga_interface_type) {
>>> +    case VGA_STD:
>>> +        pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
>>> +        break;
>>> +    case VGA_NONE:
>>> +        break;
>>> +    default:
>>> +       abort();   /* Should not happen - types are checked in vl.c
>>> already */  
>>
>> Can't comment on the actual patch but looks like a whitespace is
>> missing here.
> 
> Oops. Mark, can you fix it up when applying the patch (if you don't
> object it)? Or shall I resend?

That's okay, I can fix this up easily enough.

> By the way, would it make sense to enable virtio-vga for the sun4u
> machines, too?

Hmmm that's one thing I haven't really tested - is there any reason to use this over
the bochs_drm driver?


ATB,

Mark.
