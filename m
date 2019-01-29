Received: from eggs.gnu.org ([209.51.188.92]:34653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXby-0002AM-Q7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXbw-0000iX-T9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:55:50 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:49 +0100
Message-Id: <20190129175403.18017-5-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/18] ahci-test: Add dependency to qemu-img
 tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, John Snow <jsnow@redhat.com>

Since the ahci-test uses qemu-img, add a dependency to build it
before using it.
This fixes:

  $ gmake check-qtest V=3D1
  QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3D=
qemu-img tests/ahci-test
  Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No su=
ch file or directory)
  ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)

Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Slighly related is when vm-tests expect qemu-img available:
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html

  $ make vm-build-ubuntu.i386
  Traceback (most recent call last):
    File "source/qemu/tests/vm/basevm.py", line 236, in main
      return vm.build_image(args.image)
    File "tests/vm/ubuntu.i386", line 67, in build_image
      subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
  OSError: [Errno 2] No such file or directory
  tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386.i=
mg' failed
  make: *** [tests/vm/ubuntu.i386.img] Error 2

A better fix would be checking those tools via ./configure...
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 19b4c0a696..5e03416c81 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -706,7 +706,7 @@ tests/prom-env-test$(EXESUF): tests/prom-env-test.o $=
(libqos-obj-y)
 tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
 tests/fdc-test$(EXESUF): tests/fdc-test.o
 tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
-tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
+tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$=
(EXESUF)
 tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
 tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
 tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
--=20
2.20.1
