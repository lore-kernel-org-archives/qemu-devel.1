Received: from eggs.gnu.org ([209.51.188.92]:39481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGS-0004So-MX
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGQ-0005jD-1a
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:20:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGP-0005ia-N1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:07 +0100
Message-Id: <20190213161913.22107-20-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 19/25] char: allow specifying a GMainContext
 at opening time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Paolo Bonzini <pbonzini@redhat.com>

This will be needed by vhost-user-test, when each test switches to
its own GMainLoop and GMainContext.  Otherwise, for a reconnecting
socket the initial connection will happen on the default GMainContext,
and no one will be listening on it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190202110834.24880-1-pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char.h  | 16 ++++++++++++----
 chardev/char.c          | 32 +++++++++++++++++++-------------
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
 net/slirp.c             |  2 +-
 qtest.c                 |  2 +-
 tests/test-char.c       | 38 +++++++++++++++++++-------------------
 tests/vhost-user-test.c |  2 +-
 vl.c                    |  8 ++++----
 17 files changed, 71 insertions(+), 56 deletions(-)

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
=20
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
=20
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
=20
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
+                               bool permit_mux_mon, GMainContext *contex=
t);
=20
 /**
  * qemu_chr_be_can_write:
@@ -272,7 +279,8 @@ typedef struct ChardevClass {
 } ChardevClass;
=20
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend, Error **errp);
+                          ChardevBackend *backend, GMainContext *context=
,
+                          Error **errp);
=20
 extern int term_escape_char;
=20
diff --git a/chardev/char.c b/chardev/char.c
index b99f3692f7..f6d61fa5f8 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -636,7 +636,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, E=
rror **errp)
     return backend;
 }
=20
-Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
+Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
+                                Error **errp)
 {
     const ChardevClass *cc;
     Chardev *chr =3D NULL;
@@ -676,7 +677,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error=
 **errp)
=20
     chr =3D qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
-                           backend, errp);
+                           backend, context, errp);
=20
     if (chr =3D=3D NULL) {
         goto out;
@@ -689,7 +690,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error=
 **errp)
         backend->type =3D CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data =3D g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev =3D g_strdup(bid);
-        mux =3D qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, errp);
+        mux =3D qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context,=
 errp);
         if (mux =3D=3D NULL) {
             object_unparent(OBJECT(chr));
             chr =3D NULL;
@@ -705,7 +706,7 @@ out:
 }
=20
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
-                               bool permit_mux_mon)
+                               bool permit_mux_mon, GMainContext *contex=
t)
 {
     const char *p;
     Chardev *chr;
@@ -720,7 +721,7 @@ Chardev *qemu_chr_new_noreplay(const char *label, con=
st char *filename,
     if (!opts)
         return NULL;
=20
-    chr =3D qemu_chr_new_from_opts(opts, &err);
+    chr =3D qemu_chr_new_from_opts(opts, context, &err);
     if (!chr) {
         error_report_err(err);
         goto out;
@@ -738,10 +739,11 @@ out:
=20
 static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
                                           const char *filename,
-                                          bool permit_mux_mon)
+                                          bool permit_mux_mon,
+                                          GMainContext *context)
 {
     Chardev *chr;
-    chr =3D qemu_chr_new_noreplay(label, filename, permit_mux_mon);
+    chr =3D qemu_chr_new_noreplay(label, filename, permit_mux_mon, conte=
xt);
     if (chr) {
         if (replay_mode !=3D REPLAY_MODE_NONE) {
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
@@ -755,14 +757,16 @@ static Chardev *qemu_chr_new_permit_mux_mon(const c=
har *label,
     return chr;
 }
=20
-Chardev *qemu_chr_new(const char *label, const char *filename)
+Chardev *qemu_chr_new(const char *label, const char *filename,
+                      GMainContext *context)
 {
-    return qemu_chr_new_permit_mux_mon(label, filename, false);
+    return qemu_chr_new_permit_mux_mon(label, filename, false, context);
 }
=20
-Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename)
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename,
+                              GMainContext *context)
 {
-    return qemu_chr_new_permit_mux_mon(label, filename, true);
+    return qemu_chr_new_permit_mux_mon(label, filename, true, context);
 }
=20
 static int qmp_query_chardev_foreach(Object *obj, void *data)
@@ -937,6 +941,7 @@ void qemu_chr_set_feature(Chardev *chr,
=20
 Chardev *qemu_chardev_new(const char *id, const char *typename,
                           ChardevBackend *backend,
+                          GMainContext *gcontext,
                           Error **errp)
 {
     Object *obj;
@@ -949,6 +954,7 @@ Chardev *qemu_chardev_new(const char *id, const char =
*typename,
     obj =3D object_new(typename);
     chr =3D CHARDEV(obj);
     chr->label =3D g_strdup(id);
+    chr->gcontext =3D gcontext;
=20
     qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
@@ -993,7 +999,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Charde=
vBackend *backend,
     }
=20
     chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc))=
,
-                           backend, errp);
+                           backend, NULL, errp);
     if (!chr) {
         return NULL;
     }
@@ -1051,7 +1057,7 @@ ChardevReturn *qmp_chardev_change(const char *id, C=
hardevBackend *backend,
     }
=20
     chr_new =3D qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLAS=
S(cc)),
-                               backend, errp);
+                               backend, chr->gcontext, errp);
     if (!chr_new) {
         return NULL;
     }
diff --git a/gdbstub.c b/gdbstub.c
index a4be63f6eb..ff19579452 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2531,7 +2531,7 @@ int gdbserver_start(const char *device)
          * FIXME: it's a bit weird to allow using a mux chardev here
          * and implicitly setup a monitor. We may want to break this.
          */
-        chr =3D qemu_chr_new_noreplay("gdb", device, true);
+        chr =3D qemu_chr_new_noreplay("gdb", device, true, NULL);
         if (!chr)
             return -1;
     }
@@ -2545,7 +2545,7 @@ int gdbserver_start(const char *device)
=20
         /* Initialize a monitor terminal for gdb */
         mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
-                                   NULL, &error_abort);
+                                   NULL, NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..c18caacfd7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2395,7 +2395,7 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdi=
ct)
     if (opts =3D=3D NULL) {
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
@@ -799,7 +799,7 @@ static struct omap_sti_s *omap_sti_init(struct omap_t=
arget_agent_s *ta,
     s->irq =3D irq;
     omap_sti_reset(s);
=20
-    qemu_chr_fe_init(&s->chr, chr ?: qemu_chr_new("null", "null"),
+    qemu_chr_fe_init(&s->chr, chr ?: qemu_chr_new("null", "null", NULL),
                      &error_abort);
=20
     memory_region_init_io(&s->iomem, NULL, &omap_sti_ops, s, "omap.sti",
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 0341ded50c..fa6660a113 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -501,7 +501,7 @@ static const TypeInfo char_hci_type_info =3D {
 Chardev *uart_hci_init(void)
 {
     return qemu_chardev_new(NULL, TYPE_CHARDEV_HCI,
-                            NULL, &error_abort);
+                            NULL, NULL, &error_abort);
 }
=20
 static void register_types(void)
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 6fd1b9cf6b..b3bb1cfcec 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -63,7 +63,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->irq =3D irq;
     s->serial =3D serial_mm_init(get_system_memory(), base, 2, irq,
                                omap_clk_getrate(fclk)/16,
-                               chr ?: qemu_chr_new(label, "null"),
+                               chr ?: qemu_chr_new(label, "null", NULL),
                                DEVICE_NATIVE_ENDIAN);
     return s;
 }
@@ -183,6 +183,6 @@ void omap_uart_attach(struct omap_uart_s *s, Chardev =
*chr)
     /* TODO: Should reuse or destroy current s->serial */
     s->serial =3D serial_mm_init(get_system_memory(), s->base, 2, s->irq=
,
                                omap_clk_getrate(s->fclk) / 16,
-                               chr ?: qemu_chr_new("null", "null"),
+                               chr ?: qemu_chr_new("null", "null", NULL)=
,
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
-                         qemu_chr_new_mux_mon(label, output), &error_abo=
rt);
+                         qemu_chr_new_mux_mon(label, output, NULL),
+                         &error_abort);
     }
=20
     xenstore_store_pv_console_info(con->xendev.dev,
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 8bc2f69eaa..d54463bf03 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -44,7 +44,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
             chr =3D parallel_hds[i];
             if (chr =3D=3D NULL) {
                 name =3D g_strdup_printf("discarding-parallel%d", i);
-                chr =3D qemu_chr_new(name, "null");
+                chr =3D qemu_chr_new(name, "null", NULL);
             } else {
                 name =3D g_strdup_printf("parallel%d", i);
             }
@@ -84,7 +84,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
             chr =3D serial_hd(i);
             if (chr =3D=3D NULL) {
                 name =3D g_strdup_printf("discarding-serial%d", i);
-                chr =3D qemu_chr_new(name, "null");
+                chr =3D qemu_chr_new(name, "null", NULL);
             } else {
                 name =3D g_strdup_printf("serial%d", i);
             }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 6c9c20a93e..e5bab3cadc 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -512,7 +512,7 @@ static void boston_mach_init(MachineState *machine)
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0=
x8);
     memory_region_add_subregion_overlap(sys_mem, 0x17fff000, lcd, 0);
=20
-    chr =3D qemu_chr_new("lcd", "vc:320x240");
+    chr =3D qemu_chr_new("lcd", "vc:320x240", NULL);
     qemu_chr_fe_init(&s->lcd_display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 74667766c2..7a403ef1ce 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -568,7 +568,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *=
address_space,
     memory_region_add_subregion(address_space, base, &s->iomem_lo);
     memory_region_add_subregion(address_space, base + 0xa00, &s->iomem_h=
i);
=20
-    chr =3D qemu_chr_new("fpga", "vc:320x200");
+    chr =3D qemu_chr_new("fpga", "vc:320x200", NULL);
     qemu_chr_fe_init(&s->display, chr, NULL);
     qemu_chr_fe_set_handlers(&s->display, NULL, NULL,
                              malta_fgpa_display_event, NULL, s, NULL, tr=
ue);
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 98d1ca3c91..03c3bcd240 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -514,7 +514,7 @@ static USBDevice *usb_braille_init(USBBus *bus, const=
 char *unused)
     USBDevice *dev;
     Chardev *cdrv;
=20
-    cdrv =3D qemu_chr_new("braille", "braille");
+    cdrv =3D qemu_chr_new("braille", "braille", NULL);
     if (!cdrv)
         return NULL;
=20
diff --git a/net/slirp.c b/net/slirp.c
index 7a16d8d615..4ec989b592 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -927,7 +927,7 @@ static int slirp_guestfwd(SlirpState *s, const char *=
config_str, Error **errp)
          * FIXME: sure we want to support implicit
          * muxed monitors here?
          */
-        Chardev *chr =3D qemu_chr_new_mux_mon(buf, p);
+        Chardev *chr =3D qemu_chr_new_mux_mon(buf, p, NULL);
=20
         if (!chr) {
             error_setg(errp, "Could not open guest forwarding device '%s=
'",
diff --git a/qtest.c b/qtest.c
index 60988c8aa2..527141785f 100644
--- a/qtest.c
+++ b/qtest.c
@@ -763,7 +763,7 @@ void qtest_init(const char *qtest_chrdev, const char =
*qtest_log, Error **errp)
 {
     Chardev *chr;
=20
-    chr =3D qemu_chr_new("qtest", qtest_chrdev);
+    chr =3D qemu_chr_new("qtest", qtest_chrdev, NULL);
=20
     if (chr =3D=3D NULL) {
         error_setg(errp, "Failed to initialize device for qtest: \"%s\""=
,
diff --git a/tests/test-char.c b/tests/test-char.c
index 82579e6aa5..63b4d3289d 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -86,7 +86,7 @@ static void char_console_test_subprocess(void)
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "console", &error_abort);
=20
-    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
=20
     qemu_chr_write_all(chr, (const uint8_t *)"CONSOLE", 7);
@@ -108,7 +108,7 @@ static void char_stdio_test_subprocess(void)
     CharBackend be;
     int ret;
=20
-    chr =3D qemu_chr_new("label", "stdio");
+    chr =3D qemu_chr_new("label", "stdio", NULL);
     g_assert_nonnull(chr);
=20
     qemu_chr_fe_init(&be, chr, &error_abort);
@@ -139,7 +139,7 @@ static void char_ringbuf_test(void)
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
=20
     qemu_opt_set(opts, "size", "5", &error_abort);
-    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_null(chr);
     qemu_opts_del(opts);
=20
@@ -147,7 +147,7 @@ static void char_ringbuf_test(void)
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
     qemu_opt_set(opts, "size", "2", &error_abort);
-    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr);
     qemu_opts_del(opts);
=20
@@ -170,7 +170,7 @@ static void char_ringbuf_test(void)
                             1, &error_abort);
     qemu_opt_set(opts, "backend", "memory", &error_abort);
     qemu_opt_set(opts, "size", "2", &error_abort);
-    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
     object_unparent(OBJECT(chr));
     qemu_opts_del(opts);
@@ -189,7 +189,7 @@ static void char_mux_test(void)
     qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
     qemu_opt_set(opts, "size", "128", &error_abort);
     qemu_opt_set(opts, "mux", "on", &error_abort);
-    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     g_assert_nonnull(chr);
     qemu_opts_del(opts);
=20
@@ -412,7 +412,7 @@ static void char_websock_test(void)
     CharBackend client_be;
     Chardev *chr_client;
     Chardev *chr =3D qemu_chr_new("server",
-                                "websocket:127.0.0.1:0,server,nowait");
+                                "websocket:127.0.0.1:0,server,nowait", N=
ULL);
     const char handshake[] =3D "GET / HTTP/1.1\r\n"
                              "Upgrade: websocket\r\n"
                              "Connection: Upgrade\r\n"
@@ -436,7 +436,7 @@ static void char_websock_test(void)
     qemu_chr_fe_set_handlers(&be, websock_server_can_read, websock_serve=
r_read,
                              NULL, NULL, chr, NULL, true);
=20
-    chr_client =3D qemu_chr_new("client", tmp);
+    chr_client =3D qemu_chr_new("client", tmp, NULL);
     qemu_chr_fe_init(&client_be, chr_client, &error_abort);
     qemu_chr_fe_set_handlers(&client_be, websock_client_can_read,
                              websock_client_read,
@@ -482,7 +482,7 @@ static void char_pipe_test(void)
     }
=20
     tmp =3D g_strdup_printf("pipe:%s", pipe);
-    chr =3D qemu_chr_new("pipe", tmp);
+    chr =3D qemu_chr_new("pipe", tmp, NULL);
     g_assert_nonnull(chr);
     g_free(tmp);
=20
@@ -586,7 +586,7 @@ static void char_udp_test_internal(Chardev *reuse_chr=
, int sock)
         int port;
         sock =3D make_udp_socket(&port);
         tmp =3D g_strdup_printf("udp:127.0.0.1:%d", port);
-        chr =3D qemu_chr_new("client", tmp);
+        chr =3D qemu_chr_new("client", tmp, NULL);
         g_assert_nonnull(chr);
=20
         be =3D g_alloca(sizeof(CharBackend));
@@ -764,7 +764,7 @@ static void char_socket_server_test(gconstpointer opa=
que)
     opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"),
                                    optstr, true);
     g_assert_nonnull(opts);
-    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     qemu_opts_del(opts);
     g_assert_nonnull(chr);
     g_assert(!object_property_get_bool(OBJECT(chr), "connected", &error_=
abort));
@@ -914,7 +914,7 @@ static void char_socket_client_test(gconstpointer opa=
que)
     opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev"),
                                    optstr, true);
     g_assert_nonnull(opts);
-    chr =3D qemu_chr_new_from_opts(opts, &error_abort);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
     qemu_opts_del(opts);
     g_assert_nonnull(chr);
=20
@@ -1015,14 +1015,14 @@ static void char_serial_test(void)
     qemu_opt_set(opts, "backend", "serial", &error_abort);
     qemu_opt_set(opts, "path", "/dev/null", &error_abort);
=20
-    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
     /* TODO: add more tests with a pty */
     object_unparent(OBJECT(chr));
=20
     /* test tty alias */
     qemu_opt_set(opts, "backend", "tty", &error_abort);
-    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
     g_assert_nonnull(chr);
     object_unparent(OBJECT(chr));
=20
@@ -1055,7 +1055,7 @@ static void char_file_fifo_test(void)
     g_assert_cmpint(ret, =3D=3D, 8);
=20
     chr =3D qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
-                           &error_abort);
+                           NULL, &error_abort);
=20
     qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be,
@@ -1109,7 +1109,7 @@ static void char_file_test_internal(Chardev *ext_ch=
r, const char *filepath)
         out =3D g_build_filename(tmp_path, "out", NULL);
         file.out =3D out;
         chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
-                               &error_abort);
+                               NULL, &error_abort);
     }
     ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
     g_assert_cmpint(ret, =3D=3D, 6);
@@ -1144,7 +1144,7 @@ static void char_null_test(void)
     chr =3D qemu_chr_find("label-null");
     g_assert_null(chr);
=20
-    chr =3D qemu_chr_new("label-null", "null");
+    chr =3D qemu_chr_new("label-null", "null", NULL);
     chr =3D qemu_chr_find("label-null");
     g_assert_nonnull(chr);
=20
@@ -1181,7 +1181,7 @@ static void char_invalid_test(void)
 {
     Chardev *chr;
     g_setenv("QTEST_SILENT_ERRORS", "1", 1);
-    chr =3D qemu_chr_new("label-invalid", "invalid");
+    chr =3D qemu_chr_new("label-invalid", "invalid", NULL);
     g_assert_null(chr);
     g_unsetenv("QTEST_SILENT_ERRORS");
 }
@@ -1215,7 +1215,7 @@ static void char_hotswap_test(void)
=20
     chr_args =3D g_strdup_printf("udp:127.0.0.1:%d", port);
=20
-    chr =3D qemu_chr_new("chardev", chr_args);
+    chr =3D qemu_chr_new("chardev", chr_args, NULL);
     qemu_chr_fe_init(&be, chr, &error_abort);
=20
     /* check that chardev operates correctly */
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 7d5f234646..d961bd09d1 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -519,7 +519,7 @@ static void test_server_create_chr(TestServer *server=
, const gchar *opt)
     Chardev *chr;
=20
     chr_path =3D g_strdup_printf("unix:%s%s", server->socket_path, opt);
-    chr =3D qemu_chr_new(server->chr_name, chr_path);
+    chr =3D qemu_chr_new(server->chr_name, chr_path, NULL);
     g_free(chr_path);
=20
     g_assert_nonnull(chr);
diff --git a/vl.c b/vl.c
index 9e4dba7f92..ea794ec117 100644
--- a/vl.c
+++ b/vl.c
@@ -2302,7 +2302,7 @@ static int chardev_init_func(void *opaque, QemuOpts=
 *opts, Error **errp)
 {
     Error *local_err =3D NULL;
=20
-    if (!qemu_chr_new_from_opts(opts, &local_err)) {
+    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
         if (local_err) {
             error_propagate(errp, local_err);
             return -1;
@@ -2440,7 +2440,7 @@ static int serial_parse(const char *devname)
     snprintf(label, sizeof(label), "serial%d", index);
     serial_hds =3D g_renew(Chardev *, serial_hds, index + 1);
=20
-    serial_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
+    serial_hds[index] =3D qemu_chr_new_mux_mon(label, devname, NULL);
     if (!serial_hds[index]) {
         error_report("could not connect serial device"
                      " to character backend '%s'", devname);
@@ -2476,7 +2476,7 @@ static int parallel_parse(const char *devname)
         exit(1);
     }
     snprintf(label, sizeof(label), "parallel%d", index);
-    parallel_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
+    parallel_hds[index] =3D qemu_chr_new_mux_mon(label, devname, NULL);
     if (!parallel_hds[index]) {
         error_report("could not connect parallel device"
                      " to character backend '%s'", devname);
@@ -2490,7 +2490,7 @@ static int debugcon_parse(const char *devname)
 {
     QemuOpts *opts;
=20
-    if (!qemu_chr_new_mux_mon("debugcon", devname)) {
+    if (!qemu_chr_new_mux_mon("debugcon", devname, NULL)) {
         error_report("invalid character backend '%s'", devname);
         exit(1);
     }
--=20
2.21.0.rc0.1.g036caf7885
