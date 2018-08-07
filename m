Received: from eggs.gnu.org ([2001:4830:134:3::10]:58178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmr8x-0006i7-Ot
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 21:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmr8t-0008W9-T4
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 21:50:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmr8t-0008W1-MM
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 21:50:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmr8s-0007qU-Hl
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 01:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C9BF2E80C8
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 01:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Aug 2018 01:44:01 -0000
From: Fabian Hemmer <1785734@bugs.launchpad.net>
Reply-To: Bug 1785734 <1785734@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153360624183.17489.10217918293787091045.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785734] [NEW] movdqu partial write at page
 boundary
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

In TCG mode, when a 16-byte write instruction (such as movdqu) is
executed at a page boundary and causes a page fault, a partial write is
executed in the first page. See the attached code for an example.

Tested on the qemu-3.0.0-rc1 release.

% gcc -m32 qemu-bug2.c && ./a.out && echo && qemu-i386 ./a.out
[snip]
page fault: addr=3D0x70001000 err=3D0x7
*(0x70000ff8+ 0) =3D aa
*(0x70000ff8+ 1) =3D aa
*(0x70000ff8+ 2) =3D aa
*(0x70000ff8+ 3) =3D aa
*(0x70000ff8+ 4) =3D aa
*(0x70000ff8+ 5) =3D aa
*(0x70000ff8+ 6) =3D aa
*(0x70000ff8+ 7) =3D aa
*(0x70000ff8+ 8) =3D 55
*(0x70000ff8+ 9) =3D 55
*(0x70000ff8+10) =3D 55
*(0x70000ff8+11) =3D 55
*(0x70000ff8+12) =3D 55
*(0x70000ff8+13) =3D 55
*(0x70000ff8+14) =3D 55
*(0x70000ff8+15) =3D 55

[snip]
page fault: addr=3D0x70001000 err=3D0x6
*(0x70000ff8+ 0) =3D 77
*(0x70000ff8+ 1) =3D 66
*(0x70000ff8+ 2) =3D 55
*(0x70000ff8+ 3) =3D 44
*(0x70000ff8+ 4) =3D 33
*(0x70000ff8+ 5) =3D 22
*(0x70000ff8+ 6) =3D 11
*(0x70000ff8+ 7) =3D 0
*(0x70000ff8+ 8) =3D 55
*(0x70000ff8+ 9) =3D 55
*(0x70000ff8+10) =3D 55
*(0x70000ff8+11) =3D 55
*(0x70000ff8+12) =3D 55
*(0x70000ff8+13) =3D 55
*(0x70000ff8+14) =3D 55
*(0x70000ff8+15) =3D 55

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu-bug2.c"
   https://bugs.launchpad.net/bugs/1785734/+attachment/5172358/+files/qemu-=
bug2.c

** Description changed:

  In TCG mode, when a 16-byte write instruction (such as movdqu) is
  executed at a page boundary and causes a page fault, a partial write is
  executed in the first page. See the attached code for an example.
  =

  Tested on the qemu-3.0.0-rc1 release.
  =

- =

  % gcc -m32 qemu-bug2.c && ./a.out && echo && qemu-i386 ./a.out
- *(0x70000ff8+ 0) =3D aa
- *(0x70000ff8+ 1) =3D aa
- *(0x70000ff8+ 2) =3D aa
- *(0x70000ff8+ 3) =3D aa
- *(0x70000ff8+ 4) =3D aa
- *(0x70000ff8+ 5) =3D aa
- *(0x70000ff8+ 6) =3D aa
- *(0x70000ff8+ 7) =3D aa
- *(0x70000ff8+ 8) =3D 55
- *(0x70000ff8+ 9) =3D 55
- *(0x70000ff8+10) =3D 55
- *(0x70000ff8+11) =3D 55
- *(0x70000ff8+12) =3D 55
- *(0x70000ff8+13) =3D 55
- *(0x70000ff8+14) =3D 55
- *(0x70000ff8+15) =3D 55
+ [snip]
  page fault: addr=3D0x70001000 err=3D0x7
  *(0x70000ff8+ 0) =3D aa
  *(0x70000ff8+ 1) =3D aa
  *(0x70000ff8+ 2) =3D aa
  *(0x70000ff8+ 3) =3D aa
  *(0x70000ff8+ 4) =3D aa
  *(0x70000ff8+ 5) =3D aa
  *(0x70000ff8+ 6) =3D aa
  *(0x70000ff8+ 7) =3D aa
  *(0x70000ff8+ 8) =3D 55
  *(0x70000ff8+ 9) =3D 55
  *(0x70000ff8+10) =3D 55
  *(0x70000ff8+11) =3D 55
  *(0x70000ff8+12) =3D 55
  *(0x70000ff8+13) =3D 55
  *(0x70000ff8+14) =3D 55
  *(0x70000ff8+15) =3D 55
  =

- *(0x70000ff8+ 0) =3D aa
- *(0x70000ff8+ 1) =3D aa
- *(0x70000ff8+ 2) =3D aa
- *(0x70000ff8+ 3) =3D aa
- *(0x70000ff8+ 4) =3D aa
- *(0x70000ff8+ 5) =3D aa
- *(0x70000ff8+ 6) =3D aa
- *(0x70000ff8+ 7) =3D aa
- *(0x70000ff8+ 8) =3D 55
- *(0x70000ff8+ 9) =3D 55
- *(0x70000ff8+10) =3D 55
- *(0x70000ff8+11) =3D 55
- *(0x70000ff8+12) =3D 55
- *(0x70000ff8+13) =3D 55
- *(0x70000ff8+14) =3D 55
- *(0x70000ff8+15) =3D 55
+ [snip]
  page fault: addr=3D0x70001000 err=3D0x6
  *(0x70000ff8+ 0) =3D 77
  *(0x70000ff8+ 1) =3D 66
  *(0x70000ff8+ 2) =3D 55
  *(0x70000ff8+ 3) =3D 44
  *(0x70000ff8+ 4) =3D 33
  *(0x70000ff8+ 5) =3D 22
  *(0x70000ff8+ 6) =3D 11
  *(0x70000ff8+ 7) =3D 0
  *(0x70000ff8+ 8) =3D 55
  *(0x70000ff8+ 9) =3D 55
  *(0x70000ff8+10) =3D 55
  *(0x70000ff8+11) =3D 55
  *(0x70000ff8+12) =3D 55
  *(0x70000ff8+13) =3D 55
  *(0x70000ff8+14) =3D 55
  *(0x70000ff8+15) =3D 55

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785734

Title:
  movdqu partial write at page boundary

Status in QEMU:
  New

Bug description:
  In TCG mode, when a 16-byte write instruction (such as movdqu) is
  executed at a page boundary and causes a page fault, a partial write
  is executed in the first page. See the attached code for an example.

  Tested on the qemu-3.0.0-rc1 release.

  % gcc -m32 qemu-bug2.c && ./a.out && echo && qemu-i386 ./a.out
  [snip]
  page fault: addr=3D0x70001000 err=3D0x7
  *(0x70000ff8+ 0) =3D aa
  *(0x70000ff8+ 1) =3D aa
  *(0x70000ff8+ 2) =3D aa
  *(0x70000ff8+ 3) =3D aa
  *(0x70000ff8+ 4) =3D aa
  *(0x70000ff8+ 5) =3D aa
  *(0x70000ff8+ 6) =3D aa
  *(0x70000ff8+ 7) =3D aa
  *(0x70000ff8+ 8) =3D 55
  *(0x70000ff8+ 9) =3D 55
  *(0x70000ff8+10) =3D 55
  *(0x70000ff8+11) =3D 55
  *(0x70000ff8+12) =3D 55
  *(0x70000ff8+13) =3D 55
  *(0x70000ff8+14) =3D 55
  *(0x70000ff8+15) =3D 55

  [snip]
  page fault: addr=3D0x70001000 err=3D0x6
  *(0x70000ff8+ 0) =3D 77
  *(0x70000ff8+ 1) =3D 66
  *(0x70000ff8+ 2) =3D 55
  *(0x70000ff8+ 3) =3D 44
  *(0x70000ff8+ 4) =3D 33
  *(0x70000ff8+ 5) =3D 22
  *(0x70000ff8+ 6) =3D 11
  *(0x70000ff8+ 7) =3D 0
  *(0x70000ff8+ 8) =3D 55
  *(0x70000ff8+ 9) =3D 55
  *(0x70000ff8+10) =3D 55
  *(0x70000ff8+11) =3D 55
  *(0x70000ff8+12) =3D 55
  *(0x70000ff8+13) =3D 55
  *(0x70000ff8+14) =3D 55
  *(0x70000ff8+15) =3D 55

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785734/+subscriptions
