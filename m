Received: from eggs.gnu.org ([2001:4830:134:3::10]:57699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIF-0007u5-1i
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdKIA-0004lx-7O
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:20:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdKIA-0004lM-1S
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:19:58 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28060C04B937
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:19:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Feb 2017 18:19:36 +0100
Message-Id: <1487006388-7966-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/12] Multifd v4
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

[v4]

- Address reviews
- move synchronization to semaphores (faster).  Paolo suggestion
- improvements overall (see invidiual patches)
- fix all the checkpatch warnings
- fix all [HACKS] except for one

Please review.

[v3]

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


The following changes since commit df96bfab49dab2d0373e49b51bbb51ce72e1601e:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-vga-20170213-1' into staging (2017-02-13 10:54:49 +0000)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/multifd/20170213

for you to fetch changes up to 733be4d2d815c6331b86364f68f6980699e9bb48:

  migration: Test new fd infrastructure (2017-02-13 18:14:06 +0100)

----------------------------------------------------------------
multifd/next for 20170213

----------------------------------------------------------------
Juan Quintela (12):
      migration: Test for disabled features on reception
      migration: Don't create decompression threads if not enabled
      migration: Add multifd capability
      migration: Create x-multifd-threads parameter
      migration: Create x-multifd-group parameter
      migration: Create multifd migration threads
      migration: Start of multiple fd work
      migration: Create ram_multifd_page
      migration: Create thread infrastructure for multifd send side
      migration: Really use multiple pages at a time
      migration: Send the fd number which we are going to use for this page
      migration: Test new fd infrastructure

 hmp.c                         |  18 ++
 include/migration/migration.h |  17 ++
 migration/migration.c         |  77 ++++++-
 migration/ram.c               | 499 +++++++++++++++++++++++++++++++++++++++++-
 migration/socket.c            |  64 +++++-
 qapi-schema.json              |  29 ++-
 6 files changed, 690 insertions(+), 14 deletions(-)
