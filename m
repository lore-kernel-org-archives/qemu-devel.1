Received: from eggs.gnu.org ([2001:4830:134:3::10]:37836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZhj-0000xo-SS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZhi-0007RU-Qo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:31:07 -0400
Date: Mon, 24 Jul 2017 11:30:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724093056.GD4630@noname.str.redhat.com>
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Am 20.07.2017 um 15:11 hat Kevin Wolf geschrieben:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.
> 
> This is true as far as commands issued by libvirt are concerned. It only
> uses BlockBackend names to address nodes, so any operations it performs
> still operate on the root of the tree as intended.
> 
> However, the assumption breaks down when you consider query commands,
> which return data for the wrong node now. These commands also return
> information on some child nodes (bs->file and/or bs->backing), which
> libvirt does make use of, and which refer to the wrong nodes, too.
> 
> One of the consequences is that oVirt gets wrong information about the
> image size and stops the VM in response as long as a mirror or commit
> job is running:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1470634
> 
> This patch fixes the problem by hiding the implicit nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user
> doesn't indicate that they are aware of those nodes by providing a node
> name for them in the QMP command to start the block job.
> 
> The node-based commands query-named-block-nodes and query-blockstats
> with query-nodes=true still show all nodes, including implicit ones.
> This ensures that users that are capable of node-level management can
> still access the full information; users that only know BlockBackends
> won't use these commands.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Applied to the block branch.

Kevin
