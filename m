Received: from eggs.gnu.org ([2001:4830:134:3::10]:45054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zP-0007kZ-9H
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006CT-Nz
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:53 +1100
Message-Id: <20180212034054.23441-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/12] cuda: factor out timebase-derived counter
 value and load time
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

Commit b981289c49 "PPC: Cuda: Use cuda timer to expose tbfreq to guest" a=
ltered
the timer calculations from those based upon the hardware CUDA clock freq=
uency
to those based upon the CPU timebase frequency.

In fact we can isolate the differences to 2 simple changes: one to the co=
unter
read value and another to the counter load time. Move these changes into
separate functions so the implementation can be swapped later.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e00df4a21a..a185252144 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -145,21 +145,29 @@ static void cuda_update_irq(CUDAState *s)
     }
 }
=20
-static uint64_t get_tb(uint64_t time, uint64_t freq)
+static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
 {
-    return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
+    /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup */
+    uint64_t tb_diff =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                                s->tb_frequency, NANOSECONDS_PER_SECOND)=
 -
+                           ti->load_time;
+
+    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
+}
+
+static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
+{
+    uint64_t load_time =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
),
+                                  s->tb_frequency, NANOSECONDS_PER_SECON=
D);
+    return load_time;
 }
=20
 static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
 {
     int64_t d;
     unsigned int counter;
-    uint64_t tb_diff;
-    uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
=20
-    /* Reverse of the tb calculation algorithm that Mac OS X uses on boo=
tup. */
-    tb_diff =3D get_tb(current_time, s->tb_frequency) - ti->load_time;
-    d =3D (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
+    d =3D get_counter_value(s, ti);
=20
     if (ti->index =3D=3D 0) {
         /* the timer goes down from latch to -1 (period of latch + 2) */
@@ -178,8 +186,7 @@ static unsigned int get_counter(CUDAState *s, CUDATim=
er *ti)
 static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
 {
     CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
-    ti->load_time =3D get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           s->tb_frequency);
+    ti->load_time =3D get_counter_load_time(s, ti);
     ti->counter_value =3D val;
     cuda_timer_update(s, ti, ti->load_time);
 }
--=20
2.14.3
