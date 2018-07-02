Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2Dl-0002Ih-Ql
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2Dh-0006vm-Sv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:02:37 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2Dh-0006vC-MV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:02:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id y5-v6so4616890qti.12
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:02:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702163345.17892-1-kraxel@redhat.com>
	<20180702163345.17892-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a182d6bd-84af-cbd9-1b5a-9cc0739dfe27@amsat.org>
Date: Mon, 2 Jul 2018 14:02:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180702163345.17892-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 07/02/2018 01:33 PM, Gerd Hoffmann wrote:
> Two vga cards will try to register for the same legacy (isa) ioports.
> Due to this conflict only one of the two cards will work correctly in
> vga mode.
> 
> Print a warning message in that case.  Also try registering the ports
> only once, so the first vga added to the system will work properly.

And you also fixed a memory leak.

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/vga.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index c82e6d240a..e811571624 100644
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
> @@ -2289,9 +2290,14 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
>                                          1);
>      memory_region_set_coalescing(vga_io_memory);
>      if (init_vga_ports) {
> -        portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
> -        portio_list_set_flush_coalesced(&s->vga_port_list);
> -        portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
> +        if (vgaports_registered) {
> +            warn_report("multiple vga cards may not work as expected");
> +        } else {
> +            portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
> +            portio_list_set_flush_coalesced(&s->vga_port_list);
> +            portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
> +            vgaports_registered = true;
> +        }
>      }
>      if (vbe_ports) {
>          portio_list_init(&s->vbe_port_list, obj, vbe_ports, s, "vbe");
> 
