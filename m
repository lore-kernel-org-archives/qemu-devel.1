Received: from eggs.gnu.org ([2001:4830:134:3::10]:35946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTkIa-00063N-8o
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTkIZ-0006Ch-Dq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:41:36 -0400
Date: Fri, 15 Jun 2018 10:41:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180615084126.GA5187@localhost.localdomain>
References: <20180614232119.31669-1-naravamudan@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614232119.31669-1-naravamudan@digitalocean.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] [RFC] aio: properly bubble up
 errors from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 15.06.2018 um 01:21 hat Nishanth Aravamudan geschrieben:
> laio_init() can fail for a couple of reasons, which will lead to a NULL
> pointer dereference in laio_attach_aio_context().
> 
> To solve this, add a aio_linux_aio_setup() path which is called where
> aio_get_linux_aio() is called currently, but can propogate errors up.
> 
> virtio-block and virtio-scsi call this new function before calling
> blk_io_plug() (which eventually calls aio_get_linux_aio). This is
> necessary because plug/unplug currently assume they do not fail.
> 
> It is trivial to make qemu segfault in my testing. Set
> /proc/sys/fs/aio-max-nr to 0 and start a guest with
> aio=native,cache=directsync. With this patch, the guest successfully
> starts (but obviously isn't using native AIO). Setting aio-max-nr back
> up to a reasonable value, AIO contexts are consumed normally.
> 
> Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>

This is not a reasonable fix for several reasons:

* You frame this as a problem of blk_io_plug(), but that's not what it
  is. It is a problem of delayed initialisation of Linux AIO that may
  in the future affect other operations as well.

* This approch would need a fix in every device that uses a problematic
  operation. You came across virtio + blk_io_plug(), but that are
  probably not the only cases in the long run, which would make the code
  spread much wider than it should.

* There is only a single block driver that actually implements the new
  callback. This is a sign that this is not a generally useful callback.

Instead, the fix should be done locally in the file-posix driver, and
the virtio devices shouldn't be touched at all. I think it would be good
enough to call laio_init() when attaching to a new AioContext and to
switch to the thread pool if it fails, like you already do. Maybe an
error_report() would be appropriate to log the fact that we're not using
the requested AIO mode.

Kevin
