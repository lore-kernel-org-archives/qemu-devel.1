Received: from eggs.gnu.org ([2001:4830:134:3::10]:59132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirill.shutemov@linux.intel.com>) id 1eAbvC-0004ys-SF
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirill.shutemov@linux.intel.com>) id 1eAbv9-0002yj-NE
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:22:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:60923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kirill.shutemov@linux.intel.com>)
	id 1eAbv9-0002WB-EM
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:22:03 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri,  3 Nov 2017 16:19:59 +0300
Message-Id: <20171103131959.73560-1-kirill.shutemov@linux.intel.com>
Subject: [Qemu-devel] [PATCH] chardev: don't forget to set backend for mux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kirill@shutemov.name, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

I noticied that on recent versions on QEMU I was not able to trigger
SysRq to invoke debug capabilites of Linux Kernel.

I've tracked it down to qemu_chr_be_event() ignoring CHR_EVENT_BREAK due
s->be being NULL.

Looks like the bug was introduced in a4afa548fc6d ("char: move front end
handlers in CharBackend"). Since the commit the qemu_chr_be_event()
failed to deliver CHR_EVENT_BREAK due to qemu_chr_fe_init() forgot to
get s->be initialized in case of mux.

Let's fix this.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
---
 chardev/char-fe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index ee6d59610031..d4a54947a567 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -209,9 +209,8 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
         tag = d->mux_cnt++;
     } else if (s->be) {
         goto unavailable;
-    } else {
-        s->be = b;
     }
+    s->be = b;
 
     b->fe_open = false;
     b->tag = tag;
-- 
2.14.2
