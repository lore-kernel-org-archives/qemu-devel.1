Received: from eggs.gnu.org ([2001:4830:134:3::10]:43675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O5y-0000Te-QV
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O5w-0006z7-6r
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:54 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58382
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e7O5w-0006sN-0V
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:52 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 25 Oct 2017 16:59:14 +0100
Message-Id: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv4 00/13] sun4m: sparc32_dma tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This patchset aims to tidy-up the sparc32_dma code by improving the
modelling of the espdma/ledma devices using both QOM and the memory
API which didn't exist when the code was first written.

The result is that it is now possible to remove both the iommu_opaque
and is_ledma workarounds from the code, and the code for wiring up
the espdma/ledma and respective devices is also a lot more readable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v4:
- Rebase onto git master
- Update patch 9 to move lance QOM macros/SysBusPCNetState from sun4m.h to lance.h as suggested by Peter
- Add Reviewed-by from Peter for patch 7

v3:
- Add missing sysbus.h include to esp.h in patch 7

v2:
- Make esp/lance devices children of espdma/ledma devices respectively
- Add len parameter to ledma/espdma tracepoints


Mark Cave-Ayland (13):
  sparc32_dma: rename SPARC32_DMA type to SPARC32_DMA_DEVICE
  sparc32_dma: split esp and le into separate DMA devices
  sparc32_dma: move type declarations from sparc32_dma.c to
    sparc32_dma.h
  sun4m: move DMA device wiring from sparc32_dma_init() to
    sun4m_hw_init()
  sun4m_iommu: move TYPE_SUN4M_IOMMU declaration to sun4m.h
  sparc32_dma: use object link instead of qdev property to pass IOMMU
    reference
  esp: move TYPE_ESP and SysBusESPState from esp.c to esp.h
  sparc32_dma: make esp device child of espdma device
  lance: move TYPE_LANCE and SysBusPCNetState from lance.c to lance.h
  sparc32_dma: make lance device child of ledma device
  sparc32_dma: introduce new SPARC32_DMA type container object
  sparc32_dma: remove is_ledma hack and replace with memory region
    alias
  sparc32_dma: add len to esp/le DMA memory tracing

 hw/dma/sparc32_dma.c           |  235 +++++++++++++++++++++++++++++-----------
 hw/dma/sun4m_iommu.c           |   14 ---
 hw/dma/trace-events            |    8 +-
 hw/net/lance.c                 |   11 +-
 hw/scsi/esp.c                  |   13 ---
 hw/sparc/sun4m.c               |   82 ++++++--------
 include/hw/net/lance.h         |   41 +++++++
 include/hw/scsi/esp.h          |   14 +++
 include/hw/sparc/sparc32_dma.h |   55 ++++++++++
 include/hw/sparc/sun4m.h       |   16 +++
 10 files changed, 336 insertions(+), 153 deletions(-)
 create mode 100644 include/hw/net/lance.h

-- 
1.7.10.4
