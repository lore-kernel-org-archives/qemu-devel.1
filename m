Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5kvu-0007n8-8p
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5kvr-0004dk-A4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:53402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5kvr-0004d5-3o
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5kvp-00013U-2U
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 11C252E80D6
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:30:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 04:17:42 -0000
From: Launchpad Bug Tracker <1343827@bugs.launchpad.net>
Reply-To: Bug 1343827 <1343827@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140718061500.9209.75334.malonedeb@gac.canonical.com>
Message-Id: <152333386265.1655.2717411639510193851.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1343827] Re: block.c: multiwrite_merge()
 truncates overlapping requests
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
https://bugs.launchpad.net/bugs/1343827

Title:
  block.c: multiwrite_merge() truncates overlapping requests

Status in QEMU:
  Expired

Bug description:
  If the list of requests passed to multiwrite_merge() contains two
  requests where the first is for a range of sectors that is a strict
  subset of the second's, the second request is truncated to end where
  the first starts, so the second half of the second request is lost.

  This is easy to reproduce by running fio against a virtio-blk device
  running on qemu 2.1.0-rc1 with the below fio script. At least with fio
  2.0.13, the randwrite pass will issue overlapping bios to the block
  driver, which the kernel is happy to pass along to qemu:

  [global]
  randrepeat=3D0
  ioengine=3Dlibaio
  iodepth=3D64
  direct=3D1
  size=3D1M
  numjobs=3D1
  verify_fatal=3D1
  verify_dump=3D1

  filename=3D$dev

  [seqwrite]
  blocksize_range=3D4k-1M
  rw=3Dwrite
  verify=3Dcrc32c-intel

  [randwrite]
  stonewall
  blocksize_range=3D4k-1M
  rw=3Drandwrite
  verify=3Dmeta

  Here is a naive fix for the problem that simply avoids merging
  problematic requests. I guess a better solution would be to redo
  qemu_iovec_concat() to do the right thing.

  diff -ur old/qemu-2.1.0-rc2/block.c qemu-2.1.0-rc2/block.c
  --- old/qemu-2.1.0-rc2/block.c  2014-07-15 14:49:14.000000000 -0700
  +++ qemu-2.1.0-rc2/block.c      2014-07-17 23:03:14.224169741 -0700
  @@ -4460,7 +4460,9 @@
           int64_t oldreq_last =3D reqs[outidx].sector + reqs[outidx].nb_se=
ctors;
   =

           // Handle exactly sequential writes and overlapping writes.
  -        if (reqs[i].sector <=3D oldreq_last) {
  +        // If this request ends before the previous one, don't merge.
  +        if (reqs[i].sector <=3D oldreq_last &&
  +            reqs[i].sector + reqs[i].nb_sectors >=3D oldreq_last) {
               merge =3D 1;
           }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1343827/+subscriptions
