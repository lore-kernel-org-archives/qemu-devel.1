Received: from eggs.gnu.org ([209.51.188.92]:47108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gs2ls-0003dj-Hj
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gs2lo-0005O5-Tp
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:48:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gs2lo-0005NR-FW
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 04:48:28 -0500
Date: Fri, 8 Feb 2019 09:48:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190208094818.GA2608@work-vm>
References: <2932080.UxbmD43V0u@neil>
	<20190208062441.GF16257@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208062441.GF16257@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [regression] Clock jump on VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Neil Skrypuch <neil@tembosocial.com>, qemu-devel@nongnu.org

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Thu, Feb 07, 2019 at 05:33:25PM -0500, Neil Skrypuch wrote:
> 
> Thanks for your email!
> 
> Please post your QEMU command-line.
> 
> > The clock jump numbers above are from NTP, but you can see that they are quite 
> > close to the amount of time spent in raw_co_invalidate_cache. So, it looks 
> > like flushing the cache is just taking a long time and stalling the guest, 
> > which causes the clock jump. This isn't too surprising as the entire disk 
> > image was just written as part of the block mirror and would likely still be 
> > in the cache.
> > 
> > I see the use case for this feature, but I don't think it applies here, as 
> > we're not technically using shared storage. I believe an option to toggle this 
> > behaviour on/off and/or some sort of heuristic to guess whether or not it 
> > should be enabled by default would be in order here.
> 
> It would be good to figure out how to perform the flush without
> affecting guest time at all.  The clock jump will also inconvenience
> users who do need the flush, so I rather not work around the clock jump
> for a subset of users only.

One thing that makes Neil's setup different is that having the source
and destination on the same host, that fadvise is bound to drop pages
that are actually in use by the source on the same host.

But I'm also curious at what point in the migration we call the
invalidate and so which threads get held up, in which state.

Neil: Another printf would also be interesting, between the
bdrv_co_flush and the posix_fadvise;  I'm assuming it's the
bdrv_co_flush that's taking the time but it would be good to check.

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
