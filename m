Received: from eggs.gnu.org ([2001:4830:134:3::10]:54404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQy-0007tn-GM
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFKQu-0002BE-HO
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFKQu-0002B8-B7
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2935B83F40
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 13:10:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 May 2017 15:09:48 +0200
Message-Id: <20170529130956.20297-2-kraxel@redhat.com>
In-Reply-To: <20170529130956.20297-1-kraxel@redhat.com>
References: <20170529130956.20297-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] ehci: fix overflow in frame timer code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

In case the frame timer doesn't run for a while due to the host being
busy skipped_uframes can become big enough that UFRAME_TIMER_NS *
skipped_uframes overflows.  Which in turn throws off all subsequent
ehci frame timer calculations.

Reported-by: =E6=9D=8E=E6=9E=97 <8610_28@163.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170515104543.32044-1-kraxel@redhat.com
---
 hw/usb/hcd-ehci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 50ef817f93..d7361e570f 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2238,7 +2238,7 @@ static void ehci_frame_timer(void *opaque)
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
