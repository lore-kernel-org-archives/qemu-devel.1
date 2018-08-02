Received: from eggs.gnu.org ([2001:4830:134:3::10]:60431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flHav-0004T0-JD
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flHau-0003Zu-Gt
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flHah-0003Ke-SI
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:41:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 18:40:40 +0100
Message-Id: <20180802174042.29234-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] hw/net/pcnet-pci: Convert away from
 old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Jason Wang <jasowang@redhat.com>

This patchset converts the pcnet-pci's MMIO BAR MemoryRegionOps
away from the old_mmio accessors.

It does it in two stages:
 * patch 1 is a no-behaviour-change patch which replaces the old
   split byte/word/long accessor functions with single read and
   write functions which take the size, and look suspiciously
   similar but not identical to the existing pcnet_ioport_read/write
   functions
 * patch 2 then drops the new read and write functions and just
   uses the ioport read/write functions

My reason for structuring it like this is that I'm pretty sure
that the discrepancy between the MMIO BAR accessors and the
IO BAR accessors is just a bug (one which we fixed for the
IO BAR accessors in commit 7ba79741970 in 2011). But if I'm
wrong I want us to be able to revert the behaviour change
easily without that bringing back a use of the old_mmio accessors
(which might not even compile if we need to revert after we've
finally managed to drop those entirely).

The bug as fixed in patch 2 is that for the MMIO BAR we were
not honouring the DWIO bit (which indicates whether the device
is in 16-bit or 32-bit IO mode) when doing accesses to the
aprom range 0x0..0xf. We were already honouring DWIO for accesses
to the 0x10..0x1f range, and my trawling through datasheets
indicates that DWIO applies identically to MMIO and IO BARs
(see patch 2's commit message for details and references).

This is awkwardly hard to test, though, because Linux's
pcnet driver only uses port IO as far as I can tell. (Likely
this is why the bug has remained unnoticed for so long.)

thanks
-- PMM

Peter Maydell (2):
  hw/net/pcnet-pci: Convert away from old_mmio accessors
  hw/net/pcnet-pci: Unify pcnet_ioport_read/write and
    pcnet_mmio_read/write

 hw/net/pcnet-pci.c  | 98 +++------------------------------------------
 hw/net/trace-events |  6 ---
 2 files changed, 6 insertions(+), 98 deletions(-)

-- 
2.17.1
