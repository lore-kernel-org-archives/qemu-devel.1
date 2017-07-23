Received: from eggs.gnu.org ([2001:4830:134:3::10]:58089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZ6st-0000MI-Bc
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 22:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dZ6sq-0008N2-84
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 22:44:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dZ6sq-0008Lj-1O
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 22:44:40 -0400
Date: Sun, 23 Jul 2017 05:44:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170723054322-mutt-send-email-mst@kernel.org>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-4-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500761510-1556-4-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] pci: add QEMU-specific PCI
 capability structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, kraxel@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com

On Sun, Jul 23, 2017 at 01:11:49AM +0300, Aleksandr Bezzubikov wrote:
> On PCI init PCI bridge devices may need some
> extra info about bus number to reserve, IO, memory and
> prefetchable memory limits. QEMU can provide this
> with special vendor-specific PCI capability.
> 
> This capability is intended to be used only
> for Red Hat PCI bridges, i.e. QEMU cooperation.
> 
> Sizes of limits match ones from 
> PCI Type 1 Configuration Space Header,
> number of buses to reserve occupies only 1 byte 
> since it is the size of Subordinate Bus Number register.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  src/hw/pci_cap.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 src/hw/pci_cap.h
> 
> diff --git a/src/hw/pci_cap.h b/src/hw/pci_cap.h
> new file mode 100644
> index 0000000..1382b0b
> --- /dev/null
> +++ b/src/hw/pci_cap.h
> @@ -0,0 +1,23 @@
> +#ifndef _PCI_CAP_H
> +#define _PCI_CAP_H
> +
> +#include "types.h"
> +
> +struct vendor_pci_cap {
> +    u8 id;
> +    u8 next;
> +    u8 len;
> +};
> +
> +struct redhat_pci_bridge_cap {
> +    struct vendor_pci_cap hdr;

You want to add some kind of identifier here after
the header, such that more capabilities can be added
in future without breaking this one.

> +    u8 bus_res;
> +    u32 pref_lim_upper;
> +    u16 pref_lim;
> +    u16 mem_lim;
> +    u16 io_lim_upper;
> +    u8 io_lim;
> +    u8 padd;

Please add documentation.


> +};
> +
> +#endif /* _PCI_CAP_H */
> -- 
> 2.7.4
