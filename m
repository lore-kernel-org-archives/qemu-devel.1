Received: from eggs.gnu.org ([2001:4830:134:3::10]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbO-00010Y-Bo
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbL-0006Fa-Go
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:42902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTmbL-0006Ez-9E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:07 -0400
Received: by mail-wr0-x22d.google.com with SMTP id w10-v6so9525447wrk.9
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 04:09:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 12:09:01 +0100
Message-Id: <20180615110903.29674-2-alex.bennee@linaro.org>
In-Reply-To: <20180615110903.29674-1-alex.bennee@linaro.org>
References: <20180615110903.29674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/3] travis: display config.log when configure
 fails
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

From: Daniel P. Berrangé <berrange@redhat.com>

When configure fails in CI systems we must be able to see the contents
of the config.log file to diagnose the root cause.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
[AJB: used Eric's suggested {} form]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
