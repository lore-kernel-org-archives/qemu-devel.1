Received: from eggs.gnu.org ([2001:4830:134:3::10]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cFQ9q-0006vZ-2D
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cFQ9m-00010i-2D
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:44:34 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cFQ9l-00010U-Nt
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:44:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so5333887wma.3
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 10:44:29 -0800 (PST)
References: <7a0376a6-e9c1-92c0-a75f-6b44495ba2b2@gmail.com>
	<1476120280-30873-1-git-send-email-edward.shishkin@gmail.com>
	<580F65A5.5010802@suse.de>
From: Edward Shishkin <edward.shishkin@gmail.com>
Message-ID: <6338209f-9ee0-458b-3693-ce476175c60d@gmail.com>
Date: Fri, 9 Dec 2016 19:43:27 +0100
MIME-Version: 1.0
In-Reply-To: <580F65A5.5010802@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] 9p: v9fs add writepages.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Eric Van Hensbergen <ericvh@gmail.com>, V9FS Developers Mailing List <v9fs-developer@lists.sourceforge.net>, Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>
Cc: Edward Shishkin <Eduard.Shishkin@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, QEMU Developers Mailing List <qemu-devel@nongnu.org>, ZhangWei <zhangwei555@huawei.com>

On 10/25/2016 04:01 PM, Alexander Graf wrote:
> On 10/10/2016 07:24 PM, Edward Shishkin wrote:
>> Add a v9fs private ->writepages() method of address_space
>> operations for merging pages into long 9p messages.
>>
>> Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
>> ---
>>   fs/9p/v9fs.c      |  46 +++++++
>>   fs/9p/v9fs.h      |  22 +++-
>>   fs/9p/vfs_addr.c  | 357 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/9p/vfs_super.c |   8 +-
>>   4 files changed, 431 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
>> index 072e759..3b49daf 100644
>> --- a/fs/9p/v9fs.c
>> +++ b/fs/9p/v9fs.c
>> @@ -32,6 +32,7 @@
>>   #include <linux/parser.h>
>>   #include <linux/idr.h>
>>   #include <linux/slab.h>
>> +#include <linux/pagemap.h>
>>   #include <net/9p/9p.h>
>>   #include <net/9p/client.h>
>>   #include <net/9p/transport.h>
>> @@ -309,6 +310,49 @@ static int v9fs_parse_options(struct 
>> v9fs_session_info *v9ses, char *opts)
>>       return ret;
>>   }
>>   +void put_flush_set(struct v9fs_flush_set *fset)
>> +{
>> +    if (!fset)
>> +        return;
>> +    if (fset->pages)
>> +        kfree(fset->pages);
>> +    if (fset->buf)
>> +        kfree(fset->buf);
>> +    kfree(fset);
>> +}
>> +
>> +/**
>> + * Allocate and initalize flush set
>> + * Pre-conditions: valid msize is set
>> + */
>> +int alloc_init_flush_set(struct v9fs_session_info *v9ses)
>> +{
>> +    int ret = -ENOMEM;
>> +    int num_pages;
>> +    struct v9fs_flush_set *fset = NULL;
>> +
>> +    num_pages = v9ses->clnt->msize >> PAGE_SHIFT;
>> +    if (num_pages < 2)
>> +        /* speedup impossible */
>> +        return 0;
>> +    fset = kzalloc(sizeof(*fset), GFP_KERNEL);
>> +    if (!fset)
>> +        goto error;
>> +    fset->num_pages = num_pages;
>> +    fset->pages = kzalloc(num_pages * sizeof(*fset->pages), 
>> GFP_KERNEL);
>> +    if (!fset->pages)
>> +        goto error;
>> +    fset->buf = kzalloc(num_pages << PAGE_SHIFT, GFP_USER);
>> +    if (!fset->buf)
>> +        goto error;
>> +    spin_lock_init(&(fset->lock));
>> +    v9ses->flush = fset;
>> +    return 0;
>> + error:
>> +    put_flush_set(fset);
>> +    return ret;
>> +}
>> +
>>   /**
>>    * v9fs_session_init - initialize session
>>    * @v9ses: session information structure
>> @@ -444,6 +488,8 @@ void v9fs_session_close(struct v9fs_session_info 
>> *v9ses)
>>       kfree(v9ses->uname);
>>       kfree(v9ses->aname);
>>   +    put_flush_set(v9ses->flush);
>> +
>>       bdi_destroy(&v9ses->bdi);
>>         spin_lock(&v9fs_sessionlist_lock);
>> diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
>> index 6877050..d1092e4 100644
>> --- a/fs/9p/v9fs.h
>> +++ b/fs/9p/v9fs.h
>> @@ -23,6 +23,7 @@
>>   #ifndef FS_9P_V9FS_H
>>   #define FS_9P_V9FS_H
>>   +#include <linux/kconfig.h>
>>   #include <linux/backing-dev.h>
>>     /**
>> @@ -69,6 +70,13 @@ enum p9_cache_modes {
>>       CACHE_FSCACHE,
>>   };
>>   +struct v9fs_flush_set {
>> +        struct page **pages;
>> +    int num_pages;
>> +        char *buf;
>> +    spinlock_t lock;
>> +};
>> +
>>   /**
>>    * struct v9fs_session_info - per-instance session information
>>    * @flags: session options of type &p9_session_flags
>> @@ -105,7 +113,7 @@ struct v9fs_session_info {
>>       char *cachetag;
>>       struct fscache_cookie *fscache;
>>   #endif
>> -
>> +    struct v9fs_flush_set *flush; /* flush set for writepages */
>>       char *uname;        /* user name to mount as */
>>       char *aname;        /* name of remote hierarchy being mounted */
>>       unsigned int maxdata;    /* max data for client interface */
>> @@ -158,6 +166,8 @@ extern const struct inode_operations 
>> v9fs_symlink_inode_operations_dotl;
>>   extern struct inode *v9fs_inode_from_fid_dotl(struct 
>> v9fs_session_info *v9ses,
>>                             struct p9_fid *fid,
>>                             struct super_block *sb, int new);
>> +extern int alloc_init_flush_set(struct v9fs_session_info *v9ses);
>> +extern void put_flush_set(struct v9fs_flush_set *fset);
>>     /* other default globals */
>>   #define V9FS_PORT    564
>> @@ -222,4 +232,14 @@ v9fs_get_new_inode_from_fid(struct 
>> v9fs_session_info *v9ses, struct p9_fid *fid,
>>           return v9fs_inode_from_fid(v9ses, fid, sb, 1);
>>   }
>>   +static inline int spin_trylock_flush_set(struct v9fs_flush_set *fset)
>> +{
>> +    return spin_trylock(&(fset->lock));
>> +}
>> +
>> +static inline void spin_unlock_flush_set(struct v9fs_flush_set *fset)
>> +{
>> +    spin_unlock(&(fset->lock));
>> +}
>> +
>>   #endif
>> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
>> index 6181ad7..e871886 100644
>> --- a/fs/9p/vfs_addr.c
>> +++ b/fs/9p/vfs_addr.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/uio.h>
>>   #include <net/9p/9p.h>
>>   #include <net/9p/client.h>
>> +#include <trace/events/writeback.h>
>>     #include "v9fs.h"
>>   #include "v9fs_vfs.h"
>> @@ -209,6 +210,361 @@ static int v9fs_vfs_writepage(struct page 
>> *page, struct writeback_control *wbc)
>>       return retval;
>>   }
>>   +static void redirty_pages_for_writeback(struct page **pages, int nr,
>> +                    struct writeback_control *wbc)
>> +{
>> +    int i;
>> +    for (i = 0; i < nr; i++) {
>> +        lock_page(pages[i]);
>> +        redirty_page_for_writepage(wbc, pages[i]);
>> +        unlock_page(pages[i]);
>> +    }
>> +}
>> +
>> +static void set_pages_error(struct page **pages, int nr, int error)
>> +{
>> +    int i;
>> +    for (i = 0; i < nr; i++) {
>> +        lock_page(pages[i]);
>> +        SetPageError(pages[i]);
>> +        mapping_set_error(pages[i]->mapping, error);
>> +        unlock_page(pages[i]);
>> +    }
>> +}
>> +
>> +#define V9FS_WRITEPAGES_DEBUG   (0)
>> +
>> +struct flush_context {
>> +    struct writeback_control *wbc;
>> +    struct address_space *mapping;
>> +    struct v9fs_flush_set *fset;
>> +    pgoff_t done_index;
>> +    pgoff_t writeback_index;
>> +    pgoff_t index;
>> +    pgoff_t end; /* Inclusive */
>> +    const char *msg;
>> +    int cycled;
>> +    int range_whole;
>> +    int done;
>> +};
>> +
>> +/**
>> + * Copy a page with file's data to buffer.
>> + * Handle races with truncate, etc.
>> + * Return number of copied bytes
>> + *
>> + * @page: page to copy data from;
>> + * @page_nr: serial number of the page
>> + */
>> +static int flush_page(struct page *page, int page_nr, struct 
>> flush_context *ctx)
>> +{
>> +    char *kdata;
>> +    loff_t isize;
>> +    int copied = 0;
>> +    struct writeback_control *wbc = ctx->wbc;
>> +    /*
>> +     * At this point, the page may be truncated or
>> +     * invalidated (changing page->mapping to NULL), or
>> +     * even swizzled back from swapper_space to tmpfs file
>> +     * mapping. However, page->index will not change
>> +     * because we have a reference on the page.
>> +     */
>> +    if (page->index > ctx->end) {
>> +        /*
>> +         * can't be range_cyclic (1st pass) because
>> +         * end == -1 in that case.
>> +         */
>> +        ctx->done = 1;
>> +        ctx->msg = "page out of range";
>> +        goto exit;
>> +    }
>> +    ctx->done_index = page->index;
>> +    lock_page(page);
>> +    /*
>> +     * Page truncated or invalidated. We can freely skip it
>> +     * then, even for data integrity operations: the page
>> +     * has disappeared concurrently, so there could be no
>> +     * real expectation of this data interity operation
>> +     * even if there is now a new, dirty page at the same
>> +     * pagecache address.
>> +     */
>> +    if (unlikely(page->mapping != ctx->mapping)) {
>> +        unlock_page(page);
>> +        ctx->msg = "page truncated or invalidated";
>> +        goto exit;
>> +    }
>> +    if (!PageDirty(page)) {
>> +        /*
>> +         * someone wrote it for us
>> +         */
>> +        unlock_page(page);
>> +        ctx->msg = "page not dirty";
>> +        goto exit;
>> +    }
>> +    if (PageWriteback(page)) {
>> +        if (wbc->sync_mode != WB_SYNC_NONE)
>> +            wait_on_page_writeback(page);
>> +        else {
>> +            unlock_page(page);
>> +            ctx->msg = "page is writeback";
>> +            goto exit;
>> +        }
>> +    }
>> +    BUG_ON(PageWriteback(page));
>> +    if (!clear_page_dirty_for_io(page)) {
>> +        unlock_page(page);
>> +        ctx->msg = "failed to clear page dirty";
>> +        goto exit;
>> +    }
>> +    trace_wbc_writepage(wbc, inode_to_bdi(ctx->mapping->host));
>> +
>> +    set_page_writeback(page);
>> +    isize = i_size_read(ctx->mapping->host);
>> +    if (page->index == isize >> PAGE_SHIFT)
>> +        copied = isize & ~PAGE_MASK;
>> +    else
>> +        copied = PAGE_SIZE;
>> +    kdata = kmap_atomic(page);
>> +    memcpy(ctx->fset->buf + (page_nr << PAGE_SHIFT), kdata, copied);
>> +    kunmap_atomic(kdata);
>> +    end_page_writeback(page);
>> +
>> +    unlock_page(page);
>> +    /*
>> +     * We stop writing back only if we are not doing
>> +     * integrity sync. In case of integrity sync we have to
>> +     * keep going until we have written all the pages
>> +     * we tagged for writeback prior to entering this loop.
>> +     */
>> +    if (--wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
>> +        ctx->done = 1;
>> + exit:
>> +    return copied;
>> +}
>> +
>> +static int send_buffer(off_t offset, int len, struct flush_context 
>> *ctx)
>> +{
>> +    int ret = 0;
>> +    struct kvec kvec;
>> +    struct iov_iter iter;
>> +    struct v9fs_inode *v9inode = V9FS_I(ctx->mapping->host);
>> +
>> +    kvec.iov_base = ctx->fset->buf;
>> +    kvec.iov_len = len;
>> +    iov_iter_kvec(&iter, WRITE | ITER_KVEC, &kvec, 1, len);
>> +    BUG_ON(!v9inode->writeback_fid);
>> +
>> +    p9_client_write(v9inode->writeback_fid, offset, &iter, &ret);
>> +    return ret;
>> +}
>> +
>> +/**
>> + * Helper function for managing 9pFS write requests.
>> + * The main purpose of this function is to provide support for
>> + * the coalescing of several pages into a single 9p message.
>> + * This is similarly to NFS's pagelist.
>> + *
>> + * Copy pages with adjusent indices to a buffer and send it to
>> + * the server.
>
> Why do you need to copy the pages? The transport below 9p - virtio in 
> your case - has native scatter-gather support, so you don't need to 
> copy anything, no?
>


Perhaps we can avoid copying pages. However it would mean modification
of the 9P file transfer protocol, which is not aware of pages. I suspect 
that
such activity requires substantial sponsorship, and I am not sure that 
it will
be interesting for Huawei.

Thanks,
Edward.
