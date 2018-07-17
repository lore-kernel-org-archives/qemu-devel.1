Received: from eggs.gnu.org ([2001:4830:134:3::10]:40971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4z-00039p-94
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4v-0004mR-Fn
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4v-0004lb-8X
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id j5-v6so2374720wrr.8
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:56:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:44 +0100
Message-Id: <20180717195553.9111-10-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 09/18] docker: disable
 debian-powerpc-user-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

While we can build we can't run the unit tests due to a missing system
call (249 - swapcontext). This could be a code generation issue as
other architectures don't seem to have this system call.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
---
 tests/docker/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 09fb7db7fa..fe63aacf69 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -140,6 +140,9 @@ docker-binfmt-image-debian-powerpc-user: QEMU_TARGET = ppc-linux-user
 docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
 docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES += debian-powerpc-user
+# Unfortunalty while we can build with this image we can't run unit
+# tests due to missing system call: 249 which causes an abort
+DOCKER_PARTIAL_IMAGES += debian-powerpc-user-cross
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
-- 
2.17.1
