Received: from eggs.gnu.org ([2001:4830:134:3::10]:60129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuua-0000wd-0W
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuZ-0006XR-7t
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:24 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuZ-0006Wq-1Q
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:23 -0400
Received: by mail-wm0-x236.google.com with SMTP id y9-v6so1229788wma.5
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:04 +0100
Message-Id: <20180724105109.8392-13-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/17] docker: report hint when docker.py check
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

When a check fails we currently just report why we failed. This is not
totally helpful to people who want to boot-strap a new image. Report a
hint as to why it failed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Fam Zheng <famz@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 05afeb64a7..1aaa795743 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -73,7 +73,8 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
 			"BUILD","binfmt debian-$* (debootstrapped)"),		\
 		$(call quiet-command,						\
-			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<,	\
+			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $< || 	\
+			{ echo "You will need to build $(EXECUTABLE)"; exit 1;},\
 			"CHECK", "debian-$* exists"))
 
 endif
-- 
2.17.1
