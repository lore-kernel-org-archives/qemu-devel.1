Received: from eggs.gnu.org ([209.51.188.92]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCtX-0006wl-LD
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCtW-0002Ql-M2
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gsCtW-0002Ph-EG
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:37:06 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  8 Feb 2019 19:11:19 +0100
Message-Id: <20190208181122.23393-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190208181122.23393-1-marcandre.lureau@redhat.com>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH slirp 2/5] build-sys: add a meson build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Build a shared library, exporting only slirp_* symbols.

Install API headers and a slirp.pc pkg-config.

It has been tested to build on Linux and with mingw64 cross-compilation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 meson.build      | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 src/libslirp.map |  21 +++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 meson.build
 create mode 100644 src/libslirp.map

diff --git a/meson.build b/meson.build
new file mode 100644
index 0000000..d53d17a
--- /dev/null
+++ b/meson.build
@@ -0,0 +1,111 @@
+project('slirp', 'c',
+  version : '4.0.0',
+  license : 'BSD-3-Clause',
+  default_options : ['warning_level=3D1', 'c_std=3Dgnu99']
+)
+
+version =3D meson.project_version()
+varr =3D version.split('.')
+major_version =3D varr[0]
+minor_version =3D varr[1]
+micro_version =3D varr[2]
+
+# libtool versioning - this applies to libpackagekit
+#
+# See http://sources.redhat.com/autobook/autobook/autobook_91.html#SEC91=
 for details
+#
+# - If interfaces have been changed or added, but binary compatibility
+#   has been preserved, change:
+#      CURRENT +=3D 1
+#      REVISION =3D 0
+#      AGE +=3D 1
+# - If binary compatibility has been broken (eg removed or changed
+#   interfaces), change:
+#      CURRENT +=3D 1
+#      REVISION =3D 0
+#      AGE =3D 0
+# - If the interface is the same as the previous version, but bugs are
+#   fixed, change:
+#      REVISION +=3D 1
+lt_current =3D '0'
+lt_revision =3D '0'
+lt_age =3D '0'
+lt_version =3D '@0@.@1@.@2@'.format(lt_current, lt_age, lt_revision)
+
+host_system =3D host_machine.system()
+
+glib_dep =3D dependency('glib-2.0')
+
+cc =3D meson.get_compiler('c')
+
+platform_deps =3D []
+
+if host_system =3D=3D 'windows'
+  platform_deps +=3D [
+    cc.find_library('ws2_32'),
+    cc.find_library('iphlpapi')
+  ]
+endif
+
+cargs =3D [
+  '-DG_LOG_DOMAIN=3D"Slirp"',
+]
+
+sources =3D [
+  'src/arp_table.c',
+  'src/bootp.c',
+  'src/cksum.c',
+  'src/dhcpv6.c',
+  'src/dnssearch.c',
+  'src/if.c',
+  'src/ip6_icmp.c',
+  'src/ip6_input.c',
+  'src/ip6_output.c',
+  'src/ip_icmp.c',
+  'src/ip_input.c',
+  'src/ip_output.c',
+  'src/mbuf.c',
+  'src/misc.c',
+  'src/ncsi.c',
+  'src/ndp_table.c',
+  'src/sbuf.c',
+  'src/slirp.c',
+  'src/socket.c',
+  'src/tcp_input.c',
+  'src/tcp_output.c',
+  'src/tcp_subr.c',
+  'src/tcp_timer.c',
+  'src/tftp.c',
+  'src/udp.c',
+  'src/udp6.c',
+  'src/util.c',
+]
+
+mapfile =3D 'src/libslirp.map'
+vflag =3D '-Wl,--version-script,@0@/@1@'.format(meson.current_source_dir=
(), mapfile)
+
+lib =3D shared_library('slirp', sources,
+  soversion : lt_current,
+  version : lt_version,
+  c_args : cargs,
+  link_args : vflag,
+  link_depends : mapfile,
+  dependencies : [glib_dep, platform_deps],
+  install : true
+)
+
+install_headers(['src/libslirp.h'], subdir : 'slirp')
+
+pkg =3D import('pkgconfig')
+
+pkg.generate(
+  version : version,
+  libraries : lib,
+  requires : [
+    'glib-2.0',
+  ],
+  name : 'slirp',
+  description : 'User-space network stack',
+  filebase : 'slirp',
+  subdirs : 'slirp',
+)
diff --git a/src/libslirp.map b/src/libslirp.map
new file mode 100644
index 0000000..3eb730a
--- /dev/null
+++ b/src/libslirp.map
@@ -0,0 +1,21 @@
+SLIRP_4.0 {
+global:
+    slirp_add_exec;
+    slirp_add_guestfwd;
+    slirp_add_hostfwd;
+    slirp_cleanup;
+    slirp_connection_info;
+    slirp_init;
+    slirp_input;
+    slirp_pollfds_fill;
+    slirp_pollfds_poll;
+    slirp_remove_hostfwd;
+    slirp_socket_can_recv;
+    slirp_socket_recv;
+    slirp_state_load;
+    slirp_state_save;
+    slirp_state_version;
+    slirp_version_string;
+local:
+    *;
+};
--=20
2.21.0.rc0.1.g036caf7885
