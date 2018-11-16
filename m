Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNftQ-0002LK-8U
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNftP-0007Rb-IT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:18:48 -0500
Date: Fri, 16 Nov 2018 16:18:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181116151834.GA5066@localhost.localdomain>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51in0xuksv.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 16.11.2018 um 16:03 hat Alberto Garcia geschrieben:
> > I don't think anything needs a way to generally block graph changes
> > around some node.  We only need to prevent changes to very specific
> > sets of edges.  This is something that the permission system just
> > cannot do.
> 
> But what would you do then?

I agree with you mostly in that I think that most problems that Max
mentioned aren't readl. The only real problem I see with GRAPH_MOD as a
permission on the node level is this overblocking - but that's bad
enough that I feel using permissions to block changes to a whole node is
not a good solution.

So what's the alternative? Max had a possible solution in the first
email in this thread:

> - A property of BdrvChild that can be set by a non-parent seems more
>   feasible, e.g. a counter where changing the child is possible only
>   if the counter is 0.  This also actually makes sense in what it
>   means.

The commit job would increment BdrvChild.block_change (or whatever we
would call it) for all bs->backing edges in the subchain.

Kevin
