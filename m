Received: from eggs.gnu.org ([2001:4830:134:3::10]:56367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPL7-0004F4-He
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPL4-0005lW-Ep
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPL4-0005ku-94
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5182061B86
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:18 +0100
Message-Id: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/16] Multifd v4
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

This is the 4th version of multifd. Changes:
- XBZRLE don't need to be checked for
- Documentation and defaults are consistent
- split socketArgs
- use iovec instead of creating something similar.
- We use now the exported size of target page (another HACK removal)
- created qio_chanel_{wirtev,readv}_all functions.  the _full() name
  was already taken.
  What they do is the same that the without _all() function, but if it
  returns due to blocking it redo the call.
- it is checkpatch.pl clean now.

Please comment, Juan.




[v3]

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


Juan Quintela (16):
  qio: create new qio_channel_write_all
  qio: create new qio_channel_read_all
  migration: Test for disabled features on reception
  migration: Don't create decompression threads if not enabled
  migration: Add multifd capability
  migration: Create x-multifd-threads parameter
  migration: Create x-multifd-group parameter
  migration: Create multifd migration threads
  migration: Start of multiple fd work
  migration: Create ram_multifd_page
  migration: Really use multiple pages at a time
  migration: Send the fd number which we are going to use for this page
  migration: Create thread infrastructure for multifd recv side
  migration: Test new fd infrastructure
  migration: Transfer pages over new channels
  migration: Flush receive queue

 hmp.c                         |  18 ++
 include/io/channel.h          |  46 ++++
 include/migration/migration.h |  17 ++
 io/channel.c                  |  76 ++++++
 migration/migration.c         |  85 ++++++-
 migration/qemu-file-channel.c |  29 +--
 migration/ram.c               | 522 +++++++++++++++++++++++++++++++++++++++++-
 migration/socket.c            |  67 +++++-
 qapi-schema.json              |  30 ++-
 9 files changed, 848 insertions(+), 42 deletions(-)

-- 
2.9.3
