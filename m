Received: from eggs.gnu.org ([209.51.188.92]:49294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gptAK-0002QI-5C
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 06:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gptAH-00027F-Px
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 06:08:52 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gptAH-00026Q-GR
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 06:08:49 -0500
Received: by mail-ed1-x542.google.com with SMTP id f23so7595362edb.3
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 03:08:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  2 Feb 2019 12:08:34 +0100
Message-Id: <20190202110834.24880-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] char: allow specifying a GMainContext at
 opening time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This will be needed by vhost-user-test, when each test switches to
its own GMainLoop and GMainContext.  Otherwise, for a reconnecting
socket the initial connection will happen on the default GMainContext,
and no one will be listening on it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Based-on: <1544684731-18828-1-git-send-email-thuth@redhat.com>
---
 chardev/char.c          | 30 +++++++++++++++-------------
 gdbstub.c               |  4 ++--
 hmp.c                   |  2 +-
 hw/arm/omap2.c          |  2 +-
 hw/bt/hci-csr.c         |  2 +-
 hw/char/omap_uart.c     |  4 ++--
 hw/char/xen_console.c   |  3 ++-
 hw/isa/isa-superio.c    |  4 ++--
 hw/mips/boston.c        |  2 +-
 hw/mips/mips_malta.c    |  2 +-
 hw/usb/dev-serial.c     |  2 +-
 include/chardev/char.h  | 16 +++++++++++----
 net/slirp.c             |  2 +-
 qtest.c                 |  2 +-
 tests/test-char.c       | 43 +++++++++++++++++++++--------------------
 tests/vhost-user-test.c |  2 +-
 vl.c                    |  8 ++++----
 17 files changed, 72 insertions(+), 58 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index ccba36bafb..71ac061f62 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -634,7 +634,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
     return backend;
 }
 
-Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
+                                Error **errp)
 {
     const ChardevClass *cc;
     Chardev *chr = NULL;
@@ -674,7 +675,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
 
     chr = qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
-                           backend, errp);
+                           backend, context, errp);
 
     if (chr == NULL) {
         goto out;
@@ -687,7 +688,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
         backend->type = CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data = g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev = g_strdup(bid);
-        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, errp);
+        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
             chr = NULL;
@@ -703,7 +704,7 @@ out:
 }
 
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
-                               bool permit_mux_mon)
+                               bool permit_mux_mon, GMainContext *context)
 {
     const char *p;
     Chardev *chr;
@@ -718,7 +719,7 @@ Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
     if (!opts)
         return NULL;
 
-    chr = qemu_chr_new_from_opts(opts, &err);
+    chr = qemu_chr_new_from_opts(opts, context, &err);
     if (!chr) {
         error_report_err(err);
         goto out;
@@ -736,10 +737,11 @@ out:
 
 static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
                                           const char *filename,
-                                          bool permit_mux_mon)
+                                          bool permit_mux_mon,
+                                          GMainContext *context)
 {
     Chardev *chr;
-    chr = qemu_chr_new_noreplay(label, filename, permit_mux_mon);
+    chr = qemu_chr_new_noreplay(label, filename, permit_mux_mon, context);
     if (chr) {
         if (replay_mode != REPLAY_MODE_NONE) {
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
@@ -753,14 +755,14 @@ static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
     return chr;
 }
 
-Chardev *qemu_chr_new(const char *label, const char *filename)
+Chardev *qemu_chr_new(const char *label, const char *filename, GMainContext *context)
 {
-    return qemu_chr_new_permit_mux_mon(label, filename, false);
+    return qemu_chr_new_permit_mux_mon(label, filename, false, context);
 }
 
-Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename)
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename, GMainContext *context)
 {
-    return qemu_chr_new_permit_mux_mon(label, filename, true);
+    return qemu_chr_new_permit_mux_mon(label, filename, true, context);
 }
 
 static int qmp_query_chardev_foreach(Object *obj, void *data)
@@ -935,6 +937,7 @@ void qemu_chr_set_feature(Chardev *chr,
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
                           ChardevBackend *backend,
+                          GMainContext *gcontext,
                           Error **errp)
 {
     Object *obj;
@@ -947,6 +950,7 @@ Chardev *qemu_chardev_new(const char *id, const char *typename,
     obj = object_new(typename);
     chr = CHARDEV(obj);
     chr->label = g_strdup(id);
+    chr->gcontext = gcontext;
 
     qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
@@ -991,7 +995,7 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
     }
 
     chr = qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
-                           backend, errp);
+                           backend, NULL, errp);
     if (!chr) {
         return NULL;
     }
@@ -1049,7 +1053,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
     }
 
     chr_new = qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)),
-                               backend, errp);
+                               backend, chr->gcontext, errp);
     if (!chr_new) {
         return NULL;
     }
diff --git a/gdbstub.c b/gdbstub.c
index 3129b5c284..582e880a4a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2527,7 +2527,7 @@ int gdbserver_start(const char *device)
          * FIXME: it's a bit weird to allow using a mux chardev here
          * and implicitly setup a monitor. We may want to break this.
          */
-        chr = qemu_chr_new_noreplay("gdb", device, true);
+        chr = qemu_chr_new_noreplay("gdb", device, true, NULL);
         if (!chr)
             return -1;
     }
@@ -2541,7 +2541,7 @@ int gdbserver_start(const char *device)
 
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
-                                   NULL, &error_abort);
+                                   NULL, NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..c18caacfd7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2395,7 +2395,7 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict)
     if (opts == NULL) {
         error_setg(&err, "Parsing chardev args failed");
     } else {
-        qemu_chr_new_from_opts(opts, &err);
+        qemu_chr_new_from_opts(opts, NULL, &err);
         qemu_opts_del(opts);
     }
     hmp_handle_error(mon, &err);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 3c7d1364a9..94dffb2f57 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -799,7 +799,7 @@ static struct omap_sti_s *omap_sti_init(struct omap_target_agent_s *ta,
     s->irq = irq;
     omap_sti_reset(s);
 
-    qemu_chr_fe_init(&s->chr, chr ?: qemu_chr_new("null", "null"),
+    qemu_chr_fe_init(&s->chr, chr ?: qemu_chr_new("null", "null", NULL),
                      &error_abort);
 
     memory_region_init_io(&s->iomem, NULL, &omap_sti_ops, s, "omap.sti",
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 0341ded50c..fa6660a113 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -501,7 +501,7 @@ static const TypeInfo char_hci_type_info = {
 Chardev *uart_hci_init(void)
 {
     return qemu_chardev_new(NULL, TYPE_CHARDEV_HCI,
-                            NULL, &error_abort);
+                            NULL, NULL, &error_abort);
 }
 
 static void register_types(void)
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 6fd1b9cf6b..52c3a326c2 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -63,7 +63,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->irq = irq;
     s->serial = serial_mm_init(get_system_memory(), base, 2, irq,
                                omap_clk_getrate(fclk)/16,
-                               chr ?: qemu_chr_new(label, "null"),
+                               chr ?: qemu_chr_new(label, "null", NULL),
                                DEVICE_NATIVE_ENDIAN);
     return s;
 }
@@ -183,6 +183,6 @@ void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
     /* TODO: Should reuse or destroy current s->serial */
     s->serial = serial_mm_init(get_system_memory(), s->base, 2, s->irq,
                                omap_clk_getrate(s->fclk) / 16,
-                               chr ?: qemu_chr_new("null", "null"),
+                               chr ?: qemu_chr_new("null", "null", NULL),
                                DEVICE_NATIVE_ENDIAN);
 }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index dc6ff0e5b3..91f34ef06c 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -211,7 +211,8 @@ static int con_init(struct XenLegacyDevice *xendev)
                           * FIXME: sure we want to support implicit
                           * muxed monitors here?
                           */
-                         qemu_chr_new_mux_mon(label, output), &error_abort);
+                         qemu_chr_new_mux_mon(label, output, NULL),
+                         &error_abort);
     }
 
     xenstore_store_pv_console_info(con->xendev.dev,
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 8bc2f69eaa..d54463bf03 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -44,7 +44,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             chr = parallel_hds[i];
             if (chr == NULL) {
                 name = g_strdup_printf("discarding-parallel%d", i);
-                chr = qemu_chr_new(name, "null");
+                chr = qemu_chr_new(name, "null", NULL);
             } else {
                 name = g_strdup_printf("parallel%d", i);
             }
@@ -84,7 +84,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             chr = serial_hd(i);
             if (chr == NULL) {
                 name = g_strdup_printf("discarding-serial%d", i);
-                chr = qemu_chr_new(name, "null");
+                chr = qemu_chr_new(name, "null", NULL);
             } else {
                 name = g_strdup_printf("serial%d", i);
             }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 6c9c20a93e..e5bab3cadc 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -512,7 +512,7 @@ static void boston_mach_init(MachineState *machine)
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
     memory_region_add_subregion_overlap(sys_mem, 0x17fff000, lcd, 0);
 
-    chr = qemu_chr_new("lcd", "vc:320x240");
+    chr = qemu_chr_new("lcd", "vc:320x240", NULL);
     qemu_chr_fe_init(&s->lcd_display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 74667766c2..7a403ef1ce 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -568,7 +568,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     memory_region_add_subregion(address_space, base, &s->iomem_lo);
     memory_region_add_subregion(address_space, base + 0xa00, &s->iomem_hi);
 
-    chr = qemu_chr_new("fpga", "vc:320x200");
+    chr = qemu_chr_new("fpga", "vc:320x200", NULL);
     qemu_chr_fe_init(&s->display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->display, NULL, NULL,
                              malta_fgpa_display_event, NULL, s, NULL, true);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 98d1ca3c91..03c3bcd240 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -514,7 +514,7 @@ static USBDevice *usb_braille_init(USBBus *bus, const char *unused)
     USBDevice *dev;
     Chardev *cdrv;
 
-    cdrv = qemu_chr_new("braille", "braille");
+    cdrv = qemu_chr_new("braille", "braille", NULL);
     if (!cdrv)
         return NULL;
 
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 014566c3de..c0b57f7685 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -73,6 +73,7 @@ struct Chardev {
 /**
  * qemu_chr_new_from_opts:
  * @opts: see qemu-config.c for a list of valid options
+ * @context: the #GMainContext to be used at initialization time
  *
  * Create a new character backend from a QemuOpts list.
  *
@@ -81,6 +82,7 @@ struct Chardev {
  *                            or left untouched in case of help option
  */
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
+                                GMainContext *context,
                                 Error **errp);
 
 /**
@@ -106,25 +108,29 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
  * qemu_chr_new:
  * @label: the name of the backend
  * @filename: the URI
+ * @context: the #GMainContext to be used at initialization time
  *
  * Create a new character backend from a URI.
  * Do not implicitly initialize a monitor if the chardev is muxed.
  *
  * Returns: a new character backend
  */
-Chardev *qemu_chr_new(const char *label, const char *filename);
+Chardev *qemu_chr_new(const char *label, const char *filename,
+                      GMainContext *context);
 
 /**
  * qemu_chr_new_mux_mon:
  * @label: the name of the backend
  * @filename: the URI
+ * @context: the #GMainContext to be used at initialization time
  *
  * Create a new character backend from a URI.
  * Implicitly initialize a monitor if the chardev is muxed.
  *
  * Returns: a new character backend
  */
-Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename);
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename,
+                              GMainContext *context);
 
 /**
 * qemu_chr_change:
@@ -146,6 +152,7 @@ void qemu_chr_cleanup(void);
  * @label: the name of the backend
  * @filename: the URI
  * @permit_mux_mon: if chardev is muxed, initialize a monitor
+ * @context: the #GMainContext to be used at initialization time
  *
  * Create a new character backend from a URI.
  * Character device communications are not written
@@ -154,7 +161,7 @@ void qemu_chr_cleanup(void);
  * Returns: a new character backend
  */
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
-                               bool permit_mux_mon);
+                               bool permit_mux_mon, GMainContext *context);
 
 /**
  * qemu_chr_be_can_write:
@@ -272,7 +279,8 @@ typedef struct ChardevClass {
 } ChardevClass;
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend, Error **errp);
+                          ChardevBackend *backend, GMainContext *context,
+                          Error **errp);
 
 extern int term_escape_char;
 
diff --git a/net/slirp.c b/net/slirp.c
index f98425ee9f..f5c32e6f8e 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -780,7 +780,7 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
          * FIXME: sure we want to support implicit
          * muxed monitors here?
          */
-        Chardev *chr = qemu_chr_new_mux_mon(buf, p);
+        Chardev *chr = qemu_chr_new_mux_mon(buf, p, NULL);
 
         if (!chr) {
             error_setg(errp, "Could not open guest forwarding device '%s'",
diff --git a/qtest.c b/qtest.c
index 60988c8aa2..527141785f 100644
--- a/qtest.c
+++ b/qtest.c
@@ -763,7 +763,7 @@ void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
 {
     Chardev *chr;
 
-    chr = qemu_chr_new("qtest", qtest_chrdev);
+    chr = qemu_chr_new("qtest", qtest_chrdev, NULL);
 
     if (chr == NULL) {
         error_setg(errp, "Failed to initialize device for qtest: \"%s\"",
diff --git a/tests/test-char.c b/tests/test-char.c
index 19c3efad72..b23d038bd2 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -66,7 +66,7 @@ static void char_console_test_subprocess(void)
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "console", &error_abort);
 
-    chr = qemu_chr_new_from_opts(opts, NULL);
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
 
     qemu_chr_write_all(chr, (const uint8_t *)"CONSOLE", 7);
@@ -88,7 +88,7 @@ static void char_stdio_test_subprocess(void)
     CharBackend be;
     int ret;
 
-    chr = qemu_chr_new("label", "stdio");
+    chr = qemu_chr_new("label", "stdio", NULL);
     g_assert_nonnull(chr);
 
     qemu_chr_fe_init(&be, chr, &error_abort);
@@ -119,7 +119,7 @@ static void char_ringbuf_test(void)
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
 
     qemu_opt_set(opts, "size", "5", &error_abort);
-    chr = qemu_chr_new_from_opts(opts, NULL);
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_null(chr);
     qemu_opts_del(opts);
 
@@ -127,7 +127,7 @@ static void char_ringbuf_test(void)
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
     qemu_opt_set(opts, "size", "2", &error_abort);
-    chr = qemu_chr_new_from_opts(opts, &error_abort);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr);
     qemu_opts_del(opts);
 
@@ -150,7 +150,7 @@ static void char_ringbuf_test(void)
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "memory", &error_abort);
     qemu_opt_set(opts, "size", "2", &error_abort);
-    chr = qemu_chr_new_from_opts(opts, NULL);
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
     object_unparent(OBJECT(chr));
     qemu_opts_del(opts);
@@ -169,7 +169,7 @@ static void char_mux_test(void)
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
     qemu_opt_set(opts, "size", "128", &error_abort);
     qemu_opt_set(opts, "mux", "on", &error_abort);
-    chr = qemu_chr_new_from_opts(opts, &error_abort);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr);
     qemu_opts_del(opts);
 
@@ -335,7 +335,7 @@ static void char_socket_test_common(Chardev *chr, bool reconnect)
     qemu_chr_fe_set_handlers(&be, socket_can_read, socket_read,
                              NULL, NULL, &d, NULL, true);
 
-    chr_client = qemu_chr_new("client", tmp);
+    chr_client = qemu_chr_new("client", tmp, NULL);
     qemu_chr_fe_init(&client_be, chr_client, &error_abort);
     qemu_chr_fe_set_handlers(&client_be, socket_can_read_hello,
                              socket_read_hello,
@@ -374,7 +374,7 @@ static void char_socket_test_common(Chardev *chr, bool reconnect)
 
 static void char_socket_basic_test(void)
 {
-    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
+    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait", NULL);
 
     char_socket_test_common(chr, false);
 }
@@ -382,7 +382,7 @@ static void char_socket_basic_test(void)
 
 static void char_socket_reconnect_test(void)
 {
-    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
+    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait", NULL);
 
     char_socket_test_common(chr, true);
 }
@@ -412,7 +412,7 @@ static void char_socket_fdpass_test(void)
     g_free(optstr);
     g_assert_nonnull(opts);
 
-    chr = qemu_chr_new_from_opts(opts, &error_abort);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
 
     qemu_opts_del(opts);
 
@@ -495,7 +495,8 @@ static void char_websock_test(void)
     CharBackend client_be;
     Chardev *chr_client;
     Chardev *chr = qemu_chr_new("server",
-                                "websocket:127.0.0.1:0,server,nowait");
+                                "websocket:127.0.0.1:0,server,nowait",
+                                NULL);
     const char handshake[] = "GET / HTTP/1.1\r\n"
                              "Upgrade: websocket\r\n"
                              "Connection: Upgrade\r\n"
@@ -519,7 +520,7 @@ static void char_websock_test(void)
     qemu_chr_fe_set_handlers(&be, websock_server_can_read, websock_server_read,
                              NULL, NULL, chr, NULL, true);
 
-    chr_client = qemu_chr_new("client", tmp);
+    chr_client = qemu_chr_new("client", tmp, NULL);
     qemu_chr_fe_init(&client_be, chr_client, &error_abort);
     qemu_chr_fe_set_handlers(&client_be, websock_client_can_read,
                              websock_client_read,
@@ -565,7 +566,7 @@ static void char_pipe_test(void)
     }
 
     tmp = g_strdup_printf("pipe:%s", pipe);
-    chr = qemu_chr_new("pipe", tmp);
+    chr = qemu_chr_new("pipe", tmp, NULL);
     g_assert_nonnull(chr);
     g_free(tmp);
 
@@ -647,7 +648,7 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
         int port;
         sock = make_udp_socket(&port);
         tmp = g_strdup_printf("udp:127.0.0.1:%d", port);
-        chr = qemu_chr_new("client", tmp);
+        chr = qemu_chr_new("client", tmp, NULL);
         g_assert_nonnull(chr);
 
         be = g_alloca(sizeof(CharBackend));
@@ -691,14 +692,14 @@ static void char_serial_test(void)
     qemu_opt_set(opts, "backend", "serial", &error_abort);
     qemu_opt_set(opts, "path", "/dev/null", &error_abort);
 
-    chr = qemu_chr_new_from_opts(opts, NULL);
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
     /* TODO: add more tests with a pty */
     object_unparent(OBJECT(chr));
 
     /* test tty alias */
     qemu_opt_set(opts, "backend", "tty", &error_abort);
-    chr = qemu_chr_new_from_opts(opts, NULL);
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
     object_unparent(OBJECT(chr));
 
@@ -731,7 +732,7 @@ static void char_file_fifo_test(void)
     g_assert_cmpint(ret, ==, 8);
 
     chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
-                           &error_abort);
+                           NULL, &error_abort);
 
     qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be,
@@ -785,7 +786,7 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
         out = g_build_filename(tmp_path, "out", NULL);
         file.out = out;
         chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
-                               &error_abort);
+                               NULL, &error_abort);
     }
     ret = qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
     g_assert_cmpint(ret, ==, 6);
@@ -820,7 +821,7 @@ static void char_null_test(void)
     chr = qemu_chr_find("label-null");
     g_assert_null(chr);
 
-    chr = qemu_chr_new("label-null", "null");
+    chr = qemu_chr_new("label-null", "null", NULL);
     chr = qemu_chr_find("label-null");
     g_assert_nonnull(chr);
 
@@ -857,7 +858,7 @@ static void char_invalid_test(void)
 {
     Chardev *chr;
 
-    chr = qemu_chr_new("label-invalid", "invalid");
+    chr = qemu_chr_new("label-invalid", "invalid", NULL);
     g_assert_null(chr);
 }
 
@@ -890,7 +891,7 @@ static void char_hotswap_test(void)
 
     chr_args = g_strdup_printf("udp:127.0.0.1:%d", port);
 
-    chr = qemu_chr_new("chardev", chr_args);
+    chr = qemu_chr_new("chardev", chr_args, NULL);
     qemu_chr_fe_init(&be, chr, &error_abort);
 
     /* check that chardev operates correctly */
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index e90cd4ca65..34c4e267c7 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -543,7 +543,7 @@ static void test_server_create_chr(TestServer *server, const gchar *opt)
     Chardev *chr;
 
     chr_path = g_strdup_printf("unix:%s%s", server->socket_path, opt);
-    chr = qemu_chr_new(server->chr_name, chr_path);
+    chr = qemu_chr_new(server->chr_name, chr_path, NULL);
     g_free(chr_path);
 
     g_assert_nonnull(chr);
diff --git a/vl.c b/vl.c
index 41d6af2947..a63f7ec1fa 100644
--- a/vl.c
+++ b/vl.c
@@ -2314,7 +2314,7 @@ static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
 
-    if (!qemu_chr_new_from_opts(opts, &local_err)) {
+    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
         if (local_err) {
             error_propagate(errp, local_err);
             return -1;
@@ -2452,7 +2452,7 @@ static int serial_parse(const char *devname)
     snprintf(label, sizeof(label), "serial%d", index);
     serial_hds = g_renew(Chardev *, serial_hds, index + 1);
 
-    serial_hds[index] = qemu_chr_new_mux_mon(label, devname);
+    serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
     if (!serial_hds[index]) {
         error_report("could not connect serial device"
                      " to character backend '%s'", devname);
@@ -2488,7 +2488,7 @@ static int parallel_parse(const char *devname)
         exit(1);
     }
     snprintf(label, sizeof(label), "parallel%d", index);
-    parallel_hds[index] = qemu_chr_new_mux_mon(label, devname);
+    parallel_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
     if (!parallel_hds[index]) {
         error_report("could not connect parallel device"
                      " to character backend '%s'", devname);
@@ -2502,7 +2502,7 @@ static int debugcon_parse(const char *devname)
 {
     QemuOpts *opts;
 
-    if (!qemu_chr_new_mux_mon("debugcon", devname)) {
+    if (!qemu_chr_new_mux_mon("debugcon", devname, NULL)) {
         error_report("invalid character backend '%s'", devname);
         exit(1);
     }
-- 
2.20.1
