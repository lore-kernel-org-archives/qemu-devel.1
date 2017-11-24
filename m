Received: from eggs.gnu.org ([2001:4830:134:3::10]:48873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1eIMow-0001Wc-1A
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 17:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1eIMor-00033g-3t
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 17:51:42 -0500
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com
	([104.47.32.66]:62432
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1eIMoq-00032R-OS
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 17:51:37 -0500
Date: Sat, 25 Nov 2017 05:51:27 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20171124225127.GH3183@toto>
References: <20171124212938.7074-1-frasse.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171124212938.7074-1-frasse.iglesias@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/13] Add support for the ZynqMP
 Generic QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com, peter.maydell@linaro.org

On Fri, Nov 24, 2017 at 10:29:25PM +0100, Francisco Iglesias wrote:
> Hi,
> 
> This patch series is an attempt to add support for the ZynqMP QSPI (consisting
> of the Generic QSPI and the legacy QSPI) to the xlnx-zcu102 board and connect 
> Numonyx n25q512a11 flashes to the QSPI. Also some functionality is added to
> m25p80.
> 
> The series starts by adding support in m25p80 for continous read out of status
> registers, SST flash READ ID commands, bank address register accesses, bulk
> erase (0x60) and two Numonyx flashes (n25q512a11 and n25q512a13). Thereafter it
> updates the striping behaviour to be bit big endiann in the Xilinx QSPI model
> and adds support for RX discard, zero pumping according transfer register and 4
> byte LQSPI addresses. Finally it adds support for the ZynqMP Generic QSPI and
> adds the ZynqMP QSPI to the xlnx-zcu102 board.
> 
> Best regards,
> Francisco Iglesias


The entire series looks good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

I also ran some regressions tests on it:
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Thanks!
Edgar




> 
> Changelog:
> v7 -> v8
>   * Corrected commit messages in the patches 'xilinx_spips: Don't set TX FIFO
>     UNDERFLOW at cmd done' and 'xilinx_spips: Move FlashCMD, XilinxQSPIPS and
>     XilinxSPIPSClass'.
>   * Changed a for loop and a variable decrease for improving readability in
>     patch 'xilinx_spips: Update striping to be big-endian bit order'.
> 
> v6 -> v7
>   * Moved data_read_loop into a vmstate subsection in patch 'm25p80: Add support
>     for continuous read out of RDSR and READ_FSR' for not breaking compatibility
>     against older vmstate versions unless necessary.
>   * Minor tweaks in patch 'xilinx_spips: Add support for the ZynqMP Generic
>     QSPI'.
> 
> v5 -> v6
>   * Added data_read_loop to vmstate_m25p80 in patch 'm25p80: Add support for
>     continuous read out of RDSR and READ_FSR'. Also removed acked-by lines in 
>     the commit message because of this update.
>   * Reworked patch 'xilinx_spips: Add support for the ZynqMP Generic QSPI'.
>   * Tweaked commit messages 
> 
> v4 -> v5
>   * Added newlines in patch 'xlnx-zcu102: Add support for the ZynqMP QSPI'
> 
> v3 -> v4
>   * Corrected patch 'Add support for SST READ ID 0x90/0xAB commands'
>   * Corrected patch 'Add support Add support for BRRD/BRWR and BULK_ERASE'
>   * Minor tweaks in the ZynqMP GQSPI patch for reducing the patch 
> 
> v2 -> v3
>   * Tweaked commit messages 
>   * Corrected patch 08 'Make tx/rx_data_bytes more generic and reusable'
>   * Reworked the patch adding the ZynqMP GQSPI and splitted out another QSPI
>     related change into an own patch 'Don't set TX FIFO UNDERFLOW at cmd done'
> 
> Francisco Iglesias (13):
>   m25p80: Add support for continuous read out of RDSR and READ_FSR
>   m25p80: Add support for SST READ ID 0x90/0xAB commands
>   m25p80: Add support for BRRD/BRWR and BULK_ERASE (0x60)
>   m25p80: Add support for n25q512a11 and n25q512a13
>   xilinx_spips: Move FlashCMD, XilinxQSPIPS and XilinxSPIPSClass
>   xilinx_spips: Update striping to be big-endian bit order
>   xilinx_spips: Add support for RX discard and RX drain
>   xilinx_spips: Make tx/rx_data_bytes more generic and reusable
>   xilinx_spips: Add support for zero pumping
>   xilinx_spips: Add support for 4 byte addresses in the LQSPI
>   xilinx_spips: Don't set TX FIFO UNDERFLOW at cmd done
>   xilinx_spips: Add support for the ZynqMP Generic QSPI
>   xlnx-zcu102: Add support for the ZynqMP QSPI
> 
>  default-configs/arm-softmmu.mak |   2 +-
>  hw/arm/xlnx-zcu102.c            |  23 +
>  hw/arm/xlnx-zynqmp.c            |  26 ++
>  hw/block/m25p80.c               |  71 +++-
>  hw/ssi/xilinx_spips.c           | 899 ++++++++++++++++++++++++++++++++++------
>  include/hw/arm/xlnx-zynqmp.h    |   5 +
>  include/hw/ssi/xilinx_spips.h   |  74 +++-
>  7 files changed, 961 insertions(+), 139 deletions(-)
> 
> -- 
> 2.9.3
> 
