Received: from eggs.gnu.org ([2001:4830:134:3::10]:56053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1exueF-0002v8-Ub
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1exueB-00047Q-Ll
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:16:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1exueB-000470-HA
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:16:19 -0400
Date: Mon, 19 Mar 2018 13:15:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180319131558.GD3206@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-6-xiaoguangrong@tencent.com>
	<20180315114715.GE3062@work-vm>
	<5aa7923b-2b4c-4d44-7861-63c05e25c75f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa7923b-2b4c-4d44-7861-63c05e25c75f@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] migration: move calling
 control_save_page to the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
> 
> 
> On 03/15/2018 07:47 PM, Dr. David Alan Gilbert wrote:
> 
> > >       /* Check the pages is dirty and if it is send it */
> > >       if (migration_bitmap_clear_dirty(rs, pss->block, pss->page)) {
> > > +        RAMBlock *block = pss->block;
> > > +        ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> > > +
> > > +        if (control_save_page(rs, block, offset, &res)) {
> > > +            goto page_saved;
> > 
> > OK, but I'd prefer if you avoided this forward goto;  we do use goto but
> > we tend to keep it just for error cases.
> > 
> 
> There is a common operation, clearing unsentmap, for save_control,
> save_zero, save_compressed and save_normal, if we do not use 'goto',
> the operation would to be duplicated several times or we will have
> big if...elseif...elseif... section.
> 
> So it may be not too bad to have 'goto' under this case? :)

The problem is it always tends to creep a bit, and then you soon have
a knot of goto's.

I suggest you add a 'page_saved' bool, set it instead of taking the
goto, and then add a if (!page_saved) around the next section.
It doesn't need to nest for the last section; you just do another
if (!page_saved) if around that.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
