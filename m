Received: from eggs.gnu.org ([2001:4830:134:3::10]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kq-0007TP-4t
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Ko-0003YA-JF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3Ko-0003Xl-D7
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BC31356DB
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:53:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:52:55 +0100
Message-Id: <20180115115309.23982-14-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/27] migration: Guard ram_bytes_remaining
 against early call
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Calling ram_bytes_remaining during the early part of setup is unsafe
because the ram_state isn't yet initialised.

This can happen in the sequence:
   migrate
   migrate_cancel
   info migrate

if the migrate sticks trying to connect (e.g. to an unresponsive
destination due to the connect timeout).  Here 'info migrate' sees
a state of CANCELLING and so assumes the migrate has partially happened.

partial fix for:
RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1525899
Reported-by: Xianxian Wang <xianwang@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 021d583b9b..cb1950f3eb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -237,7 +237,8 @@ static RAMState *ram_state;
 
 uint64_t ram_bytes_remaining(void)
 {
-    return ram_state->migration_dirty_pages * TARGET_PAGE_SIZE;
+    return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
+                       0;
 }
 
 MigrationStats ram_counters;
-- 
2.14.3
