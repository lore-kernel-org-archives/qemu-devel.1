Received: from eggs.gnu.org ([2001:4830:134:3::10]:33452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ8-0002tf-8A
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ7-0006AG-EL
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33334
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQ7-00069p-9L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESnRX126441
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:28:57 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc85uy2k4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:54 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:49 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:24 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-8-groug@kaod.org>
Subject: [Qemu-devel] [PULL 07/14] 9pfs: fix error path in pdu_submit()
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

If we receive an unsupported request id, we first decide to
return -ENOTSUPP to the client, but since the request id
causes is_read_only_op() to return false, we change the
error to be -EROFS if the fsdev is read-only. This doesn't
make sense since we don't know what the client asked for.

This patch ensures that -EROFS can only be returned if the
request id is supported.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 76f90f2b7863..558efb41defd 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3473,14 +3473,12 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
     if (pdu->id >= ARRAY_SIZE(pdu_co_handlers) ||
         (pdu_co_handlers[pdu->id] == NULL)) {
         handler = v9fs_op_not_supp;
+    } else if (is_ro_export(&s->ctx) && !is_read_only_op(pdu)) {
+        handler = v9fs_fs_ro;
     } else {
         handler = pdu_co_handlers[pdu->id];
     }
 
-    if (is_ro_export(&s->ctx) && !is_read_only_op(pdu)) {
-        handler = v9fs_fs_ro;
-    }
-
     qemu_co_queue_init(&pdu->complete);
     co = qemu_coroutine_create(handler, pdu);
     qemu_coroutine_enter(co);
-- 
2.13.6
