Received: from eggs.gnu.org ([2001:4830:134:3::10]:38175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPo-0002PG-Pu
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEZPm-0003Bb-7j
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEZPl-0002xc-PB
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 238B2316499A
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 12:34:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 Oct 2018 14:34:12 +0200
Message-Id: <20181022123413.28044-40-armbru@redhat.com>
In-Reply-To: <20181022123413.28044-1-armbru@redhat.com>
References: <20181022123413.28044-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 39/40] vpc: Fail open on bad header checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

vpc_open() merely prints a warning when it finds a bad header
checksum.  Turn that into a hard error.

Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181017082702.5581-39-armbru@redhat.com>
[Error message capitalized for local consistency]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index bf294abfa7..984187cadd 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -284,9 +284,11 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
 
     checksum = be32_to_cpu(footer->checksum);
     footer->checksum = 0;
-    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
-        fprintf(stderr, "block-vpc: The header checksum of '%s' is "
-            "incorrect.\n", bs->filename);
+    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum) {
+        error_setg(errp, "Incorrect header checksum");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     /* Write 'checksum' back to footer, or else will leave it with zero. */
     footer->checksum = cpu_to_be32(checksum);
-- 
2.17.2
