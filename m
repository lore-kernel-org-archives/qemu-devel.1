Received: from eggs.gnu.org ([2001:4830:134:3::10]:35315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnPBL-0000sv-5J
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnPBH-0006JR-5E
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:11:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fnPBG-0006IX-Vq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:11:19 -0400
Date: Wed, 8 Aug 2018 15:11:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180808141112.GK2734@work-vm>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-9-xiaoguangrong@tencent.com>
	<20180808050846.GG24415@xz-mi>
	<503d7733-e2e7-09c5-75a3-1e250f549065@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503d7733-e2e7-09c5-75a3-1e250f549065@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/10] migration: handle the error
 condition properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
> 
> 
> On 08/08/2018 01:08 PM, Peter Xu wrote:
> > On Tue, Aug 07, 2018 at 05:12:07PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > ram_find_and_save_block() can return negative if any error hanppens,
> > > however, it is completely ignored in current code
> > 
> > Could you hint me where we'll return an error?
> > 
> 
> I think control_save_page() may return a error condition but i am not
> good at it ... Other places look safe _currently_. These functions were
> designed to have error returned anyway.

ram_control_save_page's return is checked by control_save_page which
returns true/false but sets *pages to a return value.

What I'd need to follow closely is the case where ram_control_save_page
returns RAM_SAVE_CONTROL_DELAYED, in that case control_save_page I think
returns with *pages=-1 and returns true.
And I think in that case ram_save_target_page can leak that -1 - hmm.

Now, ram_save_host_page already checks for <0 and will return that,
but I think that would potentially loop in ram_find_and_save_block; I'm
not sure we want to change that or not!

Dave

> 
> > (Anyway I agree that the error handling is not that good, mostly
> >   because the QEMUFile APIs does not provide proper return code, e.g.,
> >   qemu_put_be64 returns void)
> > 
> 
> Yes, it is, the returned error condition is mixed in file's API and
> function's return value... :(
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
