Received: from eggs.gnu.org ([2001:4830:134:3::10]:37218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs3-0000oz-2E
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs1-0008Mj-Oh
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:30 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:05 -0500
Message-Id: <20180127020515.27137-5-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 04/14] blockjobs: RFC add block_job_verb
 permission table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Which commands are appropriate for jobs in which state is also somewhat
burdensome to keep track of. Introduce a verbs table that, as of this RFC
patch, does nothing but serve as a declaration of intent.

(At the very least, it forced me to consider all of the possibilities.)

If this idea seems appealing, I can expand the verbs concept into a list
of interfaces to consult the table and refuse inappropriate commands,
mostly serving as new errors for the QMP interface.


cancel: can apply to any created, running, paused or ready job.
pause: can apply to any created, running, or ready job. Addition pauses
       can and do stack, so a paused job can also be paused.
       Note that a pause from the QMP context is treated separately and
       does not stack.
resume: Only a paused job can be resumed. Only a job that has been paused
        via QMP can be resumed via QMP.
set-speed: Any created, running, paused or ready job can tolerate a
           set-speed request.
complete: Only a ready job may accept a complete request.
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/blockjob.c b/blockjob.c
index d084a1e318..ea216aca5e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -52,6 +52,24 @@ bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
     /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0},
 };
 
+enum BlockJobVerb {
+    BLOCK_JOB_VERB_CANCEL,
+    BLOCK_JOB_VERB_PAUSE,
+    BLOCK_JOB_VERB_RESUME,
+    BLOCK_JOB_VERB_SET_SPEED,
+    BLOCK_JOB_VERB_COMPLETE,
+    BLOCK_JOB_VERB__MAX
+};
+
+bool BlockJobVerb[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
+                                          /* U, C, R, P, Y */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 0, 0, 1, 0},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1},
+};
+
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
 {
     BlockJobStatus s0 = job->status;
-- 
2.14.3
