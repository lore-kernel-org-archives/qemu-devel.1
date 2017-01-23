Received: from eggs.gnu.org ([2001:4830:134:3::10]:33637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE2-00024m-C5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmDz-0002h0-6d
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmDz-0002fA-1h
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:27 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D905EC057FA7
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:04 +0100
Message-Id: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/17] multifd v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Hi

This is the 3rd version of multifd. Changes:
- comments for previous verion addressed
- lots of bugs fixed
- remove DPRINTF from ram.c

- add multifd-group parameter, it gives how many pages we sent each
  time to the worker threads.  I am open to better names.
- Better flush support.
- with migration_set_speed 2G it is able to migrate "stress -vm 2
  -vm-bytes 512M" over loopback.

Please review.

Thanks, Juan.

[v2]

This is a version against current code.  It is based on top of QIO
work. It improves the thread synchronization and fixes the problem
when we could have two threads handing the same page.

Please comment, Juan.

Juan Quintela (17):
  migration: transform remained DPRINTF into trace_
  migration: create Migration Incoming State at init time
  migration: Test for disabled features on reception
  migration: Don't create decompression threads if not enabled
  migration: Add multifd capability
  migration: Create x-multifd-threads parameter
  migration: Create x-multifd-group parameter
  migration: create multifd migration threads
  migration: Start of multiple fd work
  migration: create ram_multifd_page
  migration: Create thread infrastructure for multifd send side
  migration: really use multiple pages at a time
  migration: Send the fd number which we are going to use for this page
  migration: Create thread infrastructure for multifd recv side
  migration: Test new fd infrastructure
  migration: [HACK]Transfer pages over new channels
  migration: flush receive queue

 hmp.c                         |  18 ++
 include/migration/migration.h |  17 +-
 migration/migration.c         | 115 ++++++++--
 migration/ram.c               | 515 ++++++++++++++++++++++++++++++++++++++++--
 migration/savevm.c            |   4 +-
 migration/socket.c            |  56 ++++-
 migration/trace-events        |   4 +
 qapi-schema.json              |  29 ++-
 8 files changed, 707 insertions(+), 51 deletions(-)

-- 
2.9.3
