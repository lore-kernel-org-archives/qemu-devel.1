Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ5gA-0008Qp-CZ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ5g9-0001S6-Bd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:42:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQ5g9-0001Rq-5q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:42:49 -0400
Date: Tue, 5 Jun 2018 14:42:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605064240.GA9216@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<20180601045824.GH14867@xz-mi> <5B10F412.8050900@intel.com>
	<20180601104005.GL14867@xz-mi> <20180601153328.GC2531@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601153328.GC2531@work-vm>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Fri, Jun 01, 2018 at 04:33:29PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > > > Meanwhile, this reminds me about a more funny idea: whether we can
> > > > just avoid sending the zero pages directly from QEMU's perspective.
> > > > In other words, can we just do nothing if save_zero_page() detected
> > > > that the page is zero (I guess the is_zero_range() can be fast too,
> > > > but I don't know exactly how fast it is)?  And how that would be
> > > > differed from this page hinting way in either performance and other
> > > > aspects.
> > > 
> > > I guess you referred to the zero page optimization. I think the major
> > > overhead comes to the zero page checking - lots of memory accesses, which
> > > also waste memory bandwidth. Please see the results attached in the cover
> > > letter. The legacy case already includes the zero page optimization.
> > 
> > I replied in the other thread.  We can discuss there altogether.
> > 
> > Actually after a second thought I think maybe what I worried there is
> > exactly the reason why we must send the zero page flag - otherwise
> > there can be stale non-zero page on destination.  Here "zero page" and
> > "freed page" is totally different idea since even if a page is zeroed
> > it might still be in use (not freed)!  While instead for a "free page"
> > even if it's non-zero we might be able to not send it at all, though I
> > am not sure whether that mismatch of data might cause any side effect
> > too. I think the corresponding question would be: if a page is freed
> > in Linux kernel, would its data matter any more?
> 
> I think the answer is no - it doesn't matter; by telling the hypervisor
> the page is 'free' the kernel gives freedom to the hypervisor to
> discard the page contents.

Yeh it seems so.  I just read over the whole work so I think there is
a future work for the poisoned bits.  If that's the only usage that
might make the content of freed page meaningful then it seems fine to
me.  After all I don't know much about that...  However still this
seems to be a bit tricky, e.g., we need to be very careful on the
guest OS side (when writting up the balloon driver for one guest OS)
to make sure of that otherwise it'll be very easy to break a guest
when something similar is enabled without our notice just like the
poisoned feature.

> Now, that is trusting the kernel to get it's 'free' flags right,
> and we wouldn't want a malicious guest kernel to be able to read random
> data, so we have to be a little careful that what actually lands
> in there is something the guest has had at some point - or zero
> which is a very nice empty value.

Yeah I agree - basically this feature brings more trouble from the
security POV, but I don't know whether that can be a problem since
after all we can disable this when we care very much about security.

Regards,

-- 
Peter Xu
