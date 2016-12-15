Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBj-0002Eq-90
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBg-0001A1-6N
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBf-00019H-S4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:20 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haNR056431
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:18 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm90vya-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:18 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:17 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:13 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-20-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 19/67] virtio-scsi: Don't abort when media is
 ejected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Fam Zheng <famz@redhat.com>

With an ejected block backend, blk_get_aio_context() would return
qemu_aio_context. In this case don't assert.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <1473848224-24809-3-git-send-email-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2a2d69f490c1b1dc6b6d2aef385ee7b654497a77)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/virtio-scsi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ce57ef6..e596b64 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -236,6 +236,13 @@ static void virtio_scsi_cancel_notify(Notifier *notifier, void *data)
     g_free(n);
 }
 
+static inline void virtio_scsi_ctx_check(VirtIOSCSI *s, SCSIDevice *d)
+{
+    if (s->dataplane_started && d && blk_is_available(d->conf.blk)) {
+        assert(blk_get_aio_context(d->conf.blk) == s->ctx);
+    }
+}
+
 /* Return 0 if the request is ready to be completed and return to guest;
  * -EINPROGRESS if the request is submitted and will be completed later, in the
  *  case of async cancellation. */
@@ -247,9 +254,7 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
     int target;
     int ret = 0;
 
-    if (s->dataplane_started && d) {
-        assert(blk_get_aio_context(d->conf.blk) == s->ctx);
-    }
+    virtio_scsi_ctx_check(s, d);
     /* Here VIRTIO_SCSI_S_OK means "FUNCTION COMPLETE".  */
     req->resp.tmf.response = VIRTIO_SCSI_S_OK;
 
@@ -539,9 +544,7 @@ static bool virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req
         virtio_scsi_complete_cmd_req(req);
         return false;
     }
-    if (s->dataplane_started) {
-        assert(blk_get_aio_context(d->conf.blk) == s->ctx);
-    }
+    virtio_scsi_ctx_check(s, d);
     req->sreq = scsi_req_new(d, req->req.cmd.tag,
                              virtio_scsi_get_lun(req->req.cmd.lun),
                              req->req.cmd.cdb, req);
-- 
1.9.1
