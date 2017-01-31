Received: from eggs.gnu.org ([2001:4830:134:3::10]:37026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYYku-0006gM-B0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYYkp-0007dG-EU
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:45:56 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cYYkp-0007dA-85
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:45:51 -0500
Received: by mail-pf0-x236.google.com with SMTP id 189so106474675pfu.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 05:45:51 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 31 Jan 2017 05:45:29 -0800
Message-Id: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
Subject: [Qemu-devel] [PATCH] char: drop data written to a disconnected pty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, berrange@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, ben@skyportsystems.com, Ed Swierk <eswierk@skyportsystems.com>

When a serial port writes data to a pty that's disconnected, drop the
data and return the length dropped. This avoids triggering pointless
retries in callers like the 16550A serial_xmit(), and causes
qemu_chr_fe_write() to write all data to the log file, rather than
logging only while a pty client like virsh console happens to be
connected.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 qemu-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-char.c b/qemu-char.c
index 676944a..ccb6923 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1528,7 +1528,7 @@ static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
         /* guest sends data, check for (re-)connect */
         pty_chr_update_read_handler_locked(chr);
         if (!s->connected) {
-            return 0;
+            return len;
         }
     }
     return io_channel_send(s->ioc, buf, len);
-- 
1.9.1
