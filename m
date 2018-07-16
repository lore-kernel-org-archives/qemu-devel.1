Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7Rb-0007TG-Vr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7RY-0003BC-Lj
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ff7RY-00039A-HJ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:52 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 16 Jul 2018 18:37:40 +0100
Message-Id: <20180716173743.133393-2-dgilbert@redhat.com>
In-Reply-To: <20180716173743.133393-1-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 1/4] scsi/migration: Allow bus load
 request to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow the load_request method on a bus to fail and error
the migration cleanly.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/scsi/scsi-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 5905f6bf29..34a29c2ffd 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1618,6 +1618,11 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
         req->retry = (sbyte == 1);
         if (bus->info->load_request) {
             req->hba_private = bus->info->load_request(f, req);
+
+            if (!req->hba_private) {
+                scsi_req_unref(req);
+                return -1;
+            }
         }
         if (req->ops->load_request) {
             req->ops->load_request(f, req);
-- 
2.17.1
