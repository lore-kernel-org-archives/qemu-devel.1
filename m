Received: from eggs.gnu.org ([2001:4830:134:3::10]:57687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGn-00031R-RO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGm-0001pk-RV
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGm-0001na-Lh
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD20E61460
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:30 +0100
Message-Id: <20170906184133.25524-6-dgilbert@redhat.com>
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] runstate/migrate: Two more transitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's a race if someone does a 'stop' near the end of migrate;
the migration process goes through two runstates:
    'finish migrate'
    'postmigrate'

If the user issues a 'stop' between the two we end up with invalid
state transitions.
Add the transitions as valid.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170804175011.21944-1-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index e75757f977..fb1f05b937 100644
--- a/vl.c
+++ b/vl.c
@@ -621,6 +621,7 @@ static const RunStateTransition runstate_transitions_def[] = {
 
     { RUN_STATE_PAUSED, RUN_STATE_RUNNING },
     { RUN_STATE_PAUSED, RUN_STATE_FINISH_MIGRATE },
+    { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_PAUSED, RUN_STATE_COLO},
 
@@ -633,6 +634,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
 
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PRELAUNCH },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_COLO},
-- 
2.13.5
