Received: from eggs.gnu.org ([2001:4830:134:3::10]:50365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS44-000328-ED
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS43-0004hK-Fl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:12 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS43-0004g8-9a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:11 -0500
Received: by mail-wm0-x244.google.com with SMTP id i186so8657122wmi.4
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:17:05 +0100
Message-Id: <1516112253-14480-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/51] mips: fix potential fopen(NULL,...)
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

Spotted thanks to ASAN.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180104160523.22995-18-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/nvram/ds1225y.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 57d5ab2..ad7345f 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -80,7 +80,7 @@ static int nvram_post_load(void *opaque, int version_id)
     }
 
     /* Write back nvram contents */
-    s->file = fopen(s->filename, "wb");
+    s->file = s->filename ? fopen(s->filename, "wb") : NULL;
     if (s->file) {
         /* Write back contents, as 'wb' mode cleaned the file */
         if (fwrite(s->contents, s->chip_size, 1, s->file) != 1) {
@@ -126,7 +126,7 @@ static int nvram_sysbus_initfn(SysBusDevice *dev)
     sysbus_init_mmio(dev, &s->iomem);
 
     /* Read current file */
-    file = fopen(s->filename, "rb");
+    file = s->filename ? fopen(s->filename, "rb") : NULL;
     if (file) {
         /* Read nvram contents */
         if (fread(s->contents, s->chip_size, 1, file) != 1) {
-- 
1.8.3.1
