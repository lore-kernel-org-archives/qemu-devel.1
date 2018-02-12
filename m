Received: from eggs.gnu.org ([2001:4830:134:3::10]:45031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zO-0007jp-Jj
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006Bv-Hf
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:49 +1100
Message-Id: <20180212034054.23441-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/12] cuda: rename frequency property to
 tb_frequency
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

This allows us to more easily differentiate between the timebase frequenc=
y used
to calibrate the MacOS timers and the actual frequency of the hardware cl=
ock as
indicated by CUDA_TIMER_FREQ.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[dwg: Revert some extraneous changes which break compile]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c  | 6 +++---
 hw/misc/macio/macio.c | 2 +-
 hw/ppc/mac.h          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index fa10b6d0c1..d4a52fbddb 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -179,7 +179,7 @@ static void set_counter(CUDAState *s, CUDATimer *ti, =
unsigned int val)
 {
     CUDA_DPRINTF("T%d.counter=3D%d\n", 1 + ti->index, val);
     ti->load_time =3D get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           s->frequency);
+                           s->tb_frequency);
     ti->counter_value =3D val;
     cuda_timer_update(s, ti, ti->load_time);
 }
@@ -879,7 +879,7 @@ static void cuda_realizefn(DeviceState *dev, Error **=
errp)
     struct tm tm;
=20
     s->timers[0].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer1,=
 s);
-    s->timers[0].frequency =3D s->frequency;
+    s->timers[0].frequency =3D s->tb_frequency;
     s->timers[1].timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer2,=
 s);
     s->timers[1].frequency =3D (SCALE_US * 6000) / 4700;
=20
@@ -910,7 +910,7 @@ static void cuda_initfn(Object *obj)
 }
=20
 static Property cuda_properties[] =3D {
-    DEFINE_PROP_UINT64("frequency", CUDAState, frequency, 0),
+    DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0)=
,
     DEFINE_PROP_END_OF_LIST()
 };
=20
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 44f91d1e7f..a639b09e00 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -451,7 +451,7 @@ void macio_init(PCIDevice *d,
     macio_state->escc_mem =3D escc_mem;
     /* Note: this code is strongly inspirated from the corresponding cod=
e
        in PearPC */
-    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "frequency",
+    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency=
",
                          macio_state->frequency);
=20
     qdev_init_nofail(DEVICE(d));
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index b501af1653..fa78115c95 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -99,7 +99,7 @@ typedef struct CUDAState {
     CUDATimer timers[2];
=20
     uint32_t tick_offset;
-    uint64_t frequency;
+    uint64_t tb_frequency;
=20
     uint8_t last_b;
     uint8_t last_acr;
--=20
2.14.3
