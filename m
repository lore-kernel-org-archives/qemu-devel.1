Received: from eggs.gnu.org ([2001:4830:134:3::10]:45849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIEDC-00020r-3V
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIED8-0002ri-5E
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:12:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIED8-0002rH-10
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:12:22 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 May 2018 16:12:18 +0200
Message-Id: <20180514141218.28438-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] coverity-model: replay data is considered
 trusted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Markus Armbruster <armbru@redhat.com>

Replay data is not considered a possible attack vector; add a model that
does not use getc so that "tainted data" warnings are suppressed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-model.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
index c702804f41..576f48de33 100644
--- a/scripts/coverity-model.c
+++ b/scripts/coverity-model.c
@@ -103,6 +103,19 @@ static int get_keysym(const name2keysym_t *table,
     }
 }
 
+
+/* Replay data is considered trusted.  */
+uint8_t replay_get_byte(void)
+{
+     uint8_t byte = 0;
+     if (replay_file) {
+         uint8_t c;
+         byte = c;
+     }
+     return byte;
+}
+
+
 /*
  * GLib memory allocation functions.
  *
-- 
2.17.0
