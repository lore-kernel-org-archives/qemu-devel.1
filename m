Received: from eggs.gnu.org ([2001:4830:134:3::10]:56552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC7ip-0007mF-NS
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC7ik-0008Hi-Nl
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:31:35 -0500
Date: Tue, 7 Nov 2017 18:31:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171107183125.10ab7032.cohuck@redhat.com>
In-Reply-To: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] s390x/pci: Improve zPCI to cover more
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On Tue,  7 Nov 2017 18:24:32 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Right now the PCI support is very limited (e.g. pass through of a
> host vfio device)
> To enable features like virtio-pci several modifications needs to be
> done.
> 
> Virtio-PCI uses subregions, which may eventually be discontinuous
> inside bars instead of a single flat region.
> The address offset being formerly calculated from the BAR base address
> must be adapted to the subregions instead of to the single region.
> 
> This patch provides the new calculation for the three kind of BAR
> access, zPCI STORE, zPCI LOAD and zPCI STORE BLOCK.
> 
> We use the opportunity to
>  - enhance the fault detection for zPCI STORE and LOAD,
>  - enhance the fault detection and to provide the maximum STORE BLOCK
>    block size, maxstbl, for zPCI STORE BLOCK
>  - factor out part of the code used to calculate the offset and
>    access the BARs,
>  - factor out the code for endianess conversion.

Will look at this later. Just a quick question: What kind of further
functionality is enabled by this? E.g., I can attach a virtio-net-pci
device right now, does this enable more virtio devices?

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
>  hw/s390x/s390-pci-inst.c | 250 ++++++++++++++++++++++++++++-------------------
>  hw/s390x/s390-pci-inst.h |   2 +-
>  3 files changed, 153 insertions(+), 100 deletions(-)
> 
