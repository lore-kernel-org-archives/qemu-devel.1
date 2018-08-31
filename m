Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwF-0007D9-31
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwC-0005tW-CM
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvnwC-0005tI-5V
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VIDtnr094209
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:27 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp2120.oracle.com with ESMTP id 2m2y2q4vja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEQEQ019445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7VIEQtN029535
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:26 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 19:16:06 +0100
Message-Id: <1535739372-24454-3-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 2/8] job: Fix off-by-one assert checks for
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
---
 job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/job.c b/job.c
index e36ebaafd81c..40320566f43b 100644
--- a/job.c
+++ b/job.c
@@ -166,7 +166,7 @@ bool job_is_internal(Job *job)
 static void job_state_transition(Job *job, JobStatus s1)
 {
     JobStatus s0 = job->status;
-    assert(s1 >= 0 && s1 <= JOB_STATUS__MAX);
+    assert(s1 >= 0 && s1 < JOB_STATUS__MAX);
     trace_job_state_transition(job, job->ret,
                                JobSTT[s0][s1] ? "allowed" : "disallowed",
                                JobStatus_str(s0), JobStatus_str(s1));
@@ -181,7 +181,7 @@ static void job_state_transition(Job *job, JobStatus s1)
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
