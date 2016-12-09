Received: from eggs.gnu.org ([2001:4830:134:3::10]:55738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cFQ8o-0003j4-PX
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edward.shishkin@gmail.com>) id 1cFQ8k-0000rv-R7
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:43:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edward.shishkin@gmail.com>)
	id 1cFQ8k-0000qN-H3
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 13:43:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so5366273wme.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 10:43:05 -0800 (PST)
References: <7a0376a6-e9c1-92c0-a75f-6b44495ba2b2@gmail.com>
	<1476120280-30873-1-git-send-email-edward.shishkin@gmail.com>
	<1476120280-30873-2-git-send-email-edward.shishkin@gmail.com>
	<580F689A.5070305@suse.de>
From: Edward Shishkin <edward.shishkin@gmail.com>
Message-ID: <4e24c3bf-2efb-147d-7cae-51e3797ba04d@gmail.com>
Date: Fri, 9 Dec 2016 19:42:02 +0100
MIME-Version: 1.0
In-Reply-To: <580F689A.5070305@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] 9p: v9fs new readpages.
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

Hello Alexander,

Thank you for the comments.
Please, find my answers below.


On 10/25/2016 04:13 PM, Alexander Graf wrote:
> On 10/10/2016 07:24 PM, Edward Shishkin wrote:
>> Modify v9fs private ->readpages() method of address_space
>> operations for merging pages into long 9p messages.
>>
>> Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
>> ---
>>   fs/9p/vfs_addr.c | 156 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 155 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
>> index e871886..4ad248e 100644
>> --- a/fs/9p/vfs_addr.c
>> +++ b/fs/9p/vfs_addr.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/sched.h>
>>   #include <linux/uio.h>
>> +#include <linux/slab.h>
>>   #include <net/9p/9p.h>
>>   #include <net/9p/client.h>
>>   #include <trace/events/writeback.h>
>> @@ -99,6 +100,148 @@ static int v9fs_vfs_readpage(struct file *filp, 
>> struct page *page)
>>       return v9fs_fid_readpage(filp->private_data, page);
>>   }
>>   +/*
>> + * Context for "fast readpages"
>> + */
>> +struct v9fs_readpages_ctx {
>> +    struct file *filp;
>> +    struct address_space *mapping;
>> +    pgoff_t start_index; /* index of the first page with actual data */
>> +    char *buf; /* buffer with actual data */
>> +    int len; /* length of the actual data */
>> +    int num_pages; /* maximal data chunk (in pages) that can be
>> +              passed per transmission */
>> +};
>> +
>> +static int init_readpages_ctx(struct v9fs_readpages_ctx *ctx,
>> +                  struct file *filp,
>> +                  struct address_space *mapping,
>> +                  int num_pages)
>> +{
>> +    memset(ctx, 0, sizeof(*ctx));
>> +    ctx->buf = kmalloc(num_pages << PAGE_SHIFT, GFP_USER);
>
> Doesn't this a) have potential information leak to user space


Yes, allocation with such flag is a mistake. Will be fixed in v2.


> and b) allow user space to allocate big amounts of kernel memory?


Yes, I definitely missed a sanity check for the num_pages. Will be fixed 
in v2.


> A limited page pool would probably be better here.
>
> I also don't quite grasp yet what pattern you're actually optimizing.


reading/writing a large file in sequential/random manner.


> Basically you're doing implicit read-ahead on behalf of the reader, right?


Yes. As you can see, we always read (ctx->num_pages) number of pages.


> So why would that be faster in a random 4k read scenario?


You mean 41 MB/s vs 64 MB/s?
With such read-ahead it's more likely that an up-to-date page will be 
present in
the cache. So, why not? After all, our speedup of random 4K reads is not 
dramatic.


> Also, have you compared tmpfs hosted files to only benchmark the 
> transmission path?


No, I haven't. Only I/O speedup was a concern.
I can obtain such numbers, if interesting.


>
>> +    if (!ctx->buf)
>> +        return -ENOMEM;
>> +    ctx->filp = filp;
>> +    ctx->mapping = mapping;
>> +    ctx->num_pages = num_pages;
>> +    return 0;
>> +}
>> +
>> +static void done_readpages_ctx(struct v9fs_readpages_ctx *ctx)
>> +{
>> +    kfree(ctx->buf);
>> +}
>> +
>> +static int receive_buffer(struct file *filp,
>> +              char *buf,
>> +              off_t offset, /* offset in the file */
>> +              int len,
>> +              int *err)
>> +{
>> +    struct kvec kvec;
>> +    struct iov_iter iter;
>> +
>> +    kvec.iov_base = buf;
>> +    kvec.iov_len = len;
>> +    iov_iter_kvec(&iter, READ | ITER_KVEC, &kvec, 1, len);
>> +
>> +    return p9_client_read(filp->private_data, offset, &iter, err);
>> +}
>> +
>> +static int fast_filler(struct v9fs_readpages_ctx *ctx, struct page 
>> *page)
>> +{
>> +    int err;
>> +    int ret = 0;
>> +    char *kdata;
>> +    int to_page;
>> +    off_t off_in_buf;
>> +    struct inode *inode = page->mapping->host;
>> +
>> +    BUG_ON(!PageLocked(page));
>> +    /*
>> +     * first, validate the buffer
>> +     */
>> +    if (page->index < ctx->start_index ||
>> +        ctx->start_index + ctx->num_pages < page->index) {
>> +        /*
>> +         * No actual data in the buffer,
>> +         * so actualize it
>> +         */
>> +        ret = receive_buffer(ctx->filp,
>> +                     ctx->buf,
>> +                     page_offset(page),
>> +                     ctx->num_pages << PAGE_SHIFT,
>
> Doesn't this potentially read beyond the end of the file?


POSIX doesn't prohibit to read beyond the end of a file. The only 
requirement is that
the supplement should be filled with zeros.
Full pages of such supplement are filled with zeros from the buffer: 
here we rely on
the local file system on the host. Partial pages are filled with zeros 
by us at the place
I have marked with (*) below.

Thanks,
Edward.

>
> Alex
>
>> +                     &err);
>> +        if (err) {
>> +            printk("failed to receive buffer off=%llu (%d)\n",
>> +                   (unsigned long long)page_offset(page),
>> +                   err);
>> +            ret = err;
>> +            goto done;
>> +        }
>> +        ctx->start_index = page->index;
>> +        ctx->len = ret;
>> +        ret = 0;
>> +    }
>> +    /*
>> +     * fill the page with buffer's data
>> +     */
>> +    off_in_buf = (page->index - ctx->start_index) << PAGE_SHIFT;
>> +    if (off_in_buf >= ctx->len) {
>> +        /*
>> +         * No actual data to fill the page with
>> +         */
>> +        ret = -1;
>> +        goto done;
>> +    }
>> +    to_page = ctx->len - off_in_buf;
>> +    if (to_page >= PAGE_SIZE)
>> +        to_page = PAGE_SIZE;
>> +
>> +    kdata = kmap_atomic(page);
>> +    memcpy(kdata, ctx->buf + off_in_buf, to_page);
>> +    memset(kdata + to_page, 0, PAGE_SIZE - to_page);

(*)

>> +    kunmap_atomic(kdata);
>> +
>> +    flush_dcache_page(page);
>> +    SetPageUptodate(page);
>> +    v9fs_readpage_to_fscache(inode, page);
>> + done:
>> +    unlock_page(page);
>> +    return ret;
>> +}
>> +
>> +/**
>> + * Try to read pages by groups. For every such group we issue only one
>> + * read request to the server.
>> + * @num_pages: maximal chunk of data (in pages) that can be passed per
>> + * such request
>> + */
>> +static int v9fs_readpages_tryfast(struct file *filp,
>> +                  struct address_space *mapping,
>> +                  struct list_head *pages,
>> +                  int num_pages)
>> +{
>> +    int ret;
>> +    struct v9fs_readpages_ctx ctx;
>> +
>> +    ret = init_readpages_ctx(&ctx, filp, mapping, num_pages);
>> +    if (ret)
>> +        /*
>> +         * Can not allocate resources for the fast path,
>> +         * so do it by slow way
>> +         */
>> +        return read_cache_pages(mapping, pages,
>> +                    (void *)v9fs_vfs_readpage, filp);
>> +
>> +    else
>> +        ret = read_cache_pages(mapping, pages,
>> +                       (void *)fast_filler, &ctx);
>> +    done_readpages_ctx(&ctx);
>> +    return ret;
>> +}
>> +
>>   /**
>>    * v9fs_vfs_readpages - read a set of pages from 9P
>>    *
>> @@ -114,6 +257,7 @@ static int v9fs_vfs_readpages(struct file *filp, 
>> struct address_space *mapping,
>>   {
>>       int ret = 0;
>>       struct inode *inode;
>> +    struct v9fs_flush_set *fset;
>>         inode = mapping->host;
>>       p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, filp);
>> @@ -122,7 +266,17 @@ static int v9fs_vfs_readpages(struct file *filp, 
>> struct address_space *mapping,
>>       if (ret == 0)
>>           return ret;
>>   -    ret = read_cache_pages(mapping, pages, (void 
>> *)v9fs_vfs_readpage, filp);
>> +    fset = v9fs_inode2v9ses(mapping->host)->flush;
>> +    if (!fset)
>> +        /*
>> +         * Do it by slow way
>> +         */
>> +        ret = read_cache_pages(mapping, pages,
>> +                       (void *)v9fs_vfs_readpage, filp);
>> +    else
>> +        ret = v9fs_readpages_tryfast(filp, mapping,
>> +                         pages, fset->num_pages);
>> +
>>       p9_debug(P9_DEBUG_VFS, "  = %d\n", ret);
>>       return ret;
>>   }
>
