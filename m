Received: from eggs.gnu.org ([2001:4830:134:3::10]:54381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9nGn-00065i-8Z
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9nGk-0001KT-1u
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:01 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:55477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e9nGj-0001JZ-QX
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:16:57 -0400
Received: by mail-lf0-x233.google.com with SMTP id e143so1458920lfg.12
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 00:16:57 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Wed,  1 Nov 2017 08:16:39 +0100
Message-Id: <20171101071652.19375-1-frasse.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/13] Add support for the ZynqMP Generic
 QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Hi,

This patch series is an attempt to add support for the ZynqMP QSPI (consisting
of the Generic QSPI and the legacy QSPI) to the xlnx-zcu102 board and connect 
Numonyx n25q512a11 flashes to the QSPI. Also some functionality is added to
m25p80.

The series starts by adding support in m25p80 for continous read out of status
registers, SST flash READ ID commands, bank address register accesses, bulk
erase (0x60) and two Numonyx flashes (n25q512a11 and n25q512a13). Thereafter it
updates the striping behaviour to be bit big endiann in the Xilinx QSPI model
and adds support for RX discard, zero pumping according transfer register and 4
byte LQSPI addresses. Finally it adds support for the ZynqMP Generic QSPI and
adds the ZynqMP QSPI to the xlnx-zcu102 board.

Best regards,
Francisco Iglesias

Changelog:
v5 -> v6
  * Added data_read_loop to vmstate_m25p80 in patch 'm25p80: Add support for
    continuous read out of RDSR and READ_FSR'. Also removed acked-by lines in 
    the commit message because of this update.
  * Reworked patch 'xilinx_spips: Add support for the ZynqMP Generic QSPI'.
  * Tweaked commit messages 

v4 -> v5
  * Added newlines in patch 'xlnx-zcu102: Add support for the ZynqMP QSPI'

v3 -> v4
  * Corrected patch 'Add support for SST READ ID 0x90/0xAB commands'
  * Corrected patch 'Add support Add support for BRRD/BRWR and BULK_ERASE'
  * Minor tweaks in the ZynqMP GQSPI patch for reducing the patch 

v2 -> v3
  * Tweaked commit messages 
  * Corrected patch 08 'Make tx/rx_data_bytes more generic and reusable'
  * Reworked the patch adding the ZynqMP GQSPI and splitted out another QSPI
    related change into an own patch 'Don't set TX FIFO UNDERFLOW at cmd done'

v1 -> v2
  * Reset author on commits (due to mailing issues).

Francisco Iglesias (13):
  m25p80: Add support for continuous read out of RDSR and READ_FSR
  m25p80: Add support for SST READ ID 0x90/0xAB commands
  m25p80: Add support for BRRD/BRWR and BULK_ERASE (0x60)
  m25p80: Add support for n25q512a11 and n25q512a13
  xilinx_spips: Move FlashCMD, XilinxQSPIPS and XilinxSPIPSClass
  xilinx_spips: Update striping to be big-endian bit order
  xilinx_spips: Add support for RX discard and RX drain
  xilinx_spips: Make tx/rx_data_bytes more generic and reusable
  xilinx_spips: Add support for zero pumping
  xilinx_spips: Add support for 4 byte addresses in the LQSPI
  xilinx_spips: Don't set TX FIFO UNDERFLOW at cmd done
  xilinx_spips: Add support for the ZynqMP Generic QSPI
  xlnx-zcu102: Add support for the ZynqMP QSPI

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/xlnx-zcu102.c            |  23 ++
 hw/arm/xlnx-zynqmp.c            |  26 ++
 hw/block/m25p80.c               |  41 +-
 hw/ssi/xilinx_spips.c           | 894 ++++++++++++++++++++++++++++++++++------
 include/hw/arm/xlnx-zynqmp.h    |   5 +
 include/hw/ssi/xilinx_spips.h   |  74 +++-
 7 files changed, 926 insertions(+), 138 deletions(-)

-- 
2.9.3
