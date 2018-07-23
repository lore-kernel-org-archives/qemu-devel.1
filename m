Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhWD9-0004E8-Oy
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhWD4-00030W-Po
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:28:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhWD4-00030N-KT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:28:50 -0400
Date: Mon, 23 Jul 2018 16:28:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723082838.GJ2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-7-xiaoguangrong@tencent.com>
	<20180723050325.GF2491@xz-mi>
	<d0e8afdb-dafb-709b-15d5-7b33c086d6c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0e8afdb-dafb-709b-15d5-7b33c086d6c7@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration: move handle of zero page
 to the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jul 23, 2018 at 03:56:33PM +0800, Xiao Guangrong wrote:

[...]

> > > @@ -2249,15 +2308,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
> > >           return res;
> > >       }
> > > -    /*
> > > -     * When starting the process of a new block, the first page of
> > > -     * the block should be sent out before other pages in the same
> > > -     * block, and all the pages in last block should have been sent
> > > -     * out, keeping this order is important, because the 'cont' flag
> > > -     * is used to avoid resending the block name.
> > > -     */
> > > -    if (block != rs->last_sent_block && save_page_use_compression(rs)) {
> > > -            flush_compressed_data(rs);
> > > +    if (save_compress_page(rs, block, offset)) {
> > > +        return 1;
> > 
> > It's a bit tricky (though it seems to be a good idea too) to move the
> > zero detect into the compression thread, though I noticed that we also
> > do something else for zero pages:
> > 
> >      res = save_zero_page(rs, block, offset);
> >      if (res > 0) {
> >          /* Must let xbzrle know, otherwise a previous (now 0'd) cached
> >           * page would be stale
> >           */
> >          if (!save_page_use_compression(rs)) {
> >              XBZRLE_cache_lock();
> >              xbzrle_cache_zero_page(rs, block->offset + offset);
> >              XBZRLE_cache_unlock();
> >          }
> >          ram_release_pages(block->idstr, offset, res);
> >          return res;
> >      }
> > 
> > I'd guess that the xbzrle update of the zero page is not needed for
> > compression since after all xbzrle is not enabled when compression is
> 
> Yup. if they are both enabled, compression works only for the first
> iteration (i.e, ram_bulk_stage), at that point, nothing is cached
> in xbzrle's cahe, in other words, xbzrle has posted nothing to the
> destination.
> 
> > enabled, however do we need to do ram_release_pages() somehow?
> > 
> 
> We have done it in the thread:
> 
> +static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>                                   ram_addr_t offset, uint8_t *source_buf)
>  {
> 
> 
> +    if (save_zero_page_to_file(rs, f, block, offset)) {
> +        zero_page = true;
> +        goto exit;
> +    }
> ......
> 
> +exit:
>      ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
> +    return zero_page;
>  }

Ah, then it seems fine.  Though I'd suggest you comment these into the
commit message in case people won't get it easily.

> 
> However, it is not safe to do ram_release_pages in the thread as it's
> not protected it multithreads. Fortunately, compression will be disabled
> if it switches to post-copy, so i preferred to keep current behavior and
> deferred to fix it after this patchset has been merged.

Do you mean ram_release_pages() is not thread-safe?  Why?  I didn't
notice it before but I feel like it is safe.

Regards,

-- 
Peter Xu
