Received: from eggs.gnu.org ([209.51.188.92]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXcQ-0002Wc-LR
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXcP-0000zE-MY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:56:18 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:50 +0100
Message-Id: <20190129175403.18017-6-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/18] qemu-iotests: Add dependency to
 qemu-nbd tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Since a9660664fde, some iotests use qemu-nbd.
Add a dependency to build it before using it.
This fixes:

  $ gmake check-block
          CHK version_gen.h
    GEN     qemu-img-cmds.h
    CC      qemu-img.o
    LINK    qemu-img
    CC      qemu-io.o
    LINK    qemu-io
  tests/qemu-iotests-quick.sh
  tests/qemu-iotests-quick.sh[6]: ./check: No such file or directory
  gmake: *** [/tmp/qemu-test.9GLXBk/tests/Makefile.include:1059: check-te=
sts/qemu-iotests-quick.sh] Error 1

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
On Linux, qemu-iotests-quick.sh is a bit less cryptic:

  $ gmake check-block
    GEN     qemu-img-cmds.h
    CC      qemu-img.o
    LINK    qemu-img
    CC      qemu-io.o
    LINK    qemu-io
    CC      tests/qemu-iotests/socket_scm_helper.o
    LINK    tests/qemu-iotests/socket_scm_helper
  /home/phil/source/qemu/tests/qemu-iotests-quick.sh
  check: qemu-nbd not found
  gmake: *** [/home/phil/source/qemu/tests/Makefile.include:1059: check-t=
ests/qemu-iotests-quick.sh] Error 1
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5e03416c81..3c0850704d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1055,7 +1055,7 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D =
tests/qemu-iotests/socket_scm_helper$(EXESUF)
=20
 .PHONY: check-tests/qemu-iotests-quick.sh
-check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 	$<
=20
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
--=20
2.20.1
