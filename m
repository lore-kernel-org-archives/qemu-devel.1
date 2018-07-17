Received: from eggs.gnu.org ([2001:4830:134:3::10]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4r-000335-Ed
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4q-0004hh-K3
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:05 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:51925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4q-0004g4-CT
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:04 -0400
Received: by mail-wm0-x233.google.com with SMTP id h3-v6so128529wmb.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:56:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:46 +0100
Message-Id: <20180717195553.9111-12-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 11/18] docker: add expansion for
 docker-test-FOO to Makefile.include
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

This allows us to run a particular test on all docker images. For
example:

  make docker-test-unit

Will run the unit tests on every supported image. At the same time
rename docker-test to docker-all-tests to be clearer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2
  - docker-test -> docker-all-tests
---
 tests/docker/Makefile.include | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fe63aacf69..e32c35be0d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -151,7 +151,8 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPR
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
 	) \
 	$(foreach t,$(DOCKER_TESTS), \
-		$(eval docker-test: docker-$t@$i) \
+		$(eval docker-all-tests: docker-$t@$i) \
+		$(eval docker-$t: docker-$t@$i) \
 	) \
 )
 
@@ -161,7 +162,8 @@ docker:
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
