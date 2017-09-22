Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIh5-0000Il-9l
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIh1-0001Fx-0a
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIh0-0001Fh-RU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:58 +0800
Message-Id: <20170922074659.30097-36-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/36] docker: Use archive-source.py
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

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 14 ++------------
 tests/docker/run              |  8 +-------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 2bed4c0e00..0e4f159619 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -17,23 +17,13 @@ DOCKER_TOOLS :=3D travis
 TESTS ?=3D %
 IMAGES ?=3D %
=20
-# Make archive from git repo $1 to tar.gz $2
-make-archive-maybe =3D $(if $(wildcard $1/*), \
-	$(call quiet-command, \
-		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
-			git archive -1 HEAD --format=3Dtar.gz; \
-		else \
-			git archive -1 $$(git stash create) --format=3Dtar.gz; \
-		fi) > $2, \
-		"ARCHIVE","$(notdir $2)"))
-
 CUR_TIME :=3D $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY :=3D docker-src.$(CUR_TIME)
=20
 $(DOCKER_SRC_COPY):
 	@mkdir $@
-	$(call make-archive-maybe, $(SRC_PATH), $@/qemu.tgz)
-	$(call make-archive-maybe, $(SRC_PATH)/dtc, $@/dtc.tgz)
+	$(call quiet-command, $(SRC_PATH)/scripts/archive-source.sh $@/qemu.tar=
, \
+		"GEN", "$@/qemu.tar")
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
 		"COPY","RUNNER")
=20
diff --git a/tests/docker/run b/tests/docker/run
index ec2541cbd9..52b76e443d 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -32,13 +32,7 @@ export TEST_DIR=3D/tmp/qemu-test
 mkdir -p $TEST_DIR/{src,build,install}
=20
 # Extract the source tarballs
-tar -C $TEST_DIR/src -xzf $BASE/qemu.tgz
-for p in dtc pixman; do
-    if test -f $BASE/$p.tgz; then
-        tar -C $TEST_DIR/src/$p -xzf $BASE/$p.tgz
-        export FEATURES=3D"$FEATURES $p"
-    fi
-done
+tar -C $TEST_DIR/src -xf $BASE/qemu.tar
=20
 if test -n "$SHOW_ENV"; then
     if test -f /packages.txt; then
--=20
2.13.5
