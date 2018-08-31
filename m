Received: from eggs.gnu.org ([2001:4830:134:3::10]:50018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwE-0007CY-1l
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwB-0005tA-Cp
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvnwB-0005t0-41
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VIDsiu061969
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:26 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2130.oracle.com with ESMTP id 2m2xhucv78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEPnG010883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:25 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEOBa021023
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:24 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 19:16:04 +0100
Message-Id: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/8] off-by-one and NULL pointer accesses
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

Below are a number of fixes to some off-by-one, read outside array bounds=
, and
NULL pointer accesses detected by an internal Oracle static analysis tool=
 (Parfait).
https://labs.oracle.com/pls/apex/f?p=3Dlabs:49:::::P49_PROJECT_ID:13

I have also included a patch to add a command-line option to configure to
select if AVX2 is used or not (keeping the existing behaviour by default).
My motivation was avoiding an issue with the static analysis tool but Net=
Spectre
was announced as I was working on this and I felt it may have more genera=
l uses.

v1 -> v2
Based on feedback from Eric Blake:
patch2: reworded commit message to clarify issue
patch6: Reverted common qlist routines and added assert to qlist_dump ins=
tead
patch7: Fixed incorrect logic
patch8: Added QEMU_BUILD_BUG_ON to catch future =D1=96nstance at compile-=
time

v2 -> v3
Based on feedback from Eric Blake:
patch6: removed double space from commit message
patch8: removed unnecessary comment and updated QEMU_BUILD_BUG_ON to use =
ARRAY_SIZE
Added Eric's R-b to patches 6,7,8

Liam Merwick (8):
  configure: Provide option to explicitly disable AVX2
  job: Fix off-by-one assert checks for JobSTT and JobVerbTable
  block: Null pointer dereference in blk_root_get_parent_desc()
  qemu-img: potential Null pointer deref in img_commit()
  block: Fix potential Null pointer dereferences in vvfat.c
  block: dump_qlist() may dereference a Null pointer
  io: potential unnecessary check in qio_channel_command_new_spawn()
  qcow2: Read outside array bounds in qcow2_pre_write_overlap_check()

 block/block-backend.c  |  2 +-
 block/qapi.c           |  2 ++
 block/qcow2-refcount.c | 18 ++++++++--------
 block/vvfat.c          | 56 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 configure              | 11 ++++++++--
 io/channel-command.c   |  3 +--
 job.c                  |  4 ++--
 qemu-img.c             |  3 +++
 8 files changed, 84 insertions(+), 15 deletions(-)

--=20
1.8.3.1
