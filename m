Received: from eggs.gnu.org ([2001:4830:134:3::10]:57120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fI6tk-0002RR-Sj
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fI6tk-0006eo-6a
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:23:52 -0400
Date: Mon, 14 May 2018 08:23:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180514062343.GA6665@localhost.localdomain>
References: <1526053004-12268-1-git-send-email-ivanren@tencent.com>
	<20180511172901.GC5016@localhost.localdomain>
	<CA+6E1==PkxLdnEGWMe5X0eKSPeGsVk3VQQ+fNs5+b_CDAcPMGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+6E1==PkxLdnEGWMe5X0eKSPeGsVk3VQQ+fNs5+b_CDAcPMGg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: fix preallocation with metadata
 on bare block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ivan Ren <renyime@gmail.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 13.05.2018 um 15:37 hat Ivan Ren geschrieben:
> > Doesn't this defeat the purpose of preallocation? Usually, the idea with
> > preallocation is that you don't need to update any metadata on the first
> > write, but if you set QCOW_OFLAG_ZERO, we do need a metadata update
> > again.
> >
> > So what's the advantage compared to not preallocating at all?
> 
> Yes, when do this, the qcow2_alloc_cluster_offset will call handle_alloc
> again, and will lead metada update. Good news is that in handle_alloc the
> preallocated zero cluster offset will be reuse. In this case, the
> preallocated metata will be keeped except some flags, and the cluster
> offset is fixed.

Oh, yes, there is no doubt that the result will be correct. My point is
that people aren't usually interested so much in the physical layout of
the clusters, but more about the fact that no metadata updates and no
COW is necessary when you write to a cluster for the first time (i.e.
because preallocation brings some performance improvements).

Do you have a use case where the layout is more important? If there
are good reasons for either option, maybe we need two different
preallocation modes.

Kevin
