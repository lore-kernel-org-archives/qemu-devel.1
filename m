Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9rM-0004n4-3x
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9rL-0006x9-Fv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:01:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9rL-0006wv-Ag
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 17:01:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44C68C04BD48
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 21:01:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 22:01:23 +0100
Message-Id: <20170323210124.12300-1-quintela@redhat.com>
Subject: [Qemu-devel] [RFC] Split migration bitmaps by ramblock
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

 include/exec/ram_addr.h |  13 +++-
 migration/ram.c         | 201 ++++++++++++++++++------------------------------
 2 files changed, 85 insertions(+), 129 deletions(-)

-- 
2.9.3
