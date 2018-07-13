Received: from eggs.gnu.org ([2001:4830:134:3::10]:57389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx1I-0004p6-D6
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx1G-0003rR-Rj
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdx1G-0003qB-LO
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id b15-v6so24955637wrv.10
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:17:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:32 +0100
Message-Id: <20180713121741.19262-8-alex.bennee@linaro.org>
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 07/16] docker: gracefully skip
 check_qemu
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

Not all our images are able to run the tests. Rather than use features
we can just check for the existence and run-ability of gtester. If the
image has been setup for binfmt_misc it will be able to run anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/common.rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index cfc620d554..6df431eb72 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -47,7 +47,13 @@ check_qemu()
     else
         TEST="$@"
     fi
-    make $MAKEFLAGS $TEST
+
+    if type gtester > /dev/null 2>&1 && \
+           gtester --version > /dev/null 2>&1; then
+        make $MAKEFLAGS $TEST
+    else
+        echo "No working gtester, skipping make $TEST"
+    fi
 }
 
 test_fail()
-- 
2.17.1
