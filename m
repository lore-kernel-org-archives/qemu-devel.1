Received: from eggs.gnu.org ([2001:4830:134:3::10]:56291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIw-0007Yk-0S
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIt-00024f-Be
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:28 -0500
Message-Id: <20170901180340.30009-18-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 17/29] ahci-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Managing parallel connections to two different monitors via
the implicit global_qtest makes it hard to copy-and-paste code
to tests that are not aware of the implicit state; the
management of global_qtest is even harder to follow because
it was masked behind set_context().

Instead, explicitly pass QTestState* around (generally, by
reusing the member already present in ahci->parent QOSState),
and call explicit qtest_* functions on all places that
interact with a monitor.

We can assert that the conversion is correct by checking that
global_qtest remains NULL throughout the test (a later patch
that changes global_qtest to not be a public global variable
will drop the assertions).

Bonus: there were several spots that were constructing a JSON
string, then passing that through qmp() as the format, rather
than directly using qmp() to construct the JSON.  Fixing that
gets us one step closer to enabling -Wformat checking on
constructed JSON.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/libqos.h    |  1 -
 tests/ahci-test.c        | 83 +++++++++++++++++++++++-------------------------
 tests/libqos/ahci.c      | 45 +++++++++++++-------------
 tests/libqos/libqos-pc.c |  2 +-
 tests/libqos/libqos.c    | 37 ++++++---------------
 5 files changed, 73 insertions(+), 95 deletions(-)

diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
index 07d4b93d1d..9e020efb10 100644
--- a/tests/libqos/libqos.h
+++ b/tests/libqos/libqos.h
@@ -29,7 +29,6 @@ void qtest_shutdown(QOSState *qs);
 bool have_qemu_img(void);
 void mkimg(const char *file, const char *fmt, unsigned size_mb);
 void mkqcow2(const char *file, unsigned size_mb);
-void set_context(QOSState *s);
 void migrate(QOSState *from, QOSState *to, const char *uri);
 void prepare_blkdebug_script(const char *debug_fn, const char *event);
 void generate_pattern(void *buffer, size_t len, size_t cycle_len);
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index c94d1bd712..ba3f643d09 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -157,6 +157,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_list ap)

     s = g_malloc0(sizeof(AHCIQState));
     s->parent = qtest_pc_vboot(cli, ap);
+    global_qtest = NULL;
     alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);

     /* Verify that we have an AHCI device present. */
@@ -196,7 +197,7 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;

-    set_context(qs);
+    assert(!global_qtest);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -869,15 +870,15 @@ static void ahci_test_io_rw_simple(AHCIQState *ahci, unsigned bufsize,

     /* Write some indicative pattern to our buffer. */
     generate_pattern(tx, bufsize, AHCI_SECTOR_SIZE);
-    bufwrite(ptr, tx, bufsize);
+    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);

     /* Write this buffer to disk, then read it back to the DMA buffer. */
     ahci_guest_io(ahci, port, write_cmd, ptr, bufsize, sector);
-    qmemset(ptr, 0x00, bufsize);
+    qtest_memset(ahci->parent->qts, ptr, 0x00, bufsize);
     ahci_guest_io(ahci, port, read_cmd, ptr, bufsize, sector);

     /*** Read back the Data ***/
-    bufread(ptr, rx, bufsize);
+    qtest_bufread(ahci->parent->qts, ptr, rx, bufsize);
     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);

     ahci_free(ahci, ptr);
@@ -918,7 +919,7 @@ static void ahci_test_max(AHCIQState *ahci)
     }

     port = ahci_test_nondata(ahci, cmd);
-    memread(ahci->port[port].fb + 0x40, d2h, 0x20);
+    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
     nsect = (uint64_t)d2h->lba_hi[2] << 40 |
         (uint64_t)d2h->lba_hi[1] << 32 |
         (uint64_t)d2h->lba_hi[0] << 24 |
@@ -1036,7 +1037,7 @@ static void test_dma_fragmented(void)
     /* Create a DMA buffer in guest memory, and write our pattern to it. */
     ptr = guest_alloc(ahci->parent->alloc, bufsize);
     g_assert(ptr);
-    bufwrite(ptr, tx, bufsize);
+    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);

     cmd = ahci_command_create(CMD_WRITE_DMA);
     ahci_command_adjust(cmd, 0, ptr, bufsize, 32);
@@ -1053,7 +1054,7 @@ static void test_dma_fragmented(void)
     ahci_command_free(cmd);

     /* Read back the guest's receive buffer into local memory */
-    bufread(ptr, rx, bufsize);
+    qtest_bufread(ahci->parent->qts, ptr, rx, bufsize);
     guest_free(ahci->parent->alloc, ptr);

     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
@@ -1164,8 +1165,6 @@ static void ahci_migrate_simple(uint8_t cmd_read, uint8_t cmd_write)
                     "-drive if=ide,format=%s,file=%s "
                     "-incoming %s", imgfmt, tmp_path, uri);

-    set_context(src->parent);
-
     /* initialize */
     px = ahci_port_select(src);
     ahci_port_clear(src, px);
@@ -1233,7 +1232,7 @@ static void ahci_halted_io_test(uint8_t cmd_read, uint8_t cmd_write)
     generate_pattern(tx, bufsize, AHCI_SECTOR_SIZE);
     ptr = ahci_alloc(ahci, bufsize);
     g_assert(ptr);
-    memwrite(ptr, tx, bufsize);
+    qtest_memwrite(ahci->parent->qts, ptr, tx, bufsize);

     /* Attempt to write (and fail) */
     cmd = ahci_guest_io_halt(ahci, port, cmd_write,
@@ -1299,8 +1298,6 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
                     "-incoming %s",
                     tmp_path, imgfmt, uri);

-    set_context(src->parent);
-
     /* Initialize and prepare */
     port = ahci_port_select(src);
     ahci_port_clear(src, port);
@@ -1309,7 +1306,7 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
     /* create DMA source buffer and write pattern */
     ptr = ahci_alloc(src, bufsize);
     g_assert(ptr);
-    memwrite(ptr, tx, bufsize);
+    qtest_memwrite(src->parent->qts, ptr, tx, bufsize);

     /* Write, trigger the VM to stop, migrate, then resume. */
     cmd = ahci_guest_io_halt(src, port, cmd_write,
@@ -1350,7 +1347,6 @@ static void test_flush_migrate(void)
     AHCIQState *src, *dst;
     AHCICommand *cmd;
     uint8_t px;
-    const char *s;
     char *uri = g_strdup_printf("unix:%s", mig_socket);

     prepare_blkdebug_script(debug_path, "flush_to_disk");
@@ -1368,8 +1364,6 @@ static void test_flush_migrate(void)
                     "-device ide-hd,drive=drive0 "
                     "-incoming %s", tmp_path, imgfmt, uri);

-    set_context(src->parent);
-
     px = ahci_port_select(src);
     ahci_port_clear(src, px);

@@ -1380,15 +1374,14 @@ static void test_flush_migrate(void)
     cmd = ahci_command_create(CMD_FLUSH_CACHE);
     ahci_command_commit(src, cmd, px);
     ahci_command_issue_async(src, cmd);
-    qmp_eventwait("STOP");
+    qtest_qmp_eventwait(src->parent->qts, "STOP");

     /* Migrate over */
     ahci_migrate(src, dst, uri);

     /* Complete the command */
-    s = "{'execute':'cont' }";
-    qmp_async(s);
-    qmp_eventwait("RESUME");
+    qtest_async_qmp(dst->parent->qts, "{'execute':'cont'}");
+    qtest_qmp_eventwait(dst->parent->qts, "RESUME");
     ahci_command_wait(dst, cmd);
     ahci_command_verify(dst, cmd);

@@ -1480,7 +1473,7 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     }

     rx = g_malloc0(opts->size);
-    bufread(opts->buffer, rx, opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
     g_assert_cmphex(memcmp(tx, rx, opts->size), ==, 0);
     g_free(rx);

@@ -1555,9 +1548,10 @@ static void test_atapi_bcl(void)
 }


-static void atapi_wait_tray(bool open)
+static void atapi_wait_tray(AHCIQState *ahci, bool open)
 {
-    QDict *rsp = qmp_eventwait_ref("DEVICE_TRAY_MOVED");
+    QDict *rsp = qtest_qmp_eventwait_ref(ahci->parent->qts,
+                                         "DEVICE_TRAY_MOVED");
     QDict *data = qdict_get_qdict(rsp, "data");
     if (open) {
         g_assert(qdict_get_bool(data, "tray-open"));
@@ -1584,43 +1578,46 @@ static void test_atapi_tray(void)
     port = ahci_port_select(ahci);

     ahci_atapi_eject(ahci, port);
-    atapi_wait_tray(true);
+    atapi_wait_tray(ahci, true);

     ahci_atapi_load(ahci, port);
-    atapi_wait_tray(false);
+    atapi_wait_tray(ahci, false);

     /* Remove media */
-    qmp_async("{'execute': 'blockdev-open-tray', "
-               "'arguments': {'device': 'drive0'}}");
-    atapi_wait_tray(true);
-    rsp = qmp_receive();
+    qtest_async_qmp(ahci->parent->qts, "{'execute': 'blockdev-open-tray', "
+                    "'arguments': {'device': 'drive0'}}");
+    atapi_wait_tray(ahci, true);
+    rsp = qtest_qmp_receive(ahci->parent->qts);
     QDECREF(rsp);

-    qmp_discard_response("{'execute': 'x-blockdev-remove-medium', "
-                         "'arguments': {'device': 'drive0'}}");
+    qtest_qmp_discard_response(ahci->parent->qts,
+                               "{'execute': 'x-blockdev-remove-medium', "
+                               "'arguments': {'device': 'drive0'}}");

     /* Test the tray without a medium */
     ahci_atapi_load(ahci, port);
-    atapi_wait_tray(false);
+    atapi_wait_tray(ahci, false);

     ahci_atapi_eject(ahci, port);
-    atapi_wait_tray(true);
+    atapi_wait_tray(ahci, true);

     /* Re-insert media */
-    qmp_discard_response("{'execute': 'blockdev-add', "
-                          "'arguments': {'node-name': 'node0', "
+    qtest_qmp_discard_response(ahci->parent->qts,
+                               "{'execute': 'blockdev-add', "
+                               "'arguments': {'node-name': 'node0', "
                                         "'driver': 'raw', "
                                         "'file': { 'driver': 'file', "
                                                   "'filename': %s }}}", iso);
-    qmp_discard_response("{'execute': 'x-blockdev-insert-medium',"
-                          "'arguments': { 'device': 'drive0', "
+    qtest_qmp_discard_response(ahci->parent->qts,
+                               "{'execute': 'x-blockdev-insert-medium',"
+                               "'arguments': { 'device': 'drive0', "
                                          "'node-name': 'node0' }}");

     /* Again, the event shows up first */
-    qmp_async("{'execute': 'blockdev-close-tray', "
-               "'arguments': {'device': 'drive0'}}");
-    atapi_wait_tray(false);
-    rsp = qmp_receive();
+    qtest_async_qmp(ahci->parent->qts, "{'execute': 'blockdev-close-tray', "
+                    "'arguments': {'device': 'drive0'}}");
+    atapi_wait_tray(ahci, false);
+    rsp = qtest_qmp_receive(ahci->parent->qts);
     QDECREF(rsp);

     /* Now, to convince ATAPI we understand the media has changed... */
@@ -1640,10 +1637,10 @@ static void test_atapi_tray(void)

     /* Final tray test. */
     ahci_atapi_eject(ahci, port);
-    atapi_wait_tray(true);
+    atapi_wait_tray(ahci, true);

     ahci_atapi_load(ahci, port);
-    atapi_wait_tray(false);
+    atapi_wait_tray(ahci, false);

     /* Cleanup */
     g_free(tx);
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
diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
index b554758802..a9c1aceaa7 100644
--- a/tests/libqos/libqos-pc.c
+++ b/tests/libqos/libqos-pc.c
@@ -25,7 +25,7 @@ QOSState *qtest_pc_boot(const char *cmdline_fmt, ...)
     qs = qtest_vboot(&qos_ops, cmdline_fmt, ap);
     va_end(ap);

-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    qtest_irq_intercept_in(qs->qts, "ioapic");

     return qs;
 }
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 62d2f39b93..24e8156fe2 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -79,34 +79,19 @@ void qtest_shutdown(QOSState *qs)
     }
 }

-void set_context(QOSState *s)
+static QDict *qmp_execute(QTestState *qts, const char *command)
 {
-    global_qtest = s->qts;
-}
-
-static QDict *qmp_execute(const char *command)
-{
-    char *fmt;
-    QDict *rsp;
-
-    fmt = g_strdup_printf("{ 'execute': '%s' }", command);
-    rsp = qmp(fmt);
-    g_free(fmt);
-
-    return rsp;
+    return qtest_qmp(qts, "{ 'execute': %s }", command);
 }

 void migrate(QOSState *from, QOSState *to, const char *uri)
 {
     const char *st;
-    char *s;
     QDict *rsp, *sub;
     bool running;

-    set_context(from);
-
     /* Is the machine currently running? */
-    rsp = qmp_execute("query-status");
+    rsp = qmp_execute(from->qts, "query-status");
     g_assert(qdict_haskey(rsp, "return"));
     sub = qdict_get_qdict(rsp, "return");
     g_assert(qdict_haskey(sub, "running"));
@@ -114,30 +99,27 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     QDECREF(rsp);

     /* Issue the migrate command. */
-    s = g_strdup_printf("{ 'execute': 'migrate',"
-                        "'arguments': { 'uri': '%s' } }",
-                        uri);
-    rsp = qmp(s);
-    g_free(s);
+    rsp = qtest_qmp(from->qts,
+                    "{ 'execute': 'migrate', 'arguments': { 'uri': %s }}",
+                    uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

     /* Wait for STOP event, but only if we were running: */
     if (running) {
-        qmp_eventwait("STOP");
+        qtest_qmp_eventwait(from->qts, "STOP");
     }

     /* If we were running, we can wait for an event. */
     if (running) {
         migrate_allocator(from->alloc, to->alloc);
-        set_context(to);
-        qmp_eventwait("RESUME");
+        qtest_qmp_eventwait(to->qts, "RESUME");
         return;
     }

     /* Otherwise, we need to wait: poll until migration is completed. */
     while (1) {
-        rsp = qmp_execute("query-migrate");
+        rsp = qmp_execute(from->qts, "query-migrate");
         g_assert(qdict_haskey(rsp, "return"));
         sub = qdict_get_qdict(rsp, "return");
         g_assert(qdict_haskey(sub, "status"));
@@ -160,7 +142,6 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     }

     migrate_allocator(from->alloc, to->alloc);
-    set_context(to);
 }

 bool have_qemu_img(void)
-- 
2.13.5
