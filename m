Received: from eggs.gnu.org ([2001:4830:134:3::10]:45288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVW-0002sn-Sa
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVV-0002uJ-PN
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLtVV-0002u0-FB
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:57 -0400
Date: Fri, 16 Jun 2017 18:49:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1497628168-30489-4-git-send-email-mst@redhat.com>
References: <1497628168-30489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497628168-30489-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] tests/q35-test: add TSEG size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>

From: Laszlo Ersek <lersek@redhat.com>

These checks verify that the guest RAM turns from read-write to
"blackhole" when crossing the low boundary of the TSEG. Both the standard
1MB/2MB/8MB TSEG sizes and an extended (16MB) TSEG size are tested.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/q35-test.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index 6c21b40..f98bed7 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -15,6 +15,48 @@
 #include "libqos/pci-pc.h"
 #include "hw/pci-host/q35.h"
 
+#define TSEG_SIZE_TEST_GUEST_RAM_MBYTES 128
+
+/* @esmramc_tseg_sz: ESMRAMC.TSEG_SZ bitmask for selecting the requested TSEG
+ *                   size. Must be a subset of
+ *                   MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK.
+ *
+ * @extended_tseg_mbytes: Size of the extended TSEG. Only consulted if
+ *                        @esmramc_tseg_sz equals
+ *                        MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK precisely.
+ *
+ * @expected_tseg_mbytes: Expected guest-visible TSEG size in megabytes,
+ *                        matching @esmramc_tseg_sz and @extended_tseg_mbytes
+ *                        above.
+ */
+struct TsegSizeArgs {
+    uint8_t esmramc_tseg_sz;
+    uint16_t extended_tseg_mbytes;
+    uint16_t expected_tseg_mbytes;
+};
+typedef struct TsegSizeArgs TsegSizeArgs;
+
+static const TsegSizeArgs tseg_1mb = {
+    .esmramc_tseg_sz      = MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_1MB,
+    .extended_tseg_mbytes = 0,
+    .expected_tseg_mbytes = 1,
+};
+static const TsegSizeArgs tseg_2mb = {
+    .esmramc_tseg_sz      = MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_2MB,
+    .extended_tseg_mbytes = 0,
+    .expected_tseg_mbytes = 2,
+};
+static const TsegSizeArgs tseg_8mb = {
+    .esmramc_tseg_sz      = MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_8MB,
+    .extended_tseg_mbytes = 0,
+    .expected_tseg_mbytes = 8,
+};
+static const TsegSizeArgs tseg_ext_16mb = {
+    .esmramc_tseg_sz      = MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK,
+    .extended_tseg_mbytes = 16,
+    .expected_tseg_mbytes = 16,
+};
+
 static void smram_set_bit(QPCIDevice *pcidev, uint8_t mask, bool enabled)
 {
     uint8_t smram;
@@ -80,11 +122,82 @@ static void test_smram_lock(void)
     qtest_end();
 }
 
+static void test_tseg_size(const void *data)
+{
+    const TsegSizeArgs *args = data;
+    char *cmdline;
+    QPCIBus *pcibus;
+    QPCIDevice *pcidev;
+    uint8_t smram_val;
+    uint8_t esmramc_val;
+    uint32_t ram_offs;
+
+    if (args->esmramc_tseg_sz == MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK) {
+        cmdline = g_strdup_printf("-M q35 -m %uM "
+                                  "-global mch.extended-tseg-mbytes=%u",
+                                  TSEG_SIZE_TEST_GUEST_RAM_MBYTES,
+                                  args->extended_tseg_mbytes);
+    } else {
+        cmdline = g_strdup_printf("-M q35 -m %uM",
+                                  TSEG_SIZE_TEST_GUEST_RAM_MBYTES);
+    }
+    qtest_start(cmdline);
+    g_free(cmdline);
+
+    /* locate the DRAM controller */
+    pcibus = qpci_init_pc(NULL);
+    g_assert(pcibus != NULL);
+    pcidev = qpci_device_find(pcibus, 0);
+    g_assert(pcidev != NULL);
+
+    /* Set TSEG size. Restrict TSEG visibility to SMM by setting T_EN. */
+    esmramc_val = qpci_config_readb(pcidev, MCH_HOST_BRIDGE_ESMRAMC);
+    esmramc_val &= ~MCH_HOST_BRIDGE_ESMRAMC_TSEG_SZ_MASK;
+    esmramc_val |= args->esmramc_tseg_sz;
+    esmramc_val |= MCH_HOST_BRIDGE_ESMRAMC_T_EN;
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_ESMRAMC, esmramc_val);
+
+    /* Enable TSEG by setting G_SMRAME. Close TSEG by setting D_CLS. */
+    smram_val = qpci_config_readb(pcidev, MCH_HOST_BRIDGE_SMRAM);
+    smram_val &= ~(MCH_HOST_BRIDGE_SMRAM_D_OPEN |
+                   MCH_HOST_BRIDGE_SMRAM_D_LCK);
+    smram_val |= (MCH_HOST_BRIDGE_SMRAM_D_CLS |
+                  MCH_HOST_BRIDGE_SMRAM_G_SMRAME);
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_SMRAM, smram_val);
+
+    /* lock TSEG */
+    smram_val |= MCH_HOST_BRIDGE_SMRAM_D_LCK;
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_SMRAM, smram_val);
+
+    /* Now check that the byte right before the TSEG is r/w, and that the first
+     * byte in the TSEG always reads as 0xff.
+     */
+    ram_offs = (TSEG_SIZE_TEST_GUEST_RAM_MBYTES - args->expected_tseg_mbytes) *
+               1024 * 1024 - 1;
+    g_assert_cmpint(readb(ram_offs), ==, 0);
+    writeb(ram_offs, 1);
+    g_assert_cmpint(readb(ram_offs), ==, 1);
+
+    ram_offs++;
+    g_assert_cmpint(readb(ram_offs), ==, 0xff);
+    writeb(ram_offs, 1);
+    g_assert_cmpint(readb(ram_offs), ==, 0xff);
+
+    g_free(pcidev);
+    qpci_free_pc(pcibus);
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/q35/smram/lock", test_smram_lock);
 
+    qtest_add_data_func("/q35/tseg-size/1mb", &tseg_1mb, test_tseg_size);
+    qtest_add_data_func("/q35/tseg-size/2mb", &tseg_2mb, test_tseg_size);
+    qtest_add_data_func("/q35/tseg-size/8mb", &tseg_8mb, test_tseg_size);
+    qtest_add_data_func("/q35/tseg-size/ext/16mb", &tseg_ext_16mb,
+                        test_tseg_size);
     return g_test_run();
 }
-- 
MST
