Received: from eggs.gnu.org ([2001:4830:134:3::10]:54157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNgRC-0002E7-Rw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNgR3-0000Yq-Ow
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:53:34 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 16 Nov 2018 16:53:01 +0100
Message-Id: <20181116155302.22472-3-mreitz@redhat.com>
In-Reply-To: <20181116155302.22472-1-mreitz@redhat.com>
References: <20181116155302.22472-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1? 2/3] file-posix: Fix shared locks on
 reopen commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

s->locked_shared_perm is the set of bits locked in the file, which is
the inverse of the permissions actually shared.  So we need to pass them
as they are to raw_apply_lock_bytes() instead of inverting them again.

Reported-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index df3a8d7cdf..8460d003f0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -963,7 +963,7 @@ static void raw_reopen_commit(BDRVReopenState *state)
 
     /* Copy locks to the new fd before closing the old one. */
     raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
-                         ~s->locked_shared_perm, false, &local_err);
+                         s->locked_shared_perm, false, &local_err);
     if (local_err) {
         /* shouldn't fail in a sane host, but report it just in case. */
         error_report_err(local_err);
-- 
2.17.2
