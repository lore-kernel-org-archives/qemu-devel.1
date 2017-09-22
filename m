Received: from eggs.gnu.org ([2001:4830:134:3::10]:57510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNAc-0002VK-Dg
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNAb-00078J-Fq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:35:02 -0400
Date: Fri, 22 Sep 2017 20:34:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922123400.GA32000@lemon>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
	<20170921131707.17364-2-el13635@mail.ntua.gr>
	<20170921132943.GE13703@lemon.lan>
	<20170921153935.ffyvqej37qhfkrm5@postretch>
	<20170922023053.GB1397@lemon.lan>
	<20170922110320.GD12295@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922110320.GD12295@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: add bdrv_co_drain_end
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Manos Pitsidianakis <el13635@mail.ntua.gr>

On Fri, 09/22 13:03, Kevin Wolf wrote:
> Am 22.09.2017 um 04:30 hat Fam Zheng geschrieben:
> > On Thu, 09/21 18:39, Manos Pitsidianakis wrote:
> > > On Thu, Sep 21, 2017 at 09:29:43PM +0800, Fam Zheng wrote:
> > > > On Thu, 09/21 16:17, Manos Pitsidianakis wrote:
> > > It might imply to someone that there's an assert(drv->bdrv_co_drain_begin &&
> > > drv->bdrv_co_drain_end) somewhere unless you state they don't have to be
> > > implemented at the same time. How about we be completely explicit:
> > > 
> > >  bdrv_co_drain_begin is called if implemented in the beggining of a
> > >  drain operation to drain and stop any internal sources of requests in
> > >  the driver.
> > >  bdrv_co_drain_end is called if implemented at the end of the drain.
> > > 
> > >  They should be used by the driver to e.g. manage scheduled I/O
> > >  requests, or toggle an internal state. After the end of the drain new
> > >  requests will continue normally.
> > > 
> > > I hope this is easier for a reader to understand!
> > 
> > I don't like the inconsistent semantics of when the drained section
> > ends, if we allow drivers to implement bdrv_co_drain_begin but omit
> > bdrv_co_drained_end.  Currently the point where the section ends is,
> > as said in the comment, when next I/O callback is invoked. Now we are
> > adding the explicit ".bdrv_co_drain_end" into the fomular, if we still
> > keep the previous convention, the interface contract is just mixed of
> > two things for no good reason. I don't think it's technically
> > necessary.
> 
> We don't keep the convention with the next I/O callback. We just allow
> drivers to omit an empty implementation of either callback, which seems
> to be a very sensible default to me.
> 

OK, I'm fine with this.

Fam
