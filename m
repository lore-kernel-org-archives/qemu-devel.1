Received: from eggs.gnu.org ([209.51.188.92]:40295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkX7o-0008Gz-Ij
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkX7n-0001HO-PX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:36:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:55904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gkX7n-0001E6-Jl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:36:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gkX7k-0006Si-NU
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 16:36:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3729E2E81C4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 16:36:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jan 2019 16:27:08 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1810433 <1810433@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154653873624.24628.7091357257162393259.malonedeb@gac.canonical.com>
Message-Id: <154782882878.1892.7539466562187353630.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810433] Re: aarch64-linux-user master:
 inconsistent pwrite behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit now in QEMU master as 2bd3f8998e1e7dcd9afc29fab25. This will be
in the next release: QEMU 4.0.


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810433

Title:
  aarch64-linux-user master: inconsistent pwrite behaviour

Status in QEMU:
  Fix Committed

Bug description:
  Hello,

  I am running aarch64-linux-user from master, commit
  20d6c7312f1b812bb9c750f4087f69ac8485cc90

  And I've found the following inconsistent emulation of pwrite() call when=
 buf=3D=3DNULL and len=3D0.
  Minimal reproducible sample is the following:

  #define _GNU_SOURCE
  #include <stdlib.h>
  #include <stdio.h>
  #include <unistd.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <string.h>

  /*
  =C2=A0System                  | Result
  -------------------------+----------------
  =C2=A0Native x86_64 4.12.14   | pwrite ret =3D 0
  =C2=A0Native aarch64 4.4.159  | pwrite ret =3D 0
  =C2=A0qemu-aarch64 at x86_64  | pwrite ret =3D -1
  =C2=A0=C2=A0=C2=A0( 20d6c7312f1b8 )     |
  */

  int main(int argc, char** argv) {
  =C2=A0int fd =3D open("test.dat", O_CREAT | O_RDWR, 0644);
  =C2=A0if (fd < 0) {
  =C2=A0=C2=A0perror("open");
  =C2=A0=C2=A0return 1;
  =C2=A0}

  =C2=A0int ret =3D fallocate(fd, 0, 0, 1000);
  =C2=A0if (ret < 0) {
  =C2=A0=C2=A0perror("fallocate");
  =C2=A0=C2=A0return 1;
  =C2=A0}

  =C2=A0ssize_t ret_pwrite =3D pwrite(fd, NULL, 0, 0);
  =C2=A0printf("pwrite ret =3D %ld\n", ret_pwrite);

  =C2=A0close(fd);

  =C2=A0return 0;
  }

  =

  Please note, that the same binary executable prints different output at n=
ative aarch64 platform and under aarch64-linux-user

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810433/+subscriptions
