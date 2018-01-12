Received: from eggs.gnu.org ([2001:4830:134:3::10]:48326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0003Nk-TA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0002qR-4D
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvF-0002og-U5
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07169C056820
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:45 +0100
Message-Id: <20180112125854.18261-6-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] ui: avoid pointless VNC updates if
 framebuffer isn't dirty
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

The vnc_update_client() method checks the 'has_dirty' flag to see if ther=
e are
dirty regions that are pending to send to the client. Regardless of this =
flag,
if a forced update is requested, updates must be sent. For unknown reason=
s
though, the code also tries to sent updates if audio capture is enabled. =
This
makes no sense as audio capture state does not impact framebuffer content=
s, so
this check is removed.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-5-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 7582111ca6..a79848f083 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -984,7 +984,7 @@ static int vnc_update_client(VncState *vs, int has_di=
rty)
         return 0;
     }
=20
-    if (!vs->has_dirty && !vs->audio_cap && !vs->force_update) {
+    if (!vs->has_dirty && !vs->force_update) {
         return 0;
     }
=20
--=20
2.9.3
