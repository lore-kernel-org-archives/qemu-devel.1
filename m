Received: from eggs.gnu.org ([209.51.188.92]:54493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIwv4-0006MA-Mq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIwuy-0003iu-Fb
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:01:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:60876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIwuy-0003hd-8e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:01:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIwut-0001hF-Tv
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:01:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CA84F2E817A
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:01:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 14:48:44 -0000
From: Jakub Jermar <1825311@bugs.launchpad.net>
Reply-To: Bug 1825311 <1825311@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155557460746.17507.17649109204793492383.malonedeb@soybean.canonical.com>
Message-Id: <155603092465.6530.17158756071412067771.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1825311] Re: mips_cpu_handle_mmu_fault renders
 all accessed pages executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am attaching a reproducer image and script.

Unpatched execution ends like this:

...
TAP TEST START
1..2
not ok 1 NonExecutable::ElfDataIsNotExecutable
# Assertion failed /home/jermar/Kernkonzept/software/l4/pkg/l4re-core/test/=
moe/test_nx.cc:103
# Expected: -(L4_EIPC_LO + l4_ipc_error(tag, l4_utcb())) >=3D 0
# Actual: -2003 (Receive timeout)
# There was no IPC error.
# Assertion failed /home/jermar/Kernkonzept/software/l4/pkg/l4re-core/test/=
moe/test_nx.cc:125
# Expected equality of these values:
#   pfa
#     Which is: 360
#   (l4_addr_t)execute_data
#     Which is: 17633344
# The page fault occured at the expected location.
not ok 2 NonExecutable::StackIsNotExecutable
# Assertion failed /home/jermar/Kernkonzept/software/l4/pkg/l4re-core/test/=
moe/test_nx.cc:103
# Expected: -(L4_EIPC_LO + l4_ipc_error(tag, l4_utcb())) >=3D 0
# Actual: -2003 (Receive timeout)
# There was no IPC error.
# Assertion failed /home/jermar/Kernkonzept/software/l4/pkg/l4re-core/test/=
moe/test_nx.cc:144
# Expected equality of these values:
#   pfa
#     Which is: 4358144
#   stack_func
#     Which is: 4276000
# The page fault occured at the expected location.
TAP TEST FINISHED


With the proposed patch applied, the execution should end with something
like this:

...
TAP TEST START
1..2
ok 1 NonExecutable::ElfDataIsNotExecutable
ok 2 NonExecutable::StackIsNotExecutable
TAP TEST FINISHED


** Attachment added: "Image and script for reproducing this bug."
   https://bugs.launchpad.net/qemu/+bug/1825311/+attachment/5258264/+files/=
reproducer.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825311

Title:
  mips_cpu_handle_mmu_fault renders all accessed pages executable

Status in QEMU:
  New

Bug description:
  On MIPS, data accesses to pages mapped in the TLB result in
  mips_cpu_handle_mmu_fault() marking the page unconditionally
  executable, even if the TLB entry has the XI bit set. Later on, when
  there is an attempt to execute this page, no exception is generated,
  even though TLBXI is expected.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825311/+subscriptions
