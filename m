Received: from eggs.gnu.org ([2001:4830:134:3::10]:51340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE3sc-000707-0S
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE3sY-00042U-Ni
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:21:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fE3sY-00042K-IW
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:21:54 -0400
Date: Thu, 3 May 2018 10:21:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503022136.GD8239@xz-mi>
References: <20180428081045.8878-1-xiaoguangrong@tencent.com>
	<20180502024653.GB25938@xz-mi> <20180502153039.GF2679@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502153039.GF2679@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: fix saving normal page even if
 it's been compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: quintela@redhat.com, guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Wed, May 02, 2018 at 04:30:39PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Sat, Apr 28, 2018 at 04:10:45PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > Fix the bug introduced by da3f56cb2e767016 (migration: remove
> > > ram_save_compressed_page()), It should be 'return' rather than
> > > 'res'
> > > 
> > > Sorry for this stupid mistake :(
> > > 
> > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > So is that only a performance degradation without this fix (since
> > AFAIU the compressing pages will be sent twice)?  Thanks,
> 
> It might be a bit more messy than that; because I think the
> 'compress_page_with_multi_thread' hands it to a compression thread to
> compress and write, but I don't think it waits for it.
> So I think you'll end up with this being written at the same time as the
> uncompressed data is written - I'm not sure what the other end receives.
> (Which makes me realise I don't think I understand how the compression
> threads are safe with their writing data out).

IIUC the compression threads are not really writting stuff to sockets,
but only to local RAM.  Please refer to do_data_compress() - when we
do do_compress_ram_page() we are writting to CompressParam.file which
is only a local buffer.  We flush this buffer in
flush_compressed_data() with qemu_put_qemu_file().  So IMHO the pages
are still serialized no matter whether it's a compressed page or
normal page.

Then IMHO it'll be fine, since no matter whether we receive the
compressed page or normal page first, we just update that page twice.
Then we have two possibilities:

- If the page is further modified, then both updates won't have any
  effect since we'll send a new version soon;

- If the page is not modified any more, then both the compressed page
  and normal page will have exactly the same content, then it won't
  matter much on which one we handled first on destination (note that
  we will still handle the pages sequentially on destination).

> 
> Anyway, I think we should get this one in quickly.

Yes.

Regards,

-- 
Peter Xu
