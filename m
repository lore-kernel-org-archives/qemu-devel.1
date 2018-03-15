Received: from eggs.gnu.org ([2001:4830:134:3::10]:51483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewQ4V-0001np-DN
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewQ4S-0006o8-BE
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:25:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewQ4S-0006ng-4Q
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:25:16 -0400
Date: Thu, 15 Mar 2018 10:25:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180315102501.GA3062@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-2-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, quintela@redhat.com, liang.z.li@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> As compression is a heavy work, do not do it in migration thread,
> instead, we post it out as a normal page
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 32 ++++++++++++++++----------------

Hi,
  Do you have some performance numbers to show this helps?  Were those
taken on a normal system or were they taken with one of the compression
accelerators (which I think the compression migration was designed for)?

>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7266351fd0..615693f180 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1132,7 +1132,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>      int pages = -1;
>      uint64_t bytes_xmit = 0;
>      uint8_t *p;
> -    int ret, blen;
> +    int ret;
>      RAMBlock *block = pss->block;
>      ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
>  
> @@ -1162,23 +1162,23 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>          if (block != rs->last_sent_block) {
>              flush_compressed_data(rs);
>              pages = save_zero_page(rs, block, offset);
> -            if (pages == -1) {
> -                /* Make sure the first page is sent out before other pages */
> -                bytes_xmit = save_page_header(rs, rs->f, block, offset |
> -                                              RAM_SAVE_FLAG_COMPRESS_PAGE);
> -                blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
> -                                                 migrate_compress_level());
> -                if (blen > 0) {
> -                    ram_counters.transferred += bytes_xmit + blen;
> -                    ram_counters.normal++;
> -                    pages = 1;
> -                } else {
> -                    qemu_file_set_error(rs->f, blen);
> -                    error_report("compressed data failed!");
> -                }
> -            }
>              if (pages > 0) {
>                  ram_release_pages(block->idstr, offset, pages);
> +            } else {
> +                /*
> +                 * Make sure the first page is sent out before other pages.
> +                 *
> +                 * we post it as normal page as compression will take much
> +                 * CPU resource.
> +                 */
> +                ram_counters.transferred += save_page_header(rs, rs->f, block,
> +                                                offset | RAM_SAVE_FLAG_PAGE);
> +                qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
> +                                      migrate_release_ram() &
> +                                      migration_in_postcopy());
> +                ram_counters.transferred += TARGET_PAGE_SIZE;
> +                ram_counters.normal++;
> +                pages = 1;


However, the code and idea look OK, so

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>              }
>          } else {
>              pages = save_zero_page(rs, block, offset);
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
