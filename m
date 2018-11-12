Received: from eggs.gnu.org ([2001:4830:134:3::10]:53160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJzl-0007MQ-FF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1gMJza-000310-6p
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:43:40 -0500
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Mon, 12 Nov 2018 16:42:24 -0500
Message-Id: <20181112214224.31560-15-contrib@steffen-goertz.de>
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 14/14] arm: Add Clock peripheral stub to
 NRF51 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, "open list:NRF51" <qemu-arm@nongnu.org>

This stubs enables the microbit-micropython firmware to run
on the microbit machine.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/nrf51_soc.c         | 27 +++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 86ee91c7cc..ab95e26282 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -36,6 +36,26 @@
=20
 #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
=20
+static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
+                  __func__, addr, size);
+    return 1;
+}
+
+static void clock_write(void *opaque, hwaddr addr, uint64_t data,
+                        unsigned int size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
+                  __func__, addr, data, size);
+}
+
+static const MemoryRegionOps clock_ops =3D {
+    .read =3D clock_read,
+    .write =3D clock_write
+};
+
+
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s =3D NRF51_SOC(dev_soc);
@@ -147,6 +167,13 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
Error **errp)
                                             BASE_TO_IRQ(base_addr)));
     }
=20
+    /* STUB Peripherals */
+    memory_region_init_io(&s->clock, NULL, &clock_ops, NULL,
+                          "nrf51_soc.clock", 0x1000);
+    memory_region_add_subregion_overlap(&s->container,
+                                        NRF51_IOMEM_BASE, &s->clock, -1)=
;
+
+
=20
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 89525dcb39..4610d0c7ae 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -40,6 +40,7 @@ typedef struct NRF51State {
     MemoryRegion iomem;
     MemoryRegion sram;
     MemoryRegion flash;
+    MemoryRegion clock;
=20
     uint32_t sram_size;
     uint32_t flash_size;
--=20
2.19.1
