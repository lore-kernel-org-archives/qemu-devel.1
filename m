Received: from eggs.gnu.org ([2001:4830:134:3::10]:58668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePtPm-0007rG-VK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePtPk-0007hY-Ot
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:04:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:46804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePtPk-0007ew-I2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:04:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePtPh-0005l3-M1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 17:04:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9DE432E80C9
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 17:04:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:50:21 -0000
From: Jakub Jermar <1128935@bugs.launchpad.net>
Reply-To: Bug 1128935 <1128935@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130218102749.9311.80891.malonedeb@gac.canonical.com>
Message-Id: <151335662154.11131.15241207836227032556.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1128935] Re: MIPS r4k "TLB modified exception"
 generated for TLB entries that are not visible to the TLBP instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, running the following command line with QEMU 2.11.0 on the HelenOS
0.7.1 image downloaded from
http://www.helenos.org/releases/HelenOS-0.7.1-mips32-malta-be.boot will
result in occasional "failures" of the TLBP instruction as described in
this bug and as evidenced by a warning printed by HelenOS, which goes
like:

  tlb_modified: TLBP failed in exception handler (badvaddr=3D0x7001d7d8,
ASID=3D29).

The command line to reproduce:

  qemu-system-mips -cpu 4Kc -drive
file=3Dhdisk.img,index=3D0,media=3Ddisk,format=3Draw -device e1000,vlan=3D0=
 -net
user,hostfwd=3Dudp::8080-:8080,hostfwd=3Dudp::8081-:8081,hostfwd=3Dtcp::808=
0-:8080,hostfwd=3Dtcp::8081-:8081,hostfwd=3Dtcp::2223-:2223
-usb -device intel-hda -device hda-duplex -kernel HelenOS-0.7.1-mips32
-malta-be.boot -nographic

It would be good if someone familiar with the mips target had a look at
this.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1128935

Title:
  MIPS r4k "TLB modified exception" generated for TLB entries that are
  not visible to the TLBP instruction

Status in HelenOS branches:
  New
Status in QEMU:
  Incomplete

Bug description:
  I occasionally see that the TLBP instruction fails to find the
  corresponding TLB entry in the TLB Modified exception handler.  This
  behavior is unexpected, because the invocation of the TLB Modified
  exception suggests there indeed is such an entry in the TLB and only
  requires its dirty bit to be set.

  The operating system which can trigger and is susceptible to this
  behavior is a HelenOS branch located in lp:~jakub/helenos/mips-malta.
  The QEMU version on which this is reproducible is QEMU 1.4.0 and also
  some others.

  When I looked into the QEMU sources, I noticed the following
  discrepancy, which could potentially explain the behavior:

    65  /* MIPS32/MIPS64 R4000-style MMU emulation */
    66 int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
    67                      target_ulong address, int rw, int access_type)
    68 {
    <snip>
    72     for (i =3D 0; i < env->tlb->tlb_in_use; i++) {

  1865 void r4k_helper_tlbp(CPUMIPSState *env)
  1866 {
   <snip>
  1875     for (i =3D 0; i < env->tlb->nb_tlb; i++) {

  From the above it appears as if the the code which searches the TLB
  for a matching entry searched also the QEMU-specific "shadow" TLB
  entries, which is, however, not in line with how the TLBP instruction
  searches the TLB. So if a matching entry is found on index >=3D
  tlb_in_use, the HelenOS exception handler using TLBP to locate the
  entry would hit an assertion on seeing the Index register bit P set.

  I also suspect there is a similar issue with the TLB Invalid
  exception, but thanks to the specifics of the MIPS 4Kc CPU, HelenOS is
  not susceptible in this case.

To manage notifications about this bug go to:
https://bugs.launchpad.net/helenos/+bug/1128935/+subscriptions
