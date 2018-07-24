Received: from eggs.gnu.org ([2001:4830:134:3::10]:60007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuU-0000ro-0z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuT-0006Qj-0i
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuS-0006QM-Oy
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id q10-v6so3663442wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:50:57 +0100
Message-Id: <20180724105109.8392-6-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/17] docker: split configure_qemu from
 build_qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This allows some tests that just want to configure QEMU's source tree
to do so.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 046f8a5921..ba1f942328 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -21,7 +21,7 @@ requires()
     done
 }
 
-build_qemu()
+configure_qemu()
 {
     config_opts="--enable-werror \
                  ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
@@ -32,6 +32,11 @@ build_qemu()
     echo $config_opts
     $QEMU_SRC/configure $config_opts || \
         { cat config.log && test_fail "Failed to run 'configure'"; }
+}
+
+build_qemu()
+{
+    configure_qemu $@
     make $MAKEFLAGS
 }
 
-- 
2.17.1
