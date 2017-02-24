Received: from eggs.gnu.org ([2001:4830:134:3::10]:42232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chGo7-0001Ch-4O
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chGo6-0003E8-1s
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:25:15 -0500
Date: Fri, 24 Feb 2017 15:25:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170224142505.GA4429@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/54] New op blocker system, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Am 21.02.2017 um 15:57 hat Kevin Wolf geschrieben:
> This series is the first part of implementing the new op blocker system
> whose design was agreed on quite a while ago, but proved a bit tricky to
> implement in places. There is more work to do to fully replace the old op
> blocker system, but realistically we don't have that much time until the 2.9
> freeze. So let's merge this series to complement the traditional op blockers
> and plan with a second part for the 2.10 timeframe.
> 
> The basic idea is that every user of a block node (including things outside the
> block layer that go through a BlockBackend, and also other block nodes that
> hold references to it) has to declare which low-level operations/permissions it
> needs and which operation it allows other users to perform on the same node.
> Depending on these declarations, conflicts are avoided by returning an error
> for attempts to attach a conflicting user to the same node.
> 
> After this series, all users request permissions, and hopefully all of the
> permissions they need. For writes and resize, getting the permission first is
> actually enforced with assertions. Asserting it for consistent reads is in
> theory doable, but would mean introducing a request flag that tell us that
> inconsistent reads are okay - and that in all block drivers to recursively
> propagate this flag through the backing chain. It might not be worth it.
> 
> As stated above, the series doesn't remove the old op blockers yet, though in
> theory the new op blockers should block everything that needs to be blocked.
> In practice, the read/write/resize blockers should be okay, but
> BLK_PERM_GRAPH_MOD isn't to be taken too seriously at the moment. It isn't
> really applied consistently and doesn't do much useful yet. Making proper use
> of it is left for the part 2 series.

In order to keep the pull request next week at least a bit smaller, I
applied the already reviewed patches 1-11 to the block branch (i.e.
the preparations before the actual op blocker patches start).

Kevin
