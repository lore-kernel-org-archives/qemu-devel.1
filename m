Received: from eggs.gnu.org ([2001:4830:134:3::10]:53395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si8-0001K0-Pa
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si7-0005Jr-W9
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:00 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 17:39:42 +0200
Message-Id: <20180417153945.20737-4-pbonzini@redhat.com>
In-Reply-To: <20180417153945.20737-1-pbonzini@redhat.com>
References: <20180417153945.20737-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] ide: call ide_cmd_done from
 ide_transfer_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

The code can simply be moved to the sole caller that has notify == true.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 7932b7c069..edda171b47 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -549,26 +549,23 @@ static void ide_cmd_done(IDEState *s)
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
2.17.0
