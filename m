Received: from eggs.gnu.org ([2001:4830:134:3::10]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofr-0000EK-NK
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofq-0004XI-OR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:43 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofq-0004UL-G0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:42 -0500
Received: by mail-wm1-x332.google.com with SMTP id g67so6030163wmd.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:11 +0000
Message-Id: <20181214144214.1260-20-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/22] hw/sd/sdhci: Don't leak memory region in
 sdhci_sysbus_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In sdhci_sysbus_realize() we override the initialization of
s->iomem that sdhci_common_realize() performs. However we
don't destroy the old memory region before reinitializing
it, which means that the memory allocated for mr->name in
memory_region_do_init() is leaked.

Since sdhci_initfn() already initializes s->io_ops to
&sdhci_mmio_ops, always use that in sdhci_common_realize()
and remove the now-unnecessary reinitialization of the
MMIO region from sdhci_sysbus_realize().

Spotted by clang's leak sanitizer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181204132952.2601-4-peter.maydell@linaro.org
---
 hw/sd/sdhci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 81bbf032794..83f1574ffdc 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1371,7 +1371,7 @@ static void sdhci_common_realize(SDHCIState *s, Error **errp)
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
@@ -1565,9 +1565,6 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
-            SDHC_REGISTERS_MAP_SIZE);
-
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.19.2
