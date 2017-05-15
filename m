Received: from eggs.gnu.org ([2001:4830:134:3::10]:59644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dADVj-0007iT-VI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dADVg-0001yK-M1
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dADVg-0001xe-AO
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:45:52 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 May 2017 12:45:43 +0200
Message-Id: <20170515104543.32044-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ehci: fix overflow in frame timer code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 8610_28@163.com, Gerd Hoffmann <kraxel@redhat.com>

In case the frame timer doesn't run for a while due to the host being
busy skipped_uframes can become big enough that UFRAME_TIMER_NS *
skipped_uframes overflows.  Which in turn throws off all subsequent
ehci frame timer calculations.

Reported-by: =E6=9D=8E=E6=9E=97 <8610_28@163.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 3703a8dddc..17c572c55f 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2238,7 +2238,7 @@ static void ehci_work_bh(void *opaque)
     int need_timer =3D 0;
     int64_t expire_time, t_now;
     uint64_t ns_elapsed;
-    int uframes, skipped_uframes;
+    uint64_t uframes, skipped_uframes;
     int i;
=20
     t_now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
--=20
2.9.3
