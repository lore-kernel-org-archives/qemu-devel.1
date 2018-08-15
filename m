Received: from eggs.gnu.org ([2001:4830:134:3::10]:56968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFQ-0007AH-C4
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFO-0001Cw-TY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFK-00017j-Hl
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:40 +0800
Message-Id: <20180815031248.14908-10-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/17] tests: Allow overriding archive path with
 SRC_ARCHIVE
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

In VM based tests, the source archive is created in host, we don't have
to run archive-source.sh again, as it complicates the Makefile and
scripts.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180712012829.20231-4-famz@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 1aaa795743..d3101afecd 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -27,8 +27,11 @@ DOCKER_SRC_COPY :=3D $(BUILD_DIR)/docker-src.$(CUR_TIM=
E)
=20
 $(DOCKER_SRC_COPY):
 	@mkdir $@
-	$(call quiet-command, cd $(SRC_PATH) && scripts/archive-source.sh $@/qe=
mu.tar, \
-		"GEN", "$@/qemu.tar")
+	$(if $(SRC_ARCHIVE), \
+		$(call quiet-command, cp "$(SRC_ARCHIVE)" $@/qemu.tar, \
+			"CP", "$@/qemu.tar"), \
+		$(call quiet-command, cd $(SRC_PATH) && scripts/archive-source.sh $@/q=
emu.tar, \
+			"GEN", "$@/qemu.tar"))
 	$(call quiet-command, cp $(SRC_PATH)/tests/docker/run $@/run, \
 		"COPY","RUNNER")
=20
--=20
2.17.1
