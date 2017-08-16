Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dhv1q-0006fY-Ma
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dhv1n-0002ac-Jv
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dhv1n-0002Zn-AA
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:54:19 -0400
References: <1502640203-15577-1-git-send-email-zuban32s@gmail.com>
	<1502640203-15577-3-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f49fdca4-1721-d18d-a8b5-6a5a2c21e5c5@redhat.com>
Date: Wed, 16 Aug 2017 12:54:07 +0300
MIME-Version: 1.0
In-Reply-To: <1502640203-15577-3-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 2/3] pci: add QEMU-specific PCI
 capability structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: mst@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

On 13/08/2017 19:03, Aleksandr Bezzubikov wrote:
> On PCI init PCI bridge devices may need some
> extra info about bus number to reserve, IO, memory and
> prefetchable memory limits. QEMU can provide this
> with special vendor-specific PCI capability.
> 
> This capability is intended to be used only
> for Red Hat PCI bridges, i.e. QEMU cooperation.
> 


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   src/fw/dev-pci.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 src/fw/dev-pci.h
> 
> diff --git a/src/fw/dev-pci.h b/src/fw/dev-pci.h
> new file mode 100644
> index 0000000..0dc5556
> --- /dev/null
> +++ b/src/fw/dev-pci.h
> @@ -0,0 +1,53 @@
> +#ifndef _PCI_CAP_H
> +#define _PCI_CAP_H
> +
> +#include "types.h"
> +
> +/*
> + *
> + * QEMU-specific vendor(Red Hat)-specific capability.
> + * It's intended to provide some hints for firmware to init PCI devices.
> + *
> + * Its structure is shown below:
> + *
> + * Header:
> + *
> + * u8 id;       Standard PCI Capability Header field
> + * u8 next;     Standard PCI Capability Header field
> + * u8 len;      Standard PCI Capability Header field
> + * u8 type;     Red Hat vendor-specific capability type
> + * Data:
> + *
> + * u32 bus_res;     minimum bus number to reserve;
> + *                  this is necessary for PCI Express Root Ports
> + *                  to support PCI bridges hotplug
> + * u64 io;          IO space to reserve
> + * u32 mem;         non-prefetchable memory to reserve
> + *
> + * At most of the following two fields may be set to a value
> + * different from 0xFF...F:
> + * u32 prefetchable_mem_32;     prefetchable memory to reserve (32-bit MMIO)
> + * u64 prefetchable_mem_64;     prefetchable memory to reserve (64-bit MMIO)
> + *
> + * If any field value in Data section is 0xFF...F,
> + * it means that such kind of reservation is not needed and must be ignored.
> + *
> +*/
> +
> +/* Offset of vendor-specific capability type field */
> +#define PCI_CAP_REDHAT_TYPE_OFFSET  3
> +
> +/* List of valid Red Hat vendor-specific capability types */
> +#define REDHAT_CAP_RESOURCE_RESERVE 1
> +
> +
> +/* Offsets of RESOURCE_RESERVE capability fields */
> +#define RES_RESERVE_BUS_RES        4
> +#define RES_RESERVE_IO             8
> +#define RES_RESERVE_MEM            16
> +#define RES_RESERVE_PREF_MEM_32    20
> +#define RES_RESERVE_PREF_MEM_64    24
> +#define RES_RESERVE_CAP_SIZE       32
> +
> +#endif /* _PCI_CAP_H */
> +
> 
