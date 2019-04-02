Received: from eggs.gnu.org ([209.51.188.92]:51223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDQp-0000rc-0o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBDQn-0005bJ-1Y
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBDC0-0005Qi-L3
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 02:46:44 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  2 Apr 2019 08:46:36 +0200
Message-Id: <20190402064639.27108-3-kraxel@redhat.com>
In-Reply-To: <20190402064639.27108-1-kraxel@redhat.com>
References: <20190402064639.27108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] hw/usb/bus.c: Handle "no speed matched"
 case in usb_mask_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In usb_mask_to_str() we convert a mask of USB speeds into
a human-readable string (like "full+high") for use in
tracing and error messages. However the conversion code
doesn't do anything to the string buffer if the passed in
speedmask doesn't match any of the recognized speeds,
which means that the tracing and error messages will
end up with random garbage in them. This can happen if
we're doing USB device passthrough.

Handle the "unrecognized speed" case by using the
string "unknown".

Fixes: https://bugs.launchpad.net/qemu/+bug/1603785
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20190328133503.6490-1-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 6fffab7bfa44..9a74dc956010 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -500,6 +500,10 @@ static void usb_mask_to_str(char *dest, size_t size,
                             speeds[i].name);
         }
     }
+
+    if (pos =3D=3D 0) {
+        snprintf(dest, size, "unknown");
+    }
 }
=20
 void usb_check_attach(USBDevice *dev, Error **errp)
--=20
2.18.1
