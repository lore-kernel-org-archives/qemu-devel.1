Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuue-00011Z-RW
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuua-0006Xz-6u
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:28 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:53509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuZ-0006XZ-W5
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:24 -0400
Received: by mail-wm0-x232.google.com with SMTP id s9-v6so2063181wmh.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:02 +0100
Message-Id: <20180724105109.8392-11-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/17] docker: add expansion for docker-test-FOO
 to Makefile.include
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

This allows us to run a particular test on all docker images. For
example:

  make docker-test-unit

Will run the unit tests on every supported image. At the same time
rename docker-test to docker-all-tests to be clearer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 09fb7db7fa..8fbb076396 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -148,7 +148,8 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPR
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
 	) \
 	$(foreach t,$(DOCKER_TESTS), \
-		$(eval docker-test: docker-$t@$i) \
+		$(eval docker-all-tests: docker-$t@$i) \
+		$(eval docker-$t: docker-$t@$i) \
 	) \
 )
 
@@ -158,7 +159,8 @@ docker:
 	@echo 'Available targets:'
 	@echo
 	@echo '    docker:              Print this help.'
-	@echo '    docker-test:         Run all image/test combinations.'
+	@echo '    docker-all-tests:    Run all image/test combinations.'
+	@echo '    docker-TEST:         Run TEST on all image combinations.'
 	@echo '    docker-clean:        Kill and remove residual docker testing containers.'
 	@echo '    docker-TEST@IMAGE:   Run "TEST" in container "IMAGE".'
 	@echo '                         Note: "TEST" is one of the listed test name,'
-- 
2.17.1
