Received: from eggs.gnu.org ([2001:4830:134:3::10]:35280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRl1-0006Q0-Fz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRl0-0002YR-Ct
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:43 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTRl0-0002Y6-5W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:42 -0400
Received: by mail-wr0-x241.google.com with SMTP id d2-v6so6298631wrm.10
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:53:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 14 Jun 2018 13:53:37 +0100
Message-Id: <20180614125337.24950-4-alex.bennee@linaro.org>
In-Reply-To: <20180614125337.24950-1-alex.bennee@linaro.org>
References: <20180614125337.24950-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/3] travis: reduce time taken for
 trace-backend testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

These builds are reaching regular timeouts and probably don't need to
be so widely exercised. ftrace and ust in particular are used in
conjunction with whole system profiling which makes most sense with
KVM setups, hence the native softmmu target.

We also expand simple to cover the multiple log backends while
restricting its scope to user-mode testing only.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
