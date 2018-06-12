Received: from eggs.gnu.org ([2001:4830:134:3::10]:46924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn3-0002qN-2u
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn2-0007xi-2F
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:41 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:25 +0200
Message-Id: <20180612104430.25745-4-kraxel@redhat.com>
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/8] usb/dev-mtp: Fix use of uninitialized values
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

This fixes:

  hw/usb/dev-mtp.c:971:5: warning: 4th function call argument is an unini=
tialized value
      trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path=
,
                                           c->argv[1], c->argv[2]);
                                                       ^~~~~~~~~~
and:

  hw/usb/dev-mtp.c:981:12: warning: Assigned value is garbage or undefine=
d
      offset =3D c->argv[1];
               ^ ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180604151421.23385-3-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 560c61c7c1..b0ab6a7912 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1017,12 +1017,16 @@ static MTPData *usb_mtp_get_object(MTPState *s, M=
TPControl *c,
 static MTPData *usb_mtp_get_partial_object(MTPState *s, MTPControl *c,
                                            MTPObject *o)
 {
-    MTPData *d =3D usb_mtp_data_alloc(c);
+    MTPData *d;
     off_t offset;
=20
+    if (c->argc <=3D 2) {
+        return NULL;
+    }
     trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path,
                                         c->argv[1], c->argv[2]);
=20
+    d =3D usb_mtp_data_alloc(c);
     d->fd =3D open(o->path, O_RDONLY);
     if (d->fd =3D=3D -1) {
         usb_mtp_data_free(d);
--=20
2.9.3
