Received: from eggs.gnu.org ([2001:4830:134:3::10]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuW-0000t1-Qr
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuW-0006UM-4H
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:20 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuV-0006TH-Ta
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:20 -0400
Received: by mail-wm0-x235.google.com with SMTP id s14-v6so2074359wmc.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:50:59 +0100
Message-Id: <20180724105109.8392-8-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/17] docker: gracefully skip check_qemu
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

Not all our images are able to run the tests. Rather than use features
we can just check for the existence and run-ability of gtester. If the
image has been setup for binfmt_misc it will be able to run anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 4ff5974016..4011561587 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -48,7 +48,13 @@ check_qemu()
     else
         INVOCATION="$@"
     fi
-    make $MAKEFLAGS $INVOCATION
+
+    if command -v gtester > /dev/null 2>&1 && \
+           gtester --version > /dev/null 2>&1; then
+        make $MAKEFLAGS $INVOCATION
+    else
+        echo "No working gtester, skipping make $INVOCATION"
+    fi
 }
 
 test_fail()
-- 
2.17.1
