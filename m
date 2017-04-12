Received: from eggs.gnu.org ([2001:4830:134:3::10]:55629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cyJvA-00056E-9n
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cyJv7-00070B-2v
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:11:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:51195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cyJv6-0006yi-Tg
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:10:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cyJv4-00042H-Ox
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 15:10:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BB8B72E80C4
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 15:10:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Apr 2017 15:02:21 -0000
From: Harry Wagstaff <1682093@bugs.launchpad.net>
Reply-To: Bug 1682093 <1682093@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170412105411.12710.65118.malonedeb@gac.canonical.com>
Message-Id: <20170412150221.12199.46501.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1682093] Re: aarch64-softmmu "bad ram pointer"
 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've done some investigation and it appears that this bug is caused by
the following:

1. The flash memory of the virt platform is initialised as a
cfi.pflash01. It has a memory region with romd_mode =3D true and
rom_device =3D true

2. Some code stored in the flash memory is executed. This causes the
memory to be loaded into the TLB.

3. The code is overwritten. This causes the romd_mode of the flash
memory to be reset. It also causes the code to be evicted from the TLB.

4. An attempt is made to execute the code again (cpu_exec(), cpu-exec.c:677)
4a. Eventually, QEMU attempts to refill the TLB (softmmu_template.h:127)
4b. We try to fill in the tlb entry (tlb_set_page_with_attrs, cputlb.c:602)
4b. The flash memory no longer appears to be a ram or romd (cputlb.c:632)
4c. QEMU decides that the flash memory is an IO device (cputlb.c:634)
4d. QEMU aborts while trying to fill in the rest of the TLB entry (qemu_ram=
_addr_from_host_nofail)

I have built a MWE (which I have attached) which produces this behaviour
in git head. I'm not exactly sure what a fix for this should look like:
AFAIK it's not technically valid to write into flash, but I'm not sure
that QEMU crashing should be considered correct behaviour.

** Attachment added: "mwe.tar.gz"
   https://bugs.launchpad.net/qemu/+bug/1682093/+attachment/4860707/+files/=
mwe.tar.gz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1682093

Title:
  aarch64-softmmu "bad ram pointer" crash

Status in QEMU:
  New

Bug description:
  I am developing a piece of software called SimBench which is a
  benchmarking system for full system simulators. I am currently porting
  this to aarch64, using QEMU as a test platform.

  I have encountered a 'bad ram pointer' crash. I've attempted to build
  a minimum test case, but I haven't managed to replicate the behaviour
  in isolation, so I've created a branch of my project which exhibits
  the crash: https://bitbucket.org/Awesomeclaw/simbench/get/qemu-
  bug.tar.gz

  The package can be compiled using:

  make

  and then run using:

  qemu-system-aarch64  -M virt -m 512 -cpu cortex-a57 -kernel
  out/armv8/virt/simbench -nographic

  I have replicated the issue in both qemu 2.8.1 and in 2.9.0-rc3, on
  Fedora 23. Please let me know if you need any more information or any
  logs/core dumps/etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1682093/+subscriptions
