Received: from eggs.gnu.org ([2001:4830:134:3::10]:58810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co46x-000161-DA
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1co46t-0004IQ-Di
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1co46t-0004HT-7u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:16:43 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56ACF81F07
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 08:16:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 15 Mar 2017 09:16:41 +0100
Message-Id: <20170315081641.20588-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Commit eb7eeb8 ("memory: split address_space_read and
address_space_write", 2015-12-17) made address_space_rw
dispatch to one of address_space_read or address_space_write,
rather than vice versa.

For callers of address_space_read and address_space_write this
causes false positive defects when Coverity sees a length-8 write in
address_space_read and a length-4 (e.g. int*) buffer to read into.
As long as the size of the buffer is okay, this is a false positive.

Reflect the code change into the model.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-model.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
index ee5bf9d..c702804 100644
--- a/scripts/coverity-model.c
+++ b/scripts/coverity-model.c
@@ -67,18 +67,27 @@ static void __bufread(uint8_t *buf, ssize_t len)
     int last = buf[len-1];
 }
 
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, int len, bool is_write)
+MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+                               MemTxAttrs attrs,
+                               uint8_t *buf, int len)
 {
     MemTxResult result;
-
     // TODO: investigate impact of treating reads as producing
     // tainted data, with __coverity_tainted_data_argument__(buf).
-    if (is_write) __bufread(buf, len); else __bufwrite(buf, len);
+    __bufwrite(buf, len);
+    return result;
+}
 
+MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                MemTxAttrs attrs,
+                                const uint8_t *buf, int len)
+{
+    MemTxResult result;
+    __bufread(buf, len);
     return result;
 }
 
+
 /* Tainting */
 
 typedef struct {} name2keysym_t;
-- 
2.9.3
