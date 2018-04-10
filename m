Received: from eggs.gnu.org ([2001:4830:134:3::10]:46506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z6z-000056-A8
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z6w-0006F5-MA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:25 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z6w-0006EK-Fb
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:22 -0400
Received: by mail-wr0-x244.google.com with SMTP id m13so13941980wrj.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:38:56 +0100
Message-Id: <20180410193919.28026-2-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 01/24] configure: add test for docker
 availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This tests for a working docker installation without sudo and sets up
config-host.mak accordingly. This will be useful from cross compiling
things in the future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/configure b/configure
index 4d0e92c96c..b402befe94 100755
--- a/configure
+++ b/configure
@@ -451,6 +451,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+docker="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -5396,6 +5397,23 @@ EOF
   fi
 fi
 
+##########################################
+# Docker and cross-compiler support
+#
+# This is specifically for building test
+# cases for foreign architectures, not
+# cross-compiling QEMU itself.
+
+if has "docker"; then
+    if docker images  >/dev/null 2>&1 ; then
+        docker="yes"
+    else
+        # docker may be available but using sudo
+        # so we won't use it for cross-building
+        docker="maybe"
+    fi
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -5857,6 +5875,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "docker            $docker"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6680,6 +6699,10 @@ if test "$gcov" = "yes" ; then
   echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
+if test "$docker" = "yes"; then
+    echo "HAVE_USER_DOCKER=y" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
-- 
2.16.2
