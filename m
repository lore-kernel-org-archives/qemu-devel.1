Received: from eggs.gnu.org ([2001:4830:134:3::10]:54562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVs-00057l-Et
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftFVr-0007u2-Fu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:44 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ftFVq-0007ZW-Tt
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:04:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 18:04:21 +0100
Message-Id: <20180824170422.5783-3-peter.maydell@linaro.org>
In-Reply-To: <20180824170422.5783-1-peter.maydell@linaro.org>
References: <20180824170422.5783-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] hw/nvram/fw_cfg: Use memberwise copy of
 MemoryRegionOps struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

We've now removed the 'old_mmio' member from MemoryRegionOps,
so we can perform the copy as a simple struct copy rather
than having to do it via a memberwise copy.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/fw_cfg.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index d79a568f540..b3c9b066239 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1109,12 +1109,7 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->ctl_iomem);
 
     if (s->data_width > data_ops->valid.max_access_size) {
-        /* memberwise copy because the "old_mmio" member is const */
-        s->wide_data_ops.read       = data_ops->read;
-        s->wide_data_ops.write      = data_ops->write;
-        s->wide_data_ops.endianness = data_ops->endianness;
-        s->wide_data_ops.valid      = data_ops->valid;
-        s->wide_data_ops.impl       = data_ops->impl;
+        s->wide_data_ops = *data_ops;
 
         s->wide_data_ops.valid.max_access_size = s->data_width;
         s->wide_data_ops.impl.max_access_size  = s->data_width;
-- 
2.18.0
