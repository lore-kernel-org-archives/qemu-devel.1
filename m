Received: from eggs.gnu.org ([2001:4830:134:3::10]:44943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0007hL-JA
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zH-00067I-SR
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:07 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:46 +1100
Message-Id: <20180212034054.23441-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/12] cuda: don't allow writes to port output
 pins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Use the direction registers as a mask to ensure that only input pins are
updated upon write.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 6631017ca2..eaa8924f49 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -359,11 +359,11 @@ static void cuda_write(void *opaque, hwaddr addr, u=
int64_t val, unsigned size)
=20
     switch(addr) {
     case CUDA_REG_B:
-        s->b =3D val;
+        s->b =3D (s->b & ~s->dirb) | (val & s->dirb);
         cuda_update(s);
         break;
     case CUDA_REG_A:
-        s->a =3D val;
+        s->a =3D (s->a & ~s->dira) | (val & s->dira);
         break;
     case CUDA_REG_DIRB:
         s->dirb =3D val;
--=20
2.14.3
