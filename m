Received: from eggs.gnu.org ([2001:4830:134:3::10]:40387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOe-0007Fa-KW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOa-00021X-Of
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFhOa-00021A-FE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UDcsk3028019
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:11 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2as8xdapfd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:10 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 May 2017 14:41:08 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 15:40:32 +0200
In-Reply-To: <1496151640-29919-1-git-send-email-groug@kaod.org>
References: <1496151640-29919-1-git-send-email-groug@kaod.org>
Message-Id: <1496151640-29919-4-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 03/11] 9pfs: drop pdu_push_and_notify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

Only pdu_complete() needs to notify the client that a request has completed.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/9pfs/9p.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b3048371a8ee..a25d31e62f1c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -65,11 +65,6 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     return ret;
 }
 
-static void pdu_push_and_notify(V9fsPDU *pdu)
-{
-    pdu->s->transport->push_and_notify(pdu);
-}
-
 static int omode_to_uflags(int8_t mode)
 {
     int ret = 0;
@@ -668,7 +663,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     pdu->size = len;
     pdu->id = id;
 
-    pdu_push_and_notify(pdu);
+    pdu->s->transport->push_and_notify(pdu);
 
     /* Now wakeup anybody waiting in flush for this request */
     if (!qemu_co_queue_next(&pdu->complete)) {
-- 
2.7.5
