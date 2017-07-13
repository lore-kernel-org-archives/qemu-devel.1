Received: from eggs.gnu.org ([2001:4830:134:3::10]:53801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVcjq-0004j7-5K
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVcjm-0000ow-TE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVcjm-0000oe-MW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 913CAC05689C
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 11:56:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 13 Jul 2017 12:56:44 +0100
Message-Id: <20170713115649.11853-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] A bunch of RDMA fixes
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

v2
  Dropped the timeout in the poll to 0.1s
  Don't check error_reported, just error_state and received_error

Dr. David Alan Gilbert (5):
  migration/rdma: Fix race on source
  migration: Close file on failed migration load
  migration/rdma: Allow cancelling while waiting for wrid
  migration/rdma: Safely convert control types
  migration/rdma: Send error during cancelling

 migration/migration.c |   1 +
 migration/rdma.c      | 122 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 88 insertions(+), 35 deletions(-)

-- 
2.13.0
