Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfw-0000to-Iu
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfq-0007LA-KL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:07:00 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:06:01 +0100
Message-Id: <20181112170603.23986-13-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/14] qemu-img: assert block_job_get() does not
 return NULL in img_commit()
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

Although the function block_job_get() can return NULL, it would be a
serious bug if it did so (because the job yields before executing anythin=
g
(if it started successfully); but otherwise, commit_active_start() would
have returned an error).  However, as a precaution, before dereferencing
the 'job' pointer in img_commit() assert it is not NULL.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 1541453919-25973-4-git-send-email-Liam.Merwick@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index 4c96db7ba4..13a6ca31b4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1029,6 +1029,7 @@ static int img_commit(int argc, char **argv)
     }
=20
     job =3D block_job_get("commit");
+    assert(job);
     run_block_job(job, &local_err);
     if (local_err) {
         goto unref_backing;
--=20
2.19.1
