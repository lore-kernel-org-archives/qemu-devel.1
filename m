Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C5C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA4020874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA4020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2GZq-0006PB-LZ
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i2GYv-0005wV-Pv
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i2GYr-0003Ci-BB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:05:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:44626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i2GYo-0003Ad-K3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:05:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i2GYm-0003My-10
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 15:05:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 029BD2E80C7
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 15:05:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Aug 2019 15:00:00 -0000
From: Paul Clarke <pc@us.ibm.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 7-pc
X-Launchpad-Bug-Reporter: Paul Clarke (7-pc)
X-Launchpad-Bug-Modifier: Paul Clarke (7-pc)
Message-Id: <156683160080.31851.8159878323909291412.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19031";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9f687332f796d5488c7e72bb788e6e2a6a891e32
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1841442] [NEW] floating point emulation can fail
 to set FE_INEXACT
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
Reply-To: Bug 1841442 <1841442@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Floating point emulation can fail to set FE_INEXACT in some
circumstances. This shows up quite often in glibc's "math" tests.  A
similar test is attached.

On ppc64le native:
--
$ gcc nextafter.c -o nextafter -lm
$ ./nextafter $(./nextafter)
0x0000000000000001 0.000000
0x0

0xa000000
FE_INEXACT FE_UNDERFLOW
0x0000000000000000 0.000000
--

On x86_64:
--
$ gcc nextafter.c -o nextafter -lm
$ ./nextafter $(./nextafter)
0x0000000000000001 0.000000
0x0

0x30
FE_INEXACT FE_UNDERFLOW =

0x0000000000000000 0.000000
--

Using qemu-system-ppc64
--
$ ./nextafter $(./nextafter)
0x0000000000000001 0.000000
0x0

0x8000000
FE_UNDERFLOW =

0x0000000000000000 0.000000
--

Using qemu-x86_64:
--
$ ./nextafter $(./nextafter)
0x0000000000000001 0.000000
0x0

0x0

0x0000000000000000 0.000000
--

QEMU versions vary, but not too much, and are pretty close to git HEAD:
- 586f3dced9 (HEAD -> master, origin/master, origin/HEAD) Merge remote-trac=
king branch 'remotes/cohuck/tags/s390x-20190822' into staging
- 864ab31 Update version for v4.1.0-rc4 release

Since the issue happens nearly identically on different targets, I
suspect the issue lies somewhere in fpu/softfloat.c.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "testcase reporting exceptions set by nextafter"
   https://bugs.launchpad.net/bugs/1841442/+attachment/5284718/+files/nexta=
fter.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1841442

Title:
  floating point emulation can fail to set FE_INEXACT

Status in QEMU:
  New

Bug description:
  Floating point emulation can fail to set FE_INEXACT in some
  circumstances. This shows up quite often in glibc's "math" tests.  A
  similar test is attached.

  On ppc64le native:
  --
  $ gcc nextafter.c -o nextafter -lm
  $ ./nextafter $(./nextafter)
  0x0000000000000001 0.000000
  0x0

  0xa000000
  FE_INEXACT FE_UNDERFLOW
  0x0000000000000000 0.000000
  --

  On x86_64:
  --
  $ gcc nextafter.c -o nextafter -lm
  $ ./nextafter $(./nextafter)
  0x0000000000000001 0.000000
  0x0

  0x30
  FE_INEXACT FE_UNDERFLOW =

  0x0000000000000000 0.000000
  --

  Using qemu-system-ppc64
  --
  $ ./nextafter $(./nextafter)
  0x0000000000000001 0.000000
  0x0

  0x8000000
  FE_UNDERFLOW =

  0x0000000000000000 0.000000
  --

  Using qemu-x86_64:
  --
  $ ./nextafter $(./nextafter)
  0x0000000000000001 0.000000
  0x0

  0x0

  0x0000000000000000 0.000000
  --

  QEMU versions vary, but not too much, and are pretty close to git HEAD:
  - 586f3dced9 (HEAD -> master, origin/master, origin/HEAD) Merge remote-tr=
acking branch 'remotes/cohuck/tags/s390x-20190822' into staging
  - 864ab31 Update version for v4.1.0-rc4 release

  Since the issue happens nearly identically on different targets, I
  suspect the issue lies somewhere in fpu/softfloat.c.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1841442/+subscriptions

