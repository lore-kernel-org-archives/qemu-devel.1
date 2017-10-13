Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2xCZ-0001Ka-Cw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2xCV-00029B-EG
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:28:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2xCV-00028K-8Y
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:28:19 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 13 Oct 2017 11:28:12 +0100
Message-Id: <20171013102812.29648-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: pick the right compiler for OpenBSD
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The system compiler in OpenBSD is gcc 4.2.1 which is too
old for our needs. If doing 'pkg_add gcc' you can get a
much newer version (4.9.4 in OpenBSD 6.1) which works with
QEMU. This installs binaries with two naming schemes:

  $ pkg_info  -L gcc | grep bin
  /usr/local/bin/ecpp
  /usr/local/bin/egcc
  /usr/local/bin/egcc-ar
  /usr/local/bin/egcc-nm
  /usr/local/bin/egcc-ranlib
  /usr/local/bin/egcov
  /usr/local/bin/x86_64-unknown-openbsd6.0-egcc
  /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ar
  /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-nm
  /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ranlib
  /usr/local/bin/x86_64-unknown-openbsd6.0-gcc-4.9.3

We pick the short name this it won't change across OpenBSD
releases.

This means users don't need to manually pass custom --cc
and --cxx args to configure to avoid immediate failure.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 configure | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 06f18ea9af..fcb7523933 100755
--- a/configure
+++ b/configure
@@ -255,7 +255,21 @@ cross_prefix=""
 audio_drv_list=""
 block_drv_rw_whitelist=""
 block_drv_ro_whitelist=""
-host_cc="cc"
+
+case `uname -s` in
+    OpenBSD)
+    # Default system cc in OpenBSD is unsufficient
+    # we need the 'gcc' pkg added, whch provides
+    # these modified binary names
+    host_cc="egcc"
+    host_cxx="eg++"
+    ;;
+         *)
+    host_cc="cc"
+    host_cxx="c++"
+    ;;
+esac
+
 libs_softmmu=""
 libs_tools=""
 audio_pt_int=""
@@ -466,7 +480,7 @@ else
 fi
 
 if test -z "${CXX}${cross_prefix}"; then
-  cxx="c++"
+  cxx="$host_cxx"
 else
   cxx="${CXX-${cross_prefix}g++}"
 fi
-- 
2.13.5
