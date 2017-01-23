Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVizj-0007HI-6H
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVize-0002rL-LR
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:05:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:54729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVize-0002rE-G5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:05:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVizd-0005S3-Hc
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 18:05:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 79FF82E80C2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 18:05:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 17:48:35 -0000
From: Thomas Huth <1248168@bugs.launchpad.net>
Reply-To: Bug 1248168 <1248168@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131105124713.24131.16100.malonedeb@gac.canonical.com>
Message-Id: <20170123174837.14023.51031.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1248168] Re: MIPS,
 self-modifying code and uncached memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1248168

Title:
  MIPS, self-modifying code and uncached memory

Status in QEMU:
  Incomplete

Bug description:
  Self-modifying code does not work properly in MIPS in uncached and
  unmapped kseg1 memory region.

  For example, when running this code I get unexpected behavior:

     0:	e3000010 	b	0x390
     4:	00000000 	nop
  	...
   380:	00701f40 	mfc0	ra,c0_epc
   384:	0400e0bb 	swr	zero,4(ra)
   388:	18000042 	eret
   38c:	00000000 	nop
   390:	25500000 	move	t2,zero
   394:	02000b34 	li	t3,0x2
   398:	23504b01 	subu	t2,t2,t3
   39c:	e9003c0b 	j	0xcf003a4
   3a0:	0a004a21 	addi	t2,t2,10
   3a4:	ffff0010 	b	0x3a4
   3a8:	00000000 	nop
   3ac:	00000000 	nop

    I expect that swr instruction in line 384 would change `addi	t2,t2,1`0 =
to `nop`
  This should work because no cache is used for this memory region.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1248168/+subscriptions
