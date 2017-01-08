Received: from eggs.gnu.org ([2001:4830:134:3::10]:34113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cQ9Zp-0001J9-2H
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cQ9Zl-0002oQ-Pd
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:15:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cQ9Zl-0002lH-G2
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 04:15:41 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so5987304wme.0
	for <qemu-devel@nongnu.org>; Sun, 08 Jan 2017 01:15:39 -0800 (PST)
References: <20170106105855.12c0ce73@thl530>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <b8c009c9-97a0-90ca-c4ac-3aed572f108d@tuxfamily.org>
Date: Sun, 8 Jan 2017 10:15:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170106105855.12c0ce73@thl530>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] m68k: QOMify the MCF Fast Ethernet
 Controller device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 06.01.2017 10:58, Thomas Huth wrote:
> When running qemu-system-m68k with the "-net" parameter (for example
> simply "-net nic -net user"), there is currently a confusing warning
> message saying:
> 
>  Warning: requested NIC (anonymous, model mcf_fec) was not created
>  (not supported by this machine?)
> 
> This seems to happen because the MCF NIC has never been adapted to
> the currently expected QEMU device behavior. Thus let's QOMify the
> NIC now to get rid of the warning message.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  hw/m68k/mcf5208.c     | 20 ++++++++++++++
>  hw/net/mcf_fec.c      | 75 ++++++++++++++++++++++++++++++++++++++-------------
>  include/hw/m68k/mcf.h |  4 ---
>  3 files changed, 77 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 3438314..f9e1adb 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -18,6 +18,7 @@
>  #include "net/net.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> +#include "hw/sysbus.h"
>  #include "elf.h"
>  #include "exec/address-spaces.h"
>  
> @@ -192,6 +193,25 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
>      }
>  }
>  
> +static void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd, hwaddr base,
> +                         qemu_irq *irqs)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +    int i;
> +
> +    dev = qdev_create(NULL, "mcf-fec");

I just read on http://wiki.qemu.org/Documentation/QOMConventions:

 "DO use TYPE_FOO constants, defined in a header if used in other parts
  of code"

... so I guess I should rather declare the TYPE_MCF_FEC_NET in a header
file instead. I'll send a v2 of this patch...

 Thomas
