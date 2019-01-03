Received: from eggs.gnu.org ([208.118.235.92]:52120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez4B-000462-RR
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gez49-0006vl-EE
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:13:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  3 Jan 2019 09:11:19 +0000
Message-Id: <20190103091119.9367-12-stefanha@redhat.com>
In-Reply-To: <20190103091119.9367-1-stefanha@redhat.com>
References: <20190103091119.9367-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/11] arm: Add Clock peripheral stub to NRF51
 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

This stubs enables the microbit-micropython firmware to run
on the microbit machine.

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/arm/nrf51_soc.h |  1 +
 hw/arm/nrf51_soc.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 39e613e1c9..e06f0304b4 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -38,6 +38,7 @@ typedef struct NRF51State {
     MemoryRegion iomem;
     MemoryRegion sram;
     MemoryRegion flash;
+    MemoryRegion clock;
=20
     uint32_t sram_size;
     uint32_t flash_size;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index ef70bd62fa..1630c27594 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -34,6 +34,26 @@
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
@@ -130,6 +150,12 @@ static void nrf51_soc_realize(DeviceState *dev_soc, =
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
     create_unimplemented_device("nrf51_soc.io", NRF51_IOMEM_BASE,
                                 NRF51_IOMEM_SIZE);
     create_unimplemented_device("nrf51_soc.ficr", NRF51_FICR_BASE,
--=20
2.19.2
