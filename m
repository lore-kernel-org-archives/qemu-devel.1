Received: from eggs.gnu.org ([209.51.188.92]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1guB18-0006ne-1B
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1guB14-0004MT-Ua
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:01:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:37614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1guB14-0004KY-Du
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 02:01:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1guB11-00009u-2h
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:00:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4D9F42E80CD
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Feb 2019 06:52:41 -0000
From: RTOS Pharos <1815078@bugs.launchpad.net>
Reply-To: Bug 1815078 <1815078@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
Message-Id: <155012716149.28602.16690825449346178376.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815078] Re: Qemu 3.1.0 risc-v mie.MEIE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

So I tried it but got the error:

ERROR: missing file ../qemu-3.1.0/ui/keycodemapdb/README

This is not a GIT checkout but module content appears to
be missing. Do not use 'git archive' or GitHub download links
to acquire QEMU source archives. Non-GIT builds are only
supported with source archives linked from:

  https://www.qemu.org/download/

Developers working with GIT can use scripts/archive-source.sh
if they need to create valid source archives.

Makefile.cross-compiler:259: recipe for target 'qemu-3.1' failed
make: *** [qemu-3.1] Error 1


Get this is standard error, but I don't have time now to see how to work
around it. Maybe later I can

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815078

Title:
  Qemu 3.1.0 risc-v mie.MEIE

Status in QEMU:
  Fix Committed

Bug description:
  Hello all,

  There is a bug in qemu for Risc-v, related to the mie register: when
  we try to set the MEIE bit (11) nothing is done, even when we are
  running at machine mode.

  Li   a0 , 1 << 11
  Csrs mie , a0

  And when we read mie it is as though nothing was done.

  Going through the qemu source code I was able to correct it: on file
  op_helper.c, line 94, the variable all_ints should be initialized
  with:

  uint64_t all_ints =3D delegable_ints | MIP_MSIP | MIP_MTIP | MIP_MEIP;

  That is, the MIP_MEIP was missing.

  I've successfully triggered uart interrupts with this patch (virt
  machine).

  All the best,
  Pharos team

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815078/+subscriptions
