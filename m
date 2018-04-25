Received: from eggs.gnu.org ([2001:4830:134:3::10]:45956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBP0r-0001dj-2Z
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBP0n-00009d-0X
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:19:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBP0m-00009E-SF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:19:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79F52F080F
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:19:20 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-175.rdu2.redhat.com [10.10.123.175])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D9901C707
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:19:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 25 Apr 2018 13:19:07 -0500
Message-Id: <20180425181915.577851-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] block: more byte-based cleanups: vectored
 I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In my continuing quest to nuke pointless sector-based interfaces,
here's another round of cleanups.  I spent some time on qcow,
then was appalled at how long iotests took to prove that it did
not regress; so for parallels, replication, and vhdx, I'll leave
any further cleanups within those files to interested owners.

There are now very few remaining calls into bdrv_{read,write}, so
that will be my next cleanup.

Eric Blake (8):
  parallels: Switch to byte-based calls
  qcow: Switch get_cluster_offset to be byte-based
  qcow: Switch qcow_co_readv to byte-based calls
  qcow: Switch qcow_co_writev to byte-based calls
  qcow: Switch to a byte-based driver
  replication: Switch to byte-based calls
  vhdx: Switch to byte-based calls
  block: Removed unused sector-based vectored I/O

 include/block/block.h |   4 --
 block/io.c            |  36 ---------------
 block/parallels.c     |  16 ++++---
 block/qcow.c          | 122 +++++++++++++++++++++++++-------------------------
 block/replication.c   |  14 +++---
 block/vhdx.c          |  12 ++---
 6 files changed, 86 insertions(+), 118 deletions(-)

-- 
2.14.3
