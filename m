Received: from eggs.gnu.org ([2001:4830:134:3::10]:54657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXv-0007sN-0v
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXu-0002SY-40
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:38:58 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:39:00 +0100
Message-Id: <1539981546-10596-3-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 2/8] job: Fix off-by-one assert checks for
 JobSTT and JobVerbTable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

In the assert checking the array dereference of JobVerbTable[verb]
in job_apply_verb() the check of the index, verb, allows an overrun
because an index equal to the array size is permitted.

Similarly, in the assert check of JobSTT[s0][s1] with index s1
in job_state_transition(), an off-by-one overrun is not flagged
either.

This is not a run-time issue as there are no callers actually
passing in the max value.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/job.c b/job.c
index c65e01bbfa34..da8e4b7bf2f3 100644
--- a/job.c
+++ b/job.c
@@ -159,7 +159,7 @@ bool job_is_internal(Job *job)
 static void job_state_transition(Job *job, JobStatus s1)
 {
     JobStatus s0 = job->status;
-    assert(s1 >= 0 && s1 <= JOB_STATUS__MAX);
+    assert(s1 >= 0 && s1 < JOB_STATUS__MAX);
     trace_job_state_transition(job, job->ret,
                                JobSTT[s0][s1] ? "allowed" : "disallowed",
                                JobStatus_str(s0), JobStatus_str(s1));
@@ -174,7 +174,7 @@ static void job_state_transition(Job *job, JobStatus s1)
 int job_apply_verb(Job *job, JobVerb verb, Error **errp)
 {
     JobStatus s0 = job->status;
-    assert(verb >= 0 && verb <= JOB_VERB__MAX);
+    assert(verb >= 0 && verb < JOB_VERB__MAX);
     trace_job_apply_verb(job, JobStatus_str(s0), JobVerb_str(verb),
                          JobVerbTable[verb][s0] ? "allowed" : "prohibited");
     if (JobVerbTable[verb][s0]) {
-- 
1.8.3.1
