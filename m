Received: from eggs.gnu.org ([2001:4830:134:3::10]:42379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewR54-0003V2-7e
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewR51-0003pd-0P
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:29:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewR50-0003ow-Q6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:29:54 -0400
Date: Thu, 15 Mar 2018 11:29:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180315112937.GC3062@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-4-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-4-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support to detect
 compression and decompression errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Currently the page being compressed is allowed to be updated by
> the VM on the source QEMU, correspondingly the destination QEMU
> just ignores the decompression error. However, we completely miss
> the chance to catch real errors, then the VM is corrupted silently
> 
> To make the migration more robuster, we copy the page to a buffer
> first to avoid it being written by VM, then detect and handle the
> errors of both compression and decompression errors properly
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/qemu-file.c |  4 ++--
>  migration/ram.c       | 29 +++++++++++++++++++----------
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 1ff33a1ffb..137bcc8bdc 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -711,9 +711,9 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>      blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
>                                blen, p, size);
>      if (blen < 0) {
> -        error_report("Compress Failed!");
> -        return 0;
> +        return -1;
>      }
> +
>      qemu_put_be32(f, blen);
>      if (f->ops->writev_buffer) {
>          add_to_iovec(f, f->buf + f->buf_index, blen, false);
> diff --git a/migration/ram.c b/migration/ram.c
> index fff3f31e90..c47185d38c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -273,6 +273,7 @@ struct DecompressParam {
>      bool quit;
>      QemuMutex mutex;
>      QemuCond cond;
> +    QEMUFile *file;
>      void *des;
>      uint8_t *compbuf;
>      int len;
> @@ -1051,11 +1052,13 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>  {
>      RAMState *rs = ram_state;
>      int bytes_sent, blen;
> -    uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
> +    uint8_t buf[TARGET_PAGE_SIZE], *p;

That should be malloc'd somewhere rather than be on the stack; it's a
bit big and also there are architectures where TARGET_PAGE_SIZE isn't
compile time constant.

(Also, please use g_try_malloc rather than g_malloc on larger chunks,
since g_try_malloc will return NULL so you can fail nicely;  g_malloc is
OK for small things that are very unlikely to fail).

Other than that, I think the patch is fine.

Dave

> +    p = block->host + (offset & TARGET_PAGE_MASK);
>      bytes_sent = save_page_header(rs, f, block, offset |
>                                    RAM_SAVE_FLAG_COMPRESS_PAGE);
> -    blen = qemu_put_compression_data(f, stream, p, TARGET_PAGE_SIZE);
> +    memcpy(buf, p, TARGET_PAGE_SIZE);
> +    blen = qemu_put_compression_data(f, stream, buf, TARGET_PAGE_SIZE);
>      if (blen < 0) {
>          bytes_sent = 0;
>          qemu_file_set_error(migrate_get_current()->to_dst_file, blen);
> @@ -2547,7 +2550,7 @@ static void *do_data_decompress(void *opaque)
>      DecompressParam *param = opaque;
>      unsigned long pagesize;
>      uint8_t *des;
> -    int len;
> +    int len, ret;
>  
>      qemu_mutex_lock(&param->mutex);
>      while (!param->quit) {
> @@ -2563,8 +2566,12 @@ static void *do_data_decompress(void *opaque)
>               * not a problem because the dirty page will be retransferred
>               * and uncompress() won't break the data in other pages.
>               */
> -            qemu_uncompress(&param->stream, des, pagesize,
> -                            param->compbuf, len);
> +            ret = qemu_uncompress(&param->stream, des, pagesize,
> +                                  param->compbuf, len);
> +            if (ret < 0) {
> +                error_report("decompress data failed");
> +                qemu_file_set_error(param->file, ret);
> +            }
>  
>              qemu_mutex_lock(&decomp_done_lock);
>              param->done = true;
> @@ -2581,12 +2588,12 @@ static void *do_data_decompress(void *opaque)
>      return NULL;
>  }
>  
> -static void wait_for_decompress_done(void)
> +static int wait_for_decompress_done(QEMUFile *f)
>  {
>      int idx, thread_count;
>  
>      if (!migrate_use_compression()) {
> -        return;
> +        return 0;
>      }
>  
>      thread_count = migrate_decompress_threads();
> @@ -2597,6 +2604,7 @@ static void wait_for_decompress_done(void)
>          }
>      }
>      qemu_mutex_unlock(&decomp_done_lock);
> +    return qemu_file_get_error(f);
>  }
>  
>  static void compress_threads_load_cleanup(void)
> @@ -2635,7 +2643,7 @@ static void compress_threads_load_cleanup(void)
>      decomp_param = NULL;
>  }
>  
> -static int compress_threads_load_setup(void)
> +static int compress_threads_load_setup(QEMUFile *f)
>  {
>      int i, thread_count;
>  
> @@ -2654,6 +2662,7 @@ static int compress_threads_load_setup(void)
>          }
>          decomp_param[i].stream.opaque = &decomp_param[i];
>  
> +        decomp_param[i].file = f;
>          qemu_mutex_init(&decomp_param[i].mutex);
>          qemu_cond_init(&decomp_param[i].cond);
>          decomp_param[i].compbuf = g_malloc0(compressBound(TARGET_PAGE_SIZE));
> @@ -2708,7 +2717,7 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
>   */
>  static int ram_load_setup(QEMUFile *f, void *opaque)
>  {
> -    if (compress_threads_load_setup()) {
> +    if (compress_threads_load_setup(f)) {
>          return -1;
>      }
>  
> @@ -3063,7 +3072,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          }
>      }
>  
> -    wait_for_decompress_done();
> +    ret |= wait_for_decompress_done(f);
>      rcu_read_unlock();
>      trace_ram_load_complete(ret, seq_iter);
>      return ret;
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
