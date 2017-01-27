Received: from eggs.gnu.org ([2001:4830:134:3::10]:33895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rM-0005XH-3X
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rL-0004Iv-4R
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:36 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rK-0004IK-VG
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:35 -0500
Received: by mail-wj0-x241.google.com with SMTP id i7so5995349wjf.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:46 +0100
Message-Id: <1485524749-118532-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/41] baum: use a common prefix for chr
 callbacks
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/baum.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 23d3c4a..8842936 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -253,7 +253,7 @@ static int baum_deferred_init(BaumChardev *baum)
 }
 
 /* The serial port can receive more of our data */
-static void baum_accept_input(struct Chardev *chr)
+static void baum_chr_accept_input(struct Chardev *chr)
 {
     BaumChardev *baum = (BaumChardev *)chr;
     int room, first;
@@ -470,7 +470,7 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
 }
 
 /* The other end is writing some data.  Store it and try to interpret */
-static int baum_write(Chardev *chr, const uint8_t *buf, int len)
+static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     BaumChardev *baum = (BaumChardev *)chr;
     int tocopy, cur, eaten, orig_len = len;
@@ -613,7 +613,7 @@ static void baum_chr_read(void *opaque)
     }
 }
 
-static void baum_free(struct Chardev *chr)
+static void baum_chr_free(struct Chardev *chr)
 {
     BaumChardev *baum = (BaumChardev *)chr;
 
@@ -624,7 +624,7 @@ static void baum_free(struct Chardev *chr)
     }
 }
 
-static Chardev *chr_baum_init(const CharDriver *driver,
+static Chardev *baum_chr_init(const CharDriver *driver,
                               const char *id,
                               ChardevBackend *backend,
                               ChardevReturn *ret,
@@ -670,10 +670,10 @@ static void register_types(void)
     static const CharDriver driver = {
         .instance_size = sizeof(BaumChardev),
         .kind = CHARDEV_BACKEND_KIND_BRAILLE,
-        .create = chr_baum_init,
-        .chr_write = baum_write,
-        .chr_accept_input = baum_accept_input,
-        .chr_free = baum_free,
+        .create = baum_chr_init,
+        .chr_write = baum_chr_write,
+        .chr_accept_input = baum_chr_accept_input,
+        .chr_free = baum_chr_free,
     };
 
     register_char_driver(&driver);
-- 
1.8.3.1
