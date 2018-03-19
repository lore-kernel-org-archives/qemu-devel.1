Received: from eggs.gnu.org ([2001:4830:134:3::10]:54421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1exqn6-000464-9f
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1exqn2-0001cG-5J
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:09:16 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:51518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1exqn1-0001bM-H6
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:09:11 -0400
Received: by mail-it0-x243.google.com with SMTP id j137-v6so2357013ita.1
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 02:09:11 -0700 (PDT)
References: <20180315212634.15150.88094.stgit@gimli.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <28b02805-fa03-7f7c-b603-fa8985b305aa@ozlabs.ru>
Date: Mon, 19 Mar 2018 20:09:04 +1100
MIME-Version: 1.0
In-Reply-To: <20180315212634.15150.88094.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vfio/pci: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com

On 16/3/18 8:31 am, Alex Williamson wrote:
> A vfio ioeventfd will perform the pre-specified device write on
> triggering of an eventfd.  When coupled with KVM ioeventfds, this
> feature allows a VM to trap a device page for virtualization, while
> also registering targeted ioeventfds to maintain performance of high
> frequency register writes within the trapped range.  Much like the
> existing interrupt eventfd/irqfd coupling, such writes can be handled
> entirely in the host kernel.
> 
> The new VFIO device ioctl may be supported by any vfio bus driver,
> including mdev drivers, but the implementation here only enables
> vfio-pci.  This is intended as an acceleration path, bus drivers
> may choose which regions to support and userspace should always
> intend to fall back to non-accelerated handling when unavailable.
> 
> v1->v2:
>  * Peter & Eric Sign-offs on 1/3
>  * mutex_destroy() in 3/3
>  * Slight enhancement to uapi description
>  * sparse clean - Sparse didn't like that we dropped the __iomem
>    address space when calling iowriteXX, re-adding it via the opaque
>    and data pointers of the virq was crude, and that was not a 32-bit
>    friendly soluion anyway, so add the iomem address to our ioeventfd
>    struct, pass that, and use a more simple, common handler.
> 
> RFC->v1:
>  * An arbitrary limit is added for the number of ioeventfds supported
>    per device.  The intention is to set this high enough to allow any
>    reasonable use case, but limit malicious user behavior.
>  * Split patches, including adding a patch for endian neutral io reads
>    and writes.  This should be a nop for little-endian and avoid
>    redundant swap on big-endian, and hopefully resolves Alexey's
>    comments regarding the endian nature of this interface.
>  * Rebase to v4.16-rc3
> 
> Thanks,
> Alex
> 
> ---
> 
> Alex Williamson (3):
>       vfio/pci: Pull BAR mapping setup from read-write path
>       vfio/pci: Use endian neutral helpers
>       vfio/pci: Add ioeventfd support
> 
> 
>  drivers/vfio/pci/vfio_pci.c         |   35 +++++++
>  drivers/vfio/pci/vfio_pci_private.h |   19 ++++
>  drivers/vfio/pci/vfio_pci_rdwr.c    |  184 +++++++++++++++++++++++++++++++----
>  include/uapi/linux/vfio.h           |   27 +++++
>  4 files changed, 245 insertions(+), 20 deletions(-)
> 


LGTM, I gave it a try to make sure 2/3 does not break and it does not in
all combinations of le/be host <=> le/be guest but I did not try the actual
feature - cannot make up a test quickly...

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


-- 
Alexey
