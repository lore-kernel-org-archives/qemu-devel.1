Received: from eggs.gnu.org ([2001:4830:134:3::10]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ8-0006h8-UL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ7-000734-Sc
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:06 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ7-00072g-MD
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:05 -0400
Received: by mail-wr0-x242.google.com with SMTP id d10so18957559wrf.3
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:37:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:42 +0200
Message-Id: <1522071403-52486-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/16] chardev/char-fe: Allow NULL chardev in
 qemu_chr_fe_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
Message-Id: <20180323152948.27048-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fe.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 392db78..b1f228e 100644
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
+
+            if (d->mux_cnt >= MAX_MUX) {
+                goto unavailable;
+            }
 
-        if (d->mux_cnt >= MAX_MUX) {
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
1.8.3.1
