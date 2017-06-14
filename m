Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvh-0000wh-KE
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvg-0005kh-QC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLEvg-0005kP-JY
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79CA437EEB
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:30:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 17:29:57 -0300
Message-Id: <20170614203000.19984-3-ehabkost@redhat.com>
In-Reply-To: <20170614203000.19984-1-ehabkost@redhat.com>
References: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] memory: Allow RAM up to block->max_length
 to be discarded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Currently ram_block_discard_range() is called only by the postcopy code,
using length=block->used_length.  However, new code will use
ram_block_discard_range() to discard the contents of the entire
RAMBlock, so change the limit check to use max_length instead of
used_length.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index a93e209625..585d6ed6d7 100644
--- a/exec.c
+++ b/exec.c
@@ -3522,7 +3522,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
         goto err;
     }
 
-    if ((start + length) <= rb->used_length) {
+    if ((start + length) <= rb->max_length) {
         uint8_t *host_endaddr = host_startaddr + length;
         if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
             error_report("ram_block_discard_range: Unaligned end address: %p",
-- 
2.11.0.259.g40922b1
