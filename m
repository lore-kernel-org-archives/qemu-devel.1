Received: from eggs.gnu.org ([2001:4830:134:3::10]:55940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1djtgk-0002fO-B6
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1djtgh-00019p-Oc
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:52:46 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:36536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1djtgh-000194-Jr
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:52:43 -0400
Received: by mail-it0-x241.google.com with SMTP id 190so2221850itx.3
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 13:52:42 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 21 Aug 2017 16:52:23 -0400
Message-Id: <20170821205225.3401-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] ui/cocoa.m: send ctrl-alt key combinations
 to guest if not used by QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org qemu-devel peter . maydell @ linaro . org" <qemu-devel@nongnu.org>
Cc: John Arbuckle <programmingkidx@gmail.com>

Send control-alt key combinations to the guest if not used by the user interface.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index d3e7907103..6920ea38aa 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -634,6 +634,14 @@ - (void) handleEvent:(NSEvent *)event
                     case Q_KEY_CODE_G:
                         [self ungrabMouse];
                         break;
+
+                    // send to the guest
+                    default:
+                        if (qemu_console_is_graphic(NULL)) {
+                            qemu_input_event_send_key_qcode(dcl->con, keycode,
+                                                            true);
+                        }
+                    break;
                 }
 
             // handle keys for graphic console
-- 
2.11.0 (Apple Git-81)
