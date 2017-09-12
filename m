Received: from eggs.gnu.org ([2001:4830:134:3::10]:58181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drtEy-0004BC-NF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drtEw-0007tA-0v
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:01:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:59985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drtEv-0007sg-Rx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drtEu-0003Pe-6R
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 22:01:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2F7F62E8492
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 22:01:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Sep 2017 21:47:20 -0000
From: James Clarke <jrtc27@jrtc27.com>
Reply-To: Bug 1716767 <1716767@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150524995294.5903.8871661765030368900.malonedeb@wampee.canonical.com>
Message-Id: <150525284073.29079.14299492241937433886.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716767] Re: file(1) fails with "Invalid
 argument" on qemu-sh4-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I just ran it myself inside and outside the sh4 chroot. The logging
output is the same, with the exception of the final line. Something is
happening once it's decided it's elf; looking at file_tryelf, my guess
is the fstat call is failing[0].

[0] http://sources.debian.net/src/file/1:5.31-1/src/readelf.c/#L1609

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716767

Title:
  file(1) fails with "Invalid argument" on qemu-sh4-user

Status in QEMU:
  New

Bug description:
  We recently discovered that file(1) fails on qemu-sh4-user when
  running on an ELF file:

  (sid_sh4)root@vs94:/# file /bin/bash
  /bin/bash: ERROR: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV)=
 error reading (Invalid argument)
  (sid_sh4)root@vs94:/#

  Running with "-d" yields more output:

  (sid_sh4)root@vs94:/# file -d /bin/bash 2>&1 | tail
  322: >> 7 byte&,=3D97,"(ARM)"]
  0 =3D=3D 97 =3D 0
  mget(type=3D1, flag=3D0, offset=3D7, o=3D0, nbytes=3D863324, il=3D0, nc=
=3D1)
  mget/96 @7: \000\000\000\000\000\000\000\000\000\002\000*\000\001\000\000=
\000\250\317A\0004\000\000\000L(\r\000\027\000\000\0004\000 \000\n\000(\000=
\032\000\031\000\006\000\000\0004\000\000\0004\000@\0004\000@\000@\001\000\=
000@\001\000\000\005\000\000\000\004\000\000\000\003\000\000\000t\001\000\0=
00t\001@\000t\001@\000\023\000\000

  323: >> 7 byte&,=3D-1,"(embedded)"]
  0 =3D=3D 18446744073709551615 =3D 0
  [try softmagic 1]
  [try elf -1]
  /bin/bash: ERROR: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV)=
 error reading (Invalid argument)
  (sid_sh4)root@vs94:/#

  It seems that the comparison above has a bogus (overflown?) value.

  On actual hardware, it works:

  root@tirpitz:~> file /bin/bash
  /bin/bash: ELF 32-bit LSB executable, Renesas SH, version 1 (SYSV), dynam=
ically linked, interpreter /lib/ld-linux.so.2, BuildID[sha1]=3D4dd0e4281755=
827d8bb6686fd481f8c80ea73e9a, for GNU/Linux 3.2.0, stripped
  root@tirpitz:~>

  I have uploaded a chroot with Debian unstable which allows to
  reproduce the issue:

  > https://people.debian.org/~glaubitz/sid-sh4-sbuild.tar.gz

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716767/+subscriptions
