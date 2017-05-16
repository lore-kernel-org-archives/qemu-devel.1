Received: from eggs.gnu.org ([2001:4830:134:3::10]:37659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWF8-0002di-39
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWF4-00071I-W6
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAWF4-000715-Mk
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:45:58 -0400
References: <20170512083556.22539-1-maozy.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2ac2c29a-f6b0-401a-2355-357c490ef14b@redhat.com>
Date: Tue, 16 May 2017 14:45:50 +0800
MIME-Version: 1.0
In-Reply-To: <20170512083556.22539-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/net/rocker/rocker: Convert pci device
 .init() to .realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: jiri@resnulli.us



On 2017=E5=B9=B405=E6=9C=8812=E6=97=A5 16:35, Mao Zhongyi wrote:
> Convert pci device .init() to .realize(). Also improve -device rocker
> error reporting. Because when -device rocker fails, it first reports
> a specific error, then a generic one, like this:
>
>      $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=3Dqemu-roc=
ker
>      rocker: name too long; please shorten to at most 9 chars
>      qemu-system-x86_64: -device rocker,name=3Dqemu-rocker: Device init=
ialization failed
>
> Convert pci_rocker_init() to Error to get rid of the unwanted second
> error message.
>
> Cc: jiri@resnulli.us
> Cc: jasowang@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   hw/net/rocker/rocker.c | 31 +++++++++++++------------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 6e70fdd..2cebc31 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1252,20 +1252,18 @@ rollback:
>       return err;
>   }
>  =20
> -static int rocker_msix_init(Rocker *r)
> +static int rocker_msix_init(Rocker *r, Error **errp)
>   {
>       PCIDevice *dev =3D PCI_DEVICE(r);
>       int err;
> -    Error *local_err =3D NULL;
>  =20
>       err =3D msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
>                       &r->msix_bar,
>                       ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OF=
FSET,
>                       &r->msix_bar,
>                       ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFS=
ET,
> -                    0, &local_err);
> +                    0, errp);
>       if (err) {
> -        error_report_err(local_err);
>           return err;
>       }
>  =20
> @@ -1301,7 +1299,7 @@ static World *rocker_world_type_by_name(Rocker *r=
, const char *name)
>       return NULL;
>   }
>  =20
> -static int pci_rocker_init(PCIDevice *dev)
> +static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>   {
>       Rocker *r =3D to_rocker(dev);
>       const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> @@ -1315,7 +1313,7 @@ static int pci_rocker_init(PCIDevice *dev)
>  =20
>       for (i =3D 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
>           if (!r->worlds[i]) {
> -            err =3D -ENOMEM;
> +            error_setg(errp, "allocate worlds failed");
>               goto err_world_alloc;
>           }
>       }
> @@ -1326,10 +1324,9 @@ static int pci_rocker_init(PCIDevice *dev)
>  =20
>       r->world_dflt =3D rocker_world_type_by_name(r, r->world_name);
>       if (!r->world_dflt) {
> -        fprintf(stderr,
> -                "rocker: requested world \"%s\" does not exist\n",
> +        error_setg(errp,
> +                "rocker: invalid argument, requested world %s does not=
 exist",
>                   r->world_name);
> -        err =3D -EINVAL;
>           goto err_world_type_by_name;
>       }
>  =20
> @@ -1349,7 +1346,7 @@ static int pci_rocker_init(PCIDevice *dev)
>  =20
>       /* MSI-X init */
>  =20
> -    err =3D rocker_msix_init(r);
> +    err =3D rocker_msix_init(r, errp);
>       if (err) {
>           goto err_msix_init;
>       }
> @@ -1361,7 +1358,7 @@ static int pci_rocker_init(PCIDevice *dev)
>       }
>  =20
>       if (rocker_find(r->name)) {
> -        err =3D -EEXIST;
> +        error_setg(errp, "rocker %s already exists", r->name);
>           goto err_duplicate;
>       }
>  =20
> @@ -1375,10 +1372,10 @@ static int pci_rocker_init(PCIDevice *dev)
>   #define ROCKER_IFNAMSIZ 16
>   #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
>       if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
> -        fprintf(stderr,
> -                "rocker: name too long; please shorten to at most %d c=
hars\n",
> +        error_setg(errp,
> +                "rocker: name too long; please shorten to at most %d c=
hars",
>                   MAX_ROCKER_NAME_LEN);
> -        return -EINVAL;
> +        return;
>       }
>  =20
>       if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) =3D=3D 0) {
> @@ -1410,7 +1407,6 @@ static int pci_rocker_init(PCIDevice *dev)
>        * .....
>        */
>  =20
> -    err =3D -ENOMEM;
>       for (i =3D 0; i < rocker_pci_ring_count(r); i++) {
>           DescRing *ring =3D desc_ring_alloc(r, i);

Do you need to call error_setg() for the failure below too?

Thanks

>  =20
> @@ -1447,7 +1443,7 @@ static int pci_rocker_init(PCIDevice *dev)
>  =20
>       QLIST_INSERT_HEAD(&rockers, r, next);
>  =20
> -    return 0;
> +    return;
>  =20
>   err_port_alloc:
>       for (--i; i >=3D 0; i--) {
> @@ -1473,7 +1469,6 @@ err_world_alloc:
>               world_free(r->worlds[i]);
>           }
>       }
> -    return err;
>   }
>  =20
>   static void pci_rocker_uninit(PCIDevice *dev)
> @@ -1558,7 +1553,7 @@ static void rocker_class_init(ObjectClass *klass,=
 void *data)
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>  =20
> -    k->init =3D pci_rocker_init;
> +    k->realize =3D pci_rocker_realize;
>       k->exit =3D pci_rocker_uninit;
>       k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
>       k->device_id =3D PCI_DEVICE_ID_REDHAT_ROCKER;
