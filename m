Received: from eggs.gnu.org ([209.51.188.92]:37382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2S-0005kR-JR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz2O-0006Nl-QB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz2H-0006Fj-4p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:50 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:18 +0200
Message-Id: <20190423171520.4511-11-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/12] tests: add missing dependency to build
 QTEST_QEMU_BINARY, round 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

In commit b94b330e2333 ("tests: add missing dependency to build
QTEST_QEMU_BINARY", 2017-07-31), Phil fixed the dependency list of make
target "check-qtest-%". Namely, the recipe would set QTEST_QEMU_BINARY to
the softmmu emulator for the emulation target, but the prerequisites
didn't include the emulator.

The same issue affects the "check-report-qtest-%.tap" make target, which
is the other make target whose recipe sets QTEST_QEMU_BINARY:

> $ make -j4 check-report-qtest-aarch64.tap
>   TAP     check-report-qtest-aarch64.tap
> sh: /.../aarch64-softmmu/qemu-system-aarch64: No such file or directory

Apply Phil's fix to this make target too.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Phil's R-b / T-b
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Michal's R-b
   =20
    - pick up Igor's T-b
   =20
    - pick up Michael's R-b
   =20
    v2:
   =20
    - new patch, relied upon by the next patch

 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 36fc73fef55a..e2432d5e7712 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -912,7 +912,7 @@ check-speed: $(check-speed-y)
=20
 # gtester tests with TAP output
=20
-$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: $(check-qtest-y)
+$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: subdir-%-softmmu $(check-qtest-y)
 	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
 	  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 	  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
--=20
2.19.1.3.g30247aa5d201
