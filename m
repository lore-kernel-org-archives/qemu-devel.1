Received: from eggs.gnu.org ([2001:4830:134:3::10]:42942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4c-0000hf-Df
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4b-0002U4-EG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4b-0002TO-1N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 044469FDDE
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:28 -0500
Message-Id: <20170313195547.21466-12-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/30] trace: Fix parameter types in hw/audio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/audio/trace-events | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 3210386..ea5f0c2 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -3,12 +3,12 @@
 # hw/audio/cs4231.c
 cs4231_mem_readl_dreg(uint32_t reg, uint32_t ret) "read dreg %d: 0x%02x"
 cs4231_mem_readl_reg(uint32_t reg, uint32_t ret) "read reg %d: 0x%08x"
-cs4231_mem_writel_reg(uint32_t reg, uint32_t old, uint32_t val) "write reg %d: 0x%08x -> 0x%08x"
-cs4231_mem_writel_dreg(uint32_t reg, uint32_t old, uint32_t val) "write dreg %d: 0x%02x -> 0x%02x"
+cs4231_mem_writel_reg(uint32_t reg, uint32_t old, uint64_t val) "write reg %d: 0x%08x -> 0x%08" PRIx64
+cs4231_mem_writel_dreg(uint32_t reg, uint32_t old, uint64_t val) "write dreg %d: 0x%02x -> 0x%02" PRIx64

 # hw/audio/milkymist-ac97.c
-milkymist_ac97_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_ac97_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_ac97_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_ac97_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
 milkymist_ac97_pulse_irq_crrequest(void) "Pulse IRQ CR request"
 milkymist_ac97_pulse_irq_crreply(void) "Pulse IRQ CR reply"
 milkymist_ac97_pulse_irq_dmaw(void) "Pulse IRQ DMA write"
-- 
2.9.3
