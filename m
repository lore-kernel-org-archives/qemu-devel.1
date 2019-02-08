Received: from eggs.gnu.org ([209.51.188.92]:45607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCww-000192-2m
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gsCwu-00044Z-Qs
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:40:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gsCwu-00041K-Hh
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:40:36 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  8 Feb 2019 19:11:20 +0100
Message-Id: <20190208181122.23393-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190208181122.23393-1-marcandre.lureau@redhat.com>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH slirp 3/5] build-sys: add version tooling
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

Add SLIRP_CHECK_VERSION() macro, and a slirp_version_string() helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 meson.build               | 13 +++++++++++++
 src/libslirp-version.h.in | 22 ++++++++++++++++++++++
 src/libslirp.h            |  5 +++++
 src/util.h                |  3 +++
 src/version.c             | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+)
 create mode 100644 src/libslirp-version.h.in
 create mode 100644 src/version.c

diff --git a/meson.build b/meson.build
index d53d17a..ec0a0dd 100644
--- a/meson.build
+++ b/meson.build
@@ -10,6 +10,11 @@ major_version =3D varr[0]
 minor_version =3D varr[1]
 micro_version =3D varr[2]
=20
+conf =3D configuration_data()
+conf.set('SLIRP_MAJOR_VERSION', major_version)
+conf.set('SLIRP_MINOR_VERSION', minor_version)
+conf.set('SLIRP_MICRO_VERSION', micro_version)
+
 # libtool versioning - this applies to libpackagekit
 #
 # See http://sources.redhat.com/autobook/autobook/autobook_91.html#SEC91=
 for details
@@ -79,11 +84,19 @@ sources =3D [
   'src/udp.c',
   'src/udp6.c',
   'src/util.c',
+  'src/version.c',
 ]
=20
 mapfile =3D 'src/libslirp.map'
 vflag =3D '-Wl,--version-script,@0@/@1@'.format(meson.current_source_dir=
(), mapfile)
=20
+configure_file(
+  input : 'src/libslirp-version.h.in',
+  output : 'libslirp-version.h',
+  install_dir : join_paths(get_option('includedir'), 'slirp'),
+  configuration : conf
+)
+
 lib =3D shared_library('slirp', sources,
   soversion : lt_current,
   version : lt_version,
diff --git a/src/libslirp-version.h.in b/src/libslirp-version.h.in
new file mode 100644
index 0000000..e7d56f1
--- /dev/null
+++ b/src/libslirp-version.h.in
@@ -0,0 +1,22 @@
+#ifndef LIBSLIRP_VERSION_H_
+#define LIBSLIRP_VERSION_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define SLIRP_MAJOR_VERSION @SLIRP_MAJOR_VERSION@
+#define SLIRP_MINOR_VERSION @SLIRP_MINOR_VERSION@
+#define SLIRP_MICRO_VERSION @SLIRP_MICRO_VERSION@
+
+#define SLIRP_CHECK_VERSION(major,minor,micro)                          =
\
+    (SLIRP_MAJOR_VERSION > (major) ||                                   =
\
+     (SLIRP_MAJOR_VERSION =3D=3D (major) && SLIRP_MINOR_VERSION > (minor=
)) || \
+     (SLIRP_MAJOR_VERSION =3D=3D (major) && SLIRP_MINOR_VERSION =3D=3D (=
minor) && \
+      SLIRP_MICRO_VERSION >=3D (micro)))
+
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
+#endif /* LIBSLIRP_VERSION_H_ */
diff --git a/src/libslirp.h b/src/libslirp.h
index c6cb6a9..8008bd9 100644
--- a/src/libslirp.h
+++ b/src/libslirp.h
@@ -12,6 +12,8 @@
 #include <arpa/inet.h>
 #endif
=20
+#include "libslirp-version.h"
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -97,6 +99,9 @@ void slirp_socket_recv(Slirp *slirp, struct in_addr gue=
st_addr, int guest_port,
                        const uint8_t *buf, int size);
 size_t slirp_socket_can_recv(Slirp *slirp, struct in_addr guest_addr,
                              int guest_port);
+
+const char *slirp_version_string(void);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/src/util.h b/src/util.h
index a9c4e32..82b1901 100644
--- a/src/util.h
+++ b/src/util.h
@@ -71,6 +71,9 @@ struct iovec {
 #include <sys/uio.h>
 #endif
=20
+#define stringify(s) tostring(s)
+#define tostring(s) #s
+
 #define SCALE_MS 1000000
=20
 #define ETH_ALEN 6
diff --git a/src/version.c b/src/version.c
new file mode 100644
index 0000000..1a1d51e
--- /dev/null
+++ b/src/version.c
@@ -0,0 +1,33 @@
+/*
+ * libslirp version
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "libslirp.h"
+#include "util.h"
+
+const char *
+slirp_version_string(void)
+{
+    return stringify(SLIRP_MAJOR_VERSION) "."
+        stringify(SLIRP_MINOR_VERSION) "."
+        stringify(SLIRP_MICRO_VERSION);
+}
--=20
2.21.0.rc0.1.g036caf7885
