Received: from eggs.gnu.org ([2001:4830:134:3::10]:37357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUG5f-0004J5-Tm
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUG5b-0004IZ-MQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:01:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cUG5b-0004I2-Dr
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:01:31 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6240280464
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 17:01:31 +0000 (UTC)
Date: Thu, 19 Jan 2017 17:01:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170119170128.GD27032@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170118160315.GS30347@stefanha-x1.localdomain>
	<08705645-17e8-1ffa-4199-c962f7198ab3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <08705645-17e8-1ffa-4199-c962f7198ab3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/16] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 05:31:03PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 18/01/2017 17:03, Stefan Hajnoczi wrote:
> > On Fri, Jan 13, 2017 at 02:17:15PM +0100, Paolo Bonzini wrote:
> >> This series pushes down aio_context_acquire/release to the point
> >> where we can actually reason on using different fine-grained mutexes.
> >>
> >> The main infrastructure is introduced in patch 1.  The new API aio_co_=
wake
> >> starts a coroutine with aio_context_acquire/release protection, which
> >> requires tracking each coroutine's "home" AioContext.  aio_co_schedule
> >> instead takes care of moving a sleeping coroutine to a different
> >> AioContext, also ensuring that it runs under aio_context_acquire/relea=
se.
> >> This is useful to implement bdrv_set_aio_context, as a simpler alterna=
tive
> >> to bottom halves.  Even though one-shot BHs are already simpler than
> >> what we had before, after this patch aio_co_wake and aio_co_schedule
> >> save you from having to do aio_context_acquire/release explicitly.
> >>
> >> After patch 2 and 3, which are just small preparatory changes, patches
> >> 4 to 7 provide an example of how to use the new API.  In particular pa=
tch
> >> 4 to 6 implement a new organization of coroutines in the NBD client,
> >> which allows not blocking on partial reply header reads.
> >>
> >> Patch 8 introduces helpers for AioContext locking in QED, which is
> >> the most complex AIO-based driver left.  Then the actual meat of the
> >> series runs from patch 9 to patch 13, followed by small optimizations
> >> in patches 14 and 15.
> >>
> >> The patches do some back and forth in adding/removing
> >> aio_context_acquire/release calls in block/*.c but ultimately a small
> >> number of aio_context_acquire/release pairs are added after the pushdo=
wn.
> >> These are mostly in drivers that use external libraries (where they
> >> actually could already be replaced by QemuMutex) and in device models.
> >>
> >> Notably, coroutines need not care about aio_context_acquire/release.
> >> The device models ensure that the first creation of the coroutine has
> >> the AioContext, while aio_co_wake/aio_co_schedule do the same after
> >> they yield.  Therefore, most of the files only need to use those two
> >> functions instead of, respectively, qemu_coroutine_enter and
> >> aio_bh_schedule_oneshot.
> >>
> >> However, this is only an intermediate step which is needed because the
> >> block layer and qemu-coroutine locks are thread-unsafe.  So the next
> >> part will add separate locking, independent of AioContext, to block.c =
and
> >> mostly block/io.c---this includes making CoMutex thread-safe.  Patch 16
> >> therefore already documents the current locking policies block.h to
> >> prepare for the next series.
> >>
> >> Paolo
> >>
> >> Paolo Bonzini (16):
> >>   aio: introduce aio_co_schedule and aio_co_wake
> >>   block-backend: allow blk_prw from coroutine context
> >>   test-thread-pool: use generic AioContext infrastructure
> >>   io: add methods to set I/O handlers on AioContext
> >>   io: make qio_channel_yield aware of AioContexts
> >>   nbd: do not block on partial reply header reads
> >>   coroutine-lock: reschedule coroutine on the AioContext it was running
> >>     on
> >>   qed: introduce qed_aio_start_io and qed_aio_next_io_cb
> >>   aio: push aio_context_acquire/release down to dispatching
> >>   block: explicitly acquire aiocontext in timers that need it
> >>   block: explicitly acquire aiocontext in callbacks that need it
> >>   block: explicitly acquire aiocontext in bottom halves that need it
> >>   block: explicitly acquire aiocontext in aio callbacks that need it
> >>   aio-posix: partially inline aio_dispatch into aio_poll
> >>   async: remove unnecessary inc/dec pairs
> >>   block: document fields protected by AioContext lock
> >>
> >>  aio-posix.c                    |  60 +++---------
> >>  aio-win32.c                    |  30 ++----
> >>  async.c                        |  81 ++++++++++++++--
> >>  block/blkdebug.c               |   9 +-
> >>  block/blkreplay.c              |   2 +-
> >>  block/block-backend.c          |  13 ++-
> >>  block/curl.c                   |  44 ++++++---
> >>  block/gluster.c                |   9 +-
> >>  block/io.c                     |   4 +-
> >>  block/iscsi.c                  |  15 ++-
> >>  block/linux-aio.c              |  10 +-
> >>  block/mirror.c                 |  12 ++-
> >>  block/nbd-client.c             | 108 ++++++++-------------
> >>  block/nbd-client.h             |   2 +-
> >>  block/nfs.c                    |   9 +-
> >>  block/qed-cluster.c            |   2 +
> >>  block/qed-table.c              |  12 ++-
> >>  block/qed.c                    |  58 +++++++----
> >>  block/qed.h                    |   3 +
> >>  block/sheepdog.c               |  29 +++---
> >>  block/ssh.c                    |  29 ++----
> >>  block/throttle-groups.c        |   2 +
> >>  block/win32-aio.c              |   9 +-
> >>  dma-helpers.c                  |   2 +
> >>  hw/block/virtio-blk.c          |  19 +++-
> >>  hw/scsi/scsi-bus.c             |   2 +
> >>  hw/scsi/scsi-disk.c            |  15 +++
> >>  hw/scsi/scsi-generic.c         |  20 +++-
> >>  hw/scsi/virtio-scsi.c          |   6 ++
> >>  include/block/aio.h            |  38 +++++++-
> >>  include/block/block_int.h      |  64 ++++++++-----
> >>  include/io/channel.h           |  59 +++++++++++-
> >>  include/qemu/coroutine_int.h   |  10 +-
> >>  include/sysemu/block-backend.h |  14 ++-
> >>  io/channel-command.c           |  13 +++
> >>  io/channel-file.c              |  11 +++
> >>  io/channel-socket.c            |  16 +++-
> >>  io/channel-tls.c               |  12 +++
> >>  io/channel-watch.c             |   6 ++
> >>  io/channel.c                   |  97 +++++++++++++++----
> >>  nbd/client.c                   |   2 +-
> >>  nbd/common.c                   |   9 +-
> >>  nbd/server.c                   |   4 +
> >>  tests/Makefile.include         |  15 ++-
> >>  tests/iothread.c               |  91 ++++++++++++++++++
> >>  tests/iothread.h               |  25 +++++
> >>  tests/test-aio-multithread.c   | 213 ++++++++++++++++++++++++++++++++=
+++++++++
> >>  tests/test-thread-pool.c       |  12 +--
> >>  tests/test-vmstate.c           |  11 ---
> >>  thread-pool.c                  |   6 +-
> >>  trace-events                   |   4 +
> >>  util/qemu-coroutine-lock.c     |   5 +-
> >>  util/qemu-coroutine-sleep.c    |   2 +-
> >>  util/qemu-coroutine.c          |   8 ++
> >>  util/trace-events              |   1 -
> >>  55 files changed, 1012 insertions(+), 352 deletions(-)
> >>  create mode 100644 tests/iothread.c
> >>  create mode 100644 tests/iothread.h
> >>  create mode 100644 tests/test-aio-multithread.c
> >=20
> > This is a big and somewhat risky change.  Have you run any performance
> > benchmarks?
>=20
> Not recently; I ran them a year ago and there was no measurable differenc=
e.

Good, please re-run for the final version.

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYgPDoAAoJEJykq7OBq3PIwmoH/0m5jTI3vQNV5aw6M4nnBD6O
hjLkv2pxaq5Ns/JHRIi677Qb3JuoUMjAblp8wjiAZnYOdnFBF4HVopJ6N9sEBSon
OgF+r3woRFdLsEBzwBUZ57Lllbg5iOg0+r6HjK9NC4wdxsyR//MaoZNGMI2ecGWg
8MA9i3yibpaeIny2PpArAPuILcP4dOrvxE1ScBVsR/OULNNsSVh7+7k4GkDpYQeO
Set8uuIkyTb5UPP0k/gY94+EnqmIWx4OyXWZ9mahgPy+HEYyERhZVDL1ndIa6Ek5
Ge4BFnJtvyaj/mDiYdioRi8uupPjNXq2xrczodeZBqh3PpfAMS0ESHZDnSTxipc=
=WcYo
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
