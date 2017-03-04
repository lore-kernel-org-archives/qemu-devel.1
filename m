Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqq-0005rI-H0
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqp-0007Sl-M7
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:20 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqp-0007SX-Hd
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:19 -0500
Received: by mail-qk0-x242.google.com with SMTP id j127so16932260qke.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:56:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:55:31 -0300
Message-Id: <20170304185533.10618-2-f4bug@amsat.org>
In-Reply-To: <20170304185533.10618-1-f4bug@amsat.org>
References: <20170304185533.10618-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] usb-ccid: make ccid_write_data_block()
 cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

static code analyzer complain:

hw/usb/dev-smartcard-reader.c:816:5: warning: Null pointer passed as an argument to a 'nonnull' parameter
    memcpy(p->abData, data, len);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-smartcard-reader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 757b8b3f5a..c38a4e5886 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -799,8 +799,14 @@ static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
 static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
                                   const uint8_t *data, uint32_t len)
 {
-    CCID_DataBlock *p = ccid_reserve_recv_buf(s, sizeof(*p) + len);
+    CCID_DataBlock *p;
 
+    if (len == 0) {
+        return;
+    }
+    g_assert(data != NULL);
+
+    p = ccid_reserve_recv_buf(s, sizeof(*p) + len);
     if (p == NULL) {
         return;
     }
-- 
2.11.0
