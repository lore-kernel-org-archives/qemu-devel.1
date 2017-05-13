Received: from eggs.gnu.org ([2001:4830:134:3::10]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eDL-0005ir-F1
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eDI-0001ku-9e
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:04:35 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9eDI-0001k9-5E
	for qemu-devel@nongnu.org; Sat, 13 May 2017 17:04:32 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so12273797qka.3
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 14:04:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512083556.22539-1-maozy.fnst@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8387a72-2183-538f-970c-01335526183b@amsat.org>
Date: Sat, 13 May 2017 18:04:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170512083556.22539-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: jasowang@redhat.com, jiri@resnulli.us

Hi Mao,

You can use shorter patch subject "net/rocker" instead of 
"hw/net/rocker/rocker".

On 05/12/2017 05:35 AM, Mao Zhongyi wrote:
> Convert pci device .init() to .realize(). Also improve -device rocker
> error reporting. Because when -device rocker fails, it first reports
> a specific error, then a generic one, like this:
>
>     $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
>     rocker: name too long; please shorten to at most 9 chars
>     qemu-system-x86_64: -device rocker,name=qemu-rocker: Device initialization failed
>
> Convert pci_rocker_init() to Error to get rid of the unwanted second
> error message.
>
> Cc: jiri@resnulli.us
> Cc: jasowang@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/net/rocker/rocker.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 6e70fdd..2cebc31 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -1252,20 +1252,18 @@ rollback:
>      return err;
>  }
>
> -static int rocker_msix_init(Rocker *r)
> +static int rocker_msix_init(Rocker *r, Error **errp)
>  {
>      PCIDevice *dev = PCI_DEVICE(r);
>      int err;
> -    Error *local_err = NULL;
>
>      err = msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
>                      &r->msix_bar,
>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSET,
>                      &r->msix_bar,
>                      ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
> -                    0, &local_err);
> +                    0, errp);
>      if (err) {
> -        error_report_err(local_err);
>          return err;
>      }
>
> @@ -1301,7 +1299,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
>      return NULL;
>  }
>
> -static int pci_rocker_init(PCIDevice *dev)
> +static void pci_rocker_realize(PCIDevice *dev, Error **errp)
>  {
>      Rocker *r = to_rocker(dev);
>      const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
> @@ -1315,7 +1313,7 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
>          if (!r->worlds[i]) {
> -            err = -ENOMEM;
> +            error_setg(errp, "allocate worlds failed");
>              goto err_world_alloc;
>          }
>      }
> @@ -1326,10 +1324,9 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      r->world_dflt = rocker_world_type_by_name(r, r->world_name);
>      if (!r->world_dflt) {
> -        fprintf(stderr,
> -                "rocker: requested world \"%s\" does not exist\n",
> +        error_setg(errp,
> +                "rocker: invalid argument, requested world %s does not exist",
>                  r->world_name);
> -        err = -EINVAL;
>          goto err_world_type_by_name;
>      }
>
> @@ -1349,7 +1346,7 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      /* MSI-X init */
>
> -    err = rocker_msix_init(r);
> +    err = rocker_msix_init(r, errp);
>      if (err) {
>          goto err_msix_init;
>      }
> @@ -1361,7 +1358,7 @@ static int pci_rocker_init(PCIDevice *dev)
>      }
>
>      if (rocker_find(r->name)) {
> -        err = -EEXIST;
> +        error_setg(errp, "rocker %s already exists", r->name);

Use column to have consistent logging:

         error_setg(errp, "rocker: %s already exists", r->name);

>          goto err_duplicate;
>      }
>
> @@ -1375,10 +1372,10 @@ static int pci_rocker_init(PCIDevice *dev)
>  #define ROCKER_IFNAMSIZ 16
>  #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
>      if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
> -        fprintf(stderr,
> -                "rocker: name too long; please shorten to at most %d chars\n",
> +        error_setg(errp,
> +                "rocker: name too long; please shorten to at most %d chars",
>                  MAX_ROCKER_NAME_LEN);
> -        return -EINVAL;
> +        return;

I think the correct cleanup is: "goto err_duplicate;"

Or if you want to be more specific, add another goto label 
"err_name_too_long" before the "err_duplicate" label.

>      }
>
>      if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
> @@ -1410,7 +1407,6 @@ static int pci_rocker_init(PCIDevice *dev)
>       * .....
>       */
>
> -    err = -ENOMEM;
>      for (i = 0; i < rocker_pci_ring_count(r); i++) {
>          DescRing *ring = desc_ring_alloc(r, i);
>
> @@ -1447,7 +1443,7 @@ static int pci_rocker_init(PCIDevice *dev)
>
>      QLIST_INSERT_HEAD(&rockers, r, next);
>
> -    return 0;
> +    return;
>
>  err_port_alloc:
>      for (--i; i >= 0; i--) {
> @@ -1473,7 +1469,6 @@ err_world_alloc:
>              world_free(r->worlds[i]);
>          }
>      }
> -    return err;
>  }
>
>  static void pci_rocker_uninit(PCIDevice *dev)
> @@ -1558,7 +1553,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>
> -    k->init = pci_rocker_init;
> +    k->realize = pci_rocker_realize;
>      k->exit = pci_rocker_uninit;
>      k->vendor_id = PCI_VENDOR_ID_REDHAT;
>      k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
>
