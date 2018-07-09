Received: from eggs.gnu.org ([2001:4830:134:3::10]:40537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXye-0000lm-Rr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyd-0005VW-T3
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:24 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXyd-0005VI-MS
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:23 -0400
Received: by mail-wm0-x234.google.com with SMTP id 69-v6so21053857wmf.3
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:11 +0100
Message-Id: <20180709152117.21585-5-alex.bennee@linaro.org>
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 04/10] docker: split configure_qemu
 from build_qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This allows some tests that just want to configure QEMU's source tree
to do so.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/common.rc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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
