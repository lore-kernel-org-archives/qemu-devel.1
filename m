Received: from eggs.gnu.org ([2001:4830:134:3::10]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVBt-0001lZ-1y
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cGVBo-0002oZ-2T
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:09 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cGVBn-0002nh-O8
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 13:19:04 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so12863771wjc.1
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 10:19:03 -0800 (PST)
From: edward.shishkin@gmail.com
Date: Mon, 12 Dec 2016 19:15:36 +0100
Message-Id: <1481566542-25894-1-git-send-email-edward.shishkin@gmail.com>
In-Reply-To: <db578624-4bdd-8d2d-3e18-02f518a6c212@gmail.com>
References: <db578624-4bdd-8d2d-3e18-02f518a6c212@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] 9p: v9fs add writepages.
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

Add a v9fs private ->writepages() method of address_space
operations for merging pages into long 9p messages.

Signed-off-by: Eduard Shishkin <eduard.shishkin@huawei.com>
---
 fs/9p/v9fs.c      |  46 +++++++
 fs/9p/v9fs.h      |  22 +++-
 fs/9p/vfs_addr.c  | 357 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/9p/vfs_super.c |   8 +-
 4 files changed, 431 insertions(+), 2 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 072e759..3b49daf 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -32,6 +32,7 @@
 #include <linux/parser.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
@@ -309,6 +310,49 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 	return ret;
 }
 
+void put_flush_set(struct v9fs_flush_set *fset)
+{
+	if (!fset)
+		return;
+	if (fset->pages)
+		kfree(fset->pages);
+	if (fset->buf)
+		kfree(fset->buf);
+	kfree(fset);
+}
+
+/**
+ * Allocate and initalize flush set
+ * Pre-conditions: valid msize is set
+ */
+int alloc_init_flush_set(struct v9fs_session_info *v9ses)
+{
+	int ret = -ENOMEM;
+	int num_pages;
+	struct v9fs_flush_set *fset = NULL;
+
+	num_pages = v9ses->clnt->msize >> PAGE_SHIFT;
+	if (num_pages < 2)
+		/* speedup impossible */
+		return 0;
+	fset = kzalloc(sizeof(*fset), GFP_KERNEL);
+	if (!fset)
+		goto error;
+	fset->num_pages = num_pages;
+	fset->pages = kzalloc(num_pages * sizeof(*fset->pages), GFP_KERNEL);
+	if (!fset->pages)
+		goto error;
+	fset->buf = kzalloc(num_pages << PAGE_SHIFT, GFP_USER);
+	if (!fset->buf)
+		goto error;
+	spin_lock_init(&(fset->lock));
+	v9ses->flush = fset;
+	return 0;
+ error:
+	put_flush_set(fset);
+	return ret;
+}
+
 /**
  * v9fs_session_init - initialize session
  * @v9ses: session information structure
@@ -444,6 +488,8 @@ void v9fs_session_close(struct v9fs_session_info *v9ses)
 	kfree(v9ses->uname);
 	kfree(v9ses->aname);
 
+	put_flush_set(v9ses->flush);
+
 	bdi_destroy(&v9ses->bdi);
 
 	spin_lock(&v9fs_sessionlist_lock);
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 443d12e..13a9db1 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -23,6 +23,7 @@
 #ifndef FS_9P_V9FS_H
 #define FS_9P_V9FS_H
 
+#include <linux/kconfig.h>
 #include <linux/backing-dev.h>
 
 /**
@@ -69,6 +70,13 @@ enum p9_cache_modes {
 	CACHE_FSCACHE,
 };
 
+struct v9fs_flush_set {
+        struct page **pages;
+	int num_pages;
+        char *buf;
+	spinlock_t lock;
+};
+
 /**
  * struct v9fs_session_info - per-instance session information
  * @flags: session options of type &p9_session_flags
@@ -105,7 +113,7 @@ struct v9fs_session_info {
 	char *cachetag;
 	struct fscache_cookie *fscache;
 #endif
-
+	struct v9fs_flush_set *flush; /* flush set for writepages */
 	char *uname;		/* user name to mount as */
 	char *aname;		/* name of remote hierarchy being mounted */
 	unsigned int maxdata;	/* max data for client interface */
@@ -159,6 +167,8 @@ extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
 extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
 					      struct p9_fid *fid,
 					      struct super_block *sb, int new);
+extern int alloc_init_flush_set(struct v9fs_session_info *v9ses);
+extern void put_flush_set(struct v9fs_flush_set *fset);
 
 /* other default globals */
 #define V9FS_PORT	564
@@ -223,4 +233,14 @@ v9fs_get_new_inode_from_fid(struct v9fs_session_info *v9ses, struct p9_fid *fid,
 		return v9fs_inode_from_fid(v9ses, fid, sb, 1);
 }
 
+static inline int spin_trylock_flush_set(struct v9fs_flush_set *fset)
+{
+	return spin_trylock(&(fset->lock));
+}
+
+static inline void spin_unlock_flush_set(struct v9fs_flush_set *fset)
+{
+	spin_unlock(&(fset->lock));
+}
+
 #endif
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 6181ad7..e871886 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -36,6 +36,7 @@
 #include <linux/uio.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <trace/events/writeback.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
@@ -209,6 +210,361 @@ static int v9fs_vfs_writepage(struct page *page, struct writeback_control *wbc)
 	return retval;
 }
 
+static void redirty_pages_for_writeback(struct page **pages, int nr,
+					struct writeback_control *wbc)
+{
+	int i;
+	for (i = 0; i < nr; i++) {
+		lock_page(pages[i]);
+		redirty_page_for_writepage(wbc, pages[i]);
+		unlock_page(pages[i]);
+	}
+}
+
+static void set_pages_error(struct page **pages, int nr, int error)
+{
+	int i;
+	for (i = 0; i < nr; i++) {
+		lock_page(pages[i]);
+		SetPageError(pages[i]);
+		mapping_set_error(pages[i]->mapping, error);
+		unlock_page(pages[i]);
+	}
+}
+
+#define V9FS_WRITEPAGES_DEBUG   (0)
+
+struct flush_context {
+	struct writeback_control *wbc;
+	struct address_space *mapping;
+	struct v9fs_flush_set *fset;
+	pgoff_t done_index;
+	pgoff_t writeback_index;
+	pgoff_t index;
+	pgoff_t end; /* Inclusive */
+	const char *msg;
+	int cycled;
+	int range_whole;
+	int done;
+};
+
+/**
+ * Copy a page with file's data to buffer.
+ * Handle races with truncate, etc.
+ * Return number of copied bytes
+ *
+ * @page: page to copy data from;
+ * @page_nr: serial number of the page
+ */
+static int flush_page(struct page *page, int page_nr, struct flush_context *ctx)
+{
+	char *kdata;
+	loff_t isize;
+	int copied = 0;
+	struct writeback_control *wbc = ctx->wbc;
+	/*
+	 * At this point, the page may be truncated or
+	 * invalidated (changing page->mapping to NULL), or
+	 * even swizzled back from swapper_space to tmpfs file
+	 * mapping. However, page->index will not change
+	 * because we have a reference on the page.
+	 */
+	if (page->index > ctx->end) {
+		/*
+		 * can't be range_cyclic (1st pass) because
+		 * end == -1 in that case.
+		 */
+		ctx->done = 1;
+		ctx->msg = "page out of range";
+		goto exit;
+	}
+	ctx->done_index = page->index;
+	lock_page(page);
+	/*
+	 * Page truncated or invalidated. We can freely skip it
+	 * then, even for data integrity operations: the page
+	 * has disappeared concurrently, so there could be no
+	 * real expectation of this data interity operation
+	 * even if there is now a new, dirty page at the same
+	 * pagecache address.
+	 */
+	if (unlikely(page->mapping != ctx->mapping)) {
+		unlock_page(page);
+		ctx->msg = "page truncated or invalidated";
+		goto exit;
+	}
+	if (!PageDirty(page)) {
+		/*
+		 * someone wrote it for us
+		 */
+		unlock_page(page);
+		ctx->msg = "page not dirty";
+		goto exit;
+	}
+	if (PageWriteback(page)) {
+		if (wbc->sync_mode != WB_SYNC_NONE)
+			wait_on_page_writeback(page);
+		else {
+			unlock_page(page);
+			ctx->msg = "page is writeback";
+			goto exit;
+		}
+	}
+	BUG_ON(PageWriteback(page));
+	if (!clear_page_dirty_for_io(page)) {
+		unlock_page(page);
+		ctx->msg = "failed to clear page dirty";
+		goto exit;
+	}
+	trace_wbc_writepage(wbc, inode_to_bdi(ctx->mapping->host));
+
+	set_page_writeback(page);
+	isize = i_size_read(ctx->mapping->host);
+	if (page->index == isize >> PAGE_SHIFT)
+		copied = isize & ~PAGE_MASK;
+	else
+		copied = PAGE_SIZE;
+	kdata = kmap_atomic(page);
+	memcpy(ctx->fset->buf + (page_nr << PAGE_SHIFT), kdata, copied);
+	kunmap_atomic(kdata);
+	end_page_writeback(page);
+
+	unlock_page(page);
+	/*
+	 * We stop writing back only if we are not doing
+	 * integrity sync. In case of integrity sync we have to
+	 * keep going until we have written all the pages
+	 * we tagged for writeback prior to entering this loop.
+	 */
+	if (--wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
+		ctx->done = 1;
+ exit:
+	return copied;
+}
+
+static int send_buffer(off_t offset, int len, struct flush_context *ctx)
+{
+	int ret = 0;
+	struct kvec kvec;
+	struct iov_iter iter;
+	struct v9fs_inode *v9inode = V9FS_I(ctx->mapping->host);
+
+	kvec.iov_base = ctx->fset->buf;
+	kvec.iov_len = len;
+	iov_iter_kvec(&iter, WRITE | ITER_KVEC, &kvec, 1, len);
+	BUG_ON(!v9inode->writeback_fid);
+
+	p9_client_write(v9inode->writeback_fid, offset, &iter, &ret);
+	return ret;
+}
+
+/**
+ * Helper function for managing 9pFS write requests.
+ * The main purpose of this function is to provide support for
+ * the coalescing of several pages into a single 9p message.
+ * This is similarly to NFS's pagelist.
+ *
+ * Copy pages with adjusent indices to a buffer and send it to
+ * the server.
+ *
+ * @pages: array of pages with ascending indices;
+ * @nr_pages: number of pages in the array;
+ */
+static int flush_pages(struct page **pages, int nr_pages,
+		       struct flush_context *ctx)
+{
+	int ret;
+	int pos = 0;
+	int iter_pos;
+	int iter_nrpages;
+	pgoff_t iter_page_idx;
+
+	while (pos < nr_pages) {
+
+		int i;
+		int iter_len = 0;
+		struct page *page;
+
+		iter_pos = pos;
+		iter_nrpages = 0;
+		iter_page_idx = pages[pos]->index;
+
+		for (i = 0; pos < nr_pages; i++) {
+			int from_page;
+
+			page = pages[pos];
+			if (page->index != iter_page_idx + i) {
+				/*
+				 * Hole in the indices,
+				 * further coalesce impossible.
+				 * Try to send what we have accumulated.
+				 * This page will be processed in the next
+				 * iteration
+				 */
+				goto iter_send;
+			}
+			from_page = flush_page(page, i, ctx);
+
+			iter_len += from_page;
+			iter_nrpages++;
+			pos++;
+
+			if (from_page != PAGE_SIZE) {
+				/*
+				 * Not full page was flushed,
+				 * further coalesce impossible.
+				 * Try to send what we have accumulated.
+				 */
+#if V9FS_WRITEPAGES_DEBUG
+				if (from_page == 0)
+				    printk("9p: page %lu is not flushed (%s)\n",
+					   page->index, ctx->msg);
+#endif
+				goto iter_send;
+			}
+		};
+	iter_send:
+		if (iter_len == 0)
+			/*
+			 * Nothing to send
+			 */
+			goto next_iter;
+		ret = send_buffer(iter_page_idx << PAGE_SHIFT,
+				  iter_len, ctx);
+		if (ret == -EAGAIN) {
+			redirty_pages_for_writeback(pages + iter_pos,
+						    iter_nrpages, ctx->wbc);
+			ret = 0;
+		} else if (ret < 0) {
+			/*
+			 * Something bad happened.
+			 * done_index is set past this chunk,
+			 * so media errors will not choke
+			 * background writeout for the entire
+			 * file.
+			 */
+			printk("9p: send_buffer failed (%d)\n", ret);
+
+			set_pages_error(pages + iter_pos, iter_nrpages, ret);
+			ctx->done_index =
+				pages[iter_pos + iter_nrpages - 1]->index + 1;
+			ctx->done = 1;
+			return ret;
+		} else
+			ret = 0;
+	next_iter:
+		if (ctx->done)
+			return ret;
+	};
+	return 0;
+}
+
+static void init_flush_context(struct flush_context *ctx,
+			       struct address_space *mapping,
+			       struct writeback_control *wbc,
+			       struct v9fs_flush_set *fset)
+{
+	ctx->wbc = wbc;
+	ctx->mapping = mapping;
+	ctx->fset = fset;
+	ctx->done = 0;
+	ctx->range_whole = 0;
+
+	if (wbc->range_cyclic) {
+		ctx->writeback_index = mapping->writeback_index;
+		ctx->index = ctx->writeback_index;
+		if (ctx->index == 0)
+			ctx->cycled = 1;
+		else
+			ctx->cycled = 0;
+		ctx->end = -1;
+	} else {
+		ctx->index = wbc->range_start >> PAGE_SHIFT;
+		ctx->end = wbc->range_end >> PAGE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			ctx->range_whole = 1;
+		ctx->cycled = 1; /* ignore range_cyclic tests */
+	}
+}
+
+/**
+ * Pre-condition: flush set is locked
+ */
+static int v9fs_writepages_fastpath(struct address_space *mapping,
+				    struct writeback_control *wbc,
+				    struct v9fs_flush_set *fset)
+{
+	int ret = 0;
+	int tag;
+	int nr_pages;
+        struct page **pages = fset->pages;
+	struct flush_context ctx;
+
+	init_flush_context(&ctx, mapping, wbc, fset);
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag = PAGECACHE_TAG_TOWRITE;
+	else
+		tag = PAGECACHE_TAG_DIRTY;
+retry:
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, ctx.index, ctx.end);
+
+	ctx.done_index = ctx.index;
+
+	while (!ctx.done && (ctx.index <= ctx.end)) {
+		int i;
+		nr_pages = find_get_pages_tag(mapping, &ctx.index, tag,
+					      1 + min(ctx.end - ctx.index,
+					      (pgoff_t)(fset->num_pages - 1)),
+					      pages);
+		if (nr_pages == 0)
+			break;
+
+		ret = flush_pages(pages, nr_pages, &ctx);
+		/*
+		 * unpin pages
+		 */
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
+		if (ret < 0)
+			break;
+		cond_resched();
+	}
+	if (!ctx.cycled && !ctx.done) {
+		/*
+		 * range_cyclic:
+		 * We hit the last page and there is more work
+		 * to be done: wrap back to the start of the file
+		 */
+		ctx.cycled = 1;
+		ctx.index = 0;
+		ctx.end = ctx.writeback_index - 1;
+		goto retry;
+	}
+	if (wbc->range_cyclic || (ctx.range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = ctx.done_index;
+	return ret;
+}
+
+static int v9fs_writepages(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	int ret;
+	struct v9fs_flush_set *fset;
+
+	fset = v9fs_inode2v9ses(mapping->host)->flush;
+	if (!fset || !spin_trylock_flush_set(fset))
+		/*
+		 * do it by slow way
+		 */
+		return generic_writepages(mapping, wbc);
+
+	ret = v9fs_writepages_fastpath(mapping, wbc, fset);
+	spin_unlock_flush_set(fset);
+	return ret;
+}
+
 /**
  * v9fs_launder_page - Writeback a dirty page
  * Returns 0 on success.
@@ -342,6 +698,7 @@ const struct address_space_operations v9fs_addr_operations = {
 	.readpages = v9fs_vfs_readpages,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = v9fs_vfs_writepage,
+	.writepages = v9fs_writepages,
 	.write_begin = v9fs_write_begin,
 	.write_end = v9fs_write_end,
 	.releasepage = v9fs_release_page,
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index de3ed86..c1f9af1 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -140,8 +140,14 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	}
 	v9fs_fill_super(sb, v9ses, flags, data);
 
-	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+		retval = alloc_init_flush_set(v9ses);
+		if (IS_ERR(v9ses->flush)) {
+			retval = PTR_ERR(fid);
+			goto release_sb;
+		}
 		sb->s_d_op = &v9fs_cached_dentry_operations;
+	}
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
 
-- 
2.7.4
