Received: from eggs.gnu.org ([2001:4830:134:3::10]:56796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dc4je-0007zJ-4O
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dc4ja-0003C3-V3
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dc4ja-0003Bf-Ov
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:03:22 -0400
Date: Mon, 31 Jul 2017 15:02:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170731070246.GC29971@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-12-git-send-email-peterx@redhat.com>
	<2e01324b-73e2-ddb9-7df3-6ae3ec2a7222@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e01324b-73e2-ddb9-7df3-6ae3ec2a7222@redhat.com>
Subject: Re: [Qemu-devel] [RFC 11/29] migration: new postcopy-pause state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jul 28, 2017 at 10:53:00AM -0500, Eric Blake wrote:
> On 07/28/2017 03:06 AM, Peter Xu wrote:
> > Introducing a new state "postcopy-paused", which can be used to pause a
> > postcopy migration. It is targeted to support network failures during
> > postcopy migration. Now when network down for postcopy, the source side
> > will not fail the migration. Instead we convert the status into this new
> > paused state, and we will try to wait for a rescue in the future.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> You might want to use scripts/git.orderfile to put .json changes early
> in your diffs (interface before implementation makes for easier reviews).

Will do.

> 
> > +++ b/qapi-schema.json
> > @@ -667,6 +667,8 @@
> >  #
> >  # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
> >  #
> > +# @postcopy-paused: during postcopy but paused. (since 2.10)
> > +#
> 
> You've missed 2.10; this should be 2.11.

Definitely. It should be for 2.11.

> Can this state occur without
> any explicit request (ie. old clients may be confused by it), or do you
> have to opt-in to a specific migration parameter to inform qemu that you
> are aware of how to handle this state?

Yes, it can occur automatically, without any operation from user's
side. And it does not have a tunable to switch it on/off - it'll
always be on (that's my plan, though), since IMHO holding at a paused
state is always better than crashing the source directly (that's what
we do now - when postcopy encountered network failure, the VM will
crash and data will be lost).

Thanks,

-- 
Peter Xu
