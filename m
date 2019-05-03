Received: from eggs.gnu.org ([209.51.188.92]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAt-0003nt-2H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAs-0006Gb-0C
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hMSAr-0006FL-Qh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:01 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  3 May 2019 08:59:54 +0200
Message-Id: <20190503065954.17069-8-kraxel@redhat.com>
In-Reply-To: <20190503065954.17069-1-kraxel@redhat.com>
References: <20190503065954.17069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] hw/usb: avoid format truncation warning
 when formatting port name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

hw/usb/hcd-xhci.c: In function =E2=80=98usb_xhci_realize=E2=80=99:
hw/usb/hcd-xhci.c:3339:66: warning: =E2=80=98%d=E2=80=99 directive output=
 may be truncated writing between 1 and 10 bytes into a region of size 5 =
[-Wformat-trunca\
tion=3D]
 3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #=
%d", i+1);
      |                                                                  =
^~
hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 2147=
483647]
 3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #=
%d", i+1);
      |                                                      ^~~~~~~~~~~~=
~~~

The xhci code formats the port name into a fixed length
buffer which is only large enough to hold port numbers
upto 5 digits in decimal representation. We're never
going to have a port number that large, so aserting the
port number is sensible is sufficient to tell GCC the
formatted string won't be truncated.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190412121626.19829-5-berrange@redhat.com>

[ kraxel: also s/int/unsigned int/ to tell gcc they can't
          go negative. ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d8472b4fea7f..2e9a839f2bf9 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3306,7 +3306,7 @@ static void usb_xhci_init(XHCIState *xhci)
 {
     DeviceState *dev =3D DEVICE(xhci);
     XHCIPort *port;
-    int i, usbports, speedmask;
+    unsigned int i, usbports, speedmask;
=20
     xhci->usbsts =3D USBSTS_HCH;
=20
@@ -3336,6 +3336,7 @@ static void usb_xhci_init(XHCIState *xhci)
                 USB_SPEED_MASK_LOW  |
                 USB_SPEED_MASK_FULL |
                 USB_SPEED_MASK_HIGH;
+            assert(i < MAXPORTS);
             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+=
1);
             speedmask |=3D port->speedmask;
         }
@@ -3349,6 +3350,7 @@ static void usb_xhci_init(XHCIState *xhci)
             }
             port->uport =3D &xhci->uports[i];
             port->speedmask =3D USB_SPEED_MASK_SUPER;
+            assert(i < MAXPORTS);
             snprintf(port->name, sizeof(port->name), "usb3 port #%d", i+=
1);
             speedmask |=3D port->speedmask;
         }
--=20
2.18.1
