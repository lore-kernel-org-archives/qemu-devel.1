Received: from eggs.gnu.org ([2001:4830:134:3::10]:38360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdoo-0000h3-LS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQdon-0000kO-LF
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:10:02 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  6 Jun 2018 15:09:54 -0400
Message-Id: <20180606190955.20845-7-jsnow@redhat.com>
In-Reply-To: <20180606190955.20845-1-jsnow@redhat.com>
References: <20180606190955.20845-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] atapi: call ide_set_irq before
 ide_transfer_start
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

The ATAPI_INT_REASON_IO interrupt is raised when I/O starts, but in the
AHCI case ide_set_irq was actually called at the end of a mutual recursion.
Move it early, with the side effect that ide_transfer_start becomes a tail
call in ide_atapi_cmd_reply_end.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/atapi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index c0509c8bf5..7168ff55a7 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -287,6 +287,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
         } else {
             /* a new transfer is needed */
             s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
+            ide_set_irq(s->bus);
             byte_count_limit = atapi_byte_count_limit(s);
             trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
             size = s->packet_transfer_size;
@@ -304,13 +305,12 @@ void ide_atapi_cmd_reply_end(IDEState *s)
                 if (size > (s->cd_sector_size - s->io_buffer_index))
                     size = (s->cd_sector_size - s->io_buffer_index);
             }
-            s->packet_transfer_size -= size;
-            s->elementary_transfer_size -= size;
-            s->io_buffer_index += size;
-            ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
-                               size, ide_atapi_cmd_reply_end);
-            ide_set_irq(s->bus);
             trace_ide_atapi_cmd_reply_end_new(s, s->status);
+            s->packet_transfer_size -= size;
+            s->elementary_transfer_size -= size;
+            s->io_buffer_index += size;
+            ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
+                               size, ide_atapi_cmd_reply_end);
         }
     }
 }
-- 
2.14.3
