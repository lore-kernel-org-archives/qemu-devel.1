Received: from eggs.gnu.org ([2001:4830:134:3::10]:40486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnR-0006Ic-Sl
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFnR-0004mp-34
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFnQ-0004ls-TE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1C9863705
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:22 +0100
Message-Id: <20180110124723.11879-14-quintela@redhat.com>
In-Reply-To: <20180110124723.11879-1-quintela@redhat.com>
References: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 13/14] migration: Add multifd_send_packet
 trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

I need the block name, so I can't do that sooner.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 2 ++
 migration/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index f636c7da0a..6e45f668d1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -705,6 +705,8 @@ static uint16_t multifd_send_page(RAMBlock *block, ram_addr_t offset,
     multifd_send_state->pages = p->pages;
     p->pages = pages;
     qemu_mutex_unlock(&p->mutex);
+    trace_multifd_send_packet(p->id, p->pages->block->idstr, p->pages->seq,
+                              p->pages->used, last_page);
     qemu_sem_post(&p->sem);
 
     return i;
diff --git a/migration/trace-events b/migration/trace-events
index 06aef4d4a3..598620c58e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -81,6 +81,7 @@ multifd_recv(char id, int seq, int num) "channel %d sequence %d num pages %d"
 multifd_send(char id, int seq, int num) "channel %d sequence %d num pages %d"
 multifd_recv_thread(char id, uint32_t packets) "channel %d packets %d"
 multifd_send_thread(char id, uint32_t packets) "channel %d packets %d"
+multifd_send_packet(char id, char *block_name, uint32_t seq, uint32_t packets_used, bool last) "channel %d block %s seq %d used %d last %d"
 
 # migration/migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.14.3
