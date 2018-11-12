Received: from eggs.gnu.org ([2001:4830:134:3::10]:59977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfp-0000jk-7T
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfo-0007Hu-8x
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:59 +0100
Message-Id: <20181112170603.23986-11-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] job: Fix off-by-one assert checks for
 JobSTT and JobVerbTable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Liam Merwick <Liam.Merwick@oracle.com>

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
Message-id: 1541453919-25973-2-git-send-email-Liam.Merwick@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/job.c b/job.c
index c65e01bbfa..da8e4b7bf2 100644
--- a/job.c
+++ b/job.c
@@ -159,7 +159,7 @@ bool job_is_internal(Job *job)
 static void job_state_transition(Job *job, JobStatus s1)
 {
     JobStatus s0 =3D job->status;
-    assert(s1 >=3D 0 && s1 <=3D JOB_STATUS__MAX);
+    assert(s1 >=3D 0 && s1 < JOB_STATUS__MAX);
     trace_job_state_transition(job, job->ret,
                                JobSTT[s0][s1] ? "allowed" : "disallowed"=
,
                                JobStatus_str(s0), JobStatus_str(s1));
@@ -174,7 +174,7 @@ static void job_state_transition(Job *job, JobStatus =
s1)
 int job_apply_verb(Job *job, JobVerb verb, Error **errp)
 {
     JobStatus s0 =3D job->status;
-    assert(verb >=3D 0 && verb <=3D JOB_VERB__MAX);
+    assert(verb >=3D 0 && verb < JOB_VERB__MAX);
     trace_job_apply_verb(job, JobStatus_str(s0), JobVerb_str(verb),
                          JobVerbTable[verb][s0] ? "allowed" : "prohibite=
d");
     if (JobVerbTable[verb][s0]) {
--=20
2.19.1
