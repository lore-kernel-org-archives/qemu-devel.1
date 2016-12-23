Received: from eggs.gnu.org ([2001:4830:134:3::10]:43703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKUYM-0001jP-2d
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKUYH-0006Fh-4C
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cKUYG-0006FL-UQ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:26:45 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34A22804EB
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 18:26:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Dec 2016 19:26:38 +0100
Message-Id: <20161223182641.2718-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/3] io/nbd: AioContext support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is RFC because the APIs it uses (aio_co_schedule/aio_co_wake) do
not exist yet in master, but it should be enough for a first review of
the QIOChannel API concepts and to give an idea of their usage.

It makes qio_channel_yield aware of AioContexts by adding a new
API qio_channel_set_aio_context, and it lets separate coroutines
use qio_channel_yield for reading vs. writing.

The last patch rewrites the NBD client's I/O management to use the
new infrastructure (and I think the logic here was first proposed
years ago by Stefan).  The benefit is that the new version does not
block if the server writes a partial reply header, and is also a
bit smaller.

Paolo

Paolo Bonzini (3):
  io: add methods to set I/O handlers on AioContext
  io: make qio_channel_yield aware of AioContexts
  nbd: do not block on partial reply header reads

 block/nbd-client.c   | 108 ++++++++++++++++++++-------------------------------
 include/io/channel.h |  41 +++++++++++++++++++
 io/channel-socket.c  |  16 +++++---
 io/channel-tls.c     |  12 ++++++
 io/channel-watch.c   |   6 +++
 io/channel.c         |  87 +++++++++++++++++++++++++++++++----------
 6 files changed, 178 insertions(+), 92 deletions(-)

-- 
2.9.3
