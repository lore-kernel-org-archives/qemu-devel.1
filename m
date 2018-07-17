Received: from eggs.gnu.org ([2001:4830:134:3::10]:42617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffWBY-0000cm-6R
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffWBX-0001je-9O
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:03:00 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffWBX-0001j1-23
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:02:59 -0400
Received: by mail-wm0-x235.google.com with SMTP id a19-v6so566036wmb.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:02:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:48 +0100
Message-Id: <20180717195553.9111-14-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 13/18] docker: add --hint to
 docker.py check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

When a check fails we currently just report why we failed. This is not
totally helpful to people who want to boot-strap a new image. Add a
--hint option which we can pass down to give a bit more information.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include | 3 ++-
 tests/docker/docker.py        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ec23620153..c9e412f9d0 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -73,7 +73,8 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
 			"BUILD","binfmt debian-$* (debootstrapped)"),		\
 		$(call quiet-command,						\
-			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<,	\
+			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<	\
+			--hint "you will need to build $(EXECUTABLE)",		\
 			"CHECK", "debian-$* exists"))
 
 endif
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 2f81c6b13b..523f4b95a2 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -475,6 +475,7 @@ class CheckCommand(SubCommand):
                             default="checksum", help="check type")
         parser.add_argument("--olderthan", default=60, type=int,
                             help="number of minutes")
+        parser.add_argument("--hint", default="", help="hint to user")
 
     def run(self, args, argv):
         tag = args.tag
@@ -487,7 +488,7 @@ class CheckCommand(SubCommand):
 
         info = dkr.inspect_tag(tag)
         if info is None:
-            print("Image does not exist")
+            print("Image does not exist %s" % (args.hint))
             return 1
 
         if args.checktype == "checksum":
-- 
2.17.1
