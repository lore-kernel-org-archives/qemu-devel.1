Received: from eggs.gnu.org ([208.118.235.92]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gf4Bo-0001M6-Pn
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gf4Bn-0003PC-1I
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:41:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  3 Jan 2019 14:41:24 +0000
Message-Id: <20190103144124.18917-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jim@groklearning.com, jusual@mail.ru, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.

The generic loader device (-device loader,file=3Dkernel.bin) can be used
to load a kernel instead of the -kernel option.  Some boards have flash
memory (pflash) that is set via the -pflash or -drive options.

Allow starting QEMU without the -kernel option to accommodate these
scenarios.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/armv7m.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 4bf9131b81..f444652830 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -285,11 +285,6 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *ker=
nel_filename, int mem_size)
     big_endian =3D 0;
 #endif
=20
-    if (!kernel_filename && !qtest_enabled()) {
-        error_report("Guest image must be specified (using -kernel)");
-        exit(1);
-    }
-
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         asidx =3D ARMASIdx_S;
     } else {
--=20
2.20.1
