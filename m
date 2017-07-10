Received: from eggs.gnu.org ([2001:4830:134:3::10]:33562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzn-0000K6-JN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUSzk-0000fH-E5
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUSzj-0000dX-WA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:20:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3A794E334
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 07:20:34 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Jul 2017 15:20:22 +0800
Message-Id: <20170710072027.7948-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Last time we've looked at "-object iothread,spawns=N" but it was a bit abusive.
A dedicated "iothread-group" class is cleaner from the interface point of view.
This series does that.

It has the same set of poll parameters as the existing "iothread" object, plus
a "size" option to specify how many threads to start. Using iothread-group
doesn't require the user to explicitly create the contained IOThreads. The
IOThreads are created by the group object.

Internally, IOThreads share one AioContext.  This is to make it easier to adapt
this to the current data plane code (see the last patch). But it is an
implementation detail, and will change depending on the block layer multiqueue
needs.

TODO:

- qmp_query_iothread_groups, in addition to proper QOM @child property from
  IOThreadGroup to its IOThread instances.
- Add virtio-scsi.
- Variant of iothread_stop_all().

Fam Zheng (5):
  aio: Wrap poll parameters into AioContextPollParams
  iothread: Don't error on windows
  iothread: Extract iothread_start
  Introduce iothread-group
  virtio-blk: Add iothread-group property

 Makefile.objs                   |   2 +-
 hw/block/dataplane/virtio-blk.c |  18 ++--
 hw/block/virtio-blk.c           |   6 ++
 include/block/aio.h             |  18 ++--
 include/hw/virtio/virtio-blk.h  |   2 +
 include/sysemu/iothread.h       |  35 ++++++-
 iothread-group.c                | 210 ++++++++++++++++++++++++++++++++++++++++
 iothread.c                      |  97 +++++++++----------
 util/aio-posix.c                |  10 +-
 util/aio-win32.c                |   8 +-
 10 files changed, 328 insertions(+), 78 deletions(-)
 create mode 100644 iothread-group.c

-- 
2.9.4
