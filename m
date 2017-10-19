Received: from eggs.gnu.org ([2001:4830:134:3::10]:36039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e58tM-0006zt-UO
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e58tH-0006Aa-Vq
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e58tH-0006AG-P1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:21:31 -0400
Date: Thu, 19 Oct 2017 12:21:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171019112122.GF2281@work-vm>
References: <20171018174013.22709-1-dgilbert@redhat.com>
	<20171019043145.GA7850@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019043145.GA7850@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] migration: pause-before-switchover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Oct 18, 2017 at 06:40:06PM +0100, Dr. David Alan Gilbert (git) wrote:
> 
> [...]
> 
> > The precopy flow is:
> > active->pre-switchover->device->completed
> > 
> > The postcopy flow is:
> > active->pre-switchover->postcopy-active->completed
> 
> The naming is still slightly confusing to me:
> 
> (1) we have a capability called "pause-before-switchover", so it feels
>     like there is something called "switchover" and if we enable this
>     we'll pause before that point;
> 
> (2) we have a new status "pre-switchover", it feels like that's the
>     point before we are in "switchover" state;
> 
> (3) we don't really have a "switchover" state, but instead it's called
>     "device" which is exactly the "switchover" action.
> 
> Considering (1) and (2), I would prefer "device" state to be just
> "switchover"...

Yes I stuck to pause-before-device and device originally; but
what we're doing during the 'device' stage is mostly saving device
state; the actual switchover occurs at the end.  So hmm.

> Further, not sure we can unify the state transition as well (say, we
> add this switchover state even without cap "pause-before-switchover"
> set, although it does not make much sense itself). Then, we can also
> unify the precopy/postcopy state machine into one:
> 
> active->
>   [pre-switchover->]      (optional, decided by "pause-before-switchover")
>     switchover->
>       [postcopy-active->] (optional, decided by "postcopy-arm")
>         completed

I didn't want to change the state transition behaviour without the
capability set, since that could upset an existing libvirt that would
get confused by the new state.

Dave

> (Sorry I am discussing the naming again instead of reviewing real
>  stuff!)
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
