Received: from eggs.gnu.org ([2001:4830:134:3::10]:57968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9fY0-00087n-3m
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9fXw-0008S4-EC
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1e9fXw-0008RV-7t
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:12 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 31 Oct 2017 19:02:06 -0400
Message-Id: <20171031230206.32731-3-jsnow@redhat.com>
In-Reply-To: <20171031230206.32731-1-jsnow@redhat.com>
References: <20171031230206.32731-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] ide: avoid referencing NULL dev in
 rotational rate setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The 'dev' variable can be NULL when the guest OS calls identify on an IDE
unit that does not have a drive attached to it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171020091403.1479-1-berrange@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index a04766a..471d0c9 100644
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
2.9.5
