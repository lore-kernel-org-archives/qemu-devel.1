Received: from eggs.gnu.org ([2001:4830:134:3::10]:33769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rE-0005L0-4Z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rC-0004Db-MG
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:28 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rC-0004D7-G4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:26 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so58233815wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:40 +0100
Message-Id: <1485524749-118532-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/41] bt: use qemu_chr_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use common allocator for CharDriverState.

Rename the now untouched parent field.

The casts added are temporary, they are replaced with QOM type-safe
macros in a later patch in this series.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/bt/hci-csr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index bf2deb0..e2c78b8 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -26,9 +26,10 @@
 #include "hw/irq.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
+#include "qapi/error.h"
 
 struct csrhci_s {
-    CharDriverState chr;
+    CharDriverState parent;
     int enable;
     qemu_irq *pins;
     int pin_state;
@@ -78,7 +79,8 @@ enum {
 
 static inline void csrhci_fifo_wake(struct csrhci_s *s)
 {
-    CharBackend *be = s->chr.be;
+    CharDriverState *chr = (CharDriverState *)s;
+    CharBackend *be = chr->be;
 
     if (!s->enable || !s->out_len)
         return;
@@ -468,10 +470,15 @@ CharDriverState *uart_hci_init(void)
         .chr_write = csrhci_write,
         .chr_ioctl = csrhci_ioctl,
     };
-    struct csrhci_s *s = (struct csrhci_s *)
-            g_malloc0(sizeof(struct csrhci_s));
+    Error *err = NULL;
+    ChardevCommon common = { 0, };
+    CharDriverState *chr = qemu_chr_alloc(&hci_driver, &common, &err);
+    struct csrhci_s *s = (struct csrhci_s *)chr;
 
-    s->chr.driver = &hci_driver;
+    if (err) {
+        error_report_err(err);
+        return NULL;
+    }
 
     s->hci = qemu_next_hci();
     s->hci->opaque = s;
@@ -482,5 +489,5 @@ CharDriverState *uart_hci_init(void)
     s->pins = qemu_allocate_irqs(csrhci_pins, s, __csrhci_pins);
     csrhci_reset(s);
 
-    return &s->chr;
+    return chr;
 }
-- 
1.8.3.1
