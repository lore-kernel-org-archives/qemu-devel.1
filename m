Received: from eggs.gnu.org ([2001:4830:134:3::10]:40263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVCI-0002Ai-B2
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVCD-00038o-V8
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cGVCD-00038J-OU
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so12973137wme.2
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:19:29 -0800 (PST)
From: edward.shishkin@gmail.com
Date: Mon, 12 Dec 2016 19:15:41 +0100
Message-Id: <1481566542-25894-6-git-send-email-edward.shishkin@gmail.com>
In-Reply-To: <1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
References: <db578624-4bdd-8d2d-3e18-02f518a6c212@gmail.com>
	<1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] 9p: v9fs fix readpages writepages contexts
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Van Hensbergen <ericvh@gmail.com>, V9FS Developers Mailing List <v9fs-developer@lists.sourceforge.net>, Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Cc: QEMU Developers Mailing List <qemu-devel@nongnu.org>, ZhangWei <zhangwei555@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, Greg Kurz <groug@kaod.org>, Alexander Graf <agraf@suse.de>, Eduard Shishkin <eduard.shishkin@huawei.com>

From: Eduard Shishkin <eduard.shishkin@huawei.com>

Use GFP_KERNEL instead of GFP_USER when allocating buffers for
readpages/writepages contexts.

Signed-off-by: Eduard Shishkin <eduard.shishkin@huawei.com>
---
 fs/9p/v9fs.c     | 2 +-
 fs/9p/vfs_addr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index e2f84a6..58bff9e 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -340,7 +340,7 @@ int alloc_init_flush_set(struct v9fs_session_info *v9ses)
 	fset->pages = kzalloc(num_pages * sizeof(*fset->pages), GFP_KERNEL);
 	if (!fset->pages)
 		goto error;
-	fset->buf = kzalloc(num_pages << PAGE_SHIFT, GFP_USER);
+	fset->buf = kzalloc(num_pages << PAGE_SHIFT, GFP_KERNEL);
 	if (!fset->buf)
 		goto error;
 	spin_lock_init(&(fset->lock));
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index afd8a13..4b2b1d6 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -119,7 +119,7 @@ static int init_readpages_ctx(struct v9fs_readpages_ctx *ctx,
 			      int num_pages)
 {
 	memset(ctx, 0, sizeof(*ctx));
-	ctx->buf = kmalloc(num_pages << PAGE_SHIFT, GFP_USER);
+	ctx->buf = kmalloc(num_pages << PAGE_SHIFT, GFP_KERNEL);
 	if (!ctx->buf)
 		return -ENOMEM;
 	ctx->filp = filp;
-- 
2.7.4
