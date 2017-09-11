Received: from eggs.gnu.org ([2001:4830:134:3::10]:38597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOW-0007Ue-Nr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOS-0001Fv-6u
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:00 -0500
Message-Id: <20170911172022.4738-17-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 16/38] libqos: Use explicit QTestState for
 ahci operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Drop one more client of global_qtest by teaching all ahci test
functionality to pass in an explicit QTestState.  The state was
already available, so no callers had to be adjusted.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: split libqos changes from test-ahci
---
 tests/libqos/ahci.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 790ef991b3..ba79cd77a0 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -283,7 +283,8 @@ void ahci_hba_enable(AHCIQState *ahci)
         /* Allocate Memory for the Command List Buffer & FIS Buffer */
         /* PxCLB space ... 0x20 per command, as in 4.2.2 p 36 */
         ahci->port[i].clb = ahci_alloc(ahci, num_cmd_slots * 0x20);
-        qmemset(ahci->port[i].clb, 0x00, num_cmd_slots * 0x20);
+        qtest_memset(ahci->parent->qts, ahci->port[i].clb, 0x00,
+                     num_cmd_slots * 0x20);
         g_test_message("CLB: 0x%08" PRIx64, ahci->port[i].clb);
         ahci_px_wreg(ahci, i, AHCI_PX_CLB, ahci->port[i].clb);
         g_assert_cmphex(ahci->port[i].clb, ==,
@@ -291,7 +292,7 @@ void ahci_hba_enable(AHCIQState *ahci)

         /* PxFB space ... 0x100, as in 4.2.1 p 35 */
         ahci->port[i].fb = ahci_alloc(ahci, 0x100);
-        qmemset(ahci->port[i].fb, 0x00, 0x100);
+        qtest_memset(ahci->parent->qts, ahci->port[i].fb, 0x00, 0x100);
         g_test_message("FB: 0x%08" PRIx64, ahci->port[i].fb);
         ahci_px_wreg(ahci, i, AHCI_PX_FB, ahci->port[i].fb);
         g_assert_cmphex(ahci->port[i].fb, ==,
@@ -397,7 +398,7 @@ void ahci_port_clear(AHCIQState *ahci, uint8_t port)
     g_assert_cmphex(ahci_px_rreg(ahci, port, AHCI_PX_IS), ==, 0);

     /* Wipe the FIS-Receive Buffer */
-    qmemset(ahci->port[port].fb, 0x00, 0x100);
+    qtest_memset(ahci->parent->qts, ahci->port[port].fb, 0x00, 0x100);
 }

 /**
@@ -466,7 +467,7 @@ void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t slot)
     RegD2HFIS *d2h = g_malloc0(0x20);
     uint32_t reg;

-    memread(ahci->port[port].fb + 0x40, d2h, 0x20);
+    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
     g_assert_cmphex(d2h->fis_type, ==, 0x34);

     reg = ahci_px_rreg(ahci, port, AHCI_PX_TFD);
@@ -484,7 +485,7 @@ void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
     /* We cannot check the Status or E_Status registers, because
      * the status may have again changed between the PIO Setup FIS
      * and the conclusion of the command with the D2H Register FIS. */
-    memread(ahci->port[port].fb + 0x20, pio, 0x20);
+    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x20, pio, 0x20);
     g_assert_cmphex(pio->fis_type, ==, 0x5f);

     /* BUG: PIO Setup FIS as utilized by QEMU tries to fit the entire
@@ -516,7 +517,7 @@ void ahci_get_command_header(AHCIQState *ahci, uint8_t port,
 {
     uint64_t ba = ahci->port[port].clb;
     ba += slot * sizeof(AHCICommandHeader);
-    memread(ba, cmd, sizeof(AHCICommandHeader));
+    qtest_memread(ahci->parent->qts, ba, cmd, sizeof(AHCICommandHeader));

     cmd->flags = le16_to_cpu(cmd->flags);
     cmd->prdtl = le16_to_cpu(cmd->prdtl);
@@ -537,7 +538,7 @@ void ahci_set_command_header(AHCIQState *ahci, uint8_t port,
     tmp.prdbc = cpu_to_le32(cmd->prdbc);
     tmp.ctba = cpu_to_le64(cmd->ctba);

-    memwrite(ba, &tmp, sizeof(AHCICommandHeader));
+    qtest_memwrite(ahci->parent->qts, ba, &tmp, sizeof(AHCICommandHeader));
 }

 void ahci_destroy_command(AHCIQState *ahci, uint8_t port, uint8_t slot)
@@ -575,7 +576,7 @@ void ahci_write_fis(AHCIQState *ahci, AHCICommand *cmd)
         tmp.count = cpu_to_le16(tmp.count);
     }

-    memwrite(addr, &tmp, sizeof(tmp));
+    qtest_memwrite(ahci->parent->qts, addr, &tmp, sizeof(tmp));
 }

 unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port)
@@ -636,7 +637,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     if (opts->size && !opts->buffer) {
         opts->buffer = ahci_alloc(ahci, opts->size);
         g_assert(opts->buffer);
-        qmemset(opts->buffer, 0x00, opts->size);
+        qtest_memset(ahci->parent->qts, opts->buffer, 0x00, opts->size);
     }

     /* Command creation */
@@ -661,15 +662,15 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     ahci_command_commit(ahci, cmd, port);
     ahci_command_issue_async(ahci, cmd);
     if (opts->error) {
-        qmp_eventwait("STOP");
+        qtest_qmp_eventwait(ahci->parent->qts, "STOP");
     }
     if (opts->mid_cb) {
         rc = opts->mid_cb(ahci, cmd, opts);
         g_assert_cmpint(rc, ==, 0);
     }
     if (opts->error) {
-        qmp_async("{'execute':'cont' }");
-        qmp_eventwait("RESUME");
+        qtest_async_qmp(ahci->parent->qts, "{'execute':'cont' }");
+        qtest_qmp_eventwait(ahci->parent->qts, "RESUME");
     }

     /* Wait for command to complete and verify sanity */
@@ -697,7 +698,7 @@ AHCICommand *ahci_guest_io_halt(AHCIQState *ahci, uint8_t port,
     ahci_command_adjust(cmd, sector, buffer, bufsize, 0);
     ahci_command_commit(ahci, cmd, port);
     ahci_command_issue_async(ahci, cmd);
-    qmp_eventwait("STOP");
+    qtest_qmp_eventwait(ahci->parent->qts, "STOP");

     return cmd;
 }
@@ -706,8 +707,8 @@ AHCICommand *ahci_guest_io_halt(AHCIQState *ahci, uint8_t port,
 void ahci_guest_io_resume(AHCIQState *ahci, AHCICommand *cmd)
 {
     /* Complete the command */
-    qmp_async("{'execute':'cont' }");
-    qmp_eventwait("RESUME");
+    qtest_async_qmp(ahci->parent->qts, "{'execute':'cont' }");
+    qtest_qmp_eventwait(ahci->parent->qts, "RESUME");
     ahci_command_wait(ahci, cmd);
     ahci_command_verify(ahci, cmd);
     ahci_command_free(cmd);
@@ -754,16 +755,16 @@ void ahci_io(AHCIQState *ahci, uint8_t port, uint8_t ide_cmd,
     g_assert(props);
     ptr = ahci_alloc(ahci, bufsize);
     g_assert(!bufsize || ptr);
-    qmemset(ptr, 0x00, bufsize);
+    qtest_memset(ahci->parent->qts, ptr, 0x00, bufsize);

     if (bufsize && props->write) {
-        bufwrite(ptr, buffer, bufsize);
+        qtest_bufwrite(ahci->parent->qts, ptr, buffer, bufsize);
     }

     ahci_guest_io(ahci, port, ide_cmd, ptr, bufsize, sector);

     if (bufsize && props->read) {
-        bufread(ptr, buffer, bufsize);
+        qtest_bufread(ahci->parent->qts, ptr, buffer, bufsize);
     }

     ahci_free(ahci, ptr);
@@ -901,7 +902,7 @@ static int copy_buffer(AHCIQState *ahci, AHCICommand *cmd,
                         const AHCIOpts *opts)
 {
     unsigned char *rx = opts->opaque;
-    bufread(opts->buffer, rx, opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
     return 0;
 }

@@ -1141,7 +1142,7 @@ void ahci_command_commit(AHCIQState *ahci, AHCICommand *cmd, uint8_t port)
     ahci_write_fis(ahci, cmd);
     /* Then ATAPI CMD, if needed */
     if (cmd->props->atapi) {
-        memwrite(table_ptr + 0x40, cmd->atapi_cmd, 16);
+        qtest_memwrite(ahci->parent->qts, table_ptr + 0x40, cmd->atapi_cmd, 16);
     }

     /* Construct and write the PRDs to the command table */
@@ -1162,8 +1163,8 @@ void ahci_command_commit(AHCIQState *ahci, AHCICommand *cmd, uint8_t port)
         prd.dbc |= cpu_to_le32(0x80000000); /* Request DPS Interrupt */

         /* Commit the PRD entry to the Command Table */
-        memwrite(table_ptr + 0x80 + (i * sizeof(PRD)),
-                 &prd, sizeof(PRD));
+        qtest_memwrite(ahci->parent->qts, table_ptr + 0x80 + (i * sizeof(PRD)),
+                       &prd, sizeof(PRD));
     }

     /* Bookmark the PRDTL and CTBA values */
-- 
2.13.5
