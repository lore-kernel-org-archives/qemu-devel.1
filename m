Received: from eggs.gnu.org ([2001:4830:134:3::10]:52545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4t-0007PN-GQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4s-0004fj-KP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:27 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:46906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4s-0004ex-FP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:26 -0400
Received: by mail-qt0-x22f.google.com with SMTP id h5-v6so5303297qtm.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:47:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:40 -0300
Message-Id: <20180628164643.9668-6-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 5/8] docker: Restrict the 'travis' job to
 the Travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

We can still run any test in Travis.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 91d9665517..7d9d568eee 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -99,11 +99,17 @@ docker-image-tricore-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES), \
-	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
+	$(foreach t,$(DOCKER_TESTS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
+		$(eval docker-test: docker-$t@$i) \
 	) \
-	$(foreach t,$(DOCKER_TESTS), \
+)
+# we only run Travis tests on the Travis image
+$(foreach i,travis, \
+	$(foreach t,$(DOCKER_TOOLS), \
+		$(eval .PHONY: docker-$t@$i) \
+		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
 		$(eval docker-test: docker-$t@$i) \
 	) \
 )
-- 
2.18.0
