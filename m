Received: from eggs.gnu.org ([2001:4830:134:3::10]:45001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zN-0007ib-J6
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006Bp-ED
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:48 +1100
Message-Id: <20180212034054.23441-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/12] cuda: introduce CUDAState parameter to
 get_counter()
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

This will be required shortly and also happens to match nicely with the
corresponding signature for set_counter().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index eaa8924f49..fa10b6d0c1 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -150,7 +150,7 @@ static uint64_t get_tb(uint64_t time, uint64_t freq)
     return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
 }
=20
-static unsigned int get_counter(CUDATimer *ti)
+static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
 {
     int64_t d;
     unsigned int counter;
@@ -295,12 +295,12 @@ static uint64_t cuda_read(void *opaque, hwaddr addr=
, unsigned size)
         val =3D s->dira;
         break;
     case CUDA_REG_T1CL:
-        val =3D get_counter(&s->timers[0]) & 0xff;
+        val =3D get_counter(s, &s->timers[0]) & 0xff;
         s->ifr &=3D ~T1_INT;
         cuda_update_irq(s);
         break;
     case CUDA_REG_T1CH:
-        val =3D get_counter(&s->timers[0]) >> 8;
+        val =3D get_counter(s, &s->timers[0]) >> 8;
         cuda_update_irq(s);
         break;
     case CUDA_REG_T1LL:
@@ -311,12 +311,12 @@ static uint64_t cuda_read(void *opaque, hwaddr addr=
, unsigned size)
         val =3D (s->timers[0].latch >> 8) & 0xff;
         break;
     case CUDA_REG_T2CL:
-        val =3D get_counter(&s->timers[1]) & 0xff;
+        val =3D get_counter(s, &s->timers[1]) & 0xff;
         s->ifr &=3D ~T2_INT;
         cuda_update_irq(s);
         break;
     case CUDA_REG_T2CH:
-        val =3D get_counter(&s->timers[1]) >> 8;
+        val =3D get_counter(s, &s->timers[1]) >> 8;
         break;
     case CUDA_REG_SR:
         val =3D s->sr;
--=20
2.14.3
