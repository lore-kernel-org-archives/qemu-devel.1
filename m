Received: from eggs.gnu.org ([2001:4830:134:3::10]:59475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRGc7-0007SN-GD
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 07:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRGc2-00064a-Mi
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 07:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:52184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRGc2-00063b-A6
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 07:30:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRGby-0006GG-8B
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 11:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 34E842E8195
	for <qemu-devel@nongnu.org>; Sat,  1 Jul 2017 11:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Jul 2017 11:23:19 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701798 <1701798@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149890819992.24827.8096984642709091835.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701798] [NEW] dynamically linked binaries crash
 for big-endian targets
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

On the targets
  hppa
  m68k
  mips
  mips64
  powerpc
  powerpc64
  s390x
  sparc64
dynamically linked binaries crash, but statically linked binaries work.
On the targets
  aarch64
  alpha
  armhf
  powerpc64le
  sh4
both dynamically linked and statically linked binaries work.

How to reproduce:

1) On Ubuntu 16.04, install the packages
g++-5-aarch64-linux-gnu
g++-5-alpha-linux-gnu
g++-5-arm-linux-gnueabihf
g++-5-hppa-linux-gnu
g++-5-m68k-linux-gnu
g++-5-mips-linux-gnu
g++-5-mips64-linux-gnuabi64
g++-5-powerpc-linux-gnu
g++-5-powerpc64-linux-gnu
g++-5-powerpc64le-linux-gnu
g++-5-s390x-linux-gnu
g++-5-sh4-linux-gnu
g++-5-sparc64-linux-gnu

2) Install qemu 2.9.0 from source (for m68k, use the 2.7.0-m68k
code from https://github.com/vivier/qemu-m68k.git):
$ ../configure --prefix=3D/home/bruno/inst-qemu/2.9.0 --target-list=3Daarch=
64-softmmu,alpha-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu=
,mipsel-softmmu,mips64-softmmu,mips64el-softmmu,ppc-softmmu,ppc64-softmmu,s=
390x-softmmu,sh4-softmmu,sparc-softmmu,sparc64-softmmu,x86_64-softmmu,aarch=
64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,m68k-linux-us=
er,mips-linux-user,mipsel-linux-user,mips64-linux-user,mips64el-linux-user,=
ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,s390x-linux-user,sh4-lin=
ux-user,sparc-linux-user,sparc64-linux-user --disable-strip --disable-werro=
r --enable-gtk --enable-vnc
$ make
$ make install

3) Cross-compile the programs:

$ aarch64-linux-gnu-gcc-5 -O hello.c -o hello.aarch64
$ alpha-linux-gnu-gcc-5 -O hello.c -o hello.alpha
$ arm-linux-gnueabihf-gcc-5 -O hello.c -o hello.armhf
$ hppa-linux-gnu-gcc-5 -O hello.c -o hello.hppa
$ m68k-linux-gnu-gcc-5 -O hello.c -o hello.m68k
$ mips-linux-gnu-gcc-5 -O hello.c -o hello.mips
$ mips64-linux-gnuabi64-gcc-5 -O hello.c -o hello.mips64
$ powerpc-linux-gnu-gcc-5 -O hello.c -o hello.powerpc
$ powerpc64-linux-gnu-gcc-5 -O hello.c -o hello.powerpc64
$ powerpc64le-linux-gnu-gcc-5 -O hello.c -o hello.powerpc64le
$ s390x-linux-gnu-gcc-5 -O hello.c -o hello.s390x
$ sh4-linux-gnu-gcc-5 -O hello.c -o hello.sh4
$ sparc64-linux-gnu-gcc-5 -O hello.c -o hello.sparc64

4) Run the programs:

* aarch64 works:
$ QEMU_LD_PREFIX=3D/usr/aarch64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-aarch6=
4 hello.aarch64
Hello world

* alpha works:
$ QEMU_LD_PREFIX=3D/usr/alpha-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-alpha he=
llo.alpha =

Hello world

* armhf works:
$ QEMU_LD_PREFIX=3D/usr/arm-linux-gnueabihf ~/inst-qemu/2.9.0/bin/qemu-arm =
hello.armhf
Hello world

* powerpc64le works:
$ QEMU_LD_PREFIX=3D/usr/powerpc64le-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-pp=
c64le hello.powerpc64le
Hello world

* sh4 works:
$ QEMU_LD_PREFIX=3D/usr/sh4-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-sh4 hello.=
sh4
Hello world

* =3D=3D=3D=3D=3D sparc64 does not work:
$ QEMU_LD_PREFIX=3D/usr/sparc64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-sparc6=
4 hello.sparc64
Segmentation fault (core dumped)

When I copy the file to a machine with `uname -srm` =3D "Linux 4.5.0-2-spar=
c64 sparc64",
it works:
$ ./hello.sparc64
Hello world

When I copy the file and its execution environment /usr/sparc64-linux-gnu t=
o the
same machine and run the binary in a chroot environment:
# /bin/hello.sparc64 =

Hello world

* =3D=3D=3D=3D=3D mips does not work:
$ QEMU_LD_PREFIX=3D/usr/mips-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-mips hell=
o.mips
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

When I copy the file to a machine with `uname -srm` =3D "Linux 3.16.0-4-4kc=
-malta mips",
it works:
$ ./hello.mips
Hello world

When I copy the file and its execution environment /usr/mips-linux-gnu to t=
he
same machine and run the binary in a chroot environment:
# /bin/hello.mips =

Hello world

* =3D=3D=3D=3D=3D mips64 does not work:
$ QEMU_LD_PREFIX=3D/usr/mips64-linux-gnuabi64 ~/inst-qemu/2.9.0/bin/qemu-mi=
ps64 hello.mips64
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

When I copy the file to a machine with `uname -srm` =3D "Linux 3.16.0-4-5kc=
-malta mips64",
it works:
$ ./hello.mips64
Hello world

* =3D=3D=3D=3D=3D powerpc does not work:
$ QEMU_LD_PREFIX=3D/usr/powerpc-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-ppc he=
llo.powerpc
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

When I copy the file to a machine with `uname -srm` =3D "Linux 3.17.2-200.f=
c20.ppc64p7 ppc64",
it works:
$ ./hello.powerpc
Hello world

* =3D=3D=3D=3D=3D powerpc64 does not work:
$ QEMU_LD_PREFIX=3D/usr/powerpc64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-ppc6=
4 hello.powerpc64
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

When I copy the file to a machine with `uname -srm` =3D "Linux 3.17.2-200.f=
c20.ppc64p7 ppc64",
it works:
$ ./hello.powerpc64
Hello world

* =3D=3D=3D=3D=3D s390x does not work:
$ QEMU_LD_PREFIX=3D/usr/s390x-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-s390x he=
llo.s390x
<hangs>
$ QEMU_LD_PREFIX=3D/usr/s390x-linux-gnu ~/inst-qemu/2.8.1/bin/qemu-s390x he=
llo.s390x
qemu-s390x: /media/develdata/devel/build/qemu-2.8.1/translate-all.c:175: tb=
_lock: Assertion `!have_tb_lock' failed.
Segmentation fault (core dumped)

When I copy the file to a machine with `uname -srm` =3D "Linux 3.16.0-4-s39=
0x s390x",
it works:
$ ./hello.s390x
Hello world

* =3D=3D=3D=3D=3D hppa does not work:
$ QEMU_LD_PREFIX=3D/usr/hppa-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-hppa hell=
o.hppa
Segmentation fault (core dumped)

* =3D=3D=3D=3D=3D m68k does not work:
$ QEMU_LD_PREFIX=3D/usr/m68k-linux-gnu QEMU_CPU=3Dm68020 ~/inst-qemu/2.9.0/=
bin/qemu-m68k hello.m68k
qemu: uncaught target signal 4 (Illegal instruction) - core dumped
$ QEMU_LD_PREFIX=3D/usr/m68k-linux-gnu QEMU_CPU=3Dm68020 ~/inst-qemu/2.7.0-=
m68k/bin/qemu-m68k hello.m68k
qemu: uncaught target signal 11 (Segmentation fault) - core dumped


The set of targets where it does not work is exactly the big-endian targets.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701798

Title:
  dynamically linked binaries crash for big-endian targets

Status in QEMU:
  New

Bug description:
  On the targets
    hppa
    m68k
    mips
    mips64
    powerpc
    powerpc64
    s390x
    sparc64
  dynamically linked binaries crash, but statically linked binaries work.
  On the targets
    aarch64
    alpha
    armhf
    powerpc64le
    sh4
  both dynamically linked and statically linked binaries work.

  How to reproduce:

  1) On Ubuntu 16.04, install the packages
  g++-5-aarch64-linux-gnu
  g++-5-alpha-linux-gnu
  g++-5-arm-linux-gnueabihf
  g++-5-hppa-linux-gnu
  g++-5-m68k-linux-gnu
  g++-5-mips-linux-gnu
  g++-5-mips64-linux-gnuabi64
  g++-5-powerpc-linux-gnu
  g++-5-powerpc64-linux-gnu
  g++-5-powerpc64le-linux-gnu
  g++-5-s390x-linux-gnu
  g++-5-sh4-linux-gnu
  g++-5-sparc64-linux-gnu

  2) Install qemu 2.9.0 from source (for m68k, use the 2.7.0-m68k
  code from https://github.com/vivier/qemu-m68k.git):
  $ ../configure --prefix=3D/home/bruno/inst-qemu/2.9.0 --target-list=3Daar=
ch64-softmmu,alpha-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softm=
mu,mipsel-softmmu,mips64-softmmu,mips64el-softmmu,ppc-softmmu,ppc64-softmmu=
,s390x-softmmu,sh4-softmmu,sparc-softmmu,sparc64-softmmu,x86_64-softmmu,aar=
ch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,m68k-linux-=
user,mips-linux-user,mipsel-linux-user,mips64-linux-user,mips64el-linux-use=
r,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,s390x-linux-user,sh4-l=
inux-user,sparc-linux-user,sparc64-linux-user --disable-strip --disable-wer=
ror --enable-gtk --enable-vnc
  $ make
  $ make install

  3) Cross-compile the programs:

  $ aarch64-linux-gnu-gcc-5 -O hello.c -o hello.aarch64
  $ alpha-linux-gnu-gcc-5 -O hello.c -o hello.alpha
  $ arm-linux-gnueabihf-gcc-5 -O hello.c -o hello.armhf
  $ hppa-linux-gnu-gcc-5 -O hello.c -o hello.hppa
  $ m68k-linux-gnu-gcc-5 -O hello.c -o hello.m68k
  $ mips-linux-gnu-gcc-5 -O hello.c -o hello.mips
  $ mips64-linux-gnuabi64-gcc-5 -O hello.c -o hello.mips64
  $ powerpc-linux-gnu-gcc-5 -O hello.c -o hello.powerpc
  $ powerpc64-linux-gnu-gcc-5 -O hello.c -o hello.powerpc64
  $ powerpc64le-linux-gnu-gcc-5 -O hello.c -o hello.powerpc64le
  $ s390x-linux-gnu-gcc-5 -O hello.c -o hello.s390x
  $ sh4-linux-gnu-gcc-5 -O hello.c -o hello.sh4
  $ sparc64-linux-gnu-gcc-5 -O hello.c -o hello.sparc64

  4) Run the programs:

  * aarch64 works:
  $ QEMU_LD_PREFIX=3D/usr/aarch64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-aarc=
h64 hello.aarch64
  Hello world

  * alpha works:
  $ QEMU_LD_PREFIX=3D/usr/alpha-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-alpha =
hello.alpha =

  Hello world

  * armhf works:
  $ QEMU_LD_PREFIX=3D/usr/arm-linux-gnueabihf ~/inst-qemu/2.9.0/bin/qemu-ar=
m hello.armhf
  Hello world

  * powerpc64le works:
  $ QEMU_LD_PREFIX=3D/usr/powerpc64le-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-=
ppc64le hello.powerpc64le
  Hello world

  * sh4 works:
  $ QEMU_LD_PREFIX=3D/usr/sh4-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-sh4 hell=
o.sh4
  Hello world

  * =3D=3D=3D=3D=3D sparc64 does not work:
  $ QEMU_LD_PREFIX=3D/usr/sparc64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-spar=
c64 hello.sparc64
  Segmentation fault (core dumped)

  When I copy the file to a machine with `uname -srm` =3D "Linux 4.5.0-2-sp=
arc64 sparc64",
  it works:
  $ ./hello.sparc64
  Hello world

  When I copy the file and its execution environment /usr/sparc64-linux-gnu=
 to the
  same machine and run the binary in a chroot environment:
  # /bin/hello.sparc64 =

  Hello world

  * =3D=3D=3D=3D=3D mips does not work:
  $ QEMU_LD_PREFIX=3D/usr/mips-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-mips he=
llo.mips
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  When I copy the file to a machine with `uname -srm` =3D "Linux 3.16.0-4-4=
kc-malta mips",
  it works:
  $ ./hello.mips
  Hello world

  When I copy the file and its execution environment /usr/mips-linux-gnu to=
 the
  same machine and run the binary in a chroot environment:
  # /bin/hello.mips =

  Hello world

  * =3D=3D=3D=3D=3D mips64 does not work:
  $ QEMU_LD_PREFIX=3D/usr/mips64-linux-gnuabi64 ~/inst-qemu/2.9.0/bin/qemu-=
mips64 hello.mips64
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  When I copy the file to a machine with `uname -srm` =3D "Linux 3.16.0-4-5=
kc-malta mips64",
  it works:
  $ ./hello.mips64
  Hello world

  * =3D=3D=3D=3D=3D powerpc does not work:
  $ QEMU_LD_PREFIX=3D/usr/powerpc-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-ppc =
hello.powerpc
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  When I copy the file to a machine with `uname -srm` =3D "Linux 3.17.2-200=
.fc20.ppc64p7 ppc64",
  it works:
  $ ./hello.powerpc
  Hello world

  * =3D=3D=3D=3D=3D powerpc64 does not work:
  $ QEMU_LD_PREFIX=3D/usr/powerpc64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-pp=
c64 hello.powerpc64
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  When I copy the file to a machine with `uname -srm` =3D "Linux 3.17.2-200=
.fc20.ppc64p7 ppc64",
  it works:
  $ ./hello.powerpc64
  Hello world

  * =3D=3D=3D=3D=3D s390x does not work:
  $ QEMU_LD_PREFIX=3D/usr/s390x-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-s390x =
hello.s390x
  <hangs>
  $ QEMU_LD_PREFIX=3D/usr/s390x-linux-gnu ~/inst-qemu/2.8.1/bin/qemu-s390x =
hello.s390x
  qemu-s390x: /media/develdata/devel/build/qemu-2.8.1/translate-all.c:175: =
tb_lock: Assertion `!have_tb_lock' failed.
  Segmentation fault (core dumped)

  When I copy the file to a machine with `uname -srm` =3D "Linux 3.16.0-4-s=
390x s390x",
  it works:
  $ ./hello.s390x
  Hello world

  * =3D=3D=3D=3D=3D hppa does not work:
  $ QEMU_LD_PREFIX=3D/usr/hppa-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-hppa he=
llo.hppa
  Segmentation fault (core dumped)

  * =3D=3D=3D=3D=3D m68k does not work:
  $ QEMU_LD_PREFIX=3D/usr/m68k-linux-gnu QEMU_CPU=3Dm68020 ~/inst-qemu/2.9.=
0/bin/qemu-m68k hello.m68k
  qemu: uncaught target signal 4 (Illegal instruction) - core dumped
  $ QEMU_LD_PREFIX=3D/usr/m68k-linux-gnu QEMU_CPU=3Dm68020 ~/inst-qemu/2.7.=
0-m68k/bin/qemu-m68k hello.m68k
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

  =

  The set of targets where it does not work is exactly the big-endian targe=
ts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701798/+subscriptions
