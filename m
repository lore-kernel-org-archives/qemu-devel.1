Received: from eggs.gnu.org ([2001:4830:134:3::10]:47151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ejk7U-0007tH-R6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ejk7T-0005pW-MV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:12:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1ejk7T-0005pO-Gw
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:11:59 -0500
References: <20180207001615.1156.10547.stgit@gimli.home>
	<20180207002623.1156.71094.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <36a32e4e-486b-e761-bf3b-31fecbf05859@redhat.com>
Date: Thu, 8 Feb 2018 12:11:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180207002623.1156.71094.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] vfio/quirks: Add generic support
 for ioveventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org

Hi Alex,

On 07/02/18 01:26, Alex Williamson wrote:
> We might wish to handle some quirks via ioeventfds, add a list of
> ioeventfds to the quirk.
The commit title is a bit misleading as we only add the data type and
deletion function.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/pci-quirks.c |   17 +++++++++++++++++
>  hw/vfio/pci.h        |   11 +++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 10af23217292..e4cf4ea2dd9c 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -12,6 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/range.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> @@ -278,12 +279,24 @@ static const MemoryRegionOps vfio_ati_3c3_quirk = {
>  static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
>  {
>      VFIOQuirk *quirk = g_malloc0(sizeof(*quirk));
> +    QLIST_INIT(&quirk->ioeventfds);
>      quirk->mem = g_new0(MemoryRegion, nr_mem);
>      quirk->nr_mem = nr_mem;
>  
>      return quirk;
>  }
>  
> +static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
> +{
> +    QLIST_REMOVE(ioeventfd, next);
> +    memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
> +                              ioeventfd->match_data, ioeventfd->data,
> +                              &ioeventfd->e);
> +    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
> +    event_notifier_cleanup(&ioeventfd->e);
> +    g_free(ioeventfd);
> +}
> +
>  static void vfio_vga_probe_ati_3c3_quirk(VFIOPCIDevice *vdev)
>  {
>      VFIOQuirk *quirk;
> @@ -1668,6 +1681,10 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
>      int i;
>  
>      QLIST_FOREACH(quirk, &bar->quirks, next) {
> +        while (!QLIST_EMPTY(&quirk->ioeventfds)) {
> +            vfio_ioeventfd_exit(QLIST_FIRST(&quirk->ioeventfds));
> +        }
> +
>          for (i = 0; i < quirk->nr_mem; i++) {
>              memory_region_del_subregion(bar->region.mem, &quirk->mem[i]);
>          }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index f4aa13e021fa..146065c2f715 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -24,9 +24,20 @@
>  
>  struct VFIOPCIDevice;
>  
> +typedef struct VFIOIOEventFD {
> +    QLIST_ENTRY(VFIOIOEventFD) next;
> +    MemoryRegion *mr;
> +    hwaddr addr;
> +    unsigned size;
> +    bool match_data;
Shouldn't you add the match_data field also in the kernel uapi?

Thanks

Eric
> +    uint64_t data;
> +    EventNotifier e;
> +} VFIOIOEventFD;.
> +
>  typedef struct VFIOQuirk {
>      QLIST_ENTRY(VFIOQuirk) next;
>      void *data;
> +    QLIST_HEAD(, VFIOIOEventFD) ioeventfds;
>      int nr_mem;
>      MemoryRegion *mem;
>  } VFIOQuirk;
> 
