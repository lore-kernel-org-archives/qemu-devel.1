Received: from eggs.gnu.org ([2001:4830:134:3::10]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK6-0001H9-F3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK5-0000nl-Er
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:10 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUK5-0000mx-6z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: by mail-wm0-x244.google.com with SMTP id s14-v6so15139228wmc.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:09 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	h40-v6sm13784683wrf.40.2018.07.06.10.15.07
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Jul 2018 10:15:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:27 +0200
Message-Id: <1530897268-22932-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] ioapic: remove useless lower bounds check
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index b393780..b6896ac 100644
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
1.8.3.1
