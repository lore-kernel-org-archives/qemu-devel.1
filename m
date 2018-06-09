Received: from eggs.gnu.org ([2001:4830:134:3::10]:46531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRgnb-00064n-7s
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 12:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRgnW-0007r7-Bh
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 12:33:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fRgnW-0007qx-6n
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 12:33:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  9 Jun 2018 17:32:52 +0100
Message-Id: <20180609163252.27506-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de, Stefan Hajnoczi <stefanha@redhat.com>

It turns out that GNU binutils emits START_SEG_ADDR_RECORD when the start
address is within the first megabyte (< 0x100000).  Therefore we must
handle this record type.

Originally we thought this record type was x86-specific, but binutils
also emits it on non-x86 architectures.

Based-on: <1527161340-3200-1-git-send-email-suhang16@mails.ucas.ac.cn>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Su Hang: Feel free to squash this into the next revision of your hex
loader patch.  Don't worry about the authorship information.

 hw/core/loader.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 3c0202caa8..7843b487b2 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1423,8 +1423,14 @@ static int handle_record_type(HexParser *parser)
         break;
 
     case START_SEG_ADDR_RECORD:
-        /* TODO: START_SEG_ADDR_RECORD is x86-specific */
-        return -1;
+        if (line->byte_count != 4 && line->address != 0) {
+            return -1;
+        }
+
+        /* x86 16-bit CS:IP segmented addressing */
+        *(parser->start_addr) = (((line->data[0] << 8) | line->data[1]) << 4) |
+                                (line->data[2] << 8) | line->data[3];
+        break;
 
     case START_LINEAR_ADDR_RECORD:
         if (line->byte_count != 4 && line->address != 0) {
-- 
2.17.1
