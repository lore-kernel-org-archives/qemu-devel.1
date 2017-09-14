Received: from eggs.gnu.org ([2001:4830:134:3::10]:51400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsZhf-0007N4-MW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsZhb-0003eS-Lg
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:21:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:39872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsZhb-0003e2-G1
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:21:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsZhX-0004dV-6I
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 19:21:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF5A32E84B7
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 19:21:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2017 19:06:41 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1716767 <1716767@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150524995294.5903.8871661765030368900.malonedeb@wampee.canonical.com>
	<150532784171.23106.17881126432658501179.malone@gac.canonical.com>
Message-Id: <f5c995a1-377d-b485-9fa1-3c37c09fcfc0@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1716767] Re: file(1) fails with "Invalid
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

On 09/13/2017 08:37 PM, James Clarke wrote:
> With the attached patch, qemu-sh4-static now works for file:

I can also confirm that the patch fixes the problem for me.

Would be great if it could get merged in one form or another.

-- =

 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

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
