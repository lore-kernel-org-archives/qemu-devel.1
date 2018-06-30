Received: from eggs.gnu.org ([2001:4830:134:3::10]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96a-0004h5-Mk
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96Z-0003Bj-AL
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:32 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96Z-0003Ag-3t
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:31 -0400
Received: by mail-wr0-x244.google.com with SMTP id k6-v6so10646645wrp.4
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:40 +0200
Message-Id: <20180630061040.6018-48-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/47] serial: Open non-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On a real serial device, the open can block if the handshake
lines are in a particular state.  If a QEMU is passing the serial
device to the guest, the QEMU startup is blocked opening the device
(with a symptom seen as a timeout from libvirt).

Open the serial port with O_NONBLOCK.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index ae548d2..3299b46 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -265,7 +265,8 @@ static void qmp_chardev_open_serial(Chardev *chr,
     ChardevHostdev *serial = backend->u.serial.data;
     int fd;
 
-    fd = qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
+    fd = qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBLOCK,
+                                      errp);
     if (fd < 0) {
         return;
     }
-- 
1.8.3.1
