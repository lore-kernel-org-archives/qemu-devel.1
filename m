Received: from eggs.gnu.org ([2001:4830:134:3::10]:36508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBr-0005gK-RM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBq-0001g1-Vw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:35 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:39193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBq-0001fJ-Rk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:34 -0400
Received: by mail-qk0-x232.google.com with SMTP id g14-v6so12898759qkm.6
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:14:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:14:20 -0300
Message-Id: <20180604151421.23385-3-f4bug@amsat.org>
In-Reply-To: <20180604151421.23385-1-f4bug@amsat.org>
References: <20180604151421.23385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/3] usb/dev-mtp: Fix use of uninitialized
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

  hw/usb/dev-mtp.c:971:5: warning: 4th function call argument is an uninitialized value
      trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path,
                                           c->argv[1], c->argv[2]);
                                                       ^~~~~~~~~~
and:

  hw/usb/dev-mtp.c:981:12: warning: Assigned value is garbage or undefined
      offset = c->argv[1];
               ^ ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-mtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 560c61c7c1..b0ab6a7912 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1017,12 +1017,16 @@ static MTPData *usb_mtp_get_object(MTPState *s, MTPControl *c,
 static MTPData *usb_mtp_get_partial_object(MTPState *s, MTPControl *c,
                                            MTPObject *o)
 {
-    MTPData *d = usb_mtp_data_alloc(c);
+    MTPData *d;
     off_t offset;
 
+    if (c->argc <= 2) {
+        return NULL;
+    }
     trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path,
                                         c->argv[1], c->argv[2]);
 
+    d = usb_mtp_data_alloc(c);
     d->fd = open(o->path, O_RDONLY);
     if (d->fd == -1) {
         usb_mtp_data_free(d);
-- 
2.17.1
