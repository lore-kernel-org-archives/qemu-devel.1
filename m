Received: from eggs.gnu.org ([2001:4830:134:3::10]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpJ-0002nf-8Y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpG-0003z0-Sm
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:17 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPqpG-0003yA-LR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:14 -0400
Received: by mail-wr0-x232.google.com with SMTP id d2-v6so28831038wrm.10
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:51:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  4 Jun 2018 15:51:04 +0100
Message-Id: <20180604145109.30498-3-alex.bennee@linaro.org>
In-Reply-To: <20180604145109.30498-1-alex.bennee@linaro.org>
References: <20180604145109.30498-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/7] configure: add test for docker
 availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This tests for a working docker installation without sudo and sets up
config-host.mak accordingly. This will be useful from cross compiling
things in the future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configure b/configure
index a8498ab393..2e10956cfc 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+docker="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -5444,6 +5445,17 @@ EOF
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
+    docker=$($python $source_path/tests/docker/docker.py probe)
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -5907,6 +5919,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "docker            $docker"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6731,6 +6744,10 @@ if test "$gcov" = "yes" ; then
   echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
+if test "$docker" != "no"; then
+    echo "HAVE_USER_DOCKER=y" >> $config_host_mak
+fi
+
 # use included Linux headers
 if test "$linux" = "yes" ; then
   mkdir -p linux-headers
-- 
2.17.0
