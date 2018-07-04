Received: from eggs.gnu.org ([2001:4830:134:3::10]:37388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fagWB-00030h-37
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fagW8-0003FR-Ua
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:04:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fagW8-0003FA-Ps
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6538477890
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 12:04:16 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-235.ams2.redhat.com
	[10.36.117.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9557A2026D76
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 12:04:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jul 2018 14:04:12 +0200
Message-Id: <20180704120412.19020-2-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] ioapic: remove useless lower bounds check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The vector cannot be negative.  Coverity now reports this because it sees an
array access before the check, in ioapic_stat_update_irq.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index b3937807c2..b6896ac4ce 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -152,7 +152,7 @@ static void ioapic_set_irq(void *opaque, int vector, int level)
     if (vector == 0) {
         vector = 2;
     }
-    if (vector >= 0 && vector < IOAPIC_NUM_PINS) {
+    if (vector < IOAPIC_NUM_PINS) {
         uint32_t mask = 1 << vector;
         uint64_t entry = s->ioredtbl[vector];
 
-- 
2.17.1
