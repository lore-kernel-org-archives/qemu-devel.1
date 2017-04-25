Received: from eggs.gnu.org ([2001:4830:134:3::10]:43728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xRA-0003tR-0W
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xR5-0004Ze-Tc
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:11:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xR5-0004ZN-MQ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:11:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B66E65D01
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:11:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:11:03 +0200
Message-Id: <20170425101104.3818-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi

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

Later, Juan.

Juan Quintela (1):
  ram: Split dirty bitmap by RAMBlock

 include/exec/ram_addr.h          |  13 +-
 include/migration/postcopy-ram.h |   3 -
 migration/postcopy-ram.c         |   5 +-
 migration/ram.c                  | 257 +++++++++++++++------------------------
 4 files changed, 109 insertions(+), 169 deletions(-)

-- 
2.9.3
