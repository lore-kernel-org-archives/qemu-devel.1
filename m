Received: from eggs.gnu.org ([2001:4830:134:3::10]:39896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVBz-0001qZ-0G
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVBu-0002tF-IE
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:15 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cGVBu-0002sf-9R
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so12904341wma.3
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:19:10 -0800 (PST)
From: edward.shishkin@gmail.com
Date: Mon, 12 Dec 2016 19:15:37 +0100
Message-Id: <1481566542-25894-2-git-send-email-edward.shishkin@gmail.com>
In-Reply-To: <1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
References: <db578624-4bdd-8d2d-3e18-02f518a6c212@gmail.com>
	<1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] 9p: v9fs new readpages.
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

Modify v9fs private ->readpages() method of address_space
operations for merging pages into long 9p messages.

Signed-off-by: Eduard Shishkin <eduard.shishkin@huawei.com>
---
 fs/9p/vfs_addr.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index e871886..4ad248e 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -34,6 +34,7 @@
 #include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/uio.h>
+#include <linux/slab.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <trace/events/writeback.h>
@@ -99,6 +100,148 @@ static int v9fs_vfs_readpage(struct file *filp, struct page *page)
 	return v9fs_fid_readpage(filp->private_data, page);
 }
 
+/*
+ * Context for "fast readpages"
+ */
+struct v9fs_readpages_ctx {
+	struct file *filp;
+	struct address_space *mapping;
+	pgoff_t start_index; /* index of the first page with actual data */
+	char *buf; /* buffer with actual data */
+	int len; /* length of the actual data */
+	int num_pages; /* maximal data chunk (in pages) that can be
+			  passed per transmission */
+};
+
+static int init_readpages_ctx(struct v9fs_readpages_ctx *ctx,
+			      struct file *filp,
+			      struct address_space *mapping,
+			      int num_pages)
+{
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->buf = kmalloc(num_pages << PAGE_SHIFT, GFP_USER);
+	if (!ctx->buf)
+		return -ENOMEM;
+	ctx->filp = filp;
+	ctx->mapping = mapping;
+	ctx->num_pages = num_pages;
+	return 0;
+}
+
+static void done_readpages_ctx(struct v9fs_readpages_ctx *ctx)
+{
+	kfree(ctx->buf);
+}
+
+static int receive_buffer(struct file *filp,
+			  char *buf,
+			  off_t offset, /* offset in the file */
+			  int len,
+			  int *err)
+{
+	struct kvec kvec;
+	struct iov_iter iter;
+
+	kvec.iov_base = buf;
+	kvec.iov_len = len;
+	iov_iter_kvec(&iter, READ | ITER_KVEC, &kvec, 1, len);
+
+	return p9_client_read(filp->private_data, offset, &iter, err);
+}
+
+static int fast_filler(struct v9fs_readpages_ctx *ctx, struct page *page)
+{
+	int err;
+	int ret = 0;
+	char *kdata;
+	int to_page;
+	off_t off_in_buf;
+	struct inode *inode = page->mapping->host;
+
+	BUG_ON(!PageLocked(page));
+	/*
+	 * first, validate the buffer
+	 */
+	if (page->index < ctx->start_index ||
+	    ctx->start_index + ctx->num_pages < page->index) {
+		/*
+		 * No actual data in the buffer,
+		 * so actualize it
+		 */
+		ret = receive_buffer(ctx->filp,
+				     ctx->buf,
+				     page_offset(page),
+				     ctx->num_pages << PAGE_SHIFT,
+				     &err);
+		if (err) {
+			printk("failed to receive buffer off=%llu (%d)\n",
+			       (unsigned long long)page_offset(page),
+			       err);
+			ret = err;
+			goto done;
+		}
+		ctx->start_index = page->index;
+		ctx->len = ret;
+		ret = 0;
+	}
+	/*
+	 * fill the page with buffer's data
+	 */
+	off_in_buf = (page->index - ctx->start_index) << PAGE_SHIFT;
+	if (off_in_buf >= ctx->len) {
+		/*
+		 * No actual data to fill the page with
+		 */
+		ret = -1;
+		goto done;
+	}
+	to_page = ctx->len - off_in_buf;
+	if (to_page >= PAGE_SIZE)
+		to_page = PAGE_SIZE;
+
+	kdata = kmap_atomic(page);
+	memcpy(kdata, ctx->buf + off_in_buf, to_page);
+	memset(kdata + to_page, 0, PAGE_SIZE - to_page);
+	kunmap_atomic(kdata);
+
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	v9fs_readpage_to_fscache(inode, page);
+ done:
+	unlock_page(page);
+	return ret;
+}
+
+/**
+ * Try to read pages by groups. For every such group we issue only one
+ * read request to the server.
+ * @num_pages: maximal chunk of data (in pages) that can be passed per
+ * such request
+ */
+static int v9fs_readpages_tryfast(struct file *filp,
+				  struct address_space *mapping,
+				  struct list_head *pages,
+				  int num_pages)
+{
+	int ret;
+	struct v9fs_readpages_ctx ctx;
+
+	ret = init_readpages_ctx(&ctx, filp, mapping, num_pages);
+	if (ret)
+		/*
+		 * Can not allocate resources for the fast path,
+		 * so do it by slow way
+		 */
+		return read_cache_pages(mapping, pages,
+					(void *)v9fs_vfs_readpage, filp);
+
+	else
+		ret = read_cache_pages(mapping, pages,
+				       (void *)fast_filler, &ctx);
+	done_readpages_ctx(&ctx);
+	return ret;
+}
+
 /**
  * v9fs_vfs_readpages - read a set of pages from 9P
  *
@@ -114,6 +257,7 @@ static int v9fs_vfs_readpages(struct file *filp, struct address_space *mapping,
 {
 	int ret = 0;
 	struct inode *inode;
+	struct v9fs_flush_set *fset;
 
 	inode = mapping->host;
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, filp);
@@ -122,7 +266,17 @@ static int v9fs_vfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		return ret;
 
-	ret = read_cache_pages(mapping, pages, (void *)v9fs_vfs_readpage, filp);
+	fset = v9fs_inode2v9ses(mapping->host)->flush;
+	if (!fset)
+		/*
+		 * Do it by slow way
+		 */
+		ret = read_cache_pages(mapping, pages,
+				       (void *)v9fs_vfs_readpage, filp);
+	else
+		ret = v9fs_readpages_tryfast(filp, mapping,
+					     pages, fset->num_pages);
+
 	p9_debug(P9_DEBUG_VFS, "  = %d\n", ret);
 	return ret;
 }
-- 
2.7.4
