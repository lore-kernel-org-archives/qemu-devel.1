Received: from eggs.gnu.org ([2001:4830:134:3::10]:50936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4b-0004W3-H8
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4a-0000To-K5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4a-0000TT-EB
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:11 -0300
Message-Id: <20170613165313.20954-14-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 13/15] rdma: Simplify var declaration to avoid
 confusing Coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

For some reason the declaration:

  Error *local_err = NULL, **errp = &local_err;

will be matched by Coccinelle even if we use:

  ... when != local_err
  Error *local_err = NULL;
  ... when != local_err

This moves the declarations to separate lines just to avoid that issue.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 migration/rdma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c6078bf51b..5cb9572a5c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2282,7 +2282,8 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
 static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 {
     int ret, idx;
-    Error *local_err = NULL, **temp = &local_err;
+    Error *local_err = NULL;
+    Error **temp = &local_err;
 
     /*
      * Will be validated against destination's actual capabilities
@@ -3433,7 +3434,8 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
 static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                                        uint64_t flags, void *data)
 {
-    Error *local_err = NULL, **errp = &local_err;
+    Error *local_err = NULL;
+    Error **errp = &local_err;
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
     RDMAContext *rdma = rioc->rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
@@ -3606,7 +3608,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     RDMAContext *rdma = opaque;
     int ret;
     QEMUFile *f;
-    Error *local_err = NULL, **errp = &local_err;
+    Error *local_err = NULL;
+    Error **errp = &local_err;
 
     trace_qemu_rdma_accept_incoming_migration();
     ret = qemu_rdma_accept(rdma);
-- 
2.11.0.259.g40922b1
