Received: from eggs.gnu.org ([2001:4830:134:3::10]:53249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff8kU-0001Mz-BK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff8kR-0004VB-5r
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:01:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ff8kR-0004Uy-0T
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:01:27 -0400
Date: Mon, 16 Jul 2018 20:01:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180716190122.GE2664@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-6-xiaoguangrong@tencent.com>
	<20180613162508.GM2676@work-vm>
	<b64e1091-7fe4-fe65-4b28-2597491993e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64e1091-7fe4-fe65-4b28-2597491993e1@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
> 
> 
> On 06/14/2018 12:25 AM, Dr. David Alan Gilbert wrote:
>  }
> > >   static void migration_bitmap_sync(RAMState *rs)
> > > @@ -1412,6 +1441,9 @@ static void flush_compressed_data(RAMState *rs)
> > >           qemu_mutex_lock(&comp_param[idx].mutex);
> > >           if (!comp_param[idx].quit) {
> > >               len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
> > > +            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> > > +            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
> > 
> > I think I'd rather save just len+8 rather than than the subtraction.
> > 
> Hmmmmmm, is this what you want?
>       compression_counters.reduced_size += len - 8;
> 
> Then calculate the real reduced size in populate_ram_info() where we return this
> info to the user:
>       info->compression->reduced_size = compression_counters.pages * PAGE_SIZE - compression_counters.reduced_size;
> 
> Right?

I mean I'd rather see the actual size presented to the user rather than
the saving compared to uncompressed.

Dave

> > I think other than that, and Eric's comments, it's OK.
> > 
> 
> Thanks.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
