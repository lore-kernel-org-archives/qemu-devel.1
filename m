Received: from eggs.gnu.org ([2001:4830:134:3::10]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9Ria-0007GD-LR
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9RiV-0002JU-Px
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:48:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f9RiV-0002Hy-LF
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:48:27 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 20 Apr 2018 10:48:19 +0200
Message-Id: <20180420084820.3873-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: fix use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

When vnc_client_read() return value is -1
vs is not valid any more.

Fixes: d49b87f0d1e0520443a990fc610d0f02bc63c556
Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index e164eb798c..5526e54f48 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1539,13 +1539,14 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNU=
SED,
     VncState *vs =3D opaque;
     if (condition & G_IO_IN) {
         if (vnc_client_read(vs) < 0) {
-            goto end;
+            /* vs is free()ed here */
+            return TRUE;
         }
     }
     if (condition & G_IO_OUT) {
         vnc_client_write(vs);
     }
-end:
+
     if (vs->disconnecting) {
         if (vs->ioc_tag !=3D 0) {
             g_source_remove(vs->ioc_tag);
--=20
2.9.3
