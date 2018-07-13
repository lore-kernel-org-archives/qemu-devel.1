Received: from eggs.gnu.org ([2001:4830:134:3::10]:57388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx1I-0004p4-Cg
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx1F-0003op-83
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:56 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:52412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdx1F-0003nk-1e
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:53 -0400
Received: by mail-wm0-x22d.google.com with SMTP id o11-v6so2697614wmh.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:17:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:36 +0100
Message-Id: <20180713121741.19262-12-alex.bennee@linaro.org>
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 11/16] docker: add expansion for
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
