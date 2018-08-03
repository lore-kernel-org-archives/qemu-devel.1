Received: from eggs.gnu.org ([2001:4830:134:3::10]:40032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0A-0007on-1E
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle08-0001HA-GC
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle08-0001Gy-AI
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D59054B759
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:36:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:07 +0200
Message-Id: <20180803173614.12358-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/10] configure: bump spice-server required
 version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Looking at chardev/spice.c code, I realize compilation was broken for
a while with spice-server < 0.12.3. I propose to bump required version
to 0.12.6, released 3y ago, instead of adding more #ifdef.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.h        |  2 --
 include/ui/qemu-spice.h |  9 ---------
 chardev/spice.c         | 12 ------------
 hw/display/qxl.c        |  8 --------
 ui/spice-core.c         |  8 --------
 configure               |  4 ++--
 6 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 089696ef62..e4afab8c3a 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -100,9 +100,7 @@ typedef struct PCIQXLDevice {
     QXLModes           *modes;
     uint32_t           rom_size;
     MemoryRegion       rom_bar;
-#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
     uint16_t           max_outputs;
-#endif
=20
     /* vram pci bar */
     uint64_t           vram_size;
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index c6d50eb87a..f3e17612b1 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -41,18 +41,9 @@ int qemu_spice_set_pw_expire(time_t expires);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port=
,
                             const char *subject);
=20
-#if !defined(SPICE_SERVER_VERSION) || (SPICE_SERVER_VERSION < 0xc06)
-#define SPICE_NEEDS_SET_MM_TIME 1
-#else
 #define SPICE_NEEDS_SET_MM_TIME 0
-#endif
=20
-#if SPICE_SERVER_VERSION >=3D 0x000c02
 void qemu_spice_register_ports(void);
-#else
-static inline Chardev *qemu_chr_open_spice_port(const char *name)
-{ return NULL; }
-#endif
=20
 #else  /* CONFIG_SPICE */
=20
diff --git a/chardev/spice.c b/chardev/spice.c
index 6ad95ffe62..4d4bafe34e 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -77,7 +77,6 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8=
_t *buf, int len)
     return bytes;
 }
=20
-#if SPICE_SERVER_VERSION >=3D 0x000c02
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
     SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
@@ -95,7 +94,6 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uin=
t8_t event)
     trace_spice_vmc_event(chr_event);
     qemu_chr_be_event(chr, chr_event);
 }
-#endif
=20
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
@@ -119,12 +117,8 @@ static SpiceCharDeviceInterface vmc_interface =3D {
     .state              =3D vmc_state,
     .write              =3D vmc_write,
     .read               =3D vmc_read,
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     .event              =3D vmc_event,
-#endif
-#if SPICE_SERVER_VERSION >=3D 0x000c06
     .flags              =3D SPICE_CHAR_DEVICE_NOTIFY_WRITABLE,
-#endif
 };
=20
=20
@@ -242,9 +236,7 @@ static void char_spice_finalize(Object *obj)
     }
=20
     g_free((char *)s->sin.subtype);
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     g_free((char *)s->sin.portname);
-#endif
 }
=20
 static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
@@ -259,7 +251,6 @@ static void spice_vmc_set_fe_open(struct Chardev *chr=
, int fe_open)
=20
 static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     SpiceChardev *s =3D SPICE_CHARDEV(chr);
=20
     if (fe_open) {
@@ -267,7 +258,6 @@ static void spice_port_set_fe_open(struct Chardev *ch=
r, int fe_open)
     } else {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_CLOSED);
     }
-#endif
 }
=20
 static void spice_chr_accept_input(struct Chardev *chr)
@@ -317,7 +307,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     chr_open(chr, type);
 }
=20
-#if SPICE_SERVER_VERSION >=3D 0x000c02
 static void qemu_chr_open_spice_port(Chardev *chr,
                                      ChardevBackend *backend,
                                      bool *be_opened,
@@ -350,7 +339,6 @@ void qemu_spice_register_ports(void)
         vmc_register_interface(s);
     }
 }
-#endif
=20
 static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *bac=
kend,
                                      Error **errp)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 830c392c53..cdd884984d 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -274,11 +274,9 @@ static void qxl_spice_monitors_config_async(PCIQXLDe=
vice *qxl, int replay)
                     QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,
                     0));
     } else {
-#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
         if (qxl->max_outputs) {
             spice_qxl_set_max_monitors(&qxl->ssd.qxl, qxl->max_outputs);
         }
-#endif
         qxl->guest_monitors_config =3D qxl->ram->monitors_config;
         spice_qxl_monitors_config_async(&qxl->ssd.qxl,
                 qxl->ram->monitors_config,
@@ -1094,12 +1092,10 @@ static int interface_client_monitors_config(QXLIn=
stance *sin,
         return 1;
     }
=20
-#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
     /* limit number of outputs based on setting limit */
     if (qxl->max_outputs && qxl->max_outputs <=3D max_outputs) {
         max_outputs =3D qxl->max_outputs;
     }
-#endif
=20
     config_changed =3D qxl_rom_monitors_config_changed(rom,
                                                      monitors_config,
@@ -1177,9 +1173,7 @@ static void qxl_enter_vga_mode(PCIQXLDevice *d)
         return;
     }
     trace_qxl_enter_vga_mode(d->id);
-#if SPICE_SERVER_VERSION >=3D 0x000c03 /* release 0.12.3 */
     spice_qxl_driver_unload(&d->ssd.qxl);
-#endif
     graphic_console_set_hwops(d->ssd.dcl.con, d->vga.hw_ops, &d->vga);
     update_displaychangelistener(&d->ssd.dcl, GUI_REFRESH_INTERVAL_DEFAU=
LT);
     qemu_spice_create_host_primary(&d->ssd);
@@ -2403,9 +2397,7 @@ static Property qxl_properties[] =3D {
         DEFINE_PROP_UINT32("vram64_size_mb", PCIQXLDevice, vram_size_mb,=
 -1),
         DEFINE_PROP_UINT32("vgamem_mb", PCIQXLDevice, vgamem_size_mb, 16=
),
         DEFINE_PROP_INT32("surfaces", PCIQXLDevice, ssd.num_surfaces, 10=
24),
-#if SPICE_SERVER_VERSION >=3D 0x000c06 /* release 0.12.6 */
         DEFINE_PROP_UINT16("max_outputs", PCIQXLDevice, max_outputs, 0),
-#endif
         DEFINE_PROP_UINT32("xres", PCIQXLDevice, xres, 0),
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
         DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmst=
ate, false),
diff --git a/ui/spice-core.c b/ui/spice-core.c
index f8c0878529..76896f7c7a 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -746,13 +746,7 @@ void qemu_spice_init(void)
     }
=20
     if (qemu_opt_get_bool(opts, "disable-agent-file-xfer", 0)) {
-#if SPICE_SERVER_VERSION >=3D 0x000c04
         spice_server_set_agent_file_xfer(spice_server, false);
-#else
-        error_report("this qemu build does not support the "
-                     "\"disable-agent-file-xfer\" option");
-        exit(1);
-#endif
     }
=20
     compression =3D SPICE_IMAGE_COMPRESS_AUTO_GLZ;
@@ -818,9 +812,7 @@ void qemu_spice_init(void)
     g_free(x509_cert_file);
     g_free(x509_cacert_file);
=20
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     qemu_spice_register_ports();
-#endif
=20
 #ifdef HAVE_SPICE_GL
     if (qemu_opt_get_bool(opts, "gl", 0)) {
diff --git a/configure b/configure
index 8280ae7a8a..8a1371c55c 100755
--- a/configure
+++ b/configure
@@ -4521,7 +4521,7 @@ int main(void) { spice_server_new(); return 0; }
 EOF
   spice_cflags=3D$($pkg_config --cflags spice-protocol spice-server 2>/d=
ev/null)
   spice_libs=3D$($pkg_config --libs spice-protocol spice-server 2>/dev/n=
ull)
-  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
+  if $pkg_config --atleast-version=3D0.12.6 spice-server && \
      $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice=3D"yes"
@@ -4532,7 +4532,7 @@ EOF
   else
     if test "$spice" =3D "yes" ; then
       feature_not_found "spice" \
-          "Install spice-server(>=3D0.12.0) and spice-protocol(>=3D0.12.=
3) devel"
+          "Install spice-server(>=3D0.12.6) and spice-protocol(>=3D0.12.=
3) devel"
     fi
     spice=3D"no"
   fi
--=20
2.18.0.547.g1d89318c48
