Received: from eggs.gnu.org ([2001:4830:134:3::10]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3N-00041g-3a
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3K-00063g-Mm
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:52:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA3K-00063a-Gz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:52:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:25 +0800
Message-Id: <20170526075246.20265-2-famz@redhat.com>
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/22] docker: Run tests with current user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

We've used --add-current-user to create a user in the image, use it to
run tests, because root has too much priviledge, and can surprise test
cases.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170505032340.26467-2-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
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
 			$(if $(DEBUG),-i,--net=3Dnone) 			\
 			-e TARGET_LIST=3D$(TARGET_LIST) 			\
--=20
2.9.4
