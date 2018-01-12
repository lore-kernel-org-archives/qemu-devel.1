Received: from eggs.gnu.org ([2001:4830:134:3::10]:48247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvD-0003L6-Jh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvB-0002jp-OH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvB-0002ia-HN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9093B883B0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:58:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:43 +0100
Message-Id: <20180112125854.18261-4-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] ui: remove unreachable code in
 vnc_update_client
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

A previous commit:

  commit 5a8be0f73d6f60ff08746377eb09ca459f39deab
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Wed Jul 13 12:21:20 2016 +0200

    vnc: make sure we finish disconnect

Added a check for vs->disconnecting at the very start of the
vnc_update_client method. This means that the very next "if"
statement check for !vs->disconnecting always evaluates true,
and is thus redundant. This in turn means the vs->disconnecting
check at the very end of the method never evaluates true, and
is thus unreachable code.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-3-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index d72a61bde3..29a7208475 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -969,7 +969,7 @@ static int vnc_update_client(VncState *vs, int has_di=
rty)
     }
=20
     vs->has_dirty +=3D has_dirty;
-    if (vs->need_update && !vs->disconnecting) {
+    if (vs->need_update) {
         VncDisplay *vd =3D vs->vd;
         VncJob *job;
         int y;
@@ -1030,10 +1030,6 @@ static int vnc_update_client(VncState *vs, int has=
_dirty)
         return n;
     }
=20
-    if (vs->disconnecting) {
-        vnc_disconnect_finish(vs);
-    }
-
     return 0;
 }
=20
--=20
2.9.3
