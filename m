Received: from eggs.gnu.org ([2001:4830:134:3::10]:38348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdoo-0000fu-BS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdon-0000k6-FQ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:02 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  6 Jun 2018 15:09:52 -0400
Message-Id: <20180606190955.20845-5-jsnow@redhat.com>
In-Reply-To: <20180606190955.20845-1-jsnow@redhat.com>
References: <20180606190955.20845-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] ide: call ide_cmd_done from
 ide_transfer_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The code can simply be moved to the sole caller that has notify == true.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 1a6cb337bf..54799ea6fb 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -548,26 +548,23 @@ static void ide_cmd_done(IDEState *s)
 }
 
 static void ide_transfer_halt(IDEState *s,
-                              void(*end_transfer_func)(IDEState *),
-                              bool notify)
+                              void(*end_transfer_func)(IDEState *))
 {
     s->end_transfer_func = end_transfer_func;
     s->data_ptr = s->io_buffer;
     s->data_end = s->io_buffer;
     s->status &= ~DRQ_STAT;
-    if (notify) {
-        ide_cmd_done(s);
-    }
 }
 
 void ide_transfer_stop(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_stop, true);
+    ide_transfer_halt(s, ide_transfer_stop);
+    ide_cmd_done(s);
 }
 
 static void ide_transfer_cancel(IDEState *s)
 {
-    ide_transfer_halt(s, ide_transfer_cancel, false);
+    ide_transfer_halt(s, ide_transfer_cancel);
 }
 
 int64_t ide_get_sector(IDEState *s)
-- 
2.14.3
