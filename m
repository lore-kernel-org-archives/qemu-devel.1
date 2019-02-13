Received: from eggs.gnu.org ([209.51.188.92]:43610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtzEz-0002tu-5b
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gtzEy-00029n-E4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:26:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:56062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gtzEy-00024A-7n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:26:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gtzEu-00040j-3j
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 18:26:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 015AB2E80CB
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 18:26:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Feb 2019 18:15:42 -0000
From: Palmer Dabbelt <palmer@dabbelt.com>
Reply-To: Bug 1815078 <1815078@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154955529480.22127.1382747582342462477.malonedeb@chaenomeles.canonical.com>
Message-Id: <155008174246.6115.11893564148220349314.malone@soybean.canonical.com>
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

It looks like this is fixed as of c7b951718815 ("RISC-V: Implement
modular CSR helper interface"), which was merged on January 14th.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815078

Title:
  Qemu 3.1.0 risc-v mie.MEIE

Status in QEMU:
  New

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
