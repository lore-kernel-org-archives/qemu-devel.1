Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRl1-0006Ps-8y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTRky-0002Xr-Pd
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:43 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:55513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTRky-0002XB-IY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:53:40 -0400
Received: by mail-wm0-x231.google.com with SMTP id v16-v6so10358286wmh.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:53:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 14 Jun 2018 13:53:35 +0100
Message-Id: <20180614125337.24950-2-alex.bennee@linaro.org>
In-Reply-To: <20180614125337.24950-1-alex.bennee@linaro.org>
References: <20180614125337.24950-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/3] travis: display config.log when
 configure fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Daniel P. Berrangé <berrange@redhat.com>

When configure fails in CI systems we must be able to see the contents
of the config.log file to diagnose the root cause.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
[AJB: used Eric's suggested {} form]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 814be151f4..d5e6d50e6d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -69,7 +69,7 @@ before_install:
   - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
   - git submodule update --init --recursive
 before_script:
-  - ./configure ${CONFIG}
+  - ./configure ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
@@ -151,4 +151,4 @@ matrix:
         - CONFIG="--cc=gcc-7 --cxx=g++-7 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
-        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
+        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
-- 
2.17.1
