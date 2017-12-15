Received: from eggs.gnu.org ([2001:4830:134:3::10]:37002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsZk-0005Er-7Z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsZj-0006FM-4Y
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:11:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:51026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsZi-0006De-Um
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:11:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsZf-00020E-V4
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:11:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 611D92E80E6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:10:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:59:00 -0000
From: Thomas Huth <1713066@bugs.launchpad.net>
Reply-To: Bug 1713066 <1713066@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150366905912.16996.8020711454083281212.malonedeb@gac.canonical.com>
Message-Id: <151335354169.16034.2029741953738847586.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1713066] Re: Incorrect handling of aarch64 ldp in
 some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1713066

Title:
  Incorrect handling of aarch64 ldp in some cases

Status in QEMU:
  Fix Released

Bug description:
  In some cases the ldp instruction (and presumably other multi-register
  loads and stores) can behave incorrectly.

  Given the following instruction:
  ldp x0, x1, [x0]

  This will load two 64 bit values from memory, however if each location
  to load is on a different page and the second page is unmapped this
  will raise an exception. When this happens x0 has already been updated
  so after the exception handler has run the operating system will try
  to rerun the instruction. QEMU will now try to perform an invalid load
  and raise a new exception.

  I believe this is incorrect as section D.1.14.5 of the ARMv8 reference
  manual B.a states that, on taking an exception, registers used in the
  generation of addresses are restored to their initial value, so x0
  shouldn't be changed, where x1 can be un an unknown state.

  I found the issue running FreeBSD with the cortex-strings
  implementation of memcpy. This uses a similar instruction when copying
  between 64 and 96 bytes.

  I've observed this on:
  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.14), Copyright (=
c) 2003-2008 Fabrice Bellard

  And checked I still get the same behaviour on:
  QEMU emulator version 2.9.94 (v2.10.0-rc4-dirty)
  Git revision: 248b23735645f7cbb503d9be6f5bf825f2a603ab

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1713066/+subscriptions
