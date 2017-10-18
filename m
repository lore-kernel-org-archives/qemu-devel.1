Received: from eggs.gnu.org ([2001:4830:134:3::10]:40195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4o3w-00073w-Fq
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4o3s-0002Fo-Hd
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:07:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:47935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4o3s-0002FZ-B0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:07:04 -0400
Received: by mail-wr0-x244.google.com with SMTP id y39so4963524wrd.4
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 06:07:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 15:06:29 +0200
Message-Id: <1508331989-142364-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: allow running from srcdir != builddir
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

The new script uses "git submodule", which is picky about being invoked
from the top of the git checkout.  Invoke the script from $(SRC_PATH)
to avoid git's wrath.

Fixes: b7f404201e45e99da23b9764dec27ce5f965cdcd
Cc: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

---
 tests/docker/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 6f9ea19..b6d9fa3 100644
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
1.8.3.1
