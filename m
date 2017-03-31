Received: from eggs.gnu.org ([2001:4830:134:3::10]:53365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cts1x-0005Af-Vb
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cts1u-0006sC-Pp
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cts1u-0006rU-IJ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:35:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EF9D80479
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 08:35:33 +0000 (UTC)
Date: Fri, 31 Mar 2017 16:35:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170331083526.GH3981@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-45-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-45-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 44/51] ram: reorganize last_sent_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Mar 23, 2017 at 09:45:37PM +0100, Juan Quintela wrote:
> We were setting it far away of when we changed it.  Now everything is
> done inside save_page_header.  Once there, reorganize code to pass
> RAMState.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Nit: would it worth mentioning as well the unified setup of CONTINUE
flag in commit message? No matter what:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/ram.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 83c749c..6cd77b5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -453,18 +453,22 @@ void migrate_compress_threads_create(void)
>   * @offset: offset inside the block for the page
>   *          in the lower bits, it contains flags
>   */
> -static size_t save_page_header(QEMUFile *f, RAMBlock *block, ram_addr_t offset)
> +static size_t save_page_header(RAMState *rs, RAMBlock *block, ram_addr_t offset)
>  {
>      size_t size, len;
>  
> -    qemu_put_be64(f, offset);
> +    if (block == rs->last_sent_block) {
> +        offset |= RAM_SAVE_FLAG_CONTINUE;
> +    }
> +    qemu_put_be64(rs->f, offset);
>      size = 8;
>  
>      if (!(offset & RAM_SAVE_FLAG_CONTINUE)) {
>          len = strlen(block->idstr);
> -        qemu_put_byte(f, len);
> -        qemu_put_buffer(f, (uint8_t *)block->idstr, len);
> +        qemu_put_byte(rs->f, len);
> +        qemu_put_buffer(rs->f, (uint8_t *)block->idstr, len);
>          size += 1 + len;
> +        rs->last_sent_block = block;
>      }
>      return size;
>  }
> @@ -584,7 +588,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>      }
>  
>      /* Send XBZRLE based compressed page */
> -    bytes_xbzrle = save_page_header(rs->f, block,
> +    bytes_xbzrle = save_page_header(rs, block,
>                                      offset | RAM_SAVE_FLAG_XBZRLE);
>      qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
>      qemu_put_be16(rs->f, encoded_len);
> @@ -769,7 +773,7 @@ static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
>      if (is_zero_range(p, TARGET_PAGE_SIZE)) {
>          rs->zero_pages++;
>          rs->bytes_transferred +=
> -            save_page_header(rs->f, block, offset | RAM_SAVE_FLAG_COMPRESS);
> +            save_page_header(rs, block, offset | RAM_SAVE_FLAG_COMPRESS);
>          qemu_put_byte(rs->f, 0);
>          rs->bytes_transferred += 1;
>          pages = 1;
> @@ -826,9 +830,6 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>  
>      current_addr = block->offset + offset;
>  
> -    if (block == rs->last_sent_block) {
> -        offset |= RAM_SAVE_FLAG_CONTINUE;
> -    }
>      if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
>          if (ret != RAM_SAVE_CONTROL_DELAYED) {
>              if (bytes_xmit > 0) {
> @@ -860,8 +861,8 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>  
>      /* XBZRLE overflow or normal page */
>      if (pages == -1) {
> -        rs->bytes_transferred += save_page_header(rs->f, block,
> -                                               offset | RAM_SAVE_FLAG_PAGE);
> +        rs->bytes_transferred += save_page_header(rs, block,
> +                                                  offset | RAM_SAVE_FLAG_PAGE);
>          if (send_async) {
>              qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
>                                    migrate_release_ram() &
> @@ -882,10 +883,11 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>  static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>                                  ram_addr_t offset)
>  {
> +    RAMState *rs = &ram_state;
>      int bytes_sent, blen;
>      uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
>  
> -    bytes_sent = save_page_header(f, block, offset |
> +    bytes_sent = save_page_header(rs, block, offset |
>                                    RAM_SAVE_FLAG_COMPRESS_PAGE);
>      blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
>                                       migrate_compress_level());
> @@ -1016,7 +1018,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>              pages = save_zero_page(rs, block, offset, p);
>              if (pages == -1) {
>                  /* Make sure the first page is sent out before other pages */
> -                bytes_xmit = save_page_header(rs->f, block, offset |
> +                bytes_xmit = save_page_header(rs, block, offset |
>                                                RAM_SAVE_FLAG_COMPRESS_PAGE);
>                  blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
>                                                   migrate_compress_level());
> @@ -1033,7 +1035,6 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>                  ram_release_pages(block->idstr, pss->offset, pages);
>              }
>          } else {
> -            offset |= RAM_SAVE_FLAG_CONTINUE;
>              pages = save_zero_page(rs, block, offset, p);
>              if (pages == -1) {
>                  pages = compress_page_with_multi_thread(rs, block, offset);
> @@ -1330,13 +1331,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          if (unsentmap) {
>              clear_bit(dirty_ram_abs >> TARGET_PAGE_BITS, unsentmap);
>          }
> -        /* Only update last_sent_block if a block was actually sent; xbzrle
> -         * might have decided the page was identical so didn't bother writing
> -         * to the stream.
> -         */
> -        if (res > 0) {
> -            rs->last_sent_block = pss->block;
> -        }
>      }
>  
>      return res;
> -- 
> 2.9.3
> 
> 

-- peterx
