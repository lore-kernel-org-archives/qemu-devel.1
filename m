Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R7-00028X-Bx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qw-0005I4-7B
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qv-0005G3-Rk
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YJp125229
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:48 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ajjr0ed1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:48 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:48 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:35 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-72-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 71/81] hmp: fix block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Eric Blake <eblake@redhat.com>

Commit 7a9877a made the 'device' parameter to BlockIOThrottle
optional, favoring 'id' instead.  But it forgot to update the
HMP usage to set has_device, which makes all attempts to change
throttling via HMP fail with "Need exactly one of 'device' and 'id'"

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170120230359.4244-1-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 3f35c3b166c18043596768448e5d91b5d52f8353)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hmp.c b/hmp.c
index b869617..a3dc9d6 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1551,6 +1551,7 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     BlockIOThrottle throttle = {
+        .has_device = true,
         .device = (char *) qdict_get_str(qdict, "device"),
         .bps = qdict_get_int(qdict, "bps"),
         .bps_rd = qdict_get_int(qdict, "bps_rd"),
-- 
2.7.4
