Received: from eggs.gnu.org ([2001:4830:134:3::10]:53571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d6clX-00084Y-DU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d6clU-0005pZ-C4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:55:23 -0400
Received: from greensocs.com ([193.104.36.180]:48093)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1d6clT-0005p2-TD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:55:20 -0400
References: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <d107e0b9-828b-9c9b-9b5b-1e9b46f88cb0@greensocs.com>
Date: Fri, 5 May 2017 14:55:13 +0200
MIME-Version: 1.0
In-Reply-To: <1493391576-29401-1-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 0/7] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, pbonzini@redhat.com, rth@twiddle.net, peter.maydell@linaro.org, clg@kaod.org, mark.burton@greensocs.com

Ping!

This is mostly reviewed maybe the 6th patch needs a little look.

Thanks,
Fred

On 04/28/2017 04:59 PM, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This series allows to execute code from mmio areas.
> The main goal of this is to be able to run code for example from an SPI device.
> 
> The three first patch fixes the way get_page_addr_code fills the TLB.
> 
> The sixth patch implements the mmio execution helpers: the device must
> implement the request_ptr callback of the MemoryRegion and will be notified
> when the guest wants to execute code from it.
> 
> The fouth and fifth patch introduces mmio_interface device which allows to
> dynamically map a host pointer somewhere into the memory.
> 
> The last patch implements the execution from the SPI memories in the
> xilinx_spips model.
> 
> Thanks,
> Fred
> 
> V2 -> V3:
>   * Reorder patches to allow bisection.
>   * Rebase on current master.
>   * Use an async work to invalidate the mmio region.
>   * Clear the dirty of the region before invalidating it.
> V1 -> V2:
>   * Fix the DPRINTF error.
> RFC -> V1:
>   * Use an interface (mmio-interface) to fix any reference leak issue.
> 
> KONRAD Frederic (7):
>   cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
>   cputlb: move get_page_addr_code
>   cputlb: fix the way get_page_addr_code fills the tlb
>   qdev: add MemoryRegion property
>   introduce mmio_interface
>   exec: allow to get a pointer for some mmio memory region
>   xilinx_spips: allow mmio execution
> 
>  cputlb.c                         |  82 ++++++++++++++-----------
>  hw/misc/Makefile.objs            |   1 +
>  hw/misc/mmio_interface.c         | 128 +++++++++++++++++++++++++++++++++++++++
>  hw/ssi/xilinx_spips.c            |  74 ++++++++++++++++------
>  include/exec/memory.h            |  35 +++++++++++
>  include/hw/misc/mmio_interface.h |  49 +++++++++++++++
>  include/hw/qdev-properties.h     |   2 +
>  memory.c                         | 111 +++++++++++++++++++++++++++++++++
>  8 files changed, 428 insertions(+), 54 deletions(-)
>  create mode 100644 hw/misc/mmio_interface.c
>  create mode 100644 include/hw/misc/mmio_interface.h
> 
