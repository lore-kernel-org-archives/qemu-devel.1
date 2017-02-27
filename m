Received: from eggs.gnu.org ([2001:4830:134:3::10]:46794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHj-0000Vo-5K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHf-0003tA-Tk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHf-0003mS-Jj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:47 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMra7f055653
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:39 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vq9ag8y7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:39 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:37 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Feb 2017 23:59:51 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 01/31] 9pfs: fix v9fs_lock error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

In this case, we are marshaling an error status instead of the errno value.
Reorganize the out and out_nofid labels to look like all the other cases.
Coverity reports this because the "err = -ENOENT" and "err = -EINVAL"
assignments above are dead, overwritten by the call to pdu_marshal.

(Coverity issues CID1348512 and CID1348513)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(also open-coded the success path since locking is a nop for us, Greg Kurz)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3af1c93dc87d..d99abc46025e 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3010,7 +3010,6 @@ out_nofid:
  */
 static void coroutine_fn v9fs_lock(void *opaque)
 {
-    int8_t status;
     V9fsFlock flock;
     size_t offset = 7;
     struct stat stbuf;
@@ -3018,7 +3017,6 @@ static void coroutine_fn v9fs_lock(void *opaque)
     int32_t fid, err = 0;
     V9fsPDU *pdu = opaque;
 
-    status = P9_LOCK_ERROR;
     v9fs_string_init(&flock.client_id);
     err = pdu_unmarshal(pdu, offset, "dbdqqds", &fid, &flock.type,
                         &flock.flags, &flock.start, &flock.length,
@@ -3044,15 +3042,15 @@ static void coroutine_fn v9fs_lock(void *opaque)
     if (err < 0) {
         goto out;
     }
-    status = P9_LOCK_SUCCESS;
+    err = pdu_marshal(pdu, offset, "b", P9_LOCK_SUCCESS);
+    if (err < 0) {
+        goto out;
+    }
+    err += offset;
+    trace_v9fs_lock_return(pdu->tag, pdu->id, P9_LOCK_SUCCESS);
 out:
     put_fid(pdu, fidp);
 out_nofid:
-    err = pdu_marshal(pdu, offset, "b", status);
-    if (err > 0) {
-        err += offset;
-    }
-    trace_v9fs_lock_return(pdu->tag, pdu->id, status);
     pdu_complete(pdu, err);
     v9fs_string_free(&flock.client_id);
 }
-- 
2.7.4
