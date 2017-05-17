Received: from eggs.gnu.org ([2001:4830:134:3::10]:35886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB2HE-0001Cn-0h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB2HA-0000Eh-W2
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB2HA-0000Eb-QC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:58:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B46381F07
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:58:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 17 May 2017 17:58:08 +0100
Message-Id: <20170517165810.18164-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Migration+huge page fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  The attached patch-pair fix migration in the case
where you are using huge pages but you have a RAM size
which is not a multiple of the huge page size.
It's unfortunately legal so there might be VMs out there
that already have it, and it turns out it used to work,
but it broke, probably when I added the support for hugepages
in postcopy.

Here I:
   a) Fix it for normal migration
   b) Ban it for postcopy, since postcopy+hugepage was new
     recently anyway and it's a non-trivial fix.

Dave

Dr. David Alan Gilbert (2):
  migration: Fix non-multiple of page size migration
  postcopy: Require RAMBlocks that are whole pages

 migration/postcopy-ram.c | 16 +++++++++++++---
 migration/ram.c          |  5 ++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.13.0
