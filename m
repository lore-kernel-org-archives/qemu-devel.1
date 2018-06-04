Received: from eggs.gnu.org ([2001:4830:134:3::10]:36530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBu-0005hG-0h
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBt-0001i6-3O
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:37 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:37784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBs-0001hl-Tt
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:37 -0400
Received: by mail-qk0-x22d.google.com with SMTP id j12-v6so21826495qkk.4
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:14:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:14:21 -0300
Message-Id: <20180604151421.23385-4-f4bug@amsat.org>
In-Reply-To: <20180604151421.23385-1-f4bug@amsat.org>
References: <20180604151421.23385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/3] usb/dev-mtp: Fix use of uninitialized
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This fixes:

  hw/usb/dev-mtp.c:1212:13: warning: 2nd function call argument is an uninitialized value
      o = usb_mtp_object_lookup(s, c->argv[0]);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-mtp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index b0ab6a7912..dd96c91cf9 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1281,6 +1281,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
     MTPData *data_in = NULL;
     MTPObject *o = NULL;
     uint32_t nres = 0, res0 = 0;
+    int i;
 
     /* sanity checks */
     if (c->code >= CMD_CLOSE_SESSION && s->session == 0) {
@@ -1289,6 +1290,10 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         return;
     }
 
+    for (i = c->argc; i < ARRAY_SIZE(c->argv); i++) {
+        c->argv[i] = 0;
+    }
+
     /* process commands */
     switch (c->code) {
     case CMD_GET_DEVICE_INFO:
-- 
2.17.1
