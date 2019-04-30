Received: from eggs.gnu.org ([209.51.188.92]:40721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLYMf-0003AH-Li
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLYKL-0002sC-D8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:22:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLYKK-0002rQ-Ov
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:22:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so10376489wra.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 12:22:04 -0700 (PDT)
References: <20190430191552.4027-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e384dcb-5f43-c718-15be-2577e1df69e0@redhat.com>
Date: Tue, 30 Apr 2019 21:22:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190430191552.4027-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/pci-host: Use
 object_initialize_child for correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org, qemu-trivial@nongnu.org

On 4/30/19 9:15 PM, Thomas Huth wrote:
> Both functions, object_initialize() and object_property_add_child() increase
> the reference counter of the new object, so one of the references has to be
> dropped afterwards to get the reference counting right. Otherwise the child
> object might not be properly cleaned up when the parent gets destroyed.
> Some functions of the pci-host devices miss to drop one of the references.
> Fix it by using object_initialize_child() instead, which takes care of
> calling object_initialize(), object_property_add_child() and object_unref()
> in the right order.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  v2: Added missing &error_abort parameter in xilinx-pcie.c

(I had this patch queued locally since pre-release, but haven't got to
respin my series yet, sorry.)

> 
>  hw/pci-host/designware.c  | 4 ++--
>  hw/pci-host/gpex.c        | 5 +++--
>  hw/pci-host/q35.c         | 4 ++--
>  hw/pci-host/xilinx-pcie.c | 4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 29ea313798..64ad21d295 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -721,8 +721,8 @@ static void designware_pcie_host_init(Object *obj)
>      DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
>      DesignwarePCIERoot *root = &s->root;
>  
> -    object_initialize(root, sizeof(*root), TYPE_DESIGNWARE_PCIE_ROOT);
> -    object_property_add_child(obj, "root", OBJECT(root), NULL);
> +    object_initialize_child(obj, "root",  root, sizeof(*root),
> +                            TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NULL);
>      qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>  }
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 2583b151a4..1bafffcc34 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -29,6 +29,7 @@
>   * http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
>   */
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/pci-host/gpex.h"
>  
> @@ -120,8 +121,8 @@ static void gpex_host_initfn(Object *obj)
>      GPEXHost *s = GPEX_HOST(obj);
>      GPEXRootState *root = &s->gpex_root;
>  
> -    object_initialize(root, sizeof(*root), TYPE_GPEX_ROOT_DEVICE);
> -    object_property_add_child(obj, "gpex_root", OBJECT(root), NULL);
> +    object_initialize_child(obj, "gpex_root",  root, sizeof(*root),
> +                            TYPE_GPEX_ROOT_DEVICE, &error_abort, NULL);
>      qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>  }
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 7b871b5734..960939f5ed 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -216,8 +216,8 @@ static void q35_host_initfn(Object *obj)
>      memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
>                            "pci-conf-data", 4);
>  
> -    object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
> -    object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
> +    object_initialize_child(OBJECT(s), "mch",  &s->mch, sizeof(s->mch),
> +                            TYPE_MCH_PCI_DEVICE, &error_abort, NULL);
>      qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
>      /* mch's object_initialize resets the default value, set it again */
> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
> index 60309afe9e..ceb00e23e6 100644
> --- a/hw/pci-host/xilinx-pcie.c
> +++ b/hw/pci-host/xilinx-pcie.c
> @@ -149,8 +149,8 @@ static void xilinx_pcie_host_init(Object *obj)
>      XilinxPCIEHost *s = XILINX_PCIE_HOST(obj);
>      XilinxPCIERoot *root = &s->root;
>  
> -    object_initialize(root, sizeof(*root), TYPE_XILINX_PCIE_ROOT);
> -    object_property_add_child(obj, "root", OBJECT(root), NULL);
> +    object_initialize_child(obj, "root",  root, sizeof(*root),
> +                            TYPE_XILINX_PCIE_ROOT, &error_abort, NULL);
>      qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
>      qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>  }
> 
