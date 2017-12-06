Received: from eggs.gnu.org ([2001:4830:134:3::10]:50135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCq-00019U-EK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCn-00019z-37
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCm-00018o-Qf
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE3I5043514
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:04 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5esk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:03 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:18:03 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:46 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-54-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/55] nbd/client: Don't hard-disconnect on
 ESHUTDOWN from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

The NBD spec says that a server may fail any transmission request
with ESHUTDOWN when it is apparent that no further request from
the client can be successfully honored.  The client is supposed
to then initiate a soft shutdown (wait for all remaining in-flight
requests to be answered, then send NBD_CMD_DISC).  However, since
qemu's server never uses ESHUTDOWN errors, this code was mostly
untested since its introduction in commit b6f5d3b5.

More recently, I learned that nbdkit as the NBD server is able to
send ESHUTDOWN errors, so I finally tested this code, and noticed
that our client was special-casing ESHUTDOWN to cause a hard
shutdown (immediate disconnect, with no NBD_CMD_DISC), but only
if the server sends this error as a simple reply.  Further
investigation found that commit d2febedb introduced a regression
where structured replies behave differently than simple replies -
but that the structured reply behavior is more in line with the
spec (even if we still lack code in nbd-client.c to properly quit
sending further requests).  So this patch reverts the portion of
b6f5d3b5 that introduced an improper hard-disconnect special-case
at the lower level, and leaves the future enhancement of a nicer
soft-disconnect at the higher level for another day.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171113194857.13933-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit 01b05c66a3616d5a4adc39fc90962e9efaf791d1)
 Conflicts:
	nbd/client.c
*drop dep on d2febedb
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/client.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 4caff77119..f04e95542f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -945,12 +945,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     reply->handle = ldq_be_p(buf + 8);
 
     reply->error = nbd_errno_to_system_errno(reply->error);
-
-    if (reply->error == ESHUTDOWN) {
-        /* This works even on mingw which lacks a native ESHUTDOWN */
-        error_setg(errp, "server shutting down");
-        return -EINVAL;
-    }
     trace_nbd_receive_reply(magic, reply->error, reply->handle);
 
     if (magic != NBD_REPLY_MAGIC) {
-- 
2.11.0
