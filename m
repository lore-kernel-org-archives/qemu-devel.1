Received: from eggs.gnu.org ([2001:4830:134:3::10]:43179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWgxV-0003I3-6k
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWgxQ-0001qd-8l
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:07:13 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWgxP-0001qI-VF
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:07:08 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so49420056wmd.2
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 02:07:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Jan 2017 11:07:05 +0100
Message-Id: <20170126100705.6005-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] 9pfs: fix v9fs_lock error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com

In this case, we are marshaling an error status instead of the errno value.
Reorganize the out and out_nofid labels to look like all the other cases.
Coverity reports this because the "err = -ENOENT" and "err = -EINVAL"
assignments above are dead, overwritten by the call to pdu_marshal.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/9pfs/9p.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 99e9472..d028eca 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3045,14 +3045,15 @@ static void coroutine_fn v9fs_lock(void *opaque)
         goto out;
     }
     status = P9_LOCK_SUCCESS;
-out:
-    put_fid(pdu, fidp);
-out_nofid:
     err = pdu_marshal(pdu, offset, "b", status);
-    if (err > 0) {
-        err += offset;
+    if (err < 0) {
+        goto out;
     }
+    err += offset;
     trace_v9fs_lock_return(pdu->tag, pdu->id, status);
+out:
+    put_fid(pdu, fidp);
+out_nofid:
     pdu_complete(pdu, err);
     v9fs_string_free(&flock.client_id);
 }
-- 
2.9.3
