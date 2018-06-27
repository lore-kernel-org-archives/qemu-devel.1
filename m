Received: from eggs.gnu.org ([2001:4830:134:3::10]:52376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYADI-0004c1-R1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYADF-00006M-IQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:10:24 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYADF-00005e-84
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:10:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id h5-v6so1512406qtm.13
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:10:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180627115836.25092-1-kraxel@redhat.com>
	<20180627115836.25092-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10b74818-155c-bdc8-ca0e-c7239be35673@amsat.org>
Date: Wed, 27 Jun 2018 10:10:17 -0300
MIME-Version: 1.0
In-Reply-To: <20180627115836.25092-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Gerd,

On 06/27/2018 08:58 AM, Gerd Hoffmann wrote:
> Two vga cards will listen on the same legacy (isa) ioports.  Due to this
> conflict only one of the two cards will work correctly in vga mode.

The last one registered...

> Print a warning message in that case.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index c82e6d240a..a6c246f76b 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2273,6 +2273,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>  void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>                MemoryRegion *address_space_io, bool init_vga_ports)
>  {
> +    static bool vgaports_registered;
>      MemoryRegion *vga_io_memory;
>      const MemoryRegionPortio *vga_ports, *vbe_ports;
>  
> @@ -2289,6 +2290,11 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>                                          1);
>      memory_region_set_coalescing(vga_io_memory);
>      if (init_vga_ports) {
> +        if (vgaports_registered) {
> +            warn_report("multiple vga cards may not work as expected");
> +        } else {
> +            vgaports_registered = true;
> +        }
>          portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");

Here we leak s->vga_port_list->regions from the 1st card.
Can we call portio_list_destroy() in the if (vgaports_registered) block?

>          portio_list_set_flush_coalesced(&s->vga_port_list);
>          portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
> 

Regards,

Phil.
