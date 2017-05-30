Received: from eggs.gnu.org ([2001:4830:134:3::10]:53774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFi9Y-0004FO-AM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFi9V-0008U1-3n
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:29:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
Date: Tue, 30 May 2017 16:29:02 +0200
Message-ID: <w517f0y2zbl.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Sat 27 May 2017 09:56:03 AM CEST, Stefan Hajnoczi wrote:
> Throttling groups allow multiple drives to share the same throttling
> state (i.e. budget) between them.  Manos is working on moving the
> throttling code into a block filter driver so it is no longer
> hardcoded into the I/O code path.

Now that we're discussing changes to the throttling code, I'll take the
opportunity to describe a feature that I'd like to work on at some point
in the future.

This is of course out of the scope of the work that Manos is going to
do, but I'd like to discuss it briefly to see what people think of this
idea and whether it's compatible with the changes that we are now
proposing.

Currently each block device can have either zero or one set of I/O
limits, and that set of limits can be shared among several drives using
throttling groups.

I have the following use case that cannot be handled with the current
code:

   - The provider offers the user different storage types, and each one
     of them can have a different storage backend and a different set of
     I/O limits.

   - Inside each storage type, the user can have several volumes, each
     one with its own set of I/O limits.

   - So the user could have drive A, B and C, each one of them with its
     own separate limits, and in addition to that the combination of all
     three would have a limit specific to the storage type.

I believe that this could be achieved by simply having two filter nodes
per drive, one of them would be attached to a throttling object specific
to that drive, and the other one would be attached to a throttling
object that would be shared by all drives (i.e. it would be a 3-drive
throttling group).

I think this should be possible with the -object approach that we are
discussing.

Thoughts?

Berto
