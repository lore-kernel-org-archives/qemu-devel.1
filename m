Received: from eggs.gnu.org ([2001:4830:134:3::10]:35273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWS-0004GJ-He
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWR-0005n6-TA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1camWR-0005mi-NT
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:11 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D02FF8046C
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 16:52:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  6 Feb 2017 17:51:48 +0100
Message-Id: <1486399909-16338-6-git-send-email-quintela@redhat.com>
In-Reply-To: <1486399909-16338-1-git-send-email-quintela@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] Postcopy: Reset state to avoid cleanup
 assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On a destination host with no userfault support an incoming
postcopy would cause the state to enter ADVISE before
it realised there was no support, and because it was in ADVISE
state it would perform a cleanup at the end.  Since there
was no support the cleanup function should be unreachable,
but ends up being called and asserting.

Reset the state when we realise we have no support, thus the
cleanup doesn't happen.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170202155909.31784-2-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8b8c74d..0199768 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1355,6 +1355,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
     }

     if (!postcopy_ram_supported_by_host()) {
+        postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }

-- 
2.7.4
