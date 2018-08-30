Received: from eggs.gnu.org ([2001:4830:134:3::10]:54700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvPCJ-0006mW-TI
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvP8a-0005aO-AX
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvP8a-0005XV-1x
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7UFdGPT030732
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:35 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp2120.oracle.com with ESMTP id 2m2y2pwhj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjSWc009599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:29 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjSld020721
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:28 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Thu, 30 Aug 2018 16:47:03 +0100
Message-Id: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 0/8] off-by-one and NULL pointer accesses
 detected by static analysis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Below are a number of fixes to some off-by-one, read outside array bounds, and
NULL pointer accesses detected by an internal Oracle static analysis tool (Parfait).
https://labs.oracle.com/pls/apex/f?p=labs:49:::::P49_PROJECT_ID:13

I have also included a patch to add a command-line option to configure to
select if AVX2 is used or not (keeping the existing behaviour by default).
My motivation was avoiding an issue with the static analysis tool but NetSpectre
was announced as I was working on this and I felt it may have more general uses.


Liam Merwick (8):
  configure: Provide option to explicitly disable AVX2
  job: Fix off-by-one accesses to JobSTT and JobVerbTable
  block: Null pointer dereference in blk_root_get_parent_desc()
  qemu-img: potential Null pointer deref in img_commit()
  block: Fix potential Null pointer dereferences in vvfat.c
  block: dump_qlist() may dereference a Null pointer
  io: file descriptor not initialized in qio_channel_command_new_spawn()
  qcow2: Read outside array bounds in qcow2_pre_write_overlap_check()

 block/block-backend.c    |  2 +-
 block/qcow2-refcount.c   | 17 ++++++++-------
 block/vvfat.c            | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 configure                | 11 ++++++++--
 include/qapi/qmp/qlist.h |  6 ++++++
 io/channel-command.c     |  4 ++--
 job.c                    |  4 ++--
 qemu-img.c               |  3 +++
 8 files changed, 88 insertions(+), 15 deletions(-)

-- 
1.8.3.1
