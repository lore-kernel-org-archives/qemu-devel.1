Received: from eggs.gnu.org ([2001:4830:134:3::10]:47525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibpX-0006ES-Pf
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibpU-0000Ow-Nw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:04:15 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:55 +0300
Message-Id: <3d74ee7dcae57b93a64737b954d76cf96236a367.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/14] lm32: milkymist-tmu2: fix a third integer
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

Don't truncate the multiplication and do a 64 bit one instead
because the result is stored in a 64 bit variable.

This fixes a similar coverity warning to commits 237a8650d640 and
4382fa655498, in a similar way, and is the final third of the fix for
coverity CID 1167561 (hopefully!).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Michael Walle <michael@walle.cc>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/display/milkymist-tmu2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 7528665..59120dd 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -293,7 +293,7 @@ static void tmu2_start(MilkymistTMU2State *s)
     cpu_physical_memory_unmap(mesh, mesh_len, 0, mesh_len);
=20
     /* Write back the OpenGL framebuffer to the QEMU framebuffer */
-    fb_len =3D 2 * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
+    fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
     fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 1);
     if (fb =3D=3D NULL) {
         glDeleteTextures(1, &texture);
--=20
2.1.4
