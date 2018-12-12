Received: from eggs.gnu.org ([2001:4830:134:3::10]:46706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZC-0003QQ-DT
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZB-0001jV-HV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:26 +0100
Message-Id: <20181212132735.16080-33-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/41] block: Use bdrv_reopen_set_read_only() in
 external_snapshot_commit()
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

From: Alberto Garcia <berto@igalia.com>

This patch replaces the bdrv_reopen() call that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6fa6969cd0..e6c8349409 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1703,8 +1703,7 @@ static void external_snapshot_commit(BlkActionState=
 *common)
      * bdrv_reopen_multiple() across all the entries at once, because we
      * don't want to abort all of them if one of them fails the reopen *=
/
     if (!atomic_read(&state->old_bs->copy_on_read)) {
-        bdrv_reopen(state->old_bs, state->old_bs->open_flags & ~BDRV_O_R=
DWR,
-                    NULL);
+        bdrv_reopen_set_read_only(state->old_bs, true, NULL);
     }
=20
     aio_context_release(aio_context);
--=20
2.19.2
