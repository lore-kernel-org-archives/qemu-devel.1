Received: from eggs.gnu.org ([2001:4830:134:3::10]:54297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC2GA-0005Eu-Pt
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC2G6-0001cW-5t
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:41:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:39984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC2G5-0001bZ-Sg
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:41:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC2G3-0006kS-VE
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 11:41:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8F7B62E80E2
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 11:41:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 11:27:08 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1701798 <1701798@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149890819992.24827.8096984642709091835.malonedeb@soybean.canonical.com>
Message-Id: <151005402819.4619.12007855225787351637.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701798] Re: dynamically linked binaries crash
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

I just tested with powerpc and current head-of-git QEMU and it works:

e104462:xenial:bug-1701798$ cat hello.c
#include <stdio.h>
int main(void) {
    printf("hello world\n");
    return 0;
}
e104462:xenial:bug-1701798$ powerpc-linux-gnu-gcc-5 -O hello.c -o hello.pow=
erpc
e104462:xenial:bug-1701798$ QEMU_LD_PREFIX=3D/usr/powerpc-linux-gnu ~/linar=
o/qemu-from-laptop/qemu/build/all-linux-static/ppc-linux-user/qemu-ppc ./he=
llo.powerpc =

hello world

Similarly mips, sparc64, powerpc64, hppa, mips64 are fine.

m68k is known to be not working for real m68k currently (it's mostly a
coldfire target), so not surprising that that doesn't work.

s390x still crashes:
qemu-s390x: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate=
-all.c:189: tb_lock: Assertion `!have_tb_lock' failed.

So either we've fixed a bug here, or the problem is in your environment.

For s390, it looks like the guest is trying to use an insn we don't impleme=
nt:
#0  0x0000000060215018 in raise ()
#1  0x000000006021573a in abort ()
#2  0x0000000060079a96 in op_risbg (s=3D0x7fffffffda10, o=3D0x7fffffffd950)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c=
:3450
#3  0x0000000060082c8b in translate_one (env=3D0x627f0350, s=3D0x7fffffffda=
10)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c=
:5824
#4  0x0000000060082f3f in gen_intermediate_code (cs=3D0x627e80b0, =

    tb=3D0x60794d40 <static_code_gen_buffer+56064>)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/s390x/translate.c=
:5925
#5  0x00000000600369aa in tb_gen_code (cpu=3D0x627e80b0, pc=3D274886359240, =

    cs_base=3D0, flags=3D3, cflags=3D0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.=
c:1286
#6  0x00000000600343ff in tb_find (cpu=3D0x627e80b0, =

    last_tb=3D0x60794c00 <static_code_gen_buffer+55744>, tb_exit=3D0, cf_ma=
sk=3D0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:402
#7  0x0000000060034b36 in cpu_exec (cpu=3D0x627e80b0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:722
#8  0x000000006003ac78 in cpu_loop (env=3D0x627f0350)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:3255
---Type <return> to continue, or q <return> to quit---
#9  0x000000006003c68c in main (argc=3D2, argv=3D0x7fffffffe458, envp=3D0x7=
fffffffe470)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:4882

where the abort is in op_risbg() because s->fields->op2 is 0x59, which
we don't handle.

We then fail to correctly report that abort(), because linux-user has
never been very good with reporting signals caused by QEMU itself -- it
assumes signals including SIGABRT are due to the guest code and tries to
deliver them as guest signals, usually tripping itself up in the
process. We then run into the bug described in
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01506.html
which is why we get the have_tb_lock assertion.

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
