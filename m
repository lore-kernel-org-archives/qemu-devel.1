Received: from eggs.gnu.org ([2001:4830:134:3::10]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqISy-0006i1-3b
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eqISt-0001mK-68
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:05:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eqISt-0001lT-0e
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 08:05:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6E618424C
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 13:04:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 26 Feb 2018 13:04:52 +0000
Message-Id: <20180226130452.21309-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/1] serial: Open non-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On a real serial device, the open can block if the handshake
lines are in a particular state.  If a QEMU is passing the serial
device to the guest, the QEMU startup is blocked opening the device
(with a symptom seen as a timeout from libvirt).

Open the serial port with O_NONBLOCK.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 chardev/char-serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index feb52e559d..97be5d4a63 100644
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
2.14.3
