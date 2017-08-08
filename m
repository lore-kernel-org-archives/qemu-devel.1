Received: from eggs.gnu.org ([2001:4830:134:3::10]:56110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1detMH-0007YA-7W
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1detMC-0002Gq-4A
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:32911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1detMB-0002Gk-Un
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1detMB-00066u-0R
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 01:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BA6B72E80CB
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 01:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 01:23:22 -0000
From: junchi <1709025@bugs.launchpad.net>
Reply-To: Bug 1709025 <1709025@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150209306745.21201.16700911445033219702.malonedeb@wampee.canonical.com>
Message-Id: <150215540286.11619.7932820872442768690.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1709025] Re: Disk corrupted after snapshot
 deletion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

My qemu version is 2.1.2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709025

Title:
  Disk corrupted after snapshot deletion

Status in QEMU:
  New

Bug description:
    I found the vm disk corruption after snapshot deletion sometimes(the pr=
obability is very low, I'm afraid i can't reproduce it). And I found there =
is a patch for it as follow, but I'm not sure whether the patch repaired th=
e bug. =

    Drain disk before snapshot deletion can't guarantee anything, there is =
still pending IO in snapshot-deletion process. Anyone can help?

  author	Zhang Haoyu <zhanghy@sangfor.com>	2014-10-21 16:38:01 +0800
  committer	Stefan Hajnoczi <stefanha@redhat.com>	2014-11-03 09:48:42 +0000
  commit	3432a1929ee18e08787ce35476abd74f2c93a17c (patch)
  tree	13a81c0a46707d91622f1593ccf7b926935371fd /block/snapshot.c
  parent	573742a5431a99ceaba6968ae269cee247727cce (diff)
  snapshot: add bdrv_drain_all() to bdrv_snapshot_delete() to avoid concurr=
ency problem
  If there are still pending i/o while deleting snapshot,
  because deleting snapshot is done in non-coroutine context, and
  the pending i/o read/write (bdrv_co_do_rw) is done in coroutine context,
  so it's possible to cause concurrency problem between above two operation=
s.
  Add bdrv_drain_all() to bdrv_snapshot_delete() to avoid this problem.

  Signed-off-by: Zhang Haoyu <zhanghy@sangfor.com>
  Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
  Message-id: 201410211637596311287@sangfor.com
  Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
  Diffstat (limited to 'block/snapshot.c')
  -rw-r--r--	block/snapshot.c	4	=

  1 files changed, 4 insertions, 0 deletions
  diff --git a/block/snapshot.c b/block/snapshot.c
  index 85c52ff..698e1a1 100644
  --- a/block/snapshot.c
  +++ b/block/snapshot.c
  @@ -236,6 +236,10 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
           error_setg(errp, "snapshot_id and name are both NULL");
           return -EINVAL;
       }
  +
  +    /* drain all pending i/o before deleting snapshot */
  +    bdrv_drain_all();
  +
       if (drv->bdrv_snapshot_delete) {
           return drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
       }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1709025/+subscriptions
