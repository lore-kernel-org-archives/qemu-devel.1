Received: from eggs.gnu.org ([2001:4830:134:3::10]:53403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si8-0001K9-T0
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si7-0005Jm-UA
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:00 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 17:39:44 +0200
Message-Id: <20180417153945.20737-6-pbonzini@redhat.com>
In-Reply-To: <20180417153945.20737-1-pbonzini@redhat.com>
References: <20180417153945.20737-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] atapi: call ide_set_irq before
 ide_transfer_start
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

The ATAPI_INT_REASON_IO interrupt is raised when I/O starts, but in the
AHCI case ide_set_irq was actually called at the end of a mutual recursion.
Move it early, with the side effect that ide_transfer_start becomes a tail
call in ide_atapi_cmd_reply_end.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/atapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
+            trace_ide_atapi_cmd_reply_end_new(s, s->status);
             s->packet_transfer_size -= size;
             s->elementary_transfer_size -= size;
             s->io_buffer_index += size;
             ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
                                size, ide_atapi_cmd_reply_end);
-            ide_set_irq(s->bus);
-            trace_ide_atapi_cmd_reply_end_new(s, s->status);
         }
     }
 }
-- 
2.17.0
