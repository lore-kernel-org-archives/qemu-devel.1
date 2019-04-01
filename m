Received: from eggs.gnu.org ([209.51.188.92]:41232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44w-0001hy-KK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44v-0003fR-Bi
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59628
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44v-0003ZO-3f
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1r0W095832
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:38 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegxvh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:37 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:37 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:30 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-57-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 56/97] nbd: fix NBD_FLAG_SEND_CACHE value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Valery Vdovin <valery.vdovin@acronis.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: "Denis V. Lunev" <den@openvz.org>

Commit bc37b06a5 added NBD_CMD_CACHE support, but used the wrong value
for NBD_FLAG_SEND_CACHE flag for negotiation. That commit picked bit 8,
which had already been assigned by the NBD specification to mean
NBD_FLAG_CAN_MULTI_CONN, and which was already implemented in the
Linux kernel as a part of stable userspace-kernel API since 4.10:

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

Consequences:
- a client trying to use NBD_CMD_CACHE per the NBD spec will not
see the feature as available from a qemu 3.0 server (not fatal,
clients already have to be prepared for caching to not exist)
- a client accidentally coded to the qemu 3.0 bit value instead
of following the spec may interpret NBD_CMD_CACHE as being available
when it is not (probably not fatal, the spec says the server should
gracefully fail unknown commands, and that clients of NBD_CMD_CACHE
should be prepared for failure even when the feature is advertised);
such clients are unlikely (perhaps only in unreleased Virtuozzo code),
and will disappear over time
- a client prepared to use multiple connections based on
NBD_FLAG_CAN_MULTI_CONN may cause data corruption when it assumes
that caching is consistent when in reality qemu 3.0 did not have
a consistent cache. Partially mitigated by using read-only
connections (where nothing needs to be flushed, so caching is
indeed consistent) or when using qemu-nbd with the default -e 1
(at most one client at a time); visible only when using -e 2 or
more for a writable export.

Thus the commit fixes negotiation flag in QEMU according to the
specification.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Valery Vdovin <valery.vdovin@acronis.com>
CC: Eric Blake <eblake@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-stable@nongnu.org
Message-Id: <20181004100313.4253-1-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: enhance commit message, add defines for unimplemented flags]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit df91328adab8490367776d2b21b35d790a606120)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/block/nbd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4638c839f5..a53b0cfae0 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -135,7 +135,9 @@ typedef struct NBDExtent {
 #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
 #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
 #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
-#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) */
+#define NBD_FLAG_CAN_MULTI_CONN    (1 << 8) /* Multi-client cache consistent */
+#define NBD_FLAG_SEND_RESIZE       (1 << 9) /* Send resize */
+#define NBD_FLAG_SEND_CACHE        (1 << 10) /* Send CACHE (prefetch) */
 
 /* New-style handshake (global) flags, sent from server to client, and
    control what will happen during handshake phase. */
-- 
2.17.1
