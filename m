Received: from eggs.gnu.org ([2001:4830:134:3::10]:53591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5TNd-0003Qr-39
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5TNc-0008WA-9j
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:14:13 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 20 Oct 2017 10:14:03 +0100
Message-Id: <20171020091403.1479-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] ide: avoid referencing NULL dev in rotational
 rate setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 'dev' variable can be NULL when the guest OS calls identify on an IDE
unit that does not have a drive attached to it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/ide/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index a04766aee7..471d0c928b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -208,7 +208,9 @@ static void ide_identify(IDEState *s)
     if (dev && dev->conf.discard_granularity) {
         put_le16(p + 169, 1); /* TRIM support */
     }
-    put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */
+    if (dev) {
+        put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */
+    }
 
     ide_identify_size(s);
     s->identify_set = 1;
-- 
2.13.6
