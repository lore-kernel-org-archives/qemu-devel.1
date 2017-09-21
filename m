Received: from eggs.gnu.org ([2001:4830:134:3::10]:37568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAig-00058w-8B
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAie-0004fp-VC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:22 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAie-0004ef-O3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id p37so3842333wrb.5
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:38 +0200
Message-Id: <1506035800-30509-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/32] chardev: add Chardev.gcontext field
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

It caches the gcontext that is used to poll the chardev IO.  Before this
patch, we only passed it in via chr_update_read_handlers().  However
that may not be enough if the char backend is disconnected and
reconnected afterward.  There are chardev codes that still assumed the
context be NULL (which is the main context).  Will fix that up in
following up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1505975754-21555-3-git-send-email-peterx@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char.c         | 1 +
 include/chardev/char.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index e090dd5..89eabea 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -185,6 +185,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(s);
 
+    s->gcontext = context;
     if (cc->chr_update_read_handler) {
         cc->chr_update_read_handler(s, context);
     }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 2068ea4..84fb773 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -55,6 +55,7 @@ struct Chardev {
     int logfd;
     int be_open;
     GSource *gsource;
+    GMainContext *gcontext;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
 };
 
-- 
1.8.3.1
