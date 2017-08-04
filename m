Received: from eggs.gnu.org ([2001:4830:134:3::10]:56820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddgjv-0000qP-Kk
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddgjr-0008WH-5P
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:50:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddgjq-0008U7-WA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFD2F4A71F
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 17:50:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  4 Aug 2017 18:50:11 +0100
Message-Id: <20170804175011.21944-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH f0r 2.11] runstate/migrate: Two more transitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, pbonzini@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There's a race if someone does a 'stop' near the end of migrate;
the migration process goes through two runstates:
    'finish migrate'
    'postmigrate'

If the user issues a 'stop' between the two we end up with invalid
state transitions.
Add the transitions as valid.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 99fcfa0442..bacb03f49d 100644
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
2.13.3
