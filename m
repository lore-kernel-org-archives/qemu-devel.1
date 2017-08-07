Received: from eggs.gnu.org ([2001:4830:134:3::10]:48949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ2-0007L2-Q8
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIn-0003tO-LQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:56 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:10 +0200
Message-Id: <1502117160-24655-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 06/56] char: Don't truncate -chardev and
 HMP chardev-add ringbuf size
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

qemu_chr_parse_ringbuf() initializes the new ChardevRingbuf's @size to
the value of qemu_opt_get_size().  Except it first truncates the value
from uint64_t to int.  Fix that, so you can waste your RAM on
multi-gigabyte ring buffers.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-ringbuf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index a9205ea..9275ae9 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -198,18 +198,14 @@ char *qmp_ringbuf_read(const char *device, uint64_t size,
 static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
                                    Error **errp)
 {
-    int val;
     ChardevRingbuf *ringbuf;
 
     backend->type = CHARDEV_BACKEND_KIND_RINGBUF;
     ringbuf = backend->u.ringbuf.data = g_new0(ChardevRingbuf, 1);
     qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ringbuf));
 
-    val = qemu_opt_get_size(opts, "size", 0);
-    if (val != 0) {
-        ringbuf->has_size = true;
-        ringbuf->size = val;
-    }
+    ringbuf->size = qemu_opt_get_size(opts, "size", 0);
+    ringbuf->has_size = ringbuf->size != 0;
 }
 
 static void char_ringbuf_class_init(ObjectClass *oc, void *data)
-- 
2.7.5
