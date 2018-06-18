Received: from eggs.gnu.org ([2001:4830:134:3::10]:43734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqc-0001jb-DL
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqZ-0004uh-SO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwqZ-0004ub-N4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:17:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5ADA181A4E99
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:17:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:06 +0200
Message-Id: <20180618161729.334-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/26] dmabuf: add y0_top, pass it to spice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Some scanouts during boot are top-down without this.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 1 +
 ui/spice-display.c   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 981b519dde..fb969caf70 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -186,6 +186,7 @@ struct QemuDmaBuf {
     uint32_t  stride;
     uint32_t  fourcc;
     uint32_t  texture;
+    bool      y0_top;
 };
=20
 typedef struct DisplayChangeListenerOps {
diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe734821dd..81f08a85bc 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1048,7 +1048,8 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
             /* note: spice server will close the fd, so hand over a dup =
*/
             spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
                                  dmabuf->width, dmabuf->height,
-                                 dmabuf->stride, dmabuf->fourcc, false);
+                                 dmabuf->stride, dmabuf->fourcc,
+                                 dmabuf->y0_top);
         }
         qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->h=
eight);
         ssd->guest_dmabuf_refresh =3D false;
--=20
2.18.0.rc1
