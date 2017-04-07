Received: from eggs.gnu.org ([2001:4830:134:3::10]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcFl-0007vf-OK
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwcFj-00051V-3z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:21:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  7 Apr 2017 19:20:13 -0300
Message-Id: <20170407222016.15308-2-f4bug@amsat.org>
In-Reply-To: <20170407222016.15308-1-f4bug@amsat.org>
References: <20170407222016.15308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] usb-ccid: make ccid_write_data_block()
 cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

static code analyzer complain:

hw/usb/dev-smartcard-reader.c:816:5: warning: Null pointer passed as an argument to a 'nonnull' parameter
    memcpy(p->abData, data, len);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-smartcard-reader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 757b8b3f5a..49cb1829b5 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -813,7 +813,10 @@ static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
     if (p->b.bError) {
         DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
     }
-    memcpy(p->abData, data, len);
+    if (len) {
+        g_assert_nonnull(data);
+        memcpy(p->abData, data, len);
+    }
     ccid_reset_error_status(s);
     usb_wakeup(s->bulk, 0);
 }
-- 
2.11.0
