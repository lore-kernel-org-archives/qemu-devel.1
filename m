Received: from eggs.gnu.org ([2001:4830:134:3::10]:49368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gPRvR-0001sE-Vk
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gPRvO-0003rS-0h
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:48:13 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Wed, 21 Nov 2018 12:47:47 +0000
Message-Id: <20181121124747.30696-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] scsi-disk: Fix crash if underlying host file
 or disk returns error.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: famz@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Commit 40dce4ee6 "scsi-disk: fix rerror/werror=3Dignore" introduced a
bug which causes qemu to crash with the assertion error below if the
host file or disk returns an error:

  qemu-system-x86_64: hw/scsi/scsi-bus.c:1374: scsi_req_complete:
  Assertion `req->status =3D=3D -1' failed.

Kevin Wolf suggested this fix:

  < kwolf> Hm, should the final return false; in that patch
           actually be a return true?
  < kwolf> Because I think he didn't intend to change anything
           except BLOCK_ERROR_ACTION_IGNORE

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1804323
---
 hw/scsi/scsi-disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6eb258d3f3..0e9027c8f3 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -482,7 +482,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int =
error, bool acct_failed)
     if (action =3D=3D BLOCK_ERROR_ACTION_STOP) {
         scsi_req_retry(&r->req);
     }
-    return false;
+    return true;
 }
=20
 static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
--=20
2.19.0.rc0
