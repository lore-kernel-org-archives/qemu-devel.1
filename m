Received: from eggs.gnu.org ([2001:4830:134:3::10]:49695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cY3bx-0008HI-Cl
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cY3bu-0004n6-DP
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:42566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cY3bu-0004mR-88
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 23:30:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cY3bt-0004Ym-C4
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:30:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53A042E80C0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 04:30:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2017 04:17:34 -0000
From: Launchpad Bug Tracker <1163065@bugs.launchpad.net>
Reply-To: Bug 1163065 <1163065@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130402002132.20684.26917.malonedeb@wampee.canonical.com>
Message-Id: <20170130041735.7435.27451.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1163065] Re: target-i386 cpu_get_phys_page_debug
 checks bits in wrong order
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
https://bugs.launchpad.net/bugs/1163065

Title:
  target-i386 cpu_get_phys_page_debug checks bits in wrong order

Status in QEMU:
  Expired

Bug description:
  In target-i386 cpu_get_phys_page_debug, the CR4_PAE bit is checked
  before CR0_PG. This means that if paging is disabled but the PAE bit
  has been set in CR4, cpu_get_phys_page_debug will return the wrong
  result (it will try to translate the address as virtual rather than
  using it as a physical address).

  Although this might seem like an unusual case, it in fact happens
  consistently when booting Linux on amd64 (from
  linux-2.6.32.60/arch/x86/boot/compressed/head_64.S):

      /* Enable PAE mode */
      xorl    %eax, %eax
      orl $(X86_CR4_PAE), %eax
      movl    %eax, %cr4
  [... code to set up page tables omitted ...]
      /* Enter paged protected Mode, activating Long Mode */
      movl    $(X86_CR0_PG | X86_CR0_PE), %eax /* Enable Paging and Protect=
ed mode */
      movl    %eax, %cr0

  The most noticeable effect of this bug is that using the disassembler
  during this time will fetch the wrong data by trying to read from page
  tables that aren't there. One symptom is that booting Linux amd64 with
  -d in_asm will result in several "Disassembler disagrees with
  translator over instruction decoding" messages.

  Attached is a patch that moves the CR0_PG check to the beginning. I'm
  still not 100% certain that the logic of cpu_get_phys_page_debug
  matches cpu_x86_handle_mmu_fault, but it's a start.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1163065/+subscriptions
