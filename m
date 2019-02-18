Received: from eggs.gnu.org ([209.51.188.92]:38688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwu-0005aW-Ir
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjwo-0002dV-7M
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:12 +1100
Message-Id: <20190218143049.17142-7-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/43] cuda: decrease time delay before raising
 VIA SR interrupt and remove fast path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In order to handle a race condition in the MacOS 9 CUDA driver, a
delay was introduced when raising the VIA SR interrupt inspired by
similar code in MacOnLinux.

During original testing of the MacOS 9 patches it was found that the
30us delay used in MacOnLinux did not work reliably within QEMU, and a
value of 300us was required to function correctly.

Recent experiments have shown two things: firstly when booting Linux,
MacOS 9 and MacOS X the fast path which bypasses the delay is never
triggered once the OS kernel is loaded making it effectively
useless. Rather than leave this code in place where a guest could
potentially enable it by accident and break itself, we might as well
just remove it.

Secondly the previous reliability issues are no longer present, and
this value can be reduced down to 20us with no apparent ill
effects. This has the benefit of considerably improving the
responsiveness of the ADB keyboard and mouse within the guest.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index c4f7a2f39b..3febacdd1e 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -97,17 +97,8 @@ static void cuda_set_sr_int(void *opaque)
=20
 static void cuda_delay_set_sr_int(CUDAState *s)
 {
-    MOS6522CUDAState *mcs =3D &s->mos6522_cuda;
-    MOS6522State *ms =3D MOS6522(mcs);
-    MOS6522DeviceClass *mdc =3D MOS6522_DEVICE_GET_CLASS(ms);
     int64_t expire;
=20
-    if (ms->dirb =3D=3D 0xff || s->sr_delay_ns =3D=3D 0) {
-        /* Disabled or not in Mac OS, fire the IRQ directly */
-        mdc->set_sr_int(ms);
-        return;
-    }
-
     trace_cuda_delay_set_sr_int();
=20
     expire =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
@@ -542,7 +533,7 @@ static void cuda_realize(DeviceState *dev, Error **er=
rp)
     s->tick_offset =3D (uint32_t)mktimegm(&tm) + RTC_OFFSET;
=20
     s->sr_delay_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_i=
nt, s);
-    s->sr_delay_ns =3D 300 * SCALE_US;
+    s->sr_delay_ns =3D 20 * SCALE_US;
=20
     s->adb_poll_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_adb_poll=
, s);
     s->adb_poll_mask =3D 0xffff;
--=20
2.20.1
