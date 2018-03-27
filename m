Received: from eggs.gnu.org ([2001:4830:134:3::10]:37053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0qcX-0006Vq-S1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0qcX-0001zz-6C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:34:45 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Mar 2018 17:30:11 +0200
Message-Id: <20180327153011.29569-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] blockjob: use qapi enum helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

QAPI generator provide #define helpers for looking up enum string.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 blockjob.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index ef3ed69ff1..11c9ce124d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -75,10 +75,8 @@ static void block_job_state_transition(BlockJob *job, =
BlockJobStatus s1)
     assert(s1 >=3D 0 && s1 <=3D BLOCK_JOB_STATUS__MAX);
     trace_block_job_state_transition(job, job->ret, BlockJobSTT[s0][s1] =
?
                                      "allowed" : "disallowed",
-                                     qapi_enum_lookup(&BlockJobStatus_lo=
okup,
-                                                      s0),
-                                     qapi_enum_lookup(&BlockJobStatus_lo=
okup,
-                                                      s1));
+                                     BlockJobStatus_str(s0),
+                                     BlockJobStatus_str(s1));
     assert(BlockJobSTT[s0][s1]);
     job->status =3D s1;
 }
@@ -86,17 +84,15 @@ static void block_job_state_transition(BlockJob *job,=
 BlockJobStatus s1)
 static int block_job_apply_verb(BlockJob *job, BlockJobVerb bv, Error **=
errp)
 {
     assert(bv >=3D 0 && bv <=3D BLOCK_JOB_VERB__MAX);
-    trace_block_job_apply_verb(job, qapi_enum_lookup(&BlockJobStatus_loo=
kup,
-                                                     job->status),
-                               qapi_enum_lookup(&BlockJobVerb_lookup, bv=
),
+    trace_block_job_apply_verb(job, BlockJobStatus_str(job->status),
+                               BlockJobVerb_str(bv),
                                BlockJobVerbTable[bv][job->status] ?
                                "allowed" : "prohibited");
     if (BlockJobVerbTable[bv][job->status]) {
         return 0;
     }
     error_setg(errp, "Job '%s' in state '%s' cannot accept command verb =
'%s'",
-               job->id, qapi_enum_lookup(&BlockJobStatus_lookup, job->st=
atus),
-               qapi_enum_lookup(&BlockJobVerb_lookup, bv));
+               job->id, BlockJobStatus_str(job->status), BlockJobVerb_st=
r(bv));
     return -EPERM;
 }
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
