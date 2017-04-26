Received: from eggs.gnu.org ([2001:4830:134:3::10]:35314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HRY-0008Ge-N3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3HRU-0003th-W6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3HRU-0003tG-PS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:32:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90F9D80082
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 07:32:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 09:32:46 +0200
Message-Id: <20170426073247.7441-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

I make it compile with DEBUG_POSTCOPY enabled.

Please review.

Later, Juan.

[v4]
Make postcopy_chunk_hostpages work at ramblock level, so we don't do
the double look over ramblocks.  Tested that postcopy still works as
expected.

Later, Juan.


[v3]
I messed up previous submission and sent the wrong patch.

- This verios is a rebase on top of the ramstate series
- Fixed the problem with postcopy

Important bit is this one:

-    pds->start_list[pds->cur_entry] = (start - pds->offset) * tp_size;
+    pds->start_list[pds->cur_entry] = start  * tp_size;

This chunk is only used in postcopy, that is why it didn't failed
precopy tests.  Once ther, just remove the start parameter and offset
member because it is not used anywhere else.

Please comment.

Later, Juan.


[v2]

For v2 this is a rebase on top of all the changes that happened in the
prvious two series.

Please, review.

[RFC]
This series split the migration and unsent bitmaps by ramblock.  This
makes it easier to synchronize in small bits.  This is on top of the
RAMState and not-hotplug series.

Why?

reason 1:

People have complained that by the time that we detect that a page is
sent, it has already been marked dirty "again" inside kvm, so we are
going to send it again.  On top of this patch, my idea is, for words
of the bitmap that have any bit set, just synchonize the bitmap before
sending the pages.  I have not looking into performance numbers yet,
jsut asking for comments about how it is done.

reason 2:

In case where the host page is a multiple of the the TARGET_PAGE_SIZE,
we do a lot of work when we are synchronizing the bitmaps to pass it
to target page size.  The idea is to change the bitmaps on that
RAMBlocks to mean host page size and not TARGET_PAGE_SIZE.

Note that there are two reason for this, ARM and PPC do things like
guests with 4kb pages on hosts with 16/64kb hosts, and then we have
HugePages.  Note all the workarounds that postcopy has to do because
to work in HugePages size.

Please, comment?

Juan Quintela (1):
  ram: Split dirty bitmap by RAMBlock

 include/exec/ram_addr.h          |  13 +-
 include/migration/migration.h    |   3 +-
 include/migration/postcopy-ram.h |   3 -
 migration/postcopy-ram.c         |   5 +-
 migration/ram.c                  | 273 +++++++++++++++------------------------
 5 files changed, 119 insertions(+), 178 deletions(-)

-- 
2.9.3
