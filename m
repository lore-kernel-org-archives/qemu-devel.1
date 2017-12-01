Received: from eggs.gnu.org ([2001:4830:134:3::10]:34302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKnQ3-0002VB-NM
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKnPX-0005lt-5c
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:40:03 -0500
Date: Fri, 1 Dec 2017 16:39:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171201163922.4839624e.cohuck@redhat.com>
In-Reply-To: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/7] s390x/pci: Improve zPCI to cover
 more cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, mst@redhat.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On Thu, 30 Nov 2017 13:55:23 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> This patch fixes the following BUG:
> Even a guest is able to detect virtio_pci device, the init function
> the Linux virtio_pci driver will hang because zPCI does not support
> the subregions used by virtio_pci.
> 
> It follows that right now the PCI support is very limited
> (e.g. pass through of a host vfio device)
> To enable features like virtio-pci several modifications needs to be
> done.
> 
> As already stated above, Virtio-PCI uses subregions, which may eventually
> be discontinuous inside bars instead of a single flat region often used
> by real devices.
> The address offset being formerly calculated from the BAR base address
> must be adapted to the subregions instead of to the single region.
> 
> This patch provides the new calculation for the three kind of BAR
> access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK done by zPCI.
> 
> We use the opportunity to
>  - enhance the fault detection for zPCI STORE and LOAD,
>  - enhance the fault detection and to provide the maximum STORE BLOCK
>    block size, maxstbl, for zPCI STORE BLOCK
>  - factor out part of the code used to calculate the offset and
>    access the BARs,
>  - factor out the code for endianess conversion.
> 
> 
> Pierre Morel (7):
>   s390x/pci: factor out endianess conversion
>   s390x/pci: rework PCI STORE
>   s390x/pci: rework PCI LOAD
>   s390x/pci: rework PCI STORE BLOCK
>   s390x/pci: move the memory region read from pcilg
>   s390x/pci: move the memory region write from pcistg
>   s390x/pci: search for subregion inside the BARs
> 
>  hw/s390x/s390-pci-bus.h  |   1 +
>  hw/s390x/s390-pci-inst.c | 251 ++++++++++++++++++++++++++++-------------------
>  hw/s390x/s390-pci-inst.h |   6 +-
>  3 files changed, 158 insertions(+), 100 deletions(-)
> 

Thanks, queued to s390-next.
