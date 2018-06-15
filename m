Received: from eggs.gnu.org ([2001:4830:134:3::10]:41685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbP-00010e-1n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbO-0006I2-0W
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:11 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTmbN-0006Gw-Q7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:09 -0400
Received: by mail-wr0-x241.google.com with SMTP id o12-v6so9508878wrm.12
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 04:09:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 12:09:03 +0100
Message-Id: <20180615110903.29674-4-alex.bennee@linaro.org>
In-Reply-To: <20180615110903.29674-1-alex.bennee@linaro.org>
References: <20180615110903.29674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] travis: reduce time taken for trace-backend
 testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

These builds are reaching regular timeouts and probably don't need to
be so widely exercised. ftrace and ust in particular are used in
conjunction with whole system profiling which makes most sense with
KVM setups, hence the native softmmu target.

We also expand simple to cover the multiple log backends while
restricting its scope to user-mode testing only.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/.travis.yml b/.travis.yml
index c200dde534..fabfe9ec34 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -86,13 +86,14 @@ matrix:
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
            TEST_CMD=""
       compiler: gcc
-    - env: CONFIG="--enable-trace-backends=simple"
+    # We don't need to exercise every backend with every front-end
+    - env: CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
            TEST_CMD=""
       compiler: gcc
-    - env: CONFIG="--enable-trace-backends=ftrace"
+    - env: CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
            TEST_CMD=""
       compiler: gcc
-    - env: CONFIG="--enable-trace-backends=ust"
+    - env: CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
            TEST_CMD=""
       compiler: gcc
     - env: CONFIG="--disable-tcg"
-- 
2.17.1
