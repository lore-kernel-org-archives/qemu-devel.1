Received: from eggs.gnu.org ([2001:4830:134:3::10]:55107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEGr-0000ff-3V
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEGo-00012V-03
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:52:37 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEGn-00012N-SM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:52:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id m5-v6so25344660qti.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:52:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
	<20180522165058.15404-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <efdfa65b-2375-834b-b102-e650c1047d38@amsat.org>
Date: Tue, 22 May 2018 17:52:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180522165058.15404-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] bochs-display: add pcie support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi Gerd,

On 05/22/2018 01:50 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/bochs-display.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index 9607df1c34..c33524b558 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -253,6 +253,7 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
>  {
>      BochsDisplayState *s = BOCHS_DISPLAY(dev);
>      Object *obj = OBJECT(dev);
> +    int ret;
>  
>      s->con = graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_ops, s);
>  
> @@ -280,6 +281,12 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
>      pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
>      pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
>  
> +    if (pci_bus_is_express(pci_get_bus(dev))) {
> +        dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> +        ret = pcie_endpoint_cap_init(dev, 0x80);
> +        assert(ret > 0);

Maybe error_setg(errp, ...) && return?

> +    }
> +
>      memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
>  }
>  
> @@ -342,6 +349,7 @@ static const TypeInfo bochs_display_type_info = {
>      .instance_init  = bochs_display_init,
>      .class_init     = bochs_display_class_init,
>      .interfaces     = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
>      },
> 
