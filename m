Received: from eggs.gnu.org ([2001:4830:134:3::10]:51681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5QrB-0001dT-3l
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5QrA-0007PB-0Y
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e5Qr9-0007Or-Qb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:32:31 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Oct 2017 14:32:17 +0800
Message-Id: <20171020063219.2035-4-famz@redhat.com>
In-Reply-To: <20171020063219.2035-1-famz@redhat.com>
References: <20171020063219.2035-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] docker: allow running from srcdir !=
 builddir build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

The new script uses "git submodule", which is picky about being invoked
from the top of the git checkout.  Invoke the script from $(SRC_PATH)
to avoid git's wrath.

Fixes: b7f404201e45e99da23b9764dec27ce5f965cdcd
Cc: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Message-Id: <1508331989-142364-1-git-send-email-pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 38874ec03d..02cd520590 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -18,11 +18,11 @@ TESTS ?= %
 IMAGES ?= %
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
-DOCKER_SRC_COPY := docker-src.$(CUR_TIME)
+DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
 
 $(DOCKER_SRC_COPY):
 	@mkdir $@
-	$(call quiet-command, $(SRC_PATH)/scripts/archive-source.sh $@/qemu.tar, \
+	$(call quiet-command, cd $(SRC_PATH) && scripts/archive-source.sh $@/qemu.tar, \
 		"GEN", "$@/qemu.tar")
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
 		"COPY","RUNNER")
-- 
2.13.5
