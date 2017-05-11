Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8n7X-0005sc-2l
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8n7W-0007VK-9V
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8n7W-0007Uv-34
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C0514DD49
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:23:01 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 May 2017 20:22:38 +0800
Message-Id: <1494505358-15287-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1494505358-15287-1-git-send-email-peterx@redhat.com>
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 4/4] utils: remove assert in size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

It's not very safe to assert in size_to_str(). Let's be inclusive.

It naturally allows negative values. Now it won't even limit on the
size, as long as double would allow.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/cutils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index fa5ddec..8df0963 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -622,7 +622,7 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
 
 /*
  * Return human readable string for size @val.
- * @val must be between (-1000Eib, 1000EiB), exclusively.
+ * @val can be any value.
  * Use IEC binary units like KiB, MiB, and so forth.
  * Caller is responsible for passing it to g_free().
  */
@@ -640,7 +640,12 @@ char *size_to_str(double val)
      */
     frexp(val / (1000.0 / 1024.0), &i);
     i = (i - 1) / 10;
-    assert(i < ARRAY_SIZE(suffixes));
+
+    /* Use the biggest possible suffix */
+    if (i > ARRAY_SIZE(suffixes) - 1) {
+        i = ARRAY_SIZE(suffixes) - 1;
+    }
+
     div = 1ULL << (i * 10);
 
     return g_strdup_printf("%0.3g %sB", val / div, suffixes[i]);
-- 
2.7.4
