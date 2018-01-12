Received: from eggs.gnu.org ([2001:4830:134:3::10]:48312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0003N0-Dg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvF-0002pA-HH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvF-0002oH-BW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 712C85240
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:48 +0100
Message-Id: <20180112125854.18261-9-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] ui: correctly reset framebuffer update
 state after processing dirty regions
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

According to the RFB protocol, a client sends one or more framebuffer upd=
ate
requests to the server. The server can reply with a single framebuffer up=
date
response, that covers all previously received requests. Once the client h=
as
read this update from the server, it may send further framebuffer update
requests to monitor future changes. The client is free to delay sending t=
he
framebuffer update request if it needs to throttle the amount of data it =
is
reading from the server.

The QEMU VNC server, however, has never correctly handled the framebuffer
update requests. Once QEMU has received an update request, it will contin=
ue to
send client updates forever, even if the client hasn't asked for further
updates. This prevents the client from throttling back data it gets from =
the
server. This change fixes the flawed logic such that after a set of updat=
es are
sent out, QEMU waits for a further update request before sending more dat=
a.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-8-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 30e2feeae3..243c72be13 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1031,7 +1031,7 @@ static int vnc_update_client(VncState *vs, int has_=
dirty)
     }
=20
     vnc_job_push(job);
-    vs->update =3D VNC_STATE_UPDATE_INCREMENTAL;
+    vs->update =3D VNC_STATE_UPDATE_NONE;
     vs->has_dirty =3D 0;
     return n;
 }
--=20
2.9.3
