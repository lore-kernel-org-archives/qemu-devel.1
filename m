Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4C9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7C420936
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7C420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr6Ln-0002Ev-Md
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 17:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jr6KB-0000R0-Rj
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 17:00:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:52316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jr6K9-0005Ux-B3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 17:00:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jr6K6-0007mk-I0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 21:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 797E22E8105
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 21:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2020 20:50:41 -0000
From: Langston <1886097@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: langston0
X-Launchpad-Bug-Reporter: Langston (langston0)
X-Launchpad-Bug-Modifier: Langston (langston0)
Message-Id: <159372304166.1717.6838286421660212766.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1886097] [NEW] Error in user-mode calculation of ELF program's
 brk
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0a7b469dcc9633fadc6668fb960911ab79dead0d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 16:30:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1886097 <1886097@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

There's a discrepancy between the way QEMU user-mode and Linux calculate
the initial program break for statically-linked binaries. I have a
binary with the following segments:

  Program Headers:
    Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
    EXIDX          0x065a14 0x00075a14 0x00075a14 0x00588 0x00588 R   0x4
    PHDR           0x0a3000 0x000a3000 0x000a3000 0x00160 0x00160 R   0x1000
    LOAD           0x0a3000 0x000a3000 0x000a3000 0x00160 0x00160 R   0x1000
    LOAD           0x000000 0x00010000 0x00010000 0x65fa0 0x65fa0 R E 0x100=
00
    LOAD           0x066b7c 0x00086b7c 0x00086b7c 0x02384 0x02384 RW  0x100=
00
    NOTE           0x000114 0x00010114 0x00010114 0x00044 0x00044 R   0x4
    TLS            0x066b7c 0x00086b7c 0x00086b7c 0x00010 0x00030 R   0x4
    GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x8
    GNU_RELRO      0x066b7c 0x00086b7c 0x00086b7c 0x00484 0x00484 R   0x1
    LOAD           0x07e000 0x00089000 0x00089000 0x03ff4 0x03ff4 R E 0x1000
    LOAD           0x098000 0x00030000 0x00030000 0x01000 0x01000 RW  0x1000

The call to set_brk in Linux's binfmt_elf.c receives these arguments:

  set_brk(0xa3160, 0xa3160, 1)
  =

Whereas in QEMU, info->brk gets set to 0x88f00. When the binary is run in Q=
EMU, it crashes on the second call to brk, whereas it runs fine on real ARM=
 hardware. I think the trouble is that the program break is set to an addre=
ss lower than the virtual address of a LOAD segment (the program headers, i=
n this case).

I believe that this discrepancy arises because in QEMU, info->brk is
only incremented when the LOAD segment in question has PROT_WRITE. For
this binary, the LOAD segment with write permissions and the highest
virtual address is

  LOAD           0x066b7c 0x00086b7c 0x00086b7c 0x02384 0x02384 RW  0x10000
    =

which overlaps with the TLS segment:

    TLS            0x066b7c 0x00086b7c 0x00086b7c 0x00010 0x00030 R   0x4
    =

However, the Linux kernel puts the program break after the loadable segment=
 with the highest virtual address, regardless of flags. So I think the fix =
is for QEMU to do the same.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886097

Title:
  Error in user-mode calculation of ELF program's brk

Status in QEMU:
  New

Bug description:
  There's a discrepancy between the way QEMU user-mode and Linux
  calculate the initial program break for statically-linked binaries. I
  have a binary with the following segments:

    Program Headers:
      Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Ali=
gn
      EXIDX          0x065a14 0x00075a14 0x00075a14 0x00588 0x00588 R   0x4
      PHDR           0x0a3000 0x000a3000 0x000a3000 0x00160 0x00160 R   0x1=
000
      LOAD           0x0a3000 0x000a3000 0x000a3000 0x00160 0x00160 R   0x1=
000
      LOAD           0x000000 0x00010000 0x00010000 0x65fa0 0x65fa0 R E 0x1=
0000
      LOAD           0x066b7c 0x00086b7c 0x00086b7c 0x02384 0x02384 RW  0x1=
0000
      NOTE           0x000114 0x00010114 0x00010114 0x00044 0x00044 R   0x4
      TLS            0x066b7c 0x00086b7c 0x00086b7c 0x00010 0x00030 R   0x4
      GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x8
      GNU_RELRO      0x066b7c 0x00086b7c 0x00086b7c 0x00484 0x00484 R   0x1
      LOAD           0x07e000 0x00089000 0x00089000 0x03ff4 0x03ff4 R E 0x1=
000
      LOAD           0x098000 0x00030000 0x00030000 0x01000 0x01000 RW  0x1=
000

  The call to set_brk in Linux's binfmt_elf.c receives these arguments:

    set_brk(0xa3160, 0xa3160, 1)
    =

  Whereas in QEMU, info->brk gets set to 0x88f00. When the binary is run in=
 QEMU, it crashes on the second call to brk, whereas it runs fine on real A=
RM hardware. I think the trouble is that the program break is set to an add=
ress lower than the virtual address of a LOAD segment (the program headers,=
 in this case).

  I believe that this discrepancy arises because in QEMU, info->brk is
  only incremented when the LOAD segment in question has PROT_WRITE. For
  this binary, the LOAD segment with write permissions and the highest
  virtual address is

    LOAD           0x066b7c 0x00086b7c 0x00086b7c 0x02384 0x02384 RW  0x100=
00
      =

  which overlaps with the TLS segment:

      TLS            0x066b7c 0x00086b7c 0x00086b7c 0x00010 0x00030 R   0x4
      =

  However, the Linux kernel puts the program break after the loadable segme=
nt with the highest virtual address, regardless of flags. So I think the fi=
x is for QEMU to do the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886097/+subscriptions

