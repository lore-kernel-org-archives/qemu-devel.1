Received: from eggs.gnu.org ([2001:4830:134:3::10]:39319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPg-00007c-Nv
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPd-0001oO-4s
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:19 -0500
Message-Id: <20170911172022.4738-36-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 35/38] libqtest: Merge qtest_{mem, buf}{read,
 write}() with {mem, buf}{read, write}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

Maintaining two layers of libqtest APIs, one that takes an explicit
QTestState object, and the other that uses the implicit global_qtest,
is annoying.  In the interest of getting rid of global implicit
state and having less code to maintain, merge:
 qtest_memread()
 qtest_bufread()
 qtest_memwrite()
 qtest_bufwrite()
with their short counterparts.  All callers that previously
used the short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h         | 69 ++++++------------------------------------------
 tests/libqtest.c         |  8 +++---
 tests/ahci-test.c        | 16 +++++------
 tests/e1000e-test.c      | 16 ++++++-----
 tests/i440fx-test.c      |  8 +++---
 tests/ide-test.c         | 14 +++++-----
 tests/libqos/ahci.c      | 22 +++++++--------
 tests/libqos/pci-pc.c    |  4 +--
 tests/libqos/pci-spapr.c |  4 +--
 tests/megasas-test.c     |  2 +-
 tests/postcopy-test.c    | 12 ++++-----
 tests/virtio-9p-test.c   |  4 +--
 tests/virtio-blk-test.c  | 16 +++++------
 tests/virtio-net-test.c  |  6 ++---
 tests/virtio-scsi-test.c |  4 +--
 15 files changed, 78 insertions(+), 127 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index d0c487cf79..adf04327b7 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -346,7 +346,7 @@ uint32_t readl(QTestState *s, uint64_t addr);
 uint64_t readq(QTestState *s, uint64_t addr);

 /**
- * qtest_memread:
+ * memread:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to read from.
  * @data: Pointer to where memory contents will be stored.
@@ -354,7 +354,7 @@ uint64_t readq(QTestState *s, uint64_t addr);
  *
  * Read guest memory into a buffer.
  */
-void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size);
+void memread(QTestState *s, uint64_t addr, void *data, size_t size);

 /**
  * qtest_rtas_call:
@@ -372,7 +372,7 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
                          uint32_t nret, uint64_t ret);

 /**
- * qtest_bufread:
+ * bufread:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to read from.
  * @data: Pointer to where memory contents will be stored.
@@ -380,10 +380,10 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
  *
  * Read guest memory into a buffer and receive using a base64 encoding.
  */
-void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size);
+void bufread(QTestState *s, uint64_t addr, void *data, size_t size);

 /**
- * qtest_memwrite:
+ * memwrite:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @data: Pointer to the bytes that will be written to guest memory.
@@ -391,10 +391,10 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size);
  *
  * Write a buffer to guest memory.
  */
-void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size);
+void memwrite(QTestState *s, uint64_t addr, const void *data, size_t size);

 /**
- * qtest_bufwrite:
+ * bufwrite:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @data: Pointer to the bytes that will be written to guest memory.
@@ -402,8 +402,7 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
  *
  * Write a buffer to guest memory and transmit using a base64 encoding.
  */
-void qtest_bufwrite(QTestState *s, uint64_t addr,
-                    const void *data, size_t size);
+void bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size);

 /**
  * qtest_memset:
@@ -594,58 +593,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
 char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
- * memread:
- * @addr: Guest address to read from.
- * @data: Pointer to where memory contents will be stored.
- * @size: Number of bytes to read.
- *
- * Read guest memory into a buffer.
- */
-static inline void memread(uint64_t addr, void *data, size_t size)
-{
-    qtest_memread(global_qtest, addr, data, size);
-}
-
-/**
- * bufread:
- * @addr: Guest address to read from.
- * @data: Pointer to where memory contents will be stored.
- * @size: Number of bytes to read.
- *
- * Read guest memory into a buffer, receive using a base64 encoding.
- */
-static inline void bufread(uint64_t addr, void *data, size_t size)
-{
-    qtest_bufread(global_qtest, addr, data, size);
-}
-
-/**
- * memwrite:
- * @addr: Guest address to write to.
- * @data: Pointer to the bytes that will be written to guest memory.
- * @size: Number of bytes to write.
- *
- * Write a buffer to guest memory.
- */
-static inline void memwrite(uint64_t addr, const void *data, size_t size)
-{
-    qtest_memwrite(global_qtest, addr, data, size);
-}
-
-/**
- * bufwrite:
- * @addr: Guest address to write to.
- * @data: Pointer to the bytes that will be written to guest memory.
- * @size: Number of bytes to write.
- *
- * Write a buffer to guest memory, transmit using a base64 encoding.
- */
-static inline void bufwrite(uint64_t addr, const void *data, size_t size)
-{
-    qtest_bufwrite(global_qtest, addr, data, size);
-}
-
-/**
  * qmemset:
  * @addr: Guest address to write to.
  * @patt: Byte pattern to fill the guest memory region with.
diff --git a/tests/libqtest.c b/tests/libqtest.c
index d9d0402287..a52dc635f4 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -822,7 +822,7 @@ static int hex2nib(char ch)
     }
 }

-void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
+void memread(QTestState *s, uint64_t addr, void *data, size_t size)
 {
     uint8_t *ptr = data;
     gchar **args;
@@ -877,7 +877,7 @@ void qtest_add_data_func(const char *str, const void *data,
     g_free(path);
 }

-void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
+void bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
 {
     gchar *bdata;

@@ -889,7 +889,7 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
     g_free(bdata);
 }

-void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
+void bufread(QTestState *s, uint64_t addr, void *data, size_t size)
 {
     gchar **args;
     size_t len;
@@ -908,7 +908,7 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
     g_strfreev(args);
 }

-void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
+void memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
 {
     const uint8_t *ptr = data;
     size_t i;
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 7c94c4920b..4b5f0b23fb 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -869,7 +869,7 @@ static void ahci_test_io_rw_simple(AHCIQState *ahci, unsigned bufsize,

     /* Write some indicative pattern to our buffer. */
     generate_pattern(tx, bufsize, AHCI_SECTOR_SIZE);
-    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);
+    bufwrite(ahci->parent->qts, ptr, tx, bufsize);

     /* Write this buffer to disk, then read it back to the DMA buffer. */
     ahci_guest_io(ahci, port, write_cmd, ptr, bufsize, sector);
@@ -877,7 +877,7 @@ static void ahci_test_io_rw_simple(AHCIQState *ahci, unsigned bufsize,
     ahci_guest_io(ahci, port, read_cmd, ptr, bufsize, sector);

     /*** Read back the Data ***/
-    qtest_bufread(ahci->parent->qts, ptr, rx, bufsize);
+    bufread(ahci->parent->qts, ptr, rx, bufsize);
     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);

     ahci_free(ahci, ptr);
@@ -918,7 +918,7 @@ static void ahci_test_max(AHCIQState *ahci)
     }

     port = ahci_test_nondata(ahci, cmd);
-    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
+    memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
     nsect = (uint64_t)d2h->lba_hi[2] << 40 |
         (uint64_t)d2h->lba_hi[1] << 32 |
         (uint64_t)d2h->lba_hi[0] << 24 |
@@ -1036,7 +1036,7 @@ static void test_dma_fragmented(void)
     /* Create a DMA buffer in guest memory, and write our pattern to it. */
     ptr = guest_alloc(ahci->parent->alloc, bufsize);
     g_assert(ptr);
-    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);
+    bufwrite(ahci->parent->qts, ptr, tx, bufsize);

     cmd = ahci_command_create(CMD_WRITE_DMA);
     ahci_command_adjust(cmd, 0, ptr, bufsize, 32);
@@ -1053,7 +1053,7 @@ static void test_dma_fragmented(void)
     ahci_command_free(cmd);

     /* Read back the guest's receive buffer into local memory */
-    qtest_bufread(ahci->parent->qts, ptr, rx, bufsize);
+    bufread(ahci->parent->qts, ptr, rx, bufsize);
     guest_free(ahci->parent->alloc, ptr);

     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
@@ -1231,7 +1231,7 @@ static void ahci_halted_io_test(uint8_t cmd_read, uint8_t cmd_write)
     generate_pattern(tx, bufsize, AHCI_SECTOR_SIZE);
     ptr = ahci_alloc(ahci, bufsize);
     g_assert(ptr);
-    qtest_memwrite(ahci->parent->qts, ptr, tx, bufsize);
+    memwrite(ahci->parent->qts, ptr, tx, bufsize);

     /* Attempt to write (and fail) */
     cmd = ahci_guest_io_halt(ahci, port, cmd_write,
@@ -1305,7 +1305,7 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
     /* create DMA source buffer and write pattern */
     ptr = ahci_alloc(src, bufsize);
     g_assert(ptr);
-    qtest_memwrite(src->parent->qts, ptr, tx, bufsize);
+    memwrite(src->parent->qts, ptr, tx, bufsize);

     /* Write, trigger the VM to stop, migrate, then resume. */
     cmd = ahci_guest_io_halt(src, port, cmd_write,
@@ -1472,7 +1472,7 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     }

     rx = g_malloc0(opts->size);
-    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
+    bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
     g_assert_cmphex(memcmp(tx, rx, opts->size), ==, 0);
     g_free(rx);

diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index f4ead74f96..1e39d98e4a 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -202,11 +202,13 @@ static void e1000e_tx_ring_push(e1000e_device *d, void *descr)
     uint32_t tail = e1000e_macreg_read(d, E1000E_TDT);
     uint32_t len = e1000e_macreg_read(d, E1000E_TDLEN) / E1000E_TXD_LEN;

-    memwrite(d->tx_ring + tail * E1000E_TXD_LEN, descr, E1000E_TXD_LEN);
+    memwrite(global_qtest, d->tx_ring + tail * E1000E_TXD_LEN, descr,
+             E1000E_TXD_LEN);
     e1000e_macreg_write(d, E1000E_TDT, (tail + 1) % len);

     /* Read WB data for the packet transmitted */
-    memread(d->tx_ring + tail * E1000E_TXD_LEN, descr, E1000E_TXD_LEN);
+    memread(global_qtest, d->tx_ring + tail * E1000E_TXD_LEN, descr,
+            E1000E_TXD_LEN);
 }

 static void e1000e_rx_ring_push(e1000e_device *d, void *descr)
@@ -214,11 +216,13 @@ static void e1000e_rx_ring_push(e1000e_device *d, void *descr)
     uint32_t tail = e1000e_macreg_read(d, E1000E_RDT);
     uint32_t len = e1000e_macreg_read(d, E1000E_RDLEN) / E1000E_RXD_LEN;

-    memwrite(d->rx_ring + tail * E1000E_RXD_LEN, descr, E1000E_RXD_LEN);
+    memwrite(global_qtest, d->rx_ring + tail * E1000E_RXD_LEN, descr,
+             E1000E_RXD_LEN);
     e1000e_macreg_write(d, E1000E_RDT, (tail + 1) % len);

     /* Read WB data for the packet received */
-    memread(d->rx_ring + tail * E1000E_RXD_LEN, descr, E1000E_RXD_LEN);
+    memread(global_qtest, d->rx_ring + tail * E1000E_RXD_LEN, descr,
+            E1000E_RXD_LEN);
 }

 static void e1000e_wait_isr(e1000e_device *d, uint16_t msg_id)
@@ -269,7 +273,7 @@ static void e1000e_send_verify(e1000e_device *d)

     /* Prepare test data buffer */
     uint64_t data = guest_alloc(test_alloc, data_len);
-    memwrite(data, "TEST", 5);
+    memwrite(global_qtest, data, "TEST", 5);

     /* Prepare TX descriptor */
     memset(&descr, 0, sizeof(descr));
@@ -365,7 +369,7 @@ static void e1000e_receive_verify(e1000e_device *d)
         esta_dd, ==, esta_dd);

     /* Check data sent to the backend */
-    memread(data, buffer, sizeof(buffer));
+    memread(global_qtest, data, buffer, sizeof(buffer));
     g_assert_cmpstr(buffer, == , "TEST");

     /* Free test data buffer */
diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
index 1d78089f8e..804c8ca9a8 100644
--- a/tests/i440fx-test.c
+++ b/tests/i440fx-test.c
@@ -160,7 +160,7 @@ static gboolean verify_area(uint32_t start, uint32_t end, uint8_t value)
     int i;

     data = g_malloc0(size);
-    memread(start, data, size);
+    memread(global_qtest, start, data, size);

     g_test_message("verify_area: data[0] = 0x%x", data[0]);

@@ -183,7 +183,7 @@ static void write_area(uint32_t start, uint32_t end, uint8_t value)

     data = g_malloc(size);
     memset(data, value, size);
-    memwrite(start, data, size);
+    memwrite(global_qtest, start, data, size);

     g_free(data);
 }
@@ -354,7 +354,7 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,

     /* check below 4G */
     buf = g_malloc0(BLOB_SIZE);
-    memread(0x100000000ULL - BLOB_SIZE, buf, BLOB_SIZE);
+    memread(global_qtest, 0x100000000ULL - BLOB_SIZE, buf, BLOB_SIZE);
     for (i = 0; i < BLOB_SIZE; ++i) {
         g_assert_cmphex(buf[i], ==, (uint8_t)i);
     }
@@ -362,7 +362,7 @@ static void test_i440fx_firmware(FirmwareTestFixture *fixture,
     /* check in ISA space too */
     memset(buf, 0, BLOB_SIZE);
     isa_bios_size = ISA_BIOS_MAXSZ < BLOB_SIZE ? ISA_BIOS_MAXSZ : BLOB_SIZE;
-    memread(0x100000 - isa_bios_size, buf, isa_bios_size);
+    memread(global_qtest, 0x100000 - isa_bios_size, buf, isa_bios_size);
     for (i = 0; i < isa_bios_size; ++i) {
         g_assert_cmphex(buf[i], ==,
                         (uint8_t)((BLOB_SIZE - isa_bios_size) + i));
diff --git a/tests/ide-test.c b/tests/ide-test.c
index c22dde55c1..c47cbb1949 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -222,7 +222,7 @@ static int send_dma_request(int cmd, uint64_t sector, int nb_sectors,
     /* Setup PRDT */
     len = sizeof(*prdt) * prdt_entries;
     guest_prdt = guest_alloc(guest_malloc, len);
-    memwrite(guest_prdt, prdt, len);
+    memwrite(global_qtest, guest_prdt, prdt, len);
     qpci_io_writel(dev, bmdma_bar, bmreg_prdt, guest_prdt);

     /* ATA DMA command */
@@ -299,7 +299,7 @@ static void test_bmdma_simple_rw(void)

     /* Write 0x55 pattern to sector 0 */
     memset(buf, 0x55, len);
-    memwrite(guest_buf, buf, len);
+    memwrite(global_qtest, guest_buf, buf, len);

     status = send_dma_request(CMD_WRITE_DMA, 0, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
@@ -308,7 +308,7 @@ static void test_bmdma_simple_rw(void)

     /* Write 0xaa pattern to sector 1 */
     memset(buf, 0xaa, len);
-    memwrite(guest_buf, buf, len);
+    memwrite(global_qtest, guest_buf, buf, len);

     status = send_dma_request(CMD_WRITE_DMA, 1, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
@@ -322,7 +322,7 @@ static void test_bmdma_simple_rw(void)
     g_assert_cmphex(status, ==, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);

-    memread(guest_buf, buf, len);
+    memread(global_qtest, guest_buf, buf, len);
     g_assert(memcmp(buf, cmpbuf, len) == 0);

     /* Read and verify 0xaa pattern in sector 1 */
@@ -332,7 +332,7 @@ static void test_bmdma_simple_rw(void)
     g_assert_cmphex(status, ==, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);

-    memread(guest_buf, buf, len);
+    memread(global_qtest, guest_buf, buf, len);
     g_assert(memcmp(buf, cmpbuf, len) == 0);


@@ -551,7 +551,7 @@ static void make_dirty(uint8_t device)
     g_assert(guest_buf);
     g_assert(buf);

-    memwrite(guest_buf, buf, len);
+    memwrite(global_qtest, guest_buf, buf, len);

     PrdtEntry prdt[] = {
         {
@@ -921,7 +921,7 @@ static void test_cdrom_dma(void)
     send_dma_request(CMD_PACKET, 0, 1, prdt, 1, send_scsi_cdb_read10);

     /* Read back data from guest memory into local qtest memory */
-    memread(guest_buf, rx, len);
+    memread(global_qtest, guest_buf, rx, len);
     g_assert_cmpint(memcmp(pattern, rx, len), ==, 0);

     g_free(pattern);
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index ba79cd77a0..433952c11a 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -467,7 +467,7 @@ void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t slot)
     RegD2HFIS *d2h = g_malloc0(0x20);
     uint32_t reg;

-    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
+    memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
     g_assert_cmphex(d2h->fis_type, ==, 0x34);

     reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
@@ -485,7 +485,7 @@ void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
     /* We cannot check the Status or E_Status registers, because
      * the status may have again changed between the PIO Setup FIS
      * and the conclusion of the command with the D2H Register FIS. */
-    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x20, pio, 0x20);
+    memread(ahci->parent->qts, ahci->port[port].fb + 0x20, pio, 0x20);
     g_assert_cmphex(pio->fis_type, ==, 0x5f);

     /* BUG: PIO Setup FIS as utilized by QEMU tries to fit the entire
@@ -517,7 +517,7 @@ void ahci_get_command_header(AHCIQState *ahci, uint8_t port,
 {
     uint64_t ba = ahci->port[port].clb;
     ba += slot * sizeof(AHCICommandHeader);
-    qtest_memread(ahci->parent->qts, ba, cmd, sizeof(AHCICommandHeader));
+    memread(ahci->parent->qts, ba, cmd, sizeof(AHCICommandHeader));

     cmd->flags = le16_to_cpu(cmd->flags);
     cmd->prdtl = le16_to_cpu(cmd->prdtl);
@@ -538,7 +538,7 @@ void ahci_set_command_header(AHCIQState *ahci, uint8_t port,
     tmp.prdbc = cpu_to_le32(cmd->prdbc);
     tmp.ctba = cpu_to_le64(cmd->ctba);

-    qtest_memwrite(ahci->parent->qts, ba, &tmp, sizeof(AHCICommandHeader));
+    memwrite(ahci->parent->qts, ba, &tmp, sizeof(AHCICommandHeader));
 }

 void ahci_destroy_command(AHCIQState *ahci, uint8_t port, uint8_t slot)
@@ -576,7 +576,7 @@ void ahci_write_fis(AHCIQState *ahci, AHCICommand *cmd)
         tmp.count = cpu_to_le16(tmp.count);
     }

-    qtest_memwrite(ahci->parent->qts, addr, &tmp, sizeof(tmp));
+    memwrite(ahci->parent->qts, addr, &tmp, sizeof(tmp));
 }

 unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port)
@@ -758,13 +758,13 @@ void ahci_io(AHCIQState *ahci, uint8_t port, uint8_t ide_cmd,
     qtest_memset(ahci->parent->qts, ptr, 0x00, bufsize);

     if (bufsize && props->write) {
-        qtest_bufwrite(ahci->parent->qts, ptr, buffer, bufsize);
+        bufwrite(ahci->parent->qts, ptr, buffer, bufsize);
     }

     ahci_guest_io(ahci, port, ide_cmd, ptr, bufsize, sector);

     if (bufsize && props->read) {
-        qtest_bufread(ahci->parent->qts, ptr, buffer, bufsize);
+        bufread(ahci->parent->qts, ptr, buffer, bufsize);
     }

     ahci_free(ahci, ptr);
@@ -902,7 +902,7 @@ static int copy_buffer(AHCIQState *ahci, AHCICommand *cmd,
                         const AHCIOpts *opts)
 {
     unsigned char *rx = opts->opaque;
-    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
+    bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
     return 0;
 }

@@ -1142,7 +1142,7 @@ void ahci_command_commit(AHCIQState *ahci, AHCICommand *cmd, uint8_t port)
     ahci_write_fis(ahci, cmd);
     /* Then ATAPI CMD, if needed */
     if (cmd->props->atapi) {
-        qtest_memwrite(ahci->parent->qts, table_ptr + 0x40, cmd->atapi_cmd, 16);
+        memwrite(ahci->parent->qts, table_ptr + 0x40, cmd->atapi_cmd, 16);
     }

     /* Construct and write the PRDs to the command table */
@@ -1163,8 +1163,8 @@ void ahci_command_commit(AHCIQState *ahci, AHCICommand *cmd, uint8_t port)
         prd.dbc |= cpu_to_le32(0x80000000); /* Request DPS Interrupt */

         /* Commit the PRD entry to the Command Table */
-        qtest_memwrite(ahci->parent->qts, table_ptr + 0x80 + (i * sizeof(PRD)),
-                       &prd, sizeof(PRD));
+        memwrite(ahci->parent->qts, table_ptr + 0x80 + (i * sizeof(PRD)),
+                 &prd, sizeof(PRD));
     }

     /* Bookmark the PRDTL and CTBA values */
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 4d8329bef0..aa4d5b3c43 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -68,13 +68,13 @@ static void qpci_pc_pio_writeq(QPCIBus *bus, uint32_t addr, uint64_t val)

 static void qpci_pc_memread(QPCIBus *bus, uint32_t addr, void *buf, size_t len)
 {
-    qtest_memread(bus->qts, addr, buf, len);
+    memread(bus->qts, addr, buf, len);
 }

 static void qpci_pc_memwrite(QPCIBus *bus, uint32_t addr,
                              const void *buf, size_t len)
 {
-    qtest_memwrite(bus->qts, addr, buf, len);
+    memwrite(bus->qts, addr, buf, len);
 }

 static uint8_t qpci_pc_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 7bae94e9bd..5d9f7c3494 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -94,14 +94,14 @@ static void qpci_spapr_memread(QPCIBus *bus, uint32_t addr,
                                void *buf, size_t len)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    qtest_memread(bus->qts, s->mmio32_cpu_base + addr, buf, len);
+    memread(bus->qts, s->mmio32_cpu_base + addr, buf, len);
 }

 static void qpci_spapr_memwrite(QPCIBus *bus, uint32_t addr,
                                 const void *buf, size_t len)
 {
     QPCIBusSPAPR *s = container_of(bus, QPCIBusSPAPR, bus);
-    qtest_memwrite(bus->qts, s->mmio32_cpu_base + addr, buf, len);
+    memwrite(bus->qts, s->mmio32_cpu_base + addr, buf, len);
 }

 static uint8_t qpci_spapr_config_readb(QPCIBus *bus, int devfn, uint8_t offset)
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index 81837e14af..7f16630e52 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -72,7 +72,7 @@ static void megasas_pd_get_info_fuzz(void)
     context[7] = cpu_to_le32(0);

     context_pa = qmalloc(qs, sizeof(context));
-    memwrite(context_pa, context, sizeof(context));
+    memwrite(global_qtest, context_pa, context, sizeof(context));
     qpci_io_writel(dev, bar, 0x40, context_pa);

     g_free(dev);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index efee20a099..04889b8078 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -320,13 +320,13 @@ static void check_guests_ram(QTestState *qts)
     bool hit_edge = false;
     bool bad = false;

-    qtest_memread(qts, start_address, &first_byte, 1);
+    memread(qts, start_address, &first_byte, 1);
     last_byte = first_byte;

     for (address = start_address + 4096; address < end_address; address += 4096)
     {
         uint8_t b;
-        qtest_memread(qts, address, &b, 1);
+        memread(qts, address, &b, 1);
         if (b != last_byte) {
             if (((b + 1) % 256) == last_byte && !hit_edge) {
                 /* This is OK, the guest stopped at the point of
@@ -470,19 +470,19 @@ static void test_migrate(void)

     qtest_quit(from);

-    qtest_memread(to, start_address, &dest_byte_a, 1);
+    memread(to, start_address, &dest_byte_a, 1);

     /* Destination still running, wait for a byte to change */
     do {
-        qtest_memread(to, start_address, &dest_byte_b, 1);
+        memread(to, start_address, &dest_byte_b, 1);
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

     qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
     /* With it stopped, check nothing changes */
-    qtest_memread(to, start_address, &dest_byte_c, 1);
+    memread(to, start_address, &dest_byte_c, 1);
     sleep(1);
-    qtest_memread(to, start_address, &dest_byte_d, 1);
+    memread(to, start_address, &dest_byte_d, 1);
     g_assert_cmpint(dest_byte_c, ==, dest_byte_d);

     check_guests_ram(to);
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 07cbb7f37c..e2a14bc2ff 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -116,7 +116,7 @@ typedef struct {

 static void v9fs_memwrite(P9Req *req, const void *addr, size_t len)
 {
-    memwrite(req->t_msg + req->t_off, addr, len);
+    memwrite(global_qtest, req->t_msg + req->t_off, addr, len);
     req->t_off += len;
 }

@@ -132,7 +132,7 @@ static void v9fs_memrewind(P9Req *req, size_t len)

 static void v9fs_memread(P9Req *req, void *addr, size_t len)
 {
-    memread(req->r_msg + req->r_off, addr, len);
+    memread(global_qtest, req->r_msg + req->r_off, addr, len);
     req->r_off += len;
 }

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 5f8606ea80..ec582c8e1c 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -145,9 +145,9 @@ static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice *d,

     virtio_blk_fix_request(d, req);

-    memwrite(addr, req, 16);
-    memwrite(addr + 16, req->data, data_size);
-    memwrite(addr + 16 + data_size, &status, sizeof(status));
+    memwrite(global_qtest, addr, req, 16);
+    memwrite(global_qtest, addr + 16, req->data, data_size);
+    memwrite(global_qtest, addr + 16 + data_size, &status, sizeof(status));

     return addr;
 }
@@ -221,7 +221,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
-    memread(req_addr + 16, data, 512);
+    memread(global_qtest, req_addr + 16, data, 512);
     g_assert_cmpstr(data, ==, "TEST");
     g_free(data);

@@ -270,7 +270,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
         g_assert_cmpint(status, ==, 0);

         data = g_malloc0(512);
-        memread(req_addr + 16, data, 512);
+        memread(global_qtest, req_addr + 16, data, 512);
         g_assert_cmpstr(data, ==, "TEST");
         g_free(data);

@@ -380,7 +380,7 @@ static void pci_indirect(void)
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
-    memread(req_addr + 16, data, 512);
+    memread(global_qtest, req_addr + 16, data, 512);
     g_assert_cmpstr(data, ==, "TEST");
     g_free(data);

@@ -517,7 +517,7 @@ static void pci_msix(void)
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
-    memread(req_addr + 16, data, 512);
+    memread(global_qtest, req_addr + 16, data, 512);
     g_assert_cmpstr(data, ==, "TEST");
     g_free(data);

@@ -640,7 +640,7 @@ static void pci_idx(void)
     g_assert_cmpint(status, ==, 0);

     data = g_malloc0(512);
-    memread(req_addr + 16, data, 512);
+    memread(global_qtest, req_addr + 16, data, 512);
     g_assert_cmpstr(data, ==, "TEST");
     g_free(data);

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 9250c417a9..7ae3b57d37 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -112,7 +112,7 @@ static void rx_test(QVirtioDevice *dev,
     g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));

     qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
-    memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
+    memread(global_qtest, req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");

     guest_free(alloc, req_addr);
@@ -129,7 +129,7 @@ static void tx_test(QVirtioDevice *dev,
     int ret;

     req_addr = guest_alloc(alloc, 64);
-    memwrite(req_addr + VNET_HDR_SIZE, "TEST", 4);
+    memwrite(global_qtest, req_addr + VNET_HDR_SIZE, "TEST", 4);

     free_head = qvirtqueue_add(vq, req_addr, 64, false, false);
     qvirtqueue_kick(dev, vq, free_head);
@@ -186,7 +186,7 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     QDECREF(rsp);

     qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
-    memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
+    memread(global_qtest, req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");

     guest_free(alloc, req_addr);
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 30a341df2f..2cd8db9a9a 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -77,7 +77,7 @@ static uint64_t qvirtio_scsi_alloc(QVirtIOSCSI *vs, size_t alloc_size,

     addr = guest_alloc(vs->qs->alloc, alloc_size);
     if (data) {
-        memwrite(addr, data, alloc_size);
+        memwrite(global_qtest, addr, data, alloc_size);
     }

     return addr;
@@ -129,7 +129,7 @@ static uint8_t virtio_scsi_do_command(QVirtIOSCSI *vs, const uint8_t *cdb,
                      offsetof(struct virtio_scsi_cmd_resp, response));

     if (resp_out) {
-        memread(resp_addr, resp_out, sizeof(*resp_out));
+        memread(global_qtest, resp_addr, resp_out, sizeof(*resp_out));
     }

     guest_free(vs->qs->alloc, req_addr);
-- 
2.13.5
