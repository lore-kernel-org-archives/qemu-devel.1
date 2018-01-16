Received: from eggs.gnu.org ([2001:4830:134:3::10]:41126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebSwy-0000lh-Nw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ebSwv-0003vQ-Lk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:14:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ebSwv-0003v2-Fj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:14:53 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jan 2018 16:11:51 +0100
Message-Id: <20180116151152.4040-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180116151152.4040-1-marcandre.lureau@redhat.com>
References: <20180116151152.4040-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] build-sys: add --enable-sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Typical slowdown introduced by AddressSanitizer is 2x.
UBSan shouldn't have much impact on runtime cost.

Enable it by default when --enable-debug, unless --disable-sanitizers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/configure b/configure
index 6d8c996c62..9a435917cc 100755
--- a/configure
+++ b/configure
@@ -342,6 +342,7 @@ rdma=3D""
 gprof=3D"no"
 debug_tcg=3D"no"
 debug=3D"no"
+sanitizers=3D""
 fortify_source=3D""
 strip_opt=3D"yes"
 tcg_interpreter=3D"no"
@@ -994,6 +995,10 @@ for opt do
       strip_opt=3D"no"
       fortify_source=3D"no"
   ;;
+  --enable-sanitizers) sanitizers=3D"yes"
+  ;;
+  --disable-sanitizers) sanitizers=3D"no"
+  ;;
   --enable-sparse) sparse=3D"yes"
   ;;
   --disable-sparse) sparse=3D"no"
@@ -1471,6 +1476,7 @@ Advanced options (experts only):
   --firmwarepath=3DPATH      search PATH for firmware files
   --with-confsuffix=3DSUFFIX suffix for QEMU data inside datadir/libdir/=
sysconfdir [$confsuffix]
   --enable-debug           enable common debug build options
+  --enable-sanitizers      enable default sanitizers
   --disable-strip          disable stripping binaries
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
@@ -5185,6 +5191,28 @@ if compile_prog "" "" ; then
     have_utmpx=3Dyes
 fi
=20
+##########################################
+# checks for sanitizers
+
+write_c_skeleton
+
+have_asan=3Dno
+have_ubsan=3Dno
+
+# enable sanitizers by default if --enable-debug
+if test "$sanitizers" =3D "" -a "$debug" =3D "yes"; then
+  sanitizers=3Dyes
+fi
+
+if test "$sanitizers" =3D "yes" ; then
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
+      have_asan=3Dyes
+  fi
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dundefined" ""; then
+      have_ubsan=3Dyes
+  fi
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -5209,6 +5237,13 @@ else
     CFLAGS=3D"-O2 $CFLAGS"
 fi
=20
+if test "$have_asan" =3D "yes"; then
+  CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
+fi
+if test "$have_ubsan" =3D "yes"; then
+  CFLAGS=3D"-fsanitize=3Dundefined $CFLAGS"
+fi
+
 ##########################################
 # Do we have libnfs
 if test "$libnfs" !=3D "no" ; then
--=20
2.16.0.rc1.1.gef27df75a1
