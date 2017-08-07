Received: from eggs.gnu.org ([2001:4830:134:3::10]:48520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIj-0006wl-IF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIY-0003fS-Ke
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:08 +0200
Message-Id: <1502117160-24655-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/56] char: Make ringbuf-read size
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes should use QAPI type 'size' (uint64_t).  ringbuf-read parameter
@size is 'int' (int64_t).  qmp_ringbuf_read() rejects negative values,
then implicitly converts to size_t.

Change the parameter to 'size' and drop the check for negative values.

ringbuf-read now accepts size values between 2^63 and 2^64-1.  It
accepts negative values as before, because that's how the QObject
input visitor works for backward compatibility.

The HMP command's size parameter remains uint32_t, as HMP args_type
strings can't do uint64_t byte counts: 'l' is signed, and 'o'
multiplies by 2^20.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-ringbuf.c | 11 +++--------
 qapi-schema.json       |  2 +-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index df52b04..a9205ea 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -65,10 +65,10 @@ static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
+static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, size_t len)
 {
     RingBufChardev *d = RINGBUF_CHARDEV(chr);
-    int i;
+    size_t i;
 
     qemu_mutex_lock(&chr->chr_write_lock);
     for (i = 0; i < len && d->cons != d->prod; i++) {
@@ -151,7 +151,7 @@ void qmp_ringbuf_write(const char *device, const char *data,
     }
 }
 
-char *qmp_ringbuf_read(const char *device, int64_t size,
+char *qmp_ringbuf_read(const char *device, uint64_t size,
                        bool has_format, enum DataFormat format,
                        Error **errp)
 {
@@ -171,11 +171,6 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
         return NULL;
     }
 
-    if (size <= 0) {
-        error_setg(errp, "size must be greater than zero");
-        return NULL;
-    }
-
     count = ringbuf_count(chr);
     size = size > count ? count : size;
     read_data = g_malloc(size + 1);
diff --git a/qapi-schema.json b/qapi-schema.json
index febe70e..18ec301 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -543,7 +543,7 @@
 #
 ##
 { 'command': 'ringbuf-read',
-  'data': {'device': 'str', 'size': 'int', '*format': 'DataFormat'},
+  'data': {'device': 'str', 'size': 'size', '*format': 'DataFormat'},
   'returns': 'str' }
 
 ##
-- 
2.7.5
