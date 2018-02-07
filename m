Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ejRbD-0001s1-Sq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ejRb8-0004Ad-Rx
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:25:27 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ejRb8-000486-LJ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:25:22 -0500
Received: by mail-wr0-x242.google.com with SMTP id w50so1465062wrc.2
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 07:25:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Feb 2018 16:25:15 +0100
Message-Id: <1518017115-43611-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518017115-43611-1-git-send-email-pbonzini@redhat.com>
References: <1518017115-43611-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/47] build-sys: add --enable-sanitizers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Typical slowdown introduced by AddressSanitizer is 2x.
UBSan shouldn't have much impact on runtime cost.

Enable it by default when --enable-debug, unless --disable-sanitizers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180116151152.4040-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/configure b/configure
index bdbd097..35147ad 100755
--- a/configure
+++ b/configure
@@ -342,6 +342,7 @@ rdma=""
 gprof="no"
 debug_tcg="no"
 debug="no"
+sanitizers="no"
 fortify_source=""
 strip_opt="yes"
 tcg_interpreter="no"
@@ -993,6 +994,10 @@ for opt do
       strip_opt="no"
       fortify_source="no"
   ;;
+  --enable-sanitizers) sanitizers="yes"
+  ;;
+  --disable-sanitizers) sanitizers="no"
+  ;;
   --enable-sparse) sparse="yes"
   ;;
   --disable-sparse) sparse="no"
@@ -1474,6 +1479,7 @@ Advanced options (experts only):
   --firmwarepath=PATH      search PATH for firmware files
   --with-confsuffix=SUFFIX suffix for QEMU data inside datadir/libdir/sysconfdir [$confsuffix]
   --enable-debug           enable common debug build options
+  --enable-sanitizers      enable default sanitizers
   --disable-strip          disable stripping binaries
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
@@ -5201,6 +5207,23 @@ if compile_prog "" "" ; then
 fi
 
 ##########################################
+# checks for sanitizers
+
+write_c_skeleton
+
+have_asan=no
+have_ubsan=no
+
+if test "$sanitizers" = "yes" ; then
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address" ""; then
+      have_asan=yes
+  fi
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
+      have_ubsan=yes
+  fi
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
 
@@ -5224,6 +5247,13 @@ else
     CFLAGS="-O2 $CFLAGS"
 fi
 
+if test "$have_asan" = "yes"; then
+  CFLAGS="-fsanitize=address $CFLAGS"
+fi
+if test "$have_ubsan" = "yes"; then
+  CFLAGS="-fsanitize=undefined $CFLAGS"
+fi
+
 ##########################################
 # Do we have libnfs
 if test "$libnfs" != "no" ; then
-- 
1.8.3.1
