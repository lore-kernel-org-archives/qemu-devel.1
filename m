Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZzLf-0007mK-8s
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gZz7S-0000GU-D2
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gZz7S-0000Fn-3u
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:16:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7742F8E587
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:16:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Dec 2018 18:15:42 +0400
Message-Id: <20181220141553.24098-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/12] configure: bump spice-server required
 version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com

Looking at chardev/spice.c code, I realize compilation was broken for
a while with spice-server < 0.12.3. Let's bump required version
to 0.12.5, released May 19 2014, instead of adding more #ifdef.

(this patch combines changes from an early version and some of
Frediano "[PATCH 2/2] spice: Bump required spice-server version to
0.12.6")

According to repology, all the distros that are build target platforms
for QEMU include it:

      RHEL-7: 0.14.0
      Debian (Stretch): 0.12.8
      Debian (Jessie): 0.12.5
      FreeBSD (ports): 0.14.0
      OpenSUSE Leap 15: 0.14.0
      Ubuntu (Xenial): 0.12.6

Note that a previous version of this patch was bumping version to
0.12.6. Unfortunately, Debian Jessie (oldstable) is stuck with spice
server 0.12.5, and QEMU should keep building until after 2y of current
stable (Stretch), which will be around June 17th 2019. Qemu 4.1
should thus be free of bumping to spice-server 0.12.6 during 4.1
development cycle.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/ui/qemu-spice.h |  6 ------
 chardev/spice.c         | 10 ----------
 hw/display/qxl.c        |  2 --
 ui/spice-core.c         |  8 --------
 configure               |  4 ++--
 5 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index c6d50eb87a..8c23dfe717 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -46,13 +46,7 @@ int qemu_spice_migrate_info(const char *hostname, int =
port, int tls_port,
 #else
 #define SPICE_NEEDS_SET_MM_TIME 0
 #endif
-
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
index e66e3ad568..173c257949 100644
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
@@ -119,9 +117,7 @@ static SpiceCharDeviceInterface vmc_interface =3D {
     .state              =3D vmc_state,
     .write              =3D vmc_write,
     .read               =3D vmc_read,
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     .event              =3D vmc_event,
-#endif
 #if SPICE_SERVER_VERSION >=3D 0x000c06
     .flags              =3D SPICE_CHAR_DEVICE_NOTIFY_WRITABLE,
 #endif
@@ -223,9 +219,7 @@ static void char_spice_finalize(Object *obj)
     }
=20
     g_free((char *)s->sin.subtype);
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     g_free((char *)s->sin.portname);
-#endif
 }
=20
 static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
@@ -240,7 +234,6 @@ static void spice_vmc_set_fe_open(struct Chardev *chr=
, int fe_open)
=20
 static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
-#if SPICE_SERVER_VERSION >=3D 0x000c02
     SpiceChardev *s =3D SPICE_CHARDEV(chr);
=20
     if (fe_open) {
@@ -248,7 +241,6 @@ static void spice_port_set_fe_open(struct Chardev *ch=
r, int fe_open)
     } else {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_CLOSED);
     }
-#endif
 }
=20
 static void spice_chr_accept_input(struct Chardev *chr)
@@ -298,7 +290,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
     chr_open(chr, type);
 }
=20
-#if SPICE_SERVER_VERSION >=3D 0x000c02
 static void qemu_chr_open_spice_port(Chardev *chr,
                                      ChardevBackend *backend,
                                      bool *be_opened,
@@ -331,7 +322,6 @@ void qemu_spice_register_ports(void)
         vmc_register_interface(s);
     }
 }
-#endif
=20
 static void qemu_chr_parse_spice_vmc(QemuOpts *opts, ChardevBackend *bac=
kend,
                                      Error **errp)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 9087db5dee..8e9a65e75b 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1189,9 +1189,7 @@ static void qxl_enter_vga_mode(PCIQXLDevice *d)
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
diff --git a/ui/spice-core.c b/ui/spice-core.c
index ebaae24643..fc850b3f50 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -745,13 +745,7 @@ void qemu_spice_init(void)
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
@@ -817,9 +811,7 @@ void qemu_spice_init(void)
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
index 224d3071ac..b0927b882a 100755
--- a/configure
+++ b/configure
@@ -4599,7 +4599,7 @@ int main(void) { spice_server_new(); return 0; }
 EOF
   spice_cflags=3D$($pkg_config --cflags spice-protocol spice-server 2>/d=
ev/null)
   spice_libs=3D$($pkg_config --libs spice-protocol spice-server 2>/dev/n=
ull)
-  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
+  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
      $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice=3D"yes"
@@ -4610,7 +4610,7 @@ EOF
   else
     if test "$spice" =3D "yes" ; then
       feature_not_found "spice" \
-          "Install spice-server(>=3D0.12.0) and spice-protocol(>=3D0.12.=
3) devel"
+          "Install spice-server(>=3D0.12.5) and spice-protocol(>=3D0.12.=
3) devel"
     fi
     spice=3D"no"
   fi
--=20
2.20.1.2.gb21ebb671b
