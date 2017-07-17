Received: from eggs.gnu.org ([2001:4830:134:3::10]:47843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LM-0001Mp-P6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gY-9t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gE-1V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:28 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:29:22 +0200
Message-Id: <20170717092923.12317-3-kraxel@redhat.com>
In-Reply-To: <20170717092923.12317-1-kraxel@redhat.com>
References: <20170717092923.12317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] audio/fmopl: modify timer callback to give
 opaque and channel parameters in two arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170621043401.19842-2-hpoussin@reactos.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h |  7 ++++---
 hw/audio/adlib.c |  2 +-
 hw/audio/fmopl.c | 18 +++++++++++++-----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index fc9f16b58a..f4065f425c 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -3,7 +3,7 @@
=20
 #include <stdint.h>
=20
-typedef void (*OPL_TIMERHANDLER)(int channel,double interval_Sec);
+typedef void (*OPL_TIMERHANDLER)(void *param, int channel, double interv=
al_Sec);
=20
 /* !!!!! here is private section , do not access there member direct !!!=
!! */
=20
@@ -87,13 +87,14 @@ typedef struct fm_opl_f {
 	uint8_t wavesel;
 	/* external event callback handler */
 	OPL_TIMERHANDLER  TimerHandler;		/* TIMER handler   */
-	int TimerParam;						/* TIMER parameter */
+    void *TimerParam; /* TIMER parameter */
 } FM_OPL;
=20
 /* ---------- Generic interface section ---------- */
 FM_OPL *OPLCreate(int clock, int rate);
 void OPLDestroy(FM_OPL *OPL);
-void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int ch=
annelOffset);
+void OPLSetTimerHandler(FM_OPL *OPL, OPL_TIMERHANDLER TimerHandler,
+                        void *param);
=20
 int OPLWrite(FM_OPL *OPL,int a,int v);
 unsigned char OPLRead(FM_OPL *OPL,int a);
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index c6e0f10c16..be4203476a 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -130,7 +130,7 @@ static uint32_t adlib_read(void *opaque, uint32_t npo=
rt)
     return data;
 }
=20
-static void timer_handler (int c, double interval_Sec)
+static void timer_handler (void *opaque, int c, double interval_Sec)
 {
     AdlibState *s =3D glob_adlib;
     unsigned n =3D c & 1;
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 202f752c5d..5cfb6a96dd 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -788,14 +788,18 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
 				{
 					double interval =3D st2 ? (double)OPL->T[1]*OPL->TimerBase : 0.0;
 					OPL->st[1] =3D st2;
-					if (OPL->TimerHandler) (OPL->TimerHandler)(OPL->TimerParam+1,interv=
al);
+                    if (OPL->TimerHandler) {
+                        (OPL->TimerHandler)(OPL->TimerParam, 1, interval=
);
+                    }
 				}
 				/* timer 1 */
 				if(OPL->st[0] !=3D st1)
 				{
 					double interval =3D st1 ? (double)OPL->T[0]*OPL->TimerBase : 0.0;
 					OPL->st[0] =3D st1;
-					if (OPL->TimerHandler) (OPL->TimerHandler)(OPL->TimerParam+0,interv=
al);
+                    if (OPL->TimerHandler) {
+                        (OPL->TimerHandler)(OPL->TimerParam, 0, interval=
);
+                    }
 				}
 			}
 			return;
@@ -1128,10 +1132,11 @@ void OPLDestroy(FM_OPL *OPL)
=20
 /* ----------  Option handlers ----------       */
=20
-void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int ch=
annelOffset)
+void OPLSetTimerHandler(FM_OPL *OPL, OPL_TIMERHANDLER TimerHandler,
+                        void *param)
 {
 	OPL->TimerHandler   =3D TimerHandler;
-	OPL->TimerParam =3D channelOffset;
+    OPL->TimerParam =3D param;
 }
=20
 /* ---------- YM3812 I/O interface ---------- */
@@ -1197,6 +1202,9 @@ int OPLTimerOver(FM_OPL *OPL,int c)
 		}
 	}
 	/* reload timer */
-	if (OPL->TimerHandler) (OPL->TimerHandler)(OPL->TimerParam+c,(double)OP=
L->T[c]*OPL->TimerBase);
+    if (OPL->TimerHandler) {
+        (OPL->TimerHandler)(OPL->TimerParam, c,
+                            (double)OPL->T[c] * OPL->TimerBase);
+    }
 	return OPL->status>>7;
 }
--=20
2.9.3
