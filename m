Received: from eggs.gnu.org ([2001:4830:134:3::10]:46296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cvR5j-0006YB-16
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cvR5g-0005iv-Bo
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:13:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cvR5g-0005io-20
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:13:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34G98TE034026
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 12:13:54 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29mcjfgdxx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 12:13:54 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 4 Apr 2017 17:13:52 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  4 Apr 2017 18:13:29 +0200
In-Reply-To: <1491322410-24532-1-git-send-email-groug@kaod.org>
References: <1491322410-24532-1-git-send-email-groug@kaod.org>
Message-Id: <1491322410-24532-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/2] 9pfs: fix multiple flush for same request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

If a client tries to flush the same outstanding request several times, only
the first flush completes. Subsequent ones keep waiting for the request
completion in v9fs_flush() and, therefore, leak a PDU. This will cause QEMU
to hang when draining active PDUs the next time the device is reset.

Let have each flush request wake up the next one if any. The last waiter
frees the cancelled PDU.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48babce836b6..ef47a0a5ad6f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2387,8 +2387,10 @@ static void coroutine_fn v9fs_flush(void *opaque)
          * Wait for pdu to complete.
          */
         qemu_co_queue_wait(&cancel_pdu->complete, NULL);
-        cancel_pdu->cancelled = 0;
-        pdu_free(cancel_pdu);
+        if (!qemu_co_queue_next(&cancel_pdu->complete)) {
+            cancel_pdu->cancelled = 0;
+            pdu_free(cancel_pdu);
+        }
     }
     pdu_complete(pdu, 7);
 }
-- 
2.7.4
