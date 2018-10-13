Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBQeJ-0007Vb-UI
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBQeF-00031s-Ud
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:36:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBQeF-0002z3-FT
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:36:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id 189-v6so15277147wmw.2
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 13:36:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181013063153.54423-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4be0614-a8c3-c3d1-9f36-8437b4dfcf90@amsat.org>
Date: Sat, 13 Oct 2018 22:36:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181013063153.54423-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: ne2000: make it more QOMconventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, jasowang@redhat.com
Cc: qemu-devel@nongnu.org

Hi Li,

On 10/13/18 8:31 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/net/ne2000.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
> index 07d79e317f..ab71ad49cb 100644
> --- a/hw/net/ne2000.c
> +++ b/hw/net/ne2000.c
> @@ -33,6 +33,10 @@
>  
>  #define MAX_ETH_FRAME_SIZE 1514
>  
> +#define TYPE_NE2000 "ne2k_pci"
> +#define NE2000(obj) \
> +    OBJECT_CHECK(PCINE2000State, (obj), TYPE_NE2000)

If the NIC models are similar to the devices TYPE, you can move the
previous definitions in a new header "hw/net/ne2000.h", then you can
then use it in:
 . hw/ppc/mac_newworld.c
 . hw/ppc/mac_oldworld.c
 . hw/ppc/prep.c

as:

- pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+ pci_nic_init_nofail(&nd_table[i], pci_bus, TYPE_NE2000, NULL);

Let's see what Jason think about it first.

> +
>  #define E8390_CMD	0x00  /* The command register (for all pages) */
>  /* Page 0 register offsets. */
>  #define EN0_CLDALO	0x01	/* Low byte of current local dma addr  RD */
> @@ -720,7 +724,7 @@ static NetClientInfo net_ne2000_info = {
>  
>  static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
>  {
> -    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> +    PCINE2000State *d = NE2000(pci_dev);
>      NE2000State *s;
>      uint8_t *pci_conf;
>  
> @@ -742,7 +746,7 @@ static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
>  
>  static void pci_ne2000_exit(PCIDevice *pci_dev)
>  {
> -    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> +    PCINE2000State *d = NE2000(pci_dev);
>      NE2000State *s = &d->ne2000;
>  
>      qemu_del_nic(s->nic);
> @@ -751,13 +755,12 @@ static void pci_ne2000_exit(PCIDevice *pci_dev)
>  
>  static void ne2000_instance_init(Object *obj)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> +    PCINE2000State *d = NE2000(obj);
>      NE2000State *s = &d->ne2000;
>  
>      device_add_bootindex_property(obj, &s->c.bootindex,
>                                    "bootindex", "/ethernet-phy@0",
> -                                  &pci_dev->qdev, NULL);
> +                                  DEVICE(obj), NULL);
>  }
>  
>  static Property ne2000_properties[] = {
> @@ -782,7 +785,7 @@ static void ne2000_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo ne2000_info = {
> -    .name          = "ne2k_pci",
> +    .name          = TYPE_NE2000,
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(PCINE2000State),
>      .class_init    = ne2000_class_init,
> 
