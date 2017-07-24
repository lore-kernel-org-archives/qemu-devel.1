Received: from eggs.gnu.org ([2001:4830:134:3::10]:50463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6J-0000aT-3s
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6H-00059J-EP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:03 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6H-00058t-An
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:01 -0400
Received: by mail-qk0-x241.google.com with SMTP id k2so3225574qkf.2
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:29:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:34 -0300
Message-Id: <20170724182751.18261-19-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 18/35] usb/dev-mtp: fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

hw/usb/dev-mtp.c:971:5: warning: 4th function call argument is an uninitialized value
    trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path,
                                         c->argv[1], c->argv[2]);
                                                     ^~~~~~~~~~
hw/usb/dev-mtp.c:981:12: warning: Assigned value is garbage or undefined
    offset = c->argv[1];
           ^ ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/dev-mtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index ad64495f05..b4f0b5dafd 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -965,12 +965,16 @@ static MTPData *usb_mtp_get_object(MTPState *s, MTPControl *c,
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
2.13.3
