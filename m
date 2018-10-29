Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH8NT-0003Wv-5P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH8NQ-00043f-8e
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH8NP-00040P-Uk
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:18:44 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 15:18:34 +0100
Message-Id: <20181029141834.8794-3-kraxel@redhat.com>
In-Reply-To: <20181029141834.8794-1-kraxel@redhat.com>
References: <20181029141834.8794-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] spice: prepare for upcoming spice-server
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org

Future spice-server versions will call the client_monitors_config
callback with the monitors list filtered to only include the monitors
of the given display channel (aka QXLInstance).  Luckily this is easily
detectable at runtime, so we can prepare for that in advance and also
make qemu compatible with both old and new spice-server versions.

While being at it also use the console index instead of head number as
array index.  The later doesn't work correctly in case multiple display
devices are present.

Cc: spice-devel@lists.freedesktop.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
Message-id: 20181012114551.28809-1-kraxel@redhat.com
---
 ui/spice-display.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 2f8adb6b9f..52f8cb5ae1 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -674,10 +674,28 @@ static int interface_client_monitors_config(QXLInst=
ance *sin,
=20
     memset(&info, 0, sizeof(info));
=20
-    head =3D qemu_console_get_head(ssd->dcl.con);
-    if (mc->num_of_monitors > head) {
-        info.width  =3D mc->monitors[head].width;
-        info.height =3D mc->monitors[head].height;
+    if (mc->num_of_monitors =3D=3D 1) {
+        /*
+         * New spice-server version which filters the list of monitors
+         * to only include those that belong to our display channel.
+         *
+         * single-head configuration (where filtering doesn't matter)
+         * takes this code path too.
+         */
+        info.width  =3D mc->monitors[0].width;
+        info.height =3D mc->monitors[0].height;
+    } else {
+        /*
+         * Old spice-server which gives us all monitors, so we have to
+         * figure ourself which entry we need.  Array index is the
+         * channel_id, which is the qemu console index, see
+         * qemu_spice_add_display_interface().
+         */
+        head =3D qemu_console_get_index(ssd->dcl.con);
+        if (mc->num_of_monitors > head) {
+            info.width  =3D mc->monitors[head].width;
+            info.height =3D mc->monitors[head].height;
+        }
     }
=20
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
--=20
2.9.3
