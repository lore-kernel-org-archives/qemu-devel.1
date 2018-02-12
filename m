Received: from eggs.gnu.org ([2001:4830:134:3::10]:45015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zO-0007jW-A4
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006Be-C8
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:50 +1100
Message-Id: <20180212034054.23441-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/12] cuda: minor cosmetic tidy-ups to
 get_next_irq_time()
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index d4a52fbddb..729905236c 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -184,36 +184,37 @@ static void set_counter(CUDAState *s, CUDATimer *ti=
, unsigned int val)
     cuda_timer_update(s, ti, ti->load_time);
 }
=20
-static int64_t get_next_irq_time(CUDATimer *s, int64_t current_time)
+static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
 {
     int64_t d, next_time;
     unsigned int counter;
=20
     /* current counter value */
-    d =3D muldiv64(current_time - s->load_time,
+    d =3D muldiv64(current_time - ti->load_time,
                  CUDA_TIMER_FREQ, NANOSECONDS_PER_SECOND);
     /* the timer goes down from latch to -1 (period of latch + 2) */
-    if (d <=3D (s->counter_value + 1)) {
-        counter =3D (s->counter_value - d) & 0xffff;
+    if (d <=3D (ti->counter_value + 1)) {
+        counter =3D (ti->counter_value - d) & 0xffff;
     } else {
-        counter =3D (d - (s->counter_value + 1)) % (s->latch + 2);
-        counter =3D (s->latch - counter) & 0xffff;
+        counter =3D (d - (ti->counter_value + 1)) % (ti->latch + 2);
+        counter =3D (ti->latch - counter) & 0xffff;
     }
=20
     /* Note: we consider the irq is raised on 0 */
     if (counter =3D=3D 0xffff) {
-        next_time =3D d + s->latch + 1;
+        next_time =3D d + ti->latch + 1;
     } else if (counter =3D=3D 0) {
-        next_time =3D d + s->latch + 2;
+        next_time =3D d + ti->latch + 2;
     } else {
         next_time =3D d + counter;
     }
     CUDA_DPRINTF("latch=3D%d counter=3D%" PRId64 " delta_next=3D%" PRId6=
4 "\n",
-                 s->latch, d, next_time - d);
+                 ti->latch, d, next_time - d);
     next_time =3D muldiv64(next_time, NANOSECONDS_PER_SECOND, CUDA_TIMER=
_FREQ) +
-        s->load_time;
-    if (next_time <=3D current_time)
+                         ti->load_time;
+    if (next_time <=3D current_time) {
         next_time =3D current_time + 1;
+    }
     return next_time;
 }
=20
--=20
2.14.3
