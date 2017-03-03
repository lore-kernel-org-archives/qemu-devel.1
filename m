Received: from eggs.gnu.org ([2001:4830:134:3::10]:35681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjnWr-0004j0-6K
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjnWn-00041V-7s
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:45:53 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cjnWm-00040c-Vy
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:45:49 -0500
Received: by mail-lf0-x243.google.com with SMTP id g70so7090221lfh.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 05:45:48 -0800 (PST)
Date: Fri, 3 Mar 2017 14:45:46 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170303134546.GX9606@toto>
References: <1487362633-25018-1-git-send-email-fred.konrad@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487362633-25018-1-git-send-email-fred.konrad@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH V2 0/7] execute code from mmio area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com, clg@kaod.org, pbonzini@redhat.com

On Fri, Feb 17, 2017 at 09:17:06PM +0100, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This series allows to execute code from mmio areas.
> The main goal of this is to be able to run code for example from an SPI device.
> 
> The three first patch fixes the way get_page_addr_code fills the TLB.
> 
> The fourth patch implements the mmio execution helpers: the device must
> implement the request_ptr callback of the MemoryRegion and will be notified when
> the guest wants to execute code from it.
> 
> The fifth patch introduces mmio_interface device which allows to dynamically
> map a host pointer somewhere into the memory.
> 
> The sixth patch implements the execution from the SPI memories in the
> xilinx_spips model.


I had a comment on the possible break of bisection, but the series looks
good to me. If you fix up the ordering:

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Cheers,
Edgar



> 
> Thanks,
> Fred
> 
> V1 -> V2:
>   * Fix the DPRINTF error.
> RFC -> V1:
>   * Use an interface (mmio-interface) to fix any reference leak issue.
> 
> KONRAD Frederic (7):
>   cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
>   cputlb: move get_page_addr_code
>   cputlb: fix the way get_page_addr_code fills the tlb
>   exec: allow to get a pointer for some mmio memory region
>   qdev: add MemoryRegion property
>   introduce mmio_interface
>   xilinx_spips: allow mmio execution
> 
>  cputlb.c                         |  81 ++++++++++++++-----------
>  hw/misc/Makefile.objs            |   1 +
>  hw/misc/mmio_interface.c         | 128 +++++++++++++++++++++++++++++++++++++++
>  hw/ssi/xilinx_spips.c            |  74 ++++++++++++++++------
>  include/exec/memory.h            |  35 +++++++++++
>  include/hw/misc/mmio_interface.h |  49 +++++++++++++++
>  include/hw/qdev-properties.h     |   2 +
>  memory.c                         |  57 +++++++++++++++++
>  8 files changed, 372 insertions(+), 55 deletions(-)
>  create mode 100644 hw/misc/mmio_interface.c
>  create mode 100644 include/hw/misc/mmio_interface.h
> 
> -- 
> 1.8.3.1
> 
> 
