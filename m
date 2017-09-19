Received: from eggs.gnu.org ([2001:4830:134:3::10]:57418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duDaj-0006t9-23
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duDai-0004Tj-4T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:09:13 -0400
Date: Tue, 19 Sep 2017 16:08:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170919080858.GD11534@lemon.lan>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-19-mreitz@redhat.com>
	<20170918064515.GF15551@lemon.lan>
	<ea1f7b60-4b95-f40a-2dc9-e368a74b3de5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1f7b60-4b95-f40a-2dc9-e368a74b3de5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/18] iotests: Add test for active
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Mon, 09/18 18:53, Max Reitz wrote:
> >> +
> >> +        if sync_source_and_target:
> >> +            # If source and target should be in sync after the mirror,
> >> +            # we have to flush before completion
> > 
> > Not sure I understand this requirements, does it apply to libvirt and user too?
> > I.e. it's a part of the interface ? Why cannot mirror_complete do it
> > automatically?
> 
> Well, it seems to pass without this flush, but the original intention
> was this: When mirror is completed, the source node is replaced by the
> target.  All further writes are then only executed on the (former)
> target node.  So what might happen (or at least I think it could) is
> that qemu-io submits some writes, but before they are actually
> performed, the mirror block job is completed and the source is replaced
> by the target.  Then, the write operations are performed on the target
> but no longer on the source, so source and target are then out of sync.
> For the mirror block job, that is fine -- at the point of completion,
> source and target were in sync.  The job doesn't care that they get out
> of sync after completion.  But here, we have to care or we can't compare
> source and target.
> 
> The reason for why it always seems to pass without a flush is that every
> submitted write is actually sent to the mirror node before it yields for
> the first time.  But I wouldn't bet on that, so I think it's better to
> keep the flush before completing the block job.

OK, that makes sense. Thanks.

Fam
