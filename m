Received: from eggs.gnu.org ([2001:4830:134:3::10]:42757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYBEW-0006sq-IY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYBET-0001cU-AB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:15:44 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYBET-0001cA-5D
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:15:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id c131-v6so1108479qkb.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 07:15:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627115836.25092-1-kraxel@redhat.com>
	<20180627115836.25092-2-kraxel@redhat.com>
	<10b74818-155c-bdc8-ca0e-c7239be35673@amsat.org>
	<20180627135115.jk3d4mcuhmlznkc7@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <03d6f15b-35b2-5a9f-15d8-fa3a055590ff@amsat.org>
Date: Wed, 27 Jun 2018 11:15:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180627135115.jk3d4mcuhmlznkc7@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 10:51 AM, Gerd Hoffmann wrote:
> On Wed, Jun 27, 2018 at 10:10:17AM -0300, Philippe Mathieu-Daudé wrote:
>> Hi Gerd,
>>
>> On 06/27/2018 08:58 AM, Gerd Hoffmann wrote:
>>> Two vga cards will listen on the same legacy (isa) ioports.  Due to this
>>> conflict only one of the two cards will work correctly in vga mode.
>>
>> The last one registered...
>>
>>> Print a warning message in that case.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  hw/display/vga.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/display/vga.c b/hw/display/vga.c
>>> index c82e6d240a..a6c246f76b 100644
>>> --- a/hw/display/vga.c
>>> +++ b/hw/display/vga.c
>>> @@ -2273,6 +2273,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>>>  void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>>>                MemoryRegion *address_space_io, bool init_vga_ports)
>>>  {
>>> +    static bool vgaports_registered;
>>>      MemoryRegion *vga_io_memory;
>>>      const MemoryRegionPortio *vga_ports, *vbe_ports;
>>>  
>>> @@ -2289,6 +2290,11 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>>>                                          1);
>>>      memory_region_set_coalescing(vga_io_memory);
>>>      if (init_vga_ports) {
>>> +        if (vgaports_registered) {
>>> +            warn_report("multiple vga cards may not work as expected");
>>> +        } else {
>>> +            vgaports_registered = true;
>>> +        }
>>>          portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
>>
>> Here we leak s->vga_port_list->regions from the 1st card.
>> Can we call portio_list_destroy() in the if (vgaports_registered) block?
> 
> We don't have a pointer at hand.  Easier would be to only register
> the ports in the else block.

I was thinking of:

        if (vgaports_registered) {
            warn_report("multiple vga cards may not work as expected");
            portio_list_destroy(&s->vga_port_list);
        } else {
            vgaports_registered = true;
        }

But "only register the ports in the else block" is easier indeed.

> 
> Or throw an error in the if (vgaports_registered) block instead of
> printing a warning only.
> 
> Hmm ...

Let's see if there interested user replying to this thread...
