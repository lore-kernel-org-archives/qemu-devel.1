Received: from eggs.gnu.org ([2001:4830:134:3::10]:60648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e13A0-0000gW-59
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 00:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e139x-0004qh-00
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 00:25:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:39804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e139w-0004qE-Pl
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 00:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e139t-00075O-JM
	for <qemu-devel@nongnu.org>; Sun, 08 Oct 2017 04:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 907E12E80C7
	for <qemu-devel@nongnu.org>; Sun,  8 Oct 2017 04:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Oct 2017 04:17:20 -0000
From: Launchpad Bug Tracker <1709025@bugs.launchpad.net>
Reply-To: Bug 1709025 <1709025@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150209306745.21201.16700911445033219702.malonedeb@wampee.canonical.com>
Message-Id: <150743624249.13125.13017114430876214384.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709025

Title:
  Disk corrupted after snapshot deletion

Status in QEMU:
  Expired

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
