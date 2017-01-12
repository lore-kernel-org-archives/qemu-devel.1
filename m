Received: from eggs.gnu.org ([2001:4830:134:3::10]:56148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRfFe-0006pT-Bc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cRfFW-0003Zm-IK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:10 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cRfFW-0003ZQ-CI
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:17:02 -0500
Received: by mail-wm0-x22e.google.com with SMTP id r144so19026596wme.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 05:17:02 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Jan 2017 13:16:57 +0000
Message-Id: <20170112131658.19837-2-alex.bennee@linaro.org>
In-Reply-To: <20170112131658.19837-1-alex.bennee@linaro.org>
References: <20170112131658.19837-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] travis: trim out most clang builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

We test with both gcc and clang in order to detect cases
where clang issues warnings that gcc misses. To achieve
this though we don't need to build QEMU in multiple
different configurations. Just a single clang-on-linux
build will be sufficient, if we have an "all enabled"
config.

This cuts the number of build jobs from 21 to 16,
reducing the load imposed on shared Travis CI infra.
This will make it practical to enable jobs for other
interesting & useful configurations without DOS'ing
Travis to much.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 9916178bf3..0706b9a1df 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -4,7 +4,6 @@ python:
   - "2.4"
 compiler:
   - gcc
-  - clang
 cache: ccache
 addons:
   apt:
@@ -68,6 +67,9 @@ script:
   - make -j3 && ${TEST_CMD}
 matrix:
   include:
+    # Test with CLang for compile portability
+    - env: CONFIG=""
+      compiler: clang
     # gprof/gcov are GCC features
     - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
       compiler: gcc
-- 
2.11.0
