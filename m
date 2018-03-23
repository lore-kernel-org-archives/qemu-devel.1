Received: from eggs.gnu.org ([2001:4830:134:3::10]:56510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezOdi-0006Yi-Pv
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezOdh-00054L-UI
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:29:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezOdh-00050K-MY
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:29:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 15:29:48 +0000
Message-Id: <20180323152948.27048-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] chardev/char-fe: Allow NULL chardev
 in qemu_chr_fe_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>

All the functions in char-fe.c handle the CharBackend
having a NULL Chardev pointer, which means that the
backend exists but is not connected to anything. The
exception is qemu_chr_fe_init(), which will crash if
passed a NULL Chardev pointer argument. This can happen
for various boards if they're started with 'nodefaults':
 arm-softmmu/qemu-system-arm -S -nodefaults -M cubieboard
 riscv32-softmmu/qemu-system-riscv32 -nodefaults -M sifive_e

Make qemu_chr_fe_init() accept a NULL chardev. This allows
UART models to handle NULL chardev properties without
generally needing to special case them or to manually
create a NullChardev.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is my proposal for fixing the crashes with -nodefaults.
I think we should also change hw/char/serial.c to accept
a NULL Chardev rather than treating it as an error
( "Can't create serial device, empty char device"), and
similarly for any other devices that currently error out
on NULL chardevs. I'd rather postpone that part til 2.13, though.


 chardev/char-fe.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 392db78b13..b1f228e8b5 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -198,19 +198,21 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
 
-    if (CHARDEV_IS_MUX(s)) {
-        MuxChardev *d = MUX_CHARDEV(s);
+    if (s) {
+        if (CHARDEV_IS_MUX(s)) {
+            MuxChardev *d = MUX_CHARDEV(s);
 
-        if (d->mux_cnt >= MAX_MUX) {
+            if (d->mux_cnt >= MAX_MUX) {
+                goto unavailable;
+            }
+
+            d->backends[d->mux_cnt] = b;
+            tag = d->mux_cnt++;
+        } else if (s->be) {
             goto unavailable;
+        } else {
+            s->be = b;
         }
-
-        d->backends[d->mux_cnt] = b;
-        tag = d->mux_cnt++;
-    } else if (s->be) {
-        goto unavailable;
-    } else {
-        s->be = b;
     }
 
     b->fe_open = false;
-- 
2.16.2
