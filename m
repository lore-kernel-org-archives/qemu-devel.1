Received: from eggs.gnu.org ([2001:4830:134:3::10]:53196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEIIM-0007zt-G1
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEIII-00052W-AW
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:13:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eEIII-00052F-3R
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:13:10 -0500
Date: Mon, 13 Nov 2017 18:13:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171113181305.5786d700.cohuck@redhat.com>
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
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

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

I assume you'll send a v2?

I'll see if I can find some time to wire up pci in tcg (as this would
get us additional test coverage, especially regarding endianness), but
I won't complain should someone beat me to it.
