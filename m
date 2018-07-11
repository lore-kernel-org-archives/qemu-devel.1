Received: from eggs.gnu.org ([2001:4830:134:3::10]:36181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFxG-0001Qc-HZ
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFxF-0003lV-Lv
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdFxF-0003lP-Gn
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 22:18:28 +0800
Message-Id: <20180711141829.17406-4-famz@redhat.com>
In-Reply-To: <20180711141829.17406-1-famz@redhat.com>
References: <20180711141829.17406-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] tests: Allow overriding archive path
 with SRC_ARCHIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

In VM based tests, the source archive is created in host, we don't have
to run archive-source.sh again, as it complicates the Makefile and
scripts.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b2a7e761cc..f0525b91a7 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -27,8 +27,11 @@ DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
 
 $(DOCKER_SRC_COPY):
 	@mkdir $@
-	$(call quiet-command, cd $(SRC_PATH) && scripts/archive-source.sh $@/qemu.tar, \
-		"GEN", "$@/qemu.tar")
+	$(if $(SRC_ARCHIVE), \
+		$(call quiet-command, cp "$(SRC_ARCHIVE)" $@/qemu.tar, \
+			"CP", "$@/qemu.tar"), \
+		$(call quiet-command, cd $(SRC_PATH) && scripts/archive-source.sh $@/qemu.tar, \
+			"GEN", "$@/qemu.tar"))
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
 		"COPY","RUNNER")
 
-- 
2.17.1
