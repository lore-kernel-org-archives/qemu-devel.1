Received: from eggs.gnu.org ([2001:4830:134:3::10]:53162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f6fhT-0008TM-3B
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f6fhO-0002x8-8I
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 13:07:55 -0400
Date: Thu, 12 Apr 2018 19:07:11 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20180412170711.GA6240@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hello,

I mentioned this some time ago, but I'd like to retake it now: I'm
checking how to copy arbitrary nodes on a backing chain, so if I have
e.g.

   [A] <- [B] <- [C] <- [D]

I'd like to end up with

   [A] <- [E] <- [C] <- [D]

where [E] is a copy of [B]. The most obvious use case is to move [B]
to a different storage backend.

At the moment we can already copy [B] into [E] (outside QEMU) and then
do

   change-backing-file device=[D] image-node-name=[C] backing-file=[E]

However this only changes the image on disk and the bs->backing_file
string in memory. QEMU keeps using the [B] BlockDriverState, and we
need to make it switch to [E].

One possible way to do this would be to modify blockdev-mirror so the
source image can be located anywhere on a chain. Currently there's
bs->backing_blocker preventing that, plus qmp_blockdev_mirror()
refuses to take any non-root source node. Other than permission
changes I don't think the algorithm itself needs any additional
modification, although I suppose we'd like to change the backing file
as part of the same job, and that would require API changes.

One other way is to have a more generic replace-node command which
would call bdrv_replace_node(), but I don't know if we want to expose
that and I don't have any other use case for it at the moment.

Opinions, comments?

Berto
