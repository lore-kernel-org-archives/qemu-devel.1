Received: from eggs.gnu.org ([2001:4830:134:3::10]:36901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytr-0005yy-4L
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6Ytq-0005af-5l
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6Ytp-0005aI-Uz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 05:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15D915F7BE
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:19:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 11:19:44 +0200
Message-Id: <20171023091947.20771-7-kraxel@redhat.com>
In-Reply-To: <20171023091947.20771-1-kraxel@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] ps2: fix scancodess sent for Pause key in
 AT set 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The ps2 device was previously fixed to send the special Pause/Print
scancode sequences in:

  commit 8c10e0baf0260b59a4e984744462a18016662e3e
  Author: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
  Date:   Thu Sep 15 22:06:26 2016 +0200

    ps2: use QEMU qcodes instead of scancodes

The sequence used for Pause had a small typo in the AT set 1, with a 0xe1
accidentally changed to 0x91.  This is not immediately visible with Linux
guests since they run the ps2 device with AT set 2 scancodes.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20171019142848.572-7-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index c35b410e4d..133cc2aa64 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -645,7 +645,7 @@ static void ps2_keyboard_event(DeviceState *dev, Qemu=
Console *src,
                 ps2_put_keycode(s, 0xe1);
                 ps2_put_keycode(s, 0x1d);
                 ps2_put_keycode(s, 0x45);
-                ps2_put_keycode(s, 0x91);
+                ps2_put_keycode(s, 0xe1);
                 ps2_put_keycode(s, 0x9d);
                 ps2_put_keycode(s, 0xc5);
             }
--=20
2.9.3
