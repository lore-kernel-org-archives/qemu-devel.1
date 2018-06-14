Received: from eggs.gnu.org ([2001:4830:134:3::10]:60940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRbF-0001F7-5e
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRbB-0005K3-5L
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTRbB-0005Jg-0s
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4457C80125D6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:43:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 14:43:29 +0200
Message-Id: <20180614124330.12224-3-armbru@redhat.com>
In-Reply-To: <20180614124330.12224-1-armbru@redhat.com>
References: <20180614124330.12224-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 2/3] coverity-model: replay data is
 considered trusted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Replay data is not considered a possible attack vector; add a model that
does not use getc so that "tainted data" warnings are suppressed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180514141218.28438-1-pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Whitespace tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/coverity-model.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
index c702804f41..2ec753db05 100644
--- a/scripts/coverity-model.c
+++ b/scripts/coverity-model.c
@@ -103,6 +103,18 @@ static int get_keysym(const name2keysym_t *table,
     }
 }
 
+/* Replay data is considered trusted.  */
+uint8_t replay_get_byte(void)
+{
+    uint8_t byte = 0;
+    if (replay_file) {
+        uint8_t c;
+        byte = c;
+    }
+    return byte;
+}
+
+
 /*
  * GLib memory allocation functions.
  *
-- 
2.17.1
