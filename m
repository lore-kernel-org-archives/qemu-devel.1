Received: from eggs.gnu.org ([2001:4830:134:3::10]:38688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOc-0007ak-Ax
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOa-0001JN-H9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:02 -0500
Message-Id: <20170911172022.4738-19-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 18/38] ahci-test: Drop dependence on
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
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

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

Bonus: there was one spots that was creating a needless temporary
variable to execute the 'cont' command, rather than just directly
passing the literal command through qtest_qmp().  Fixing that
gets us one step closer to enabling -Wformat checking on
constructed JSON.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: split bulk of libqos changes into earlier patch
---
 tests/libqos/libqos.h |  1 -
 tests/ahci-test.c     | 83 ++++++++++++++++++++++++---------------------------
 tests/libqos/libqos.c |  9 ------
 3 files changed, 39 insertions(+), 54 deletions(-)

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
index d6696cc370..7c94c4920b 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -157,7 +157,6 @@ static AHCIQState *ahci_vboot(const char *cli, va_list ap)

     s = g_malloc0(sizeof(AHCIQState));
     s->parent = qtest_pc_vboot(cli, ap);
-    global_qtest = s->parent->qts;
     alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);

     /* Verify that we have an AHCI device present. */
@@ -197,7 +196,7 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;

-    set_context(qs);
+    assert(!global_qtest);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -870,15 +869,15 @@ static void ahci_test_io_rw_simple(AHCIQState *ahci, unsigned bufsize,

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
@@ -919,7 +918,7 @@ static void ahci_test_max(AHCIQState *ahci)
     }

     port = ahci_test_nondata(ahci, cmd);
-    memread(ahci->port[port].fb + 0x40, d2h, 0x20);
+    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x40, d2h, 0x20);
     nsect = (uint64_t)d2h->lba_hi[2] << 40 |
         (uint64_t)d2h->lba_hi[1] << 32 |
         (uint64_t)d2h->lba_hi[0] << 24 |
@@ -1037,7 +1036,7 @@ static void test_dma_fragmented(void)
     /* Create a DMA buffer in guest memory, and write our pattern to it. */
     ptr = guest_alloc(ahci->parent->alloc, bufsize);
     g_assert(ptr);
-    bufwrite(ptr, tx, bufsize);
+    qtest_bufwrite(ahci->parent->qts, ptr, tx, bufsize);

     cmd = ahci_command_create(CMD_WRITE_DMA);
     ahci_command_adjust(cmd, 0, ptr, bufsize, 32);
@@ -1054,7 +1053,7 @@ static void test_dma_fragmented(void)
     ahci_command_free(cmd);

     /* Read back the guest's receive buffer into local memory */
-    bufread(ptr, rx, bufsize);
+    qtest_bufread(ahci->parent->qts, ptr, rx, bufsize);
     guest_free(ahci->parent->alloc, ptr);

     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
@@ -1165,8 +1164,6 @@ static void ahci_migrate_simple(uint8_t cmd_read, uint8_t cmd_write)
                     "-drive if=ide,format=%s,file=%s "
                     "-incoming %s", imgfmt, tmp_path, uri);

-    set_context(src->parent);
-
     /* initialize */
     px = ahci_port_select(src);
     ahci_port_clear(src, px);
@@ -1234,7 +1231,7 @@ static void ahci_halted_io_test(uint8_t cmd_read, uint8_t cmd_write)
     generate_pattern(tx, bufsize, AHCI_SECTOR_SIZE);
     ptr = ahci_alloc(ahci, bufsize);
     g_assert(ptr);
-    memwrite(ptr, tx, bufsize);
+    qtest_memwrite(ahci->parent->qts, ptr, tx, bufsize);

     /* Attempt to write (and fail) */
     cmd = ahci_guest_io_halt(ahci, port, cmd_write,
@@ -1300,8 +1297,6 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
                     "-incoming %s",
                     tmp_path, imgfmt, uri);

-    set_context(src->parent);
-
     /* Initialize and prepare */
     port = ahci_port_select(src);
     ahci_port_clear(src, port);
@@ -1310,7 +1305,7 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
     /* create DMA source buffer and write pattern */
     ptr = ahci_alloc(src, bufsize);
     g_assert(ptr);
-    memwrite(ptr, tx, bufsize);
+    qtest_memwrite(src->parent->qts, ptr, tx, bufsize);

     /* Write, trigger the VM to stop, migrate, then resume. */
     cmd = ahci_guest_io_halt(src, port, cmd_write,
@@ -1351,7 +1346,6 @@ static void test_flush_migrate(void)
     AHCIQState *src, *dst;
     AHCICommand *cmd;
     uint8_t px;
-    const char *s;
     char *uri = g_strdup_printf("unix:%s", mig_socket);

     prepare_blkdebug_script(debug_path, "flush_to_disk");
@@ -1369,8 +1363,6 @@ static void test_flush_migrate(void)
                     "-device ide-hd,drive=drive0 "
                     "-incoming %s", tmp_path, imgfmt, uri);

-    set_context(src->parent);
-
     px = ahci_port_select(src);
     ahci_port_clear(src, px);

@@ -1381,15 +1373,14 @@ static void test_flush_migrate(void)
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

@@ -1481,7 +1472,7 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     }

     rx = g_malloc0(opts->size);
-    bufread(opts->buffer, rx, opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
     g_assert_cmphex(memcmp(tx, rx, opts->size), ==, 0);
     g_free(rx);

@@ -1556,9 +1547,10 @@ static void test_atapi_bcl(void)
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
@@ -1585,43 +1577,46 @@ static void test_atapi_tray(void)
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
@@ -1641,10 +1636,10 @@ static void test_atapi_tray(void)

     /* Final tray test. */
     ahci_atapi_eject(ahci, port);
-    atapi_wait_tray(true);
+    atapi_wait_tray(ahci, true);

     ahci_atapi_load(ahci, port);
-    atapi_wait_tray(false);
+    atapi_wait_tray(ahci, false);

     /* Cleanup */
     g_free(tx);
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 9798e1d027..3ff61246a4 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -75,11 +75,6 @@ void qtest_shutdown(QOSState *qs)
     }
 }

-void set_context(QOSState *s)
-{
-    global_qtest = s->qts;
-}
-
 static QDict *qmp_execute(QTestState *qts, const char *command)
 {
     return qtest_qmp(qts, "{ 'execute': %s }", command);
@@ -91,8 +86,6 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     QDict *rsp, *sub;
     bool running;

-    set_context(from);
-
     /* Is the machine currently running? */
     rsp = qmp_execute(from->qts, "query-status");
     g_assert(qdict_haskey(rsp, "return"));
@@ -116,7 +109,6 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     /* If we were running, we can wait for an event. */
     if (running) {
         migrate_allocator(from->alloc, to->alloc);
-        set_context(to);
         qtest_qmp_eventwait(to->qts, "RESUME");
         return;
     }
@@ -146,7 +138,6 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     }

     migrate_allocator(from->alloc, to->alloc);
-    set_context(to);
 }

 bool have_qemu_img(void)
-- 
2.13.5
