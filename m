Received: from eggs.gnu.org ([2001:4830:134:3::10]:58648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct3Xr-00072A-KP
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct3Xn-0000tb-0L
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct3Xm-0000sd-Nk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:41:06 -0400
References: <20170327044030.31306-1-aik@ozlabs.ru>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <748df0cd-f088-5dc9-f5a4-f46c37b7f210@redhat.com>
Date: Wed, 29 Mar 2017 10:40:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170327044030.31306-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Add missing drop of bus master
 AS reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>



On 2017=E5=B9=B403=E6=9C=8827=E6=97=A5 12:40, Alexey Kardashevskiy wrote:
> The recent introduction of a bus master container added
> memory_region_add_subregion() into the PCI device registering path but
> missed memory_region_del_subregion() in the unregistering path leaving
> a reference to the root memory region of the new container.
>
> This adds missing memory_region_del_subregion().
>
> Fixes: 3716d5902d743 ("pci: introduce a bus master container")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   hw/pci/pci.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e6b08e1988..bd8043c460 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci=
_dev)
>       pci_dev->bus->devices[pci_dev->devfn] =3D NULL;
>       pci_config_free(pci_dev);
>  =20
> +    memory_region_del_subregion(&pci_dev->bus_master_container_region,
> +                                &pci_dev->bus_master_enable_region);
>       address_space_destroy(&pci_dev->bus_master_as);
>   }
>  =20

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks!
