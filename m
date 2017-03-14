Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnknr-0006I4-MO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkno-0005UF-I7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnkno-0005SY-D7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:39:44 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC19E47CF
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 11:39:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 12:39:41 +0100
Message-Id: <20170314113941.15362-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] coverity-model: model address_space_read/write
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

When more complexity was added to facilitate inlining, Coverity
lost the ability to use the address_space_rw model for
address_space_read/write.

This causes false positive defects when Coverity sees
a length-8 write in address_space_read and a length-4
(e.g. int*) buffer to read into.  As long as the size of
the buffer is okay, this is a false positive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-model.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
index ee5bf9d..2e30150 100644
--- a/scripts/coverity-model.c
+++ b/scripts/coverity-model.c
@@ -79,6 +79,25 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     return result;
 }
 
+MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+                               MemTxAttrs attrs,
+                               uint8_t *buf, int len)
+{
+    MemTxResult result;
+    __bufwrite(buf, len);
+    return result;
+}
+
+MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                MemTxAttrs attrs,
+                                const uint8_t *buf, int len)
+{
+    MemTxResult result;
+    __bufread(buf, len);
+    return result;
+}
+
+
 /* Tainting */
 
 typedef struct {} name2keysym_t;
-- 
2.9.3
