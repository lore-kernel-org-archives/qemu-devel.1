Received: from eggs.gnu.org ([2001:4830:134:3::10]:34494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt3-0003Z9-H1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt0-0001N8-Dk
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSSt0-0001MQ-7O
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:22 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  4 Jul 2017 19:49:10 +0100
Message-Id: <20170704184915.31586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] A bunch of RDMA fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>


Hi,
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

(I sent the 'Fix race on source' patch yesterday, but this
set supersedes it).

Dave

Dr. David Alan Gilbert (5):
  migration/rdma: Fix race on source
  migration: Close file on failed migration load
  migration/rdma: Allow cancelling while waiting for wrid
  migration/rdma: Safely convert control types
  migration/rdma: Send error during cancelling

 migration/migration.c |   1 +
 migration/rdma.c      | 124 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 90 insertions(+), 35 deletions(-)

-- 
2.13.0
