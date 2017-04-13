Received: from eggs.gnu.org ([2001:4830:134:3::10]:34730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhJn-0008T1-VC
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhJl-0005A0-8Q
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cyhJl-00059c-21
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 253883D8
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 16:09:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 18:09:52 +0200
Message-Id: <20170413160952.29918-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] util/error: Fix leak in error_vprepend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 util/error.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/error.c b/util/error.c
index 9c40b1f458..020b86b9f0 100644
--- a/util/error.c
+++ b/util/error.c
@@ -134,6 +134,7 @@ void error_vprepend(Error **errp, const char *fmt, va_list ap)
     newmsg = g_string_new(NULL);
     g_string_vprintf(newmsg, fmt, ap);
     g_string_append(newmsg, (*errp)->msg);
+    g_free((*errp)->msg);
     (*errp)->msg = g_string_free(newmsg, 0);
 }
 
-- 
2.12.2
