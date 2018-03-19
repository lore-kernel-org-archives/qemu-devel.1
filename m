Received: from eggs.gnu.org ([2001:4830:134:3::10]:52555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exwGt-0000U4-Lt
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exwGp-0006Ft-J1
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:00:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1exwGp-0006FH-Ai
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:00:19 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Mar 2018 16:00:16 +0100
Message-Id: <1521471616-24157-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/char/serial: Fix crash when
 serial_mm_init() is used with -nodefaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Quite a lot of boards call serial_mm_init() directly with a value from
the serial_hds[] table. However, this table is only containing NULL
if QEMU has been started with "-nodefaults":

$ gdb --args arm-softmmu/qemu-system-arm -S -nodefaults -M cubieboard
(gdb) r
Program received signal SIGSEGV, Segmentation fault.
qemu_chr_fe_init (b=b@entry=0x555556cc4260, s=s@entry=0x0, errp=0x55555697eb40 <error_abort>)
    at chardev/char-fe.c:210
210	    } else if (s->be) {

Since calling serial_mm_init with a NULL pointer seems to be a common
pattern between many boards, let's simply fix this by creating a "null"
chardev on the fly in this case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/char/serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index eb72191..c1f7ff7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1040,6 +1040,10 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
 {
     SerialState *s;
 
+    if (!chr) {
+        chr = qemu_chardev_new(NULL, TYPE_CHARDEV_NULL, NULL, &error_abort);
+    }
+
     s = g_malloc0(sizeof(SerialState));
 
     s->it_shift = it_shift;
-- 
1.8.3.1
