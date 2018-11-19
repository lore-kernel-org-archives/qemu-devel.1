Received: from eggs.gnu.org ([2001:4830:134:3::10]:46965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZJ-0001Xi-CJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZD-0007Cm-N8
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:43 +0100
Message-Id: <20181119142944.29061-9-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] file-posix: Fix shared locks on reopen
 commit
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

From: Max Reitz <mreitz@redhat.com>

s->locked_shared_perm is the set of bits locked in the file, which is
the inverse of the permissions actually shared.  So we need to pass them
as they are to raw_apply_lock_bytes() instead of inverting them again.

Reported-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 58c86a01ea..07bbdab953 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -959,7 +959,7 @@ static void raw_reopen_commit(BDRVReopenState *state)
=20
     /* Copy locks to the new fd before closing the old one. */
     raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
-                         ~s->locked_shared_perm, false, &local_err);
+                         s->locked_shared_perm, false, &local_err);
     if (local_err) {
         /* shouldn't fail in a sane host, but report it just in case. */
         error_report_err(local_err);
--=20
2.19.1
