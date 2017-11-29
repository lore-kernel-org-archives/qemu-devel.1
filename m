Received: from eggs.gnu.org ([2001:4830:134:3::10]:53164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK67R-0001ap-83
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK67Q-0008Tq-Gw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:25:57 -0500
Date: Wed, 29 Nov 2017 18:25:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171129172546.GG3753@localhost.localdomain>
References: <20171129144956.11409-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] block: Rewrite block drain
 begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

Am 29.11.2017 um 15:49 hat Fam Zheng geschrieben:
> While we look at the fixes for 2.11, I briefly prototyped this series
> to see if it makes sense as a simplification of the drain API for
> 2.12.
> 
> The idea is to let AioContext manage quiesce callbacks, then the block
> layer only needs to do the in-flight request waiting. This lets us get
> rid of the callback recursion (both up and down).

So essentially you don't drain individual nodes any more, but whole
AioContexts. I have a feeeling that this would be a step in the wrong
direction.

Not only would it completely bypass the path I/O requests take and
potentially drain a lot more than is actually necessary, but it also
requires that all nodes that are connected in a tree are in the same
AioContext.

Paolo can say more on this, but my understanding was that the long-term
plan is to make the block layer fully thread safe so that any thread
could call things on any node. I remember Paolo saying that AioContext
was even fully going away in the future. I don't see how this is
compatible with your approach.

And finally, I don't really think that the recursion is even a problem.
The problem is with graph changes made by callbacks that drain allows to
run. With your changes, it might be a bit easier to avoid that
bdrv_drain() itself gets into trouble due to graph changes, but this
doesn't solve the problem for any (possibly indirect) callers of
bdrv_drain().

Kevin
