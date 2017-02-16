Received: from eggs.gnu.org ([2001:4830:134:3::10]:51802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6W-0003hL-K6
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6S-00083s-IF
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:16 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6S-00083U-Ce
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:12 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so3407207wmd.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:31 +0100
Message-Id: <1487255507-106654-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/23] char: drop data written to a disconnected
 pty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ed Swierk <eswierk@skyportsystems.com>

From: Ed Swierk <eswierk@skyportsystems.com>

When a serial port writes data to a pty that's disconnected, drop the
data and return the length dropped. This avoids triggering pointless
retries in callers like the 16550A serial_xmit(), and causes
qemu_chr_fe_write() to write all data to the log file, rather than
logging only while a pty client like virsh console happens to be
connected.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
Message-Id: <1485870329-79428-1-git-send-email-eswierk@skyportsystems.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 27eb85f..ecf2c7a 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -129,7 +129,7 @@ static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
         /* guest sends data, check for (re-)connect */
         pty_chr_update_read_handler_locked(chr);
         if (!s->connected) {
-            return 0;
+            return len;
         }
     }
     return io_channel_send(s->ioc, buf, len);
-- 
1.8.3.1
