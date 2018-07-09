Received: from eggs.gnu.org ([2001:4830:134:3::10]:40585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyg-0000nd-Nz
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyf-0005Wp-Qe
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:26 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:40856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXyf-0005WP-Jd
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:25 -0400
Received: by mail-wm0-x22d.google.com with SMTP id z13-v6so21177154wma.5
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:13 +0100
Message-Id: <20180709152117.21585-7-alex.bennee@linaro.org>
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 06/10] docker: gracefully skip
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
