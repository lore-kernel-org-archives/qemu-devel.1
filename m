Received: from eggs.gnu.org ([2001:4830:134:3::10]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPDX-0005vn-0F
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPDT-0004HX-OF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38762 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPDT-0004Gn-Je
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1154C401DEAA
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:32:28 +0000 (UTC)
Received: from red.redhat.com (ovpn-123-175.rdu2.redhat.com [10.10.123.175])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF4BB111CB8E
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:32:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 25 Apr 2018 13:32:15 -0500
Message-Id: <20180425183223.580566-1-eblake@redhat.com>
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

Based-on: <20180424192506.149089-1-eblake@redhat.com>
([PATCH v2 0/6] block: byte-based AIO read/write)
Based-on: <20180424220157.177385-1-eblake@redhat.com>
([PATCH] block: Merge .bdrv_co_writev{, _flags} in drivers)

My quest continues.  I spent some time pruning qcow down as far
as possible (and was dismayed at how long it took to prove no
iotests regressions); so for the other drivers, I did the bare
minimum to get rid of an interface, but will leave it to those
file owners if they want to get rid of further pointless sector
manipulations in their files.

Next on the chopping block: bdrv_read/bdrv_write.

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
