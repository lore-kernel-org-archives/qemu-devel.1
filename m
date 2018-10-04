Received: from eggs.gnu.org ([2001:4830:134:3::10]:40210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1g80T9-0001Wp-Gj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1g80T6-0007Pa-6C
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 06:02:55 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Thu,  4 Oct 2018 13:03:13 +0300
Message-Id: <20181004100313.4253-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] nbd: fix NBD_CMD_CACHE negitiation
 according to the NBD specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Valery Vdovin <valery.vdovin@acronis.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Commit bc37b06a5 was made very bad thing, it has been added
NBD_FLAG_SEND_CACHE flag for negotiation. The problem is that the value
of the flag was taken wrong and directly violates NBD specification.
This value (bit 8) is used at least in the Linux kernel as a part of
stable userspace-kernel API since 4.10 as NBD_FLAG_CAN_MULTI_CONN
as defined in the specification:

"bit 8, NBD_FLAG_CAN_MULTI_CONN: Indicates that the server operates
entirely without cache, or that the cache it uses is shared among all
connections to the given device. In particular, if this flag is
present, then the effects of NBD_CMD_FLUSH and NBD_CMD_FLAG_FUA
MUST be visible across all connections when the server sends its reply
to that command to the client. In the absense of this flag, clients
SHOULD NOT multiplex their commands over more than one connection to
the export.
...
bit 10, NBD_FLAG_SEND_CACHE: documents that the server understands
NBD_CMD_CACHE; however, note that server implementations exist
which support the command without advertising this bit, and
conversely that this bit does not guarantee that the command will
succeed or have an impact."

Personally I do not see any option that we will be allowed to fix the
specification in favor of QEMU and apply the fix to the kernel. This
is a big-big problem. Let us fix this in QEMU as soon as possible.

Thus the commit fixes negotiation flag in QEMU accoring to the
specification. Fortunately enough the bit has been added by Virtuozzo
and there are no released products in the field with this bit used
so far.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Valery Vdovin <valery.vdovin@acronis.com>
CC: Eric Blake <eblake@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/nbd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4638c839f5..4377fa502c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -135,7 +135,7 @@ typedef struct NBDExtent {
 #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
 #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
-#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) */
+#define NBD_FLAG_SEND_CACHE        (1 << 10) /* Send CACHE (prefetch) */
 
 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
-- 
2.17.1
