Received: from eggs.gnu.org ([209.51.188.92]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxco-00025N-H0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcm-0004sT-CJ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:59 -0500
Message-Id: <20190401140903.19186-11-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/14] nbd/client: Reject inaccessible tail of
 inconsistent server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec suggests that a server should never advertise a size
inconsistent with its minimum block alignment, as that tail is
effectively inaccessible to a compliant client obeying those block
constraints. Since we have a habit of rounding up rather than
truncating, to avoid losing the last few bytes of user input, and we
cannot access the tail when the server advertises bogus block sizing,
abort the connection to alert the server to fix their bug.  And
rejecting such servers matches what we already did for a min_block
that was not a power of 2 or which was larger than max_block.

Does not impact either qemu (which always sends properly aligned
sizes) or nbdkit (which does not send minimum block requirements yet);
so this is mostly aimed at new NBD server implementations, and ensures
that the rest of our code can assume the size is aligned.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190330155704.24191-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/nbd/client.c b/nbd/client.c
index de7da48246b..427980bdd22 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -426,6 +426,14 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint3=
2_t opt,
                 nbd_send_opt_abort(ioc);
                 return -1;
             }
+            if (info->min_block &&
+                !QEMU_IS_ALIGNED(info->size, info->min_block)) {
+                error_setg(errp, "export size %" PRIu64 "is not multiple=
 of "
+                           "minimum block size %" PRIu32, info->size,
+                           info->min_block);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
             trace_nbd_receive_negotiate_size_flags(info->size, info->fla=
gs);
             break;

--=20
2.20.1
