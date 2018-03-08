Received: from eggs.gnu.org ([2001:4830:134:3::10]:44050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etrRs-0006P4-A4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etrRn-0003tk-DS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:02:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etrRn-0003tV-8v
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:02:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2894FD1437
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 09:02:36 +0000 (UTC)
References: <20180306194600.9650-1-pbonzini@redhat.com>
	<20180306194600.9650-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ab061320-f21b-4a97-4abe-76ba33c7f1c1@redhat.com>
Date: Thu, 8 Mar 2018 10:02:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180306194600.9650-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 06.03.2018 20:45, Paolo Bonzini wrote:
> Remove the hard-coded list of PCI NIC names; instead, fill an array
> using all PCI devices listed under DEVICE_CATEGORY_NETWORK. Keep
> the old shortcut "virtio" for virtio-net-pci.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/pci/pci.c | 61 ++++++++++++++++++++++++++++++----------------------=
--------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2174c254eb..aa24a26680 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1815,49 +1815,48 @@ PciInfoList *qmp_query_pci(Error **errp)
>      return head;
>  }
> =20
> -static const char * const pci_nic_models[] =3D {
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
> -static const char * const pci_nic_names[] =3D {
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
>      const char *devaddr =3D nd->devaddr ? nd->devaddr : default_devadd=
r;
> +    GSList *list;
> +    GPtrArray *pci_nic_models;
>      PCIBus *bus;
>      PCIDevice *pci_dev;
>      DeviceState *dev;
>      int devfn;
>      int i;
> =20
> -    if (qemu_show_nic_models(nd->model, pci_nic_models)) {
> +    if (!strcmp(nd->model, "virtio")) {
> +        g_free(nd->model);
> +        nd->model =3D g_strdup("virtio-net-pci");

Should we maybe also print out a deprecation message in this case, so
that we could get rid of this hack in a couple of releases? (i.e. only
allow "virtio-net-pci" in future releases?)

> +    }
> +
> +    list =3D object_class_get_list_sorted(TYPE_PCI_DEVICE, false);
> +    pci_nic_models =3D g_ptr_array_new_with_free_func(g_free);

OK, so that means that the entries will be freed when the array is
destroyed, right? ...

> +    while (list) {
> +        DeviceClass *dc =3D OBJECT_CLASS_CHECK(DeviceClass, list->data=
,
> +                                             TYPE_DEVICE);
> +        GSList *next;
> +        if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
> +            dc->user_creatable) {
> +            const char *name =3D object_class_get_name(list->data) ;

... but object_class_get_name() returns the original name, not a
g_strdup of it, right?
(apart from that: Please remove the space before the semicolon)

> +            g_ptr_array_add(pci_nic_models, (gpointer)name);
> +        }
> +        next =3D list->next;
> +        g_slist_free_1(list);
> +        list =3D next;
> +    }
> +    g_ptr_array_add(pci_nic_models, NULL);
> +
> +    if (qemu_show_nic_models(nd->model, (const char **)pci_nic_models-=
>pdata)) {
>          exit(0);
>      }
> =20
> -    i =3D qemu_find_nic_model(nd, pci_nic_models, default_model);
> +    i =3D qemu_find_nic_model(nd, (const char **)pci_nic_models->pdata=
,
> +                            default_model);
>      if (i < 0) {
>          exit(1);
>      }
> @@ -1865,15 +1864,15 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCI=
Bus *rootbus,
>      bus =3D pci_get_bus_devfn(&devfn, rootbus, devaddr);
>      if (!bus) {
>          error_report("Invalid PCI device address %s for device %s",
> -                     devaddr, pci_nic_names[i]);
> +                     devaddr, nd->model);
>          exit(1);
>      }
> =20
> -    pci_dev =3D pci_create(bus, devfn, pci_nic_names[i]);
> +    pci_dev =3D pci_create(bus, devfn, nd->model);
>      dev =3D &pci_dev->qdev;
>      qdev_set_nic_properties(dev, nd);
>      qdev_init_nofail(dev);
> -
> +    g_ptr_array_free(pci_nic_models, true);

... so this will g_free the original pointers of the device classes - I
guess this will sooner or later cause some trouble.

Apart from that, I really like this patch - that hard-coded
pci_nic_models[] was really ugly.

 Thomas
