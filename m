Received: from eggs.gnu.org ([2001:4830:134:3::10]:46918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fHrC5-000108-RO
	for qemu-devel@nongnu.org; Sun, 13 May 2018 09:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fHrC5-00066h-1i
	for qemu-devel@nongnu.org; Sun, 13 May 2018 09:37:45 -0400
MIME-Version: 1.0
References: <1526053004-12268-1-git-send-email-ivanren@tencent.com>
	<20180511172901.GC5016@localhost.localdomain>
In-Reply-To: <20180511172901.GC5016@localhost.localdomain>
From: Ivan Ren <renyime@gmail.com>
Date: Sun, 13 May 2018 21:37:21 +0800
Message-ID: <CA+6E1==PkxLdnEGWMe5X0eKSPeGsVk3VQQ+fNs5+b_CDAcPMGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: kwolf@redhat.com
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

> Doesn't this defeat the purpose of preallocation? Usually, the idea with
> preallocation is that you don't need to update any metadata on the first
> write, but if you set QCOW_OFLAG_ZERO, we do need a metadata update
> again.
>
> So what's the advantage compared to not preallocating at all?

Yes, when do this, the qcow2_alloc_cluster_offset will call handle_alloc
again, and will lead metada update. Good news is that in handle_alloc the
preallocated zero cluster offset will be reuse. In this case, the
preallocated metata will be keeped except some flags, and the cluster
offset is fixed.

On Sat, May 12, 2018 at 1:29 AM Kevin Wolf <kwolf@redhat.com> wrote:

> Am 11.05.2018 um 17:36 hat Ivan Ren geschrieben:
> > Create a qcow2 directly on bare block device with
> > "-o preallocation=metadata" option. When read this qcow2, it will
> > return pre-existing data on block device. This patch add
> > QCOW_OFLAG_ZERO flag (supported in qcow_version >= 3) for
> > preallocated l2 entry to avoid this problem.
> >
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
>
> Doesn't this defeat the purpose of preallocation? Usually, the idea with
> preallocation is that you don't need to update any metadata on the first
> write, but if you set QCOW_OFLAG_ZERO, we do need a metadata update
> again.
>
> So what's the advantage compared to not preallocating at all?
>
> Kevin
>
