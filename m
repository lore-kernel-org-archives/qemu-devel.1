Received: from eggs.gnu.org ([2001:4830:134:3::10]:43096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4m-0000qJ-75
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4l-0002be-GH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4l-0002av-BK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BBC7A0B50
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:39 -0500
Message-Id: <20170313195547.21466-23-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/30] trace: Fix parameter types in hw/nvram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the traces to use types matching
the callers, and in this case, make sure all callers pass the same
width type.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/nvram/fw_cfg.c     | 2 +-
 hw/nvram/trace-events | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9..5c328c8 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -435,7 +435,7 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     stl_be_dma(s->dma_as, dma_addr + offsetof(FWCfgDmaAccess, control),
                 dma.control);

-    trace_fw_cfg_read(s, 0);
+    trace_fw_cfg_read(s, (uint64_t) 0);
 }

 static uint64_t fw_cfg_dma_mem_read(void *opaque, hwaddr addr,
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 1f1e05a..32d67c2 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -1,8 +1,8 @@
 # See docs/tracing.txt for syntax documentation.

 # hw/nvram/ds1225y.c
-nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
-nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x -> 0x%02x"
+nvram_read(hwaddr addr, uint32_t ret) "read addr %" HWADDR_PRId ": 0x%02x"
+nvram_write(hwaddr addr, uint32_t old, uint64_t val) "write addr %" HWADDR_PRId ": 0x%02x -> 0x%02" PRIx64

 # hw/nvram/fw_cfg.c
 fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d = %d"
-- 
2.9.3
