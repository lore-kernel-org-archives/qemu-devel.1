Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDp5-0006AP-M7
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDp0-0002DE-Pb
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:37758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDp0-0002Cp-K6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:14 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDoz-0004Ox-IX
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 880B52E80AE
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:21:10 -0000
From: Thomas Huth <1587535@bugs.launchpad.net>
Reply-To: Bug 1587535 <1587535@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160531153217.28152.41001.malonedeb@gac.canonical.com>
Message-Id: <20170119142110.21271.28091.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1587535] Re: Incorrect MAS1_TSIZE_SHIFT in
 ppce500_spin.c causes incorrectly sized TLB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch had been released with QEMU 2.7

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1587535

Title:
  Incorrect MAS1_TSIZE_SHIFT in ppce500_spin.c causes incorrectly sized
  TLB.

Status in QEMU:
  Fix Released

Bug description:
  When e500 PPC is booted multi-core, the non-boot cores are started via
  the spin table.  ppce500_spin.c:spin_kick() calls
  mmubooke_create_initial_mapping() to allocate a 64MB TLB entry, but
  the created TLB entry is only 256KB.

  The root cause is that the function computing the size of the TLB
  entry, namely booke206_page_size_to_tlb assumes MAS1.TSIZE as defined
  by latter PPC cores, specifically n to the power of FOUR * 1KB.  The
  result is then used by mmubooke_create_initial_mapping using
  MAS1_TSIZE_SHIFT, but MAS1_TSIZE_SHIFT is defined assuming TLB entries
  are n to the power of TWO * 1KB.  I.e., a difference of shift=3D7 or
  shift=3D8.

  Simply changing MAS1_TSIZE_SHIFT from 7 to 8 is not appropriate since
  the macro is used elsewhere.

  Removing the ">>1" from:

  > static inline hwaddr booke206_page_size_to_tlb(uint64_t size)
  > {
  >     return ctz32(size >> 10) >> 1;

  and adding an appropriate comment is what I used as a work around:

  > static inline hwaddr booke206_page_size_to_tlb(uint64_t size)
  > {
  >     // resulting size is based on MAS1_TSIZE_SHIFT=3D7 TLB size.
  >     return ctz32(size >> 10);

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1587535/+subscriptions
