Received: from eggs.gnu.org ([2001:4830:134:3::10]:47134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eH9Uh-0007hX-EQ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eH9Ue-00011O-6n
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eH9Ue-00010v-0C
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:25:44 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 21 Nov 2017 14:25:38 +0000
Message-Id: <20171121142538.22072-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Developers sometimes mistakenly run 'make test' instead of 'make check'.
'make test' triggers the ancient, unmaintained tcg unit tests in
tests/tcg/Makefile which have long since ceased compiling.

Even if someone fixes the TCG tests, it makes little sense to put
them in a 'make test' target, rather they should be 'make check-tcg',
possibly wired up as a dependency of 'make check'.

In the meantime, this patch disarms the 'make test' trap by simply
deleting it so users get an immediate error. This should be enough
for them to remember to type 'make check' instead (or 'make help'
to learn). It also deletes 'make speed' which is another route
into the tcg tests.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---

Changed in v2:

 - Remove 'test' & 'speed' targets, instead of making 'test'
   a synonym for 'check'

 Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index d2e31d98af..ab0354c153 100644
--- a/Makefile
+++ b/Makefile
@@ -253,7 +253,7 @@ Makefile: ;
 configure: ;
 
 .PHONY: all clean cscope distclean html info install install-doc \
-	pdf txt recurse-all speed test dist msi FORCE
+	pdf txt recurse-all dist msi FORCE
 
 $(call set-vpath, $(SRC_PATH))
 
@@ -716,10 +716,6 @@ endif
 	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
         done
 
-# various test targets
-test speed: all
-	$(MAKE) -C tests/tcg $@
-
 .PHONY: ctags
 ctags:
 	rm -f tags
-- 
2.14.3
