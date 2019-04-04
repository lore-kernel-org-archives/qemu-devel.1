Received: from eggs.gnu.org ([209.51.188.92]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hC3jL-0006KN-Ql
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hC3jJ-00073m-SQ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:52:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  4 Apr 2019 09:52:26 -0500
Message-Id: <20190404145226.32649-1-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0? 8/7] nbd/client: Fix error message for
 server with unusable sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

Add a missing space to the error message used when giving up on a
server that insists on an alignment which renders the last few bytes
of the export unreadable.

Fixes: 3add3ab78
Signed-off-by: Eric Blake <eblake@redhat.com>
---

We've already concluded that 5-7 are too risky for 4.0 (so qemu 4.0
NBD servers will have non-compliance issues in alignment corner cases,
although in fewer places than where 3.1 had similar bugs; and the 4.0
client is able to work around those non-compliance cases).  But I'd
still like a review on 1-3 and this patch 8, as trivial improvements
worth having in 4.0. I'm borderline on whether having patch 4 in 4.0
adds any value.

 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 427980bdd22..4de30630c73 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -428,7 +428,7 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32=
_t opt,
             }
             if (info->min_block &&
                 !QEMU_IS_ALIGNED(info->size, info->min_block)) {
-                error_setg(errp, "export size %" PRIu64 "is not multiple=
 of "
+                error_setg(errp, "export size %" PRIu64 " is not multipl=
e of "
                            "minimum block size %" PRIu32, info->size,
                            info->min_block);
                 nbd_send_opt_abort(ioc);
--=20
2.20.1
