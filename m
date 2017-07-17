Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX3uL-0002sU-1i
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dX3uG-0002n3-S5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:09:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dX3uG-0002mk-MG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:09:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE73885541
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 11:09:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 17 Jul 2017 12:09:30 +0100
Message-Id: <20170717110936.23314-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/6] A bunch of RDMA fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

  This is a bunch of RDMA fixes, the first is a race
I spotted a while ago that you don't hit during normal
operation; the rest are to do with migration failure and
cancellation that I started looking at because of lp1545052 which
is a failure to recover on the source if the destination
fails.
 
  I'm pretty sure there are other cases where the source
might hang waiting for a failed destination; particularly
if the destination hangs rather than fails completely;
one I know of is waiting for the event after the rdma_disconnect
but I don't have a good fix for it.  Suggestions welcome.
 
v4
  Fix more error paths in qemu_rdma_block_for_wrid - often
  the 'ret' wasn't set. Fix that and also fix the case we
  add to also set the ret. Spotted by Peter.

Dr. David Alan Gilbert (6):
  migration/rdma: Fix race on source
  migration: Close file on failed migration load
  migration/rdma: fix qemu_rdma_block_for_wrid error paths
  migration/rdma: Allow cancelling while waiting for wrid
  migration/rdma: Safely convert control types
  migration/rdma: Send error during cancelling

 migration/migration.c |   1 +
 migration/rdma.c      | 137 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 101 insertions(+), 37 deletions(-)

-- 
2.13.0
