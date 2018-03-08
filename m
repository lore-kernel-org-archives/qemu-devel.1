Received: from eggs.gnu.org ([2001:4830:134:3::10]:54486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu0fo-0001GW-PF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu0fj-0006JB-S7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:53:52 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu0fj-0006Ip-IJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:53:47 -0500
Received: by mail-wm0-x241.google.com with SMTP id h21so1223518wmd.1
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 10:53:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180308172834.3281-1-pbonzini@redhat.com>
	<20180308172834.3281-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b5b322a5-38d0-f7e0-10e1-c43c3a7bad58@amsat.org>
Date: Thu, 8 Mar 2018 15:53:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180308172834.3281-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] net: allow using any PCI NICs in -net
 or -nic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

On 03/08/2018 02:28 PM, Paolo Bonzini wrote:
> Remove the hard-coded list of PCI NIC names; instead, fill an array
> using all PCI devices listed under DEVICE_CATEGORY_NETWORK. Keep
> the old shortcut "virtio" for virtio-net-pci.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci/pci.c | 61 ++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2174c254eb..67a3f72bd6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1815,49 +1815,48 @@ PciInfoList *qmp_query_pci(Error **errp)
>      return head;
>  }
>  
> -static const char * const pci_nic_models[] = {
> -    "ne2k_pci",
> -    "i82551",
> -    "i82557b",
> -    "i82559er",
> -    "rtl8139",
> -    "e1000",
> -    "pcnet",
> -    "virtio",
> -    "sungem",
> -    NULL
> -};
> -
> -static const char * const pci_nic_names[] = {
> -    "ne2k_pci",
> -    "i82551",
> -    "i82557b",
> -    "i82559er",
> -    "rtl8139",
> -    "e1000",
> -    "pcnet",
> -    "virtio-net-pci",
> -    "sungem",
> -    NULL
> -};
> -
>  /* Initialize a PCI NIC.  */
>  PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>                                 const char *default_model,
>                                 const char *default_devaddr)
>  {
>      const char *devaddr = nd->devaddr ? nd->devaddr : default_devaddr;
> +    GSList *list;
> +    GPtrArray *pci_nic_models;
>      PCIBus *bus;
>      PCIDevice *pci_dev;
>      DeviceState *dev;
>      int devfn;
>      int i;
>  
> -    if (qemu_show_nic_models(nd->model, pci_nic_models)) {
> +    if (nd->model && !strcmp(nd->model, "virtio")) {
> +        g_free(nd->model);
> +        nd->model = g_strdup("virtio-net-pci");
> +    }
> +
> +    list = object_class_get_list_sorted(TYPE_PCI_DEVICE, false);
> +    pci_nic_models = g_ptr_array_new();
> +    while (list) {
> +        DeviceClass *dc = OBJECT_CLASS_CHECK(DeviceClass, list->data,
> +                                             TYPE_DEVICE);
> +        GSList *next;
> +        if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
> +            dc->user_creatable) {
> +            const char *name = object_class_get_name(list->data);
> +            g_ptr_array_add(pci_nic_models, (gpointer)name);
> +        }
> +        next = list->next;
> +        g_slist_free_1(list);
> +        list = next;
> +    }
> +    g_ptr_array_add(pci_nic_models, NULL);
> +
> +    if (qemu_show_nic_models(nd->model, (const char **)pci_nic_models->pdata)) {
>          exit(0);
>      }
>  
> -    i = qemu_find_nic_model(nd, pci_nic_models, default_model);
> +    i = qemu_find_nic_model(nd, (const char **)pci_nic_models->pdata,
> +                            default_model);
>      if (i < 0) {
>          exit(1);
>      }
> @@ -1865,15 +1864,15 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>      bus = pci_get_bus_devfn(&devfn, rootbus, devaddr);
>      if (!bus) {
>          error_report("Invalid PCI device address %s for device %s",
> -                     devaddr, pci_nic_names[i]);
> +                     devaddr, nd->model);
>          exit(1);
>      }
>  
> -    pci_dev = pci_create(bus, devfn, pci_nic_names[i]);
> +    pci_dev = pci_create(bus, devfn, nd->model);
>      dev = &pci_dev->qdev;
>      qdev_set_nic_properties(dev, nd);
>      qdev_init_nofail(dev);
> -
> +    g_ptr_array_free(pci_nic_models, true);
>      return pci_dev;
>  }
>  
> 
