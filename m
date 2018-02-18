Received: from eggs.gnu.org ([2001:4830:134:3::10]:33800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1enTaA-0000hi-7o
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 13:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1enTa9-0005oq-7y
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 13:21:02 -0500
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 18 Feb 2018 18:20:58 +0000
Message-ID: <CAJSP0QV=rntD8h4kLdDaydDHxf9ustrK0jnUfU-aQFJp2wPAWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Multiqueue block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

Paolo's patches have been getting us closer to multiqueue block layer
support but there is a final set of changes required that has become
clearer to me just recently.  I'm curious if this matches Paolo's
vision and whether anyone else has comments.

Multiqueue block layer means that I/O requests for a single disk image
can be processed by multiple threads safely.  Requests will be
processed simultaneously where possible, but in some cases
synchronization is necessary to protect shared metadata.

Imagine a virtio-blk device with multiple virtqueues, each with an
ioeventfd that is handled by a different IOThread.  Each IOThread
should be able to process I/O requests and invoke completion functions
in the AioContext that submitted the request.

Paolo has made key parts of AioContext and coroutine locks (e.g.
CoQueue) thread-safe.  Coroutine code can therefore safely execute in
multiple IOThreads and locking works correctly.

That's not to say that block layer code and block drivers are
thread-safe today.  They are not because some code still relies on the
fact that coroutines only execute in one AioContext.  They rely on the
AioContext acquire/release lock for thread safety.

We need to push the AioContext lock down into BlockDriverState so that
thread-safety is not tied to a single AioContext but to the
BlockDriverState itself.  We also need to audit block layer code to
identify places that assume everything is run from a single
AioContext.

After this is done the final piece is to eliminate
bdrv_set_aio_context().  BlockDriverStates should not be associated
with an AioContext.  Instead they should use whichever AioContext they
are invoked under.  The current thread's AioContext can be fetched
using qemu_get_current_aio_context().  This is either the main loop
AioContext or an IOThread AioContext.

The .bdrv_attach/detach_aio_context() callbacks will no longer be
necessary in a world where block driver code is thread-safe and any
AioContext can be used.

bdrv_drain_all() and friends do not require extensive modifications
because the bdrv_wakeup() mechanism already works properly when there
are multiple IOThreads involved.

Block jobs no longer need to be in the same AioContext as the
BlockDriverState.  For simplicity we may choose to always run them in
the main loop AioContext by default.  This may have a performance
impact on tight loops like bdrv_is_allocated() and the initial
mirroring phase, but maybe not.

The upshot of all this is that bdrv_set_aio_context() goes away while
all block driver code needs to be more aware of thread-safety.  It can
no longer assume that everything is called from one AioContext.

We should optimize file-posix.c and qcow2.c for maximum parallelism
using fine-grained locks and other techniques.  The remaining block
drivers can use one CoMutex per BlockDriverState.

I'm excited that we're relatively close to multiqueue now.  I don't
want to jinx it by saying 2018 is the year of the multiqueue block
layer, but I'll say it anyway :).

Thoughts?

Stefan
