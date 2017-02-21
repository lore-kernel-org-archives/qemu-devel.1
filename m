Received: from eggs.gnu.org ([2001:4830:134:3::10]:37220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgFb3-0007Ea-HD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgFb1-0006os-TB
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgFb1-0006nT-NL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:31 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3DDBC05678C
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:55:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 21 Feb 2017 18:55:25 +0000
Message-Id: <20170221185527.3901-2-dgilbert@redhat.com>
In-Reply-To: <20170221185527.3901-1-dgilbert@redhat.com>
References: <20170221185527.3901-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] hmp: fix block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, phrdina@redhat.com, thuth@redhat.com

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
---
 hmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hmp.c b/hmp.c
index 2bc4f06..0c80596 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1552,6 +1552,7 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     BlockIOThrottle throttle = {
+        .has_device = true,
         .device = (char *) qdict_get_str(qdict, "device"),
         .bps = qdict_get_int(qdict, "bps"),
         .bps_rd = qdict_get_int(qdict, "bps_rd"),
-- 
2.9.3
