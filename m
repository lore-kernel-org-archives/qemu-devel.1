Received: from eggs.gnu.org ([2001:4830:134:3::10]:53514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOm-0003vR-TE
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOl-0006v1-OU
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOl-0006ug-IK
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91564C059757
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:46 +0200
Message-Id: <1493018820-23445-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] util/error: Fix leak in error_vprepend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20170413160952.29918-1-mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/error.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/error.c b/util/error.c
index 9c40b1f..020b86b 100644
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
2.7.4
