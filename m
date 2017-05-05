Received: from eggs.gnu.org ([2001:4830:134:3::10]:59670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6TqU-0007NR-Mo
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6TqT-0007pN-BQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6TqT-0007p9-5i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 May 2017 11:23:36 +0800
Message-Id: <20170505032340.26467-2-famz@redhat.com>
In-Reply-To: <20170505032340.26467-1-famz@redhat.com>
References: <20170505032340.26467-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] docker: Run tests with current user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We've used --add-current-user to create a user in the image, use it to
run tests, because root has too much priviledge, and can surprise test
cases.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 03eda37..0ed8c3d 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -126,7 +126,7 @@ docker-run: docker-qemu-src
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
 		$(SRC_PATH)/tests/docker/docker.py run 			\
-			-t 						\
+			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-i,--net=none) 			\
 			-e TARGET_LIST=$(TARGET_LIST) 			\
-- 
2.9.3
