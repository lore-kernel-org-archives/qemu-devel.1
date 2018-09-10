Received: from eggs.gnu.org ([2001:4830:134:3::10]:55505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKX-0003I4-OT
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKU-0004rw-JK
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzDKU-0004rS-EP
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 11:57:19 +0800
Message-Id: <20180910035719.18056-6-famz@redhat.com>
In-Reply-To: <20180910035719.18056-1-famz@redhat.com>
References: <20180910035719.18056-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] docker: Clean dangling tarball files
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

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

When a container fails, it leaves a dangling tarball which name is
based on a timestamp. Further uses of make won't clean those files,
neither calling the 'docker-clean' target.

Use the .DELETE_ON_ERROR built-in target to let make remove those
temporary tarballs in case of failure.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180818030337.22271-1-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index d3101afecd..6e03235ab9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -25,6 +25,7 @@ IMAGES ?=3D %
 CUR_TIME :=3D $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY :=3D $(BUILD_DIR)/docker-src.$(CUR_TIME)
=20
+.DELETE_ON_ERROR: $(DOCKER_SRC_COPY)
 $(DOCKER_SRC_COPY):
 	@mkdir $@
 	$(if $(SRC_ARCHIVE), \
--=20
2.17.1
