Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqrWr-0001La-Cj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 23:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqrWm-0005hi-ET
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 23:03:53 -0400
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:44187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqrWl-0005hA-6p
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 23:03:48 -0400
Received: by mail-vk0-x236.google.com with SMTP id 125-v6so4115856vke.11
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 20:03:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 18 Aug 2018 00:03:37 -0300
Message-Id: <20180818030337.22271-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: Clean dangling tarball files
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

When a container fails, it leaves a dangling tarball which name is
based on a timestamp. Further uses of make won't clean those files,
neither calling the 'docker-clean' target.

Use the .DELETE_ON_ERROR built-in target to let make remove those
temporary tarballs in case of failure.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index d3101afecd..6e03235ab9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -25,6 +25,7 @@ IMAGES ?= %
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
 
+.DELETE_ON_ERROR: $(DOCKER_SRC_COPY)
 $(DOCKER_SRC_COPY):
 	@mkdir $@
 	$(if $(SRC_ARCHIVE), \
-- 
2.18.0
