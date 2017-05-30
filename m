Received: from eggs.gnu.org ([2001:4830:134:3::10]:45568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFdaM-0006IF-Dk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFdaL-0000hC-Lh
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:37:06 -0400
Date: Tue, 30 May 2017 11:37:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170530093700.GA5210@noname.redhat.com>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
	<w517f0z4sb6.fsf@maestria.local.igalia.com>
	<20170529205737.fpbiakja36txmsnm@postretch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170529205737.fpbiakja36txmsnm@postretch>
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org

[ Cc: qemu-block - noticed only now that it's missing ]

Am 29.05.2017 um 22:57 hat Manos Pitsidianakis geschrieben:
> On Mon, May 29, 2017 at 05:05:17PM +0200, Alberto Garcia wrote:
> >On Sat 27 May 2017 09:56:03 AM CEST, Stefan Hajnoczi wrote:
> >>A quirk in the current implementation is that the throttling limits
> >>for the group are overwritten by each -drive throttling.group=group0.
> >>Limits for all but the last -drive in a group are ignored.
> >  - bps or iops != 0   -> set the I/O limits of a throttling group. The
> >                          selected device is moved to that group if it
> >                          wasn't there yet.
> >
> >  - bps and iops == 0  -> remove a device from a throttling group
> >                          without touching that group's I/O limits.
> 
> These are very unintuitive.

I agree, this is not an interface to extend, but one to get rid of. (Of
course, we'll have to keep it around for a while because compatibility,
but we should try to offer something better.)

> However, even without considering backwards compatibility, I think
> that using -object notation (eg "object-add
> throttle-group,id=foo,iops=...) is intuitive in the case of groups,
> but not when you need individual limits for each device as the syntax
> would be too verbose.  Of course the old interface covers that.
> 
> In any case, is having multiple interfaces a problem or not? And, is
> using QOM straightforward implementation-wise?

We can have an interface for the throttling node that requires that you
specify either a throttle group object name or the limits, but never
both. If you specify the limits, this would just be a convenience
function that creates the right QOM object internally.

As for the implementation, QOM tends to be a bit heavy on boilerplate
code, but I think it's not too bad otherwise.

Kevin
