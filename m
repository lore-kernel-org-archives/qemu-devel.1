Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C73C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71D2206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71D2206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbgv9-0003kh-Ux
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgsV-0000Fo-FB
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:20:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:54682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgsT-0001L5-3k
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:20:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbgsQ-0006w7-4P
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:20:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1EA1D2E811E
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:06:01 -0000
From: Thomas Huth <1653419@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: svm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anandj91 th-huth
X-Launchpad-Bug-Reporter: Anand J (anandj91)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170101121115.14908.69350.malonedeb@wampee.canonical.com>
Message-Id: <160482636153.28021.12240587816465945928.malone@chaenomeles.canonical.com>
Subject: [Bug 1653419] Re: SVM emulation fails due to EIP and FLAG register
 update optimization
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 2bdc3e1f28d75609fc0b2445a6fb98709298cff6
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1653419 <1653419@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to
"Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653419

Title:
  SVM emulation fails due to EIP and FLAG register update optimization

Status in QEMU:
  Incomplete

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

