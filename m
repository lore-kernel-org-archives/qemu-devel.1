Received: from eggs.gnu.org ([2001:4830:134:3::10]:49251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0iq7-0005Pk-Cx
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0iq2-0006K8-41
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 03:48:31 -0400
Date: Fri, 14 Sep 2018 15:47:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180914074751.GH3653@lemon.usersys.redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-12-kwolf@redhat.com>
	<908e08a4-a58a-e4e1-5eb7-fe9d17adfbe3@redhat.com>
	<20180913165954.GB5172@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913165954.GB5172@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 11/17] block-backend: Decrease in_flight
 only after callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On Thu, 09/13 18:59, Kevin Wolf wrote:
> Am 13.09.2018 um 17:10 hat Paolo Bonzini geschrieben:
> > On 13/09/2018 14:52, Kevin Wolf wrote:
> > > + if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
> > > + /* If we are in the main thread, the callback is allowed to unref
> > > + * the BlockBackend, so we have to hold an additional reference */
> > > + blk_ref(acb->rwco.blk);
> > > + }
> > > acb->common.cb(acb->common.opaque, acb->rwco.ret);
> > > + blk_dec_in_flight(acb->rwco.blk);
> > > + if (qemu_get_current_aio_context() == qemu_get_aio_context()) {
> > > + blk_unref(acb->rwco.blk);
> > > + }
> > 
> > Is this something that happens only for some specific callers?  That is,
> > which callers are sure that the callback is invoked from the main thread?
> 
> I can't seem to reproduce the problem I saw any more even when reverting
> the bdrv_ref/unref pair. If I remember correctly it was actually a
> nested aio_poll() that was running a block job completion or something
> like that - which would obviously only happen on the main thread because
> the job intentionally defers to the main thread.
> 
> The only reason I made this conditional is that I think bdrv_unref()
> still isn't safe outside the main thread, is it?

I think that is correct.

Fam
