Received: from eggs.gnu.org ([2001:4830:134:3::10]:41448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYX-0007As-3M
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYW-0004Q5-A3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:29 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYW-0004OD-4A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:28 -0500
Received: by mail-wm0-x243.google.com with SMTP id v123so2001713wmd.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:30 +0100
Message-Id: <1515756676-3860-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/52] chardev: use backend chr context when
 watch for fe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

In commit 6bbb6c0644 ("chardev: use per-dev context for
io_add_watch_poll", 2017-09-22) all the chardev watches are converted to
use per-chardev gcontext to support chardev to be run outside default
main thread.  However that's still missing one call from the frontend
code.  Touch that up.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180104141835.17987-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index ee6d596..c611b3f 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -356,7 +356,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
     }
 
     g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
-    tag = g_source_attach(src, NULL);
+    tag = g_source_attach(src, s->gcontext);
     g_source_unref(src);
 
     return tag;
-- 
1.8.3.1
