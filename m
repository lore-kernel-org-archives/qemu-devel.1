Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNf80-0003fx-9w
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 07:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNf7v-00025g-7A
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 07:20:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:54248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cNf7u-000251-NW
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 07:20:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cNf7t-0007Ue-8j
	for <qemu-devel@nongnu.org>; Sun, 01 Jan 2017 12:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 226082E80C9
	for <qemu-devel@nongnu.org>; Sun,  1 Jan 2017 12:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Jan 2017 12:11:15 -0000
From: Anand J <1653419@bugs.launchpad.net>
Reply-To: Bug 1653419 <1653419@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170101121115.14908.69350.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1653419] [NEW] SVM emulation fails due to EIP and
 FLAG register update optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

SVM emulation support has a bug due to which causes KVM emulation error
when qemu-kvm is run over KVM installed on top of QEmu in software mode.

Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Run KVM inside QEmu(software mode with SVM emulation support). Make sure=
 kvm_amd is running.
2. Run any guest OS on top of the KVM using qemu-kvm.
3. Following KVM emulation error is thrown immediately.

KVM internal error. Suberror: 1
emulation failure
EAX=3Dffffffff EBX=3D4000004b ECX=3D00000000 EDX=3D000f5ea0
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00006fd0
EIP=3D40000000 EFL=3D00000086 [--S--P-] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
CS =3D0008 00000000 ffffffff 00c09b00 DPL=3D0 CS32 [-RA]
SS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
DS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
FS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
GS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
LDT=3D0000 00000000 0000ffff 00008200 DPL=3D0 LDT
TR =3D0000 00000000 0000ffff 00008b00 DPL=3D0 TSS32-busy
GDT=3D     000f7180 00000037
IDT=3D     000f71be 00000000
CR0=3D00000011 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00

Reason for the error
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Due to performance reasons, EIP and FLAG registers are not updated after ex=
ecuting every guest instructions. There are optimizations done to update th=
ese registers intelligently, for eg: EIP is updated at the end of translati=
on block. This means EIP remains the address of the first instruction in th=
e TB throughout the execution.

In case of a VMEXIT because of a page fault happened after executing an
instruction in the middle of the TB, the VMCB is updated with the wrong
guest EIP and jumps to the address where host has left off. On the
subsequent VMRUN by the host QEmu start executing some of the
instructions that has already been executed. This can cause wrong
execution flow.

Following is the instruction execution trace of the above scenario.

0x00000000000f368f: callq 0xeecc4
vmexit(00000060, 0000000000000000, 0000000000000000, 00000000000eecc4)!
vmsave! 00000000b72e9000
vmload! 00000000b72e9000
vmrun! 00000000b72e9000
0x00000000000eecc4: push %rbx
0x00000000000eecc5: xor %ecx,%ecx
0x00000000000eecc7: mov (%rax,%rcx,1),%bl
0x00000000000eecca: cmp (%rdx,%rcx,1),%bl
vmexit(0000004e, 0000000000000000, 00000000000f5ea0, 00000000000eecc4)!

Page fault happens at 0x00000000000eecca which triggers a VMEXIT.
vmcb->save->rip is updated with 0x00000000000eecc4 instead of
0x00000000000eecca.

vmsave! 00000000b72e9000
vmload! 00000000b72e9000
vmrun! 00000000b72e9000
0x00000000000eecc4: push %rbx
0x00000000000eecc5: xor %ecx,%ecx
0x00000000000eecc7: mov (%rax,%rcx,1),%bl
0x00000000000eecca: cmp (%rdx,%rcx,1),%bl
0x00000000000eeccd: je 0xeecdc
0x00000000000eeccf: setl %al
0x00000000000eecd2: movzbl %al,%eax
0x00000000000eecd5: neg %eax
0x00000000000eecd7: or $0x1,%eax
0x00000000000eecda: jmp 0xeece3
0x00000000000eece3: pop %rbx
0x00000000000eece4: retq
vmexit(0000004e, 0000000000000000, 0000000040000000, 0000000040000000)!

The subsequent VMRUN again starts executing from 0x00000000000eecc4
which causes %rbx being pushed to the stack for the second time. The
retq instruction picks wrong return address and jumps to an illegal
location.

Similar issue is there with updating FLAG register as well.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: svm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653419

Title:
  SVM emulation fails due to EIP and FLAG register update optimization

Status in QEMU:
  New

Bug description:
  SVM emulation support has a bug due to which causes KVM emulation
  error when qemu-kvm is run over KVM installed on top of QEmu in
  software mode.

  Steps to reproduce
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  1. Run KVM inside QEmu(software mode with SVM emulation support). Make su=
re kvm_amd is running.
  2. Run any guest OS on top of the KVM using qemu-kvm.
  3. Following KVM emulation error is thrown immediately.

  KVM internal error. Suberror: 1
  emulation failure
  EAX=3Dffffffff EBX=3D4000004b ECX=3D00000000 EDX=3D000f5ea0
  ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00006fd0
  EIP=3D40000000 EFL=3D00000086 [--S--P-] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  CS =3D0008 00000000 ffffffff 00c09b00 DPL=3D0 CS32 [-RA]
  SS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  DS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  FS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  GS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
  LDT=3D0000 00000000 0000ffff 00008200 DPL=3D0 LDT
  TR =3D0000 00000000 0000ffff 00008b00 DPL=3D0 TSS32-busy
  GDT=3D     000f7180 00000037
  IDT=3D     000f71be 00000000
  CR0=3D00000011 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00

  Reason for the error
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Due to performance reasons, EIP and FLAG registers are not updated after =
executing every guest instructions. There are optimizations done to update =
these registers intelligently, for eg: EIP is updated at the end of transla=
tion block. This means EIP remains the address of the first instruction in =
the TB throughout the execution.

  In case of a VMEXIT because of a page fault happened after executing
  an instruction in the middle of the TB, the VMCB is updated with the
  wrong guest EIP and jumps to the address where host has left off. On
  the subsequent VMRUN by the host QEmu start executing some of the
  instructions that has already been executed. This can cause wrong
  execution flow.

  Following is the instruction execution trace of the above scenario.

  0x00000000000f368f: callq 0xeecc4
  vmexit(00000060, 0000000000000000, 0000000000000000, 00000000000eecc4)!
  vmsave! 00000000b72e9000
  vmload! 00000000b72e9000
  vmrun! 00000000b72e9000
  0x00000000000eecc4: push %rbx
  0x00000000000eecc5: xor %ecx,%ecx
  0x00000000000eecc7: mov (%rax,%rcx,1),%bl
  0x00000000000eecca: cmp (%rdx,%rcx,1),%bl
  vmexit(0000004e, 0000000000000000, 00000000000f5ea0, 00000000000eecc4)!

  Page fault happens at 0x00000000000eecca which triggers a VMEXIT.
  vmcb->save->rip is updated with 0x00000000000eecc4 instead of
  0x00000000000eecca.

  vmsave! 00000000b72e9000
  vmload! 00000000b72e9000
  vmrun! 00000000b72e9000
  0x00000000000eecc4: push %rbx
  0x00000000000eecc5: xor %ecx,%ecx
  0x00000000000eecc7: mov (%rax,%rcx,1),%bl
  0x00000000000eecca: cmp (%rdx,%rcx,1),%bl
  0x00000000000eeccd: je 0xeecdc
  0x00000000000eeccf: setl %al
  0x00000000000eecd2: movzbl %al,%eax
  0x00000000000eecd5: neg %eax
  0x00000000000eecd7: or $0x1,%eax
  0x00000000000eecda: jmp 0xeece3
  0x00000000000eece3: pop %rbx
  0x00000000000eece4: retq
  vmexit(0000004e, 0000000000000000, 0000000040000000, 0000000040000000)!

  The subsequent VMRUN again starts executing from 0x00000000000eecc4
  which causes %rbx being pushed to the stack for the second time. The
  retq instruction picks wrong return address and jumps to an illegal
  location.

  Similar issue is there with updating FLAG register as well.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1653419/+subscriptions
