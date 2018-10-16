Received: from eggs.gnu.org ([2001:4830:134:3::10]:56818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMA-00066m-TA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM9-0000Dd-2S
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM8-0000Bd-Mn
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF8C3C0587CE
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E5855C2E1
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:58 +0200
Message-Id: <20181016174158.15229-39-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 38/38] vpc: Fail open on bad header checksum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

vpc_open() merely prints a warning when it finds a bad header
checksum.  Turn that into a hard error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/vpc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index bf294abfa7..1729c0cb44 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -284,9 +284,11 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
 
     checksum = be32_to_cpu(footer->checksum);
     footer->checksum = 0;
-    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum)
-        fprintf(stderr, "block-vpc: The header checksum of '%s' is "
-            "incorrect.\n", bs->filename);
+    if (vpc_checksum(s->footer_buf, HEADER_SIZE) != checksum) {
+        error_setg(errp, "incorrect header checksum");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     /* Write 'checksum' back to footer, or else will leave it with zero. */
     footer->checksum = cpu_to_be32(checksum);
-- 
2.17.1
