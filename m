Received: from eggs.gnu.org ([2001:4830:134:3::10]:34824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewTqp-0000WG-Do
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewTqk-0000wY-HC
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:27:27 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewTqk-0000vy-Bg
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:27:22 -0400
Received: by mail-wr0-x244.google.com with SMTP id h2so8454292wre.12
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 07:27:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Mar 2018 15:27:13 +0100
Message-Id: <20180315142713.30960-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] docker: dump 'config.log' if ./configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
v2:
- avoid subshell using { ; } (Eric)
- use test_fail() instead of prep_fail() (Fam)

 tests/docker/common.rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 7951555e3f..046f8a5921 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -30,7 +30,9 @@ build_qemu()
                  $@"
     echo "Configure options:"
     echo $config_opts
-    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
+    $QEMU_SRC/configure $config_opts || \
+        { cat config.log && test_fail "Failed to run 'configure'"; }
+    make $MAKEFLAGS
 }
 
 test_fail()
-- 
2.16.2
