Received: from eggs.gnu.org ([2001:4830:134:3::10]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPLGh-0001fd-VK
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPLGg-0006tf-VF
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cPLGg-0006tD-Lr
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:32:38 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  6 Jan 2017 11:32:23 +0800
Message-Id: <1483673544-10663-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1483673544-10663-1-git-send-email-jasowang@redhat.com>
References: <1483673544-10663-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] rtl8139: correctly handle PHY reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Jason Wang <jasowang@redhat.com>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

According to datasheet:
"[Bit 15 of Basic Mode Control Register] sets the status and control regi=
sters
of the PHY (register 0062-0074) in a default state. This bit is self-clea=
ring.
1 =3D software reset; 0 =3D normal operation."

This fixes the netcard detection failure in Minoca OS.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rtl8139.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index f05e59c..671c7e4 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -1205,6 +1205,20 @@ static void rtl8139_reset_rxring(RTL8139State *s, =
uint32_t bufferSize)
     s->RxBufAddr =3D 0;
 }
=20
+static void rtl8139_reset_phy(RTL8139State *s)
+{
+    s->BasicModeStatus  =3D 0x7809;
+    s->BasicModeStatus |=3D 0x0020; /* autonegotiation completed */
+    /* preserve link state */
+    s->BasicModeStatus |=3D qemu_get_queue(s->nic)->link_down ? 0 : 0x04=
;
+
+    s->NWayAdvert    =3D 0x05e1; /* all modes, full duplex */
+    s->NWayLPAR      =3D 0x05e1; /* all modes, full duplex */
+    s->NWayExpansion =3D 0x0001; /* autonegotiation supported */
+
+    s->CSCR =3D CSCR_F_LINK_100 | CSCR_HEART_BIT | CSCR_LD;
+}
+
 static void rtl8139_reset(DeviceState *d)
 {
     RTL8139State *s =3D RTL8139(d);
@@ -1256,25 +1270,14 @@ static void rtl8139_reset(DeviceState *d)
     s->Config3 =3D 0x1; /* fast back-to-back compatible */
     s->Config5 =3D 0x0;
=20
-    s->CSCR =3D CSCR_F_LINK_100 | CSCR_HEART_BIT | CSCR_LD;
-
     s->CpCmd   =3D 0x0; /* reset C+ mode */
     s->cplus_enabled =3D 0;
=20
-
 //    s->BasicModeCtrl =3D 0x3100; // 100Mbps, full duplex, autonegotiat=
ion
 //    s->BasicModeCtrl =3D 0x2100; // 100Mbps, full duplex
     s->BasicModeCtrl =3D 0x1000; // autonegotiation
=20
-    s->BasicModeStatus  =3D 0x7809;
-    //s->BasicModeStatus |=3D 0x0040; /* UTP medium */
-    s->BasicModeStatus |=3D 0x0020; /* autonegotiation completed */
-    /* preserve link state */
-    s->BasicModeStatus |=3D qemu_get_queue(s->nic)->link_down ? 0 : 0x04=
;
-
-    s->NWayAdvert    =3D 0x05e1; /* all modes, full duplex */
-    s->NWayLPAR      =3D 0x05e1; /* all modes, full duplex */
-    s->NWayExpansion =3D 0x0001; /* autonegotiation supported */
+    rtl8139_reset_phy(s);
=20
     /* also reset timer and disable timer interrupt */
     s->TCTR =3D 0;
@@ -1469,7 +1472,7 @@ static void rtl8139_BasicModeCtrl_write(RTL8139Stat=
e *s, uint32_t val)
     DPRINTF("BasicModeCtrl register write(w) val=3D0x%04x\n", val);
=20
     /* mask unwritable bits */
-    uint32_t mask =3D 0x4cff;
+    uint32_t mask =3D 0xccff;
=20
     if (1 || !rtl8139_config_writable(s))
     {
@@ -1479,6 +1482,11 @@ static void rtl8139_BasicModeCtrl_write(RTL8139Sta=
te *s, uint32_t val)
         mask |=3D 0x0100;
     }
=20
+    if (val & 0x8000) {
+        /* Reset PHY */
+        rtl8139_reset_phy(s);
+    }
+
     val =3D SET_MASKED(val, mask, s->BasicModeCtrl);
=20
     s->BasicModeCtrl =3D val;
--=20
2.7.4
