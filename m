Received: from eggs.gnu.org ([2001:4830:134:3::10]:32853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3N8-0004DQ-JX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3N3-0000DF-Qy
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3N3-0000CZ-LB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:13:45 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:12:01 +0800
Message-Id: <20170905021201.25684-13-famz@redhat.com>
In-Reply-To: <20170905021201.25684-1-famz@redhat.com>
References: <20170905021201.25684-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 12/12] docker: Use archive-source.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 15 ++-------------
 tests/docker/run              |  8 +-------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaab1a4208..7a027d5bd6 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -17,24 +17,13 @@ DOCKER_TOOLS := travis
 TESTS ?= %
 IMAGES ?= %
 
-# Make archive from git repo $1 to tar.gz $2
-make-archive-maybe = $(if $(wildcard $1/*), \
-	$(call quiet-command, \
-		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
-			git archive -1 HEAD --format=tar.gz; \
-		else \
-			git archive -1 $$(git stash create) --format=tar.gz; \
-		fi) > $2, \
-		"ARCHIVE","$(notdir $2)"))
-
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := docker-src.$(CUR_TIME)
 
 $(DOCKER_SRC_COPY):
 	@mkdir $@
-	$(call make-archive-maybe, $(SRC_PATH), $@/qemu.tgz)
-	$(call make-archive-maybe, $(SRC_PATH)/dtc, $@/dtc.tgz)
-	$(call make-archive-maybe, $(SRC_PATH)/pixman, $@/pixman.tgz)
+	$(call quiet-command, $(SRC_PATH)/scripts/archive-source.sh $@/qemu.tar, \
+		"GEN", "$@/qemu.tar")
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
 		"COPY","RUNNER")
 
diff --git a/tests/docker/run b/tests/docker/run
index c1e4513bce..9eb9165f76 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -32,13 +32,7 @@ export TEST_DIR=/tmp/qemu-test
 mkdir -p $TEST_DIR/{src,build,install}
 
 # Extract the source tarballs
-tar -C $TEST_DIR/src -xzf $BASE/qemu.tgz
-for p in dtc pixman; do
-    if test -f $BASE/$p.tgz; then
-        tar -C $TEST_DIR/src/$p -xzf $BASE/$p.tgz
-        export FEATURES="$FEATURES $p"
-    fi
-done
+tar -C $TEST_DIR/src -xf $BASE/qemu.tar
 
 if test -n "$SHOW_ENV"; then
     if test -f /packages.txt; then
-- 
2.13.5
