Received: from eggs.gnu.org ([2001:4830:134:3::10]:35879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePtbg-0000dQ-3E
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePtba-0001ir-FC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePtba-0001f1-9c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:17:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CB68820F2
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 17:17:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Dec 2017 17:16:53 +0000
Message-Id: <20171215171655.7818-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] migration/channel errors and cancelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, berrange@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  Where a channel fails asynchronously during connect, call
back through the migration code so it can clean up.
  In particular this causes the transition of a 'cancelling' state
to 'cancelled' in the case of:

    migrate -d tcp:deadhost:port
     <host tries to connect>
    migrate_cancel

previously the status would get stuck in cancelling because
the final cleanup didn't happen.

  This is the second part of the fix for:
https://bugzilla.redhat.com/show_bug.cgi?id=1525899

Dave

Dr. David Alan Gilbert (2):
  migration: Allow migrate_fd_connect to take an Error *
  migration: Route errors down  through migration_channel_connect

 migration/channel.c    | 32 ++++++++++++++++----------------
 migration/channel.h    |  3 ++-
 migration/exec.c       |  2 +-
 migration/fd.c         |  2 +-
 migration/migration.c  |  7 ++++++-
 migration/migration.h  |  2 +-
 migration/rdma.c       |  2 +-
 migration/socket.c     |  4 +---
 migration/tls.c        |  3 +--
 migration/trace-events |  2 +-
 10 files changed, 31 insertions(+), 28 deletions(-)

-- 
2.14.3
