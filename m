Received: from eggs.gnu.org ([2001:4830:134:3::10]:53164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVH-0000vF-7G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESy-0004MU-DF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:11 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:39835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESy-0004Lj-2g
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:48 -0400
Received: by mail-wm0-x22a.google.com with SMTP id p11-v6so6150184wmc.4
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:37 +0100
Message-Id: <20180605160541.10664-3-alex.bennee@linaro.org>
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/6] configure: add test for docker availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This tests for a working docker installation without sudo and sets up
config-host.mak accordingly. This will be useful from cross compiling
things in the future.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/configure b/configure
index ab810d728f..db8c9d8288 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+docker="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -5450,6 +5451,17 @@ EOF
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
@@ -5913,6 +5925,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "docker            $docker"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6740,6 +6753,10 @@ if test "$gcov" = "yes" ; then
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
