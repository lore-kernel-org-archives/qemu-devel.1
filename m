Received: from eggs.gnu.org ([2001:4830:134:3::10]:46920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn2-0002pr-Ri
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn2-0007xc-2V
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:40 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:24 +0200
Message-Id: <20180612104430.25745-3-kraxel@redhat.com>
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/8] usb: correctly handle Zero Length Packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

USB Specification Revision 2.0, =C2=A75.5.3:
  The Data stage of a control transfer from an endpoint to the host is co=
mplete when the endpoint does one of the following:
  =E2=80=A2 Has transferred exactly the amount of data specified during t=
he Setup stage
  =E2=80=A2 Transfers a packet with a payload size less than wMaxPacketSi=
ze or transfers a zero-length packet"

hw/usb/redirect.c:802:9: warning: Declared variable-length array (VLA) ha=
s zero size
        uint8_t buf[size];
        ^~~~~~~~~~~ ~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180604151421.23385-2-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/redirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 65a9196c1a..58e8f7f5bd 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -795,7 +795,7 @@ static void usbredir_handle_bulk_data(USBRedirDevice =
*dev, USBPacket *p,
            usbredirparser_peer_has_cap(dev->parser,
                                        usb_redir_cap_32bits_bulk_length)=
);
=20
-    if (ep & USB_DIR_IN) {
+    if (ep & USB_DIR_IN || size =3D=3D 0) {
         usbredirparser_send_bulk_packet(dev->parser, p->id,
                                         &bulk_packet, NULL, 0);
     } else {
--=20
2.9.3
