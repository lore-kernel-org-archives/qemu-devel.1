Received: from eggs.gnu.org ([2001:4830:134:3::10]:53477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clu6M-0005kv-0o
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clu6I-0003Bn-QF
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1clu6I-0003BU-Jd
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:11:10 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE0D03D95C
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 09:11:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Mar 2017 10:11:01 +0100
Message-Id: <1489050661-17989-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
References: <1489050661-17989-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] qxl: clear guest_cursor on QXL_CURSOR_HIDE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Make sure we don't leave guest_cursor pointing into nowhere.  This might
lead to (rare) live migration failures, due to target trying to restore
the cursor from the stale pointer.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1421788
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1488789111-27340-1-git-send-email-kraxel@redhat.com
---
 hw/display/qxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index af4c0ca..0d02f0e 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -477,6 +477,11 @@ static int qxl_track_command(PCIQXLDevice *qxl, stru=
ct QXLCommandExt *ext)
             qxl->guest_cursor =3D ext->cmd.data;
             qemu_mutex_unlock(&qxl->track_lock);
         }
+        if (cmd->type =3D=3D QXL_CURSOR_HIDE) {
+            qemu_mutex_lock(&qxl->track_lock);
+            qxl->guest_cursor =3D 0;
+            qemu_mutex_unlock(&qxl->track_lock);
+        }
         break;
     }
     }
--=20
1.8.3.1
