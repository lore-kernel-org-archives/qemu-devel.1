Received: from eggs.gnu.org ([2001:4830:134:3::10]:60552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxq-0002Iz-W2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxn-0001By-Ro
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:07 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxn-0001B9-Np
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:03 -0400
Received: by mail-qt0-x231.google.com with SMTP id o9-v6so5102220qtp.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:36:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 12:35:33 -0300
Message-Id: <20180628153535.1411-3-f4bug@amsat.org>
In-Reply-To: <20180628153535.1411-1-f4bug@amsat.org>
References: <20180628153535.1411-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] tests/vm: Add a dependency to qemu-img
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

Before the first use, the VM image are resized with qemu-img.

Add a dependency to the qemu-img tool to fix:

  $ make vm-build-ubuntu.i386
  Traceback (most recent call last):
    File "source/qemu/tests/vm/basevm.py", line 236, in main
      return vm.build_image(args.image)
    File "tests/vm/ubuntu.i386", line 67, in build_image
      subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
  OSError: [Errno 2] No such file or directory
  tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386.img' failed
  make: *** [tests/vm/ubuntu.i386.img] Error 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 5daa2a3b73..e5e8146267 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -17,10 +17,13 @@ vm-test:
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
+$(IMAGE_FILES): qemu-img$(EXESUF)
+
 tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
 		$(SRC_PATH)/tests/vm/basevm.py \
 		$(SRC_PATH)/tests/vm/Makefile.include
 	$(call quiet-command, \
+		PATH=$(PATH):. \
 		$< \
 		$(if $(V)$(DEBUG), --debug) \
 		--image "$@" \
-- 
2.18.0
