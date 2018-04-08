Received: from eggs.gnu.org ([2001:4830:134:3::10]:44924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5BBQ-0003XO-Hw
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 10:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5BBN-0005mL-4L
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 10:20:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:57264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5BBM-0005ks-Pd
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 10:20:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5BBL-0005md-Ls
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 14:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 970082E80CB
	for <qemu-devel@nongnu.org>; Sun,  8 Apr 2018 14:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Apr 2018 14:13:49 -0000
From: =?utf-8?b?Q2lybyBTYW50aWxsaSDlha3lm5vkuovku7Yg5rOV6L2u5Yqf?=
	<ciro.santilli@gmail.com>
Reply-To: Bug 1762179 <1762179@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152319497960.30219.9338727401860906105.malonedeb@gac.canonical.com>
Message-Id: <152319683000.29311.14126523413893232101.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1762179] Re: Record and replay replay fails with:
 "ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

- QEMU master at 08e173f29461396575c85510eb41474b993cb1fb
+ QEMU master at 08e173f29461396575c85510eb41474b993cb1fb Ubuntu 17.10
+ host.
  =

  QEMU commands:
- =

  =

  ```
  #!/usr/bin/env bash
  cmd=3D"\
  time \
  ./out/x86_64/buildroot/host/usr/bin/qemu-system-x86_64 \
  -M pc \
  -append 'root=3D/dev/sda console=3DttyS0 nokaslr printk.time=3Dy - lkmc_e=
val=3D\"/rand_check.out;/sbin/ifup -a;wget -S google.com;/poweroff.out;\"' \
  -kernel 'out/x86_64/buildroot/images/bzImage' \
  -nographic \
  \
  -drive file=3Dout/x86_64/buildroot/images/rootfs.ext2.qcow2,if=3Dnone,id=
=3Dimg-direct,format=3Dqcow2 \
  -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay=
 \
  -device ide-hd,drive=3Dimg-blkreplay \
  \
  -netdev user,id=3Dnet1 \
  -device rtl8139,netdev=3Dnet1 \
  -object filter-replay,id=3Dreplay,netdev=3Dnet1 \
  "
  echo "$cmd"
  eval "$cmd -icount 'shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin'"
  eval "$cmd -icount 'shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin'"
  ```
  =

  Images uploaded to: https://github.com/cirosantilli/linux-kernel-module-
  cheat/releases/download/test-replay-arm/images4.zip
  =

  The replay failed straight out with:
  =

  ```
  ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed: (repla=
y_file && replay_mutex_locked())
  ```
  =

  Images generated with: https://github.com/cirosantilli/linux-kernel-
  module-cheat/tree/9513c162ef57e6cb70006dfe870856f94ee9a133
  =

  QEMU configure:
  =

  ```
  cd /home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/buil=
d/host-qemu-custom; PATH=3D"/home/ciro/bak/git/linux-kernel-module-cheat/ou=
t/x86_64/buildroot/host/bin:/home/ciro/bak/git/linux-kernel-modul
  e-cheat/out/x86_64/buildroot/host/sbin:./node_modules/.bin:/usr/local/her=
oku/bin:/home/ciro/android-sdk/platform-tools:/home/ciro/android-sdk/tools:=
/home/ciro/android-studio//bin:/home/ciro/android-sdk/ndk-bundl
  e:/home/ciro/android-sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/=
prebuilt/linux-x86_64/bin:/home/ciro/bak/git/devbin:/home/ciro/bin:/usr/loc=
al/texlive/2013/bin/x86_64-linux:/home/ciro/.rvm/gems/ruby-2.4.
  1/bin:/home/ciro/.rvm/gems/ruby-2.4.1@global/bin:/home/ciro/.rvm/rubies/r=
uby-2.4.1/bin:./node_modules/.bin:/usr/local/heroku/bin:/home/ciro/android-=
sdk/platform-tools:/home/ciro/android-sdk/tools:/home/ciro/andr
  oid-studio//bin:/home/ciro/android-sdk/ndk-bundle:/home/ciro/android-sdk/=
ndk-bundle/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:/=
home/ciro/bak/git/devbin:/home/ciro/bin:/usr/local/texlive/2013
  /bin/x86_64-linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin:/usr/games:/usr/local/games:/usr/bin:/snap/bin:/home/ciro/bak/git/lat=
ex:/home/ciro/.rvm/bin:/home/ciro/anaconda2/bin:/home/ciro/.cab
  al/bin:/bin:/home/ciro/.go/bin:/home/ciro/.local/bin/:/home/ciro/bak/git/=
runlinux:/usr/bin:/home/ciro/bak/git/latex:/home/ciro/.rvm/bin:/home/ciro/a=
naconda2/bin:/home/ciro/.cabal/bin:/bin:/home/ciro/.go/bin:/home/ciro/.loca=
l/bin/:/home/ciro/bak/git/runlinux" PKG_CONFIG=3D"/home/ciro/bak/git/linux-=
kernel-module-cheat/out/x86_64/buildroot/host/bin/pkg-config" PKG_CONFIG_SY=
SROOT_DIR=3D"/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=3D1 PKG_
  CONFIG_ALLOW_SYSTEM_LIBS=3D1 PKG_CONFIG_LIBDIR=3D"/home/ciro/bak/git/linu=
x-kernel-module-cheat/out/x86_64/buildroot/host/lib/pkgconfig:/home/ciro/ba=
k/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/share/pkg
  config" AR=3D"/usr/bin/ar" AS=3D"/usr/bin/as" LD=3D"/usr/bin/ld" NM=3D"/u=
sr/bin/nm" CC=3D"/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/bu=
ildroot/host/bin/ccache /usr/bin/gcc" GCC=3D"/home/ciro/bak/git/linux-kerne
  l-module-cheat/out/x86_64/buildroot/host/bin/ccache /usr/bin/gcc" CXX=3D"=
/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/bin/=
ccache /usr/bin/g++" CPP=3D"/usr/bin/cpp" OBJCOPY=3D"/usr/bin/objcopy
  " RANLIB=3D"/usr/bin/ranlib" CPPFLAGS=3D"-I/home/ciro/bak/git/linux-kerne=
l-module-cheat/out/x86_64/buildroot/host/include" CFLAGS=3D"-O2 -I/home/cir=
o/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/include
  " CXXFLAGS=3D"-O2 -I/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_=
64/buildroot/host/include" LDFLAGS=3D"-L/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host/lib -Wl,-rpath,/home/ciro/bak/g
  it/linux-kernel-module-cheat/out/x86_64/buildroot/host/lib" INTLTOOL_PERL=
=3D/usr/bin/perl CPP=3D"/home/ciro/bak/git/linux-kernel-module-cheat/out/x8=
6_64/buildroot/host/bin/ccache /usr/bin/gcc -E" ./configure --targe
  t-list=3D"x86_64-softmmu" --prefix=3D"/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host" --interp-prefix=3D/home/ciro/bak/git/l=
inux-kernel-module-cheat/out/x86_64/buildroot/host/x86_64-buildroot-l
  inux-uclibc/sysroot --cc=3D"/home/ciro/bak/git/linux-kernel-module-cheat/=
out/x86_64/buildroot/host/bin/ccache /usr/bin/gcc" --host-cc=3D"/home/ciro/=
bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/bin/cca
  che /usr/bin/gcc" --python=3D/home/ciro/bak/git/linux-kernel-module-cheat=
/out/x86_64/buildroot/host/bin/python2 --extra-cflags=3D"-O2 -I/home/ciro/b=
ak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/include"
-  --extra-ldflags=3D"-L/home/ciro/bak/git/linux-kernel-module-cheat/out/x8=
6_64/buildroot/host/lib -Wl,-rpath,/home/ciro/bak/git/linux-kernel-module-c=
heat/out/x86_64/buildroot/host/lib" --enable-debug --extra-cflags
+ =C2=A0--extra-ldflags=3D"-L/home/ciro/bak/git/linux-kernel-module-cheat/o=
ut/x86_64/buildroot/host/lib -Wl,-rpath,/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host/lib" --enable-debug --extra-cflags
  =3D-DDEBUG_PL061=3D1 --enable-trace-backends=3Dsimple --enable-sdl --with=
-sdlabi=3D2.0
  ```
- =

- QEMU build:
- =

- ```
- PATH=3D"/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot=
/host/bin:/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot=
/host/sbin:./node_modules/.bin:/usr/local/heroku/bin:/home/ciro/a
- ndroid-sdk/platform-tools:/home/ciro/android-sdk/tools:/home/ciro/android=
-studio//bin:/home/ciro/android-sdk/ndk-bundle:/home/ciro/android-sdk/ndk-b=
undle/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_6
- 4/bin:/home/ciro/bak/git/devbin:/home/ciro/bin:/usr/local/texlive/2013/bi=
n/x86_64-linux:/home/ciro/.rvm/gems/ruby-2.4.1/bin:/home/ciro/.rvm/gems/rub=
y-2.4.1@global/bin:/home/ciro/.rvm/rubies/ruby-2.4.1/bin:./node
- _modules/.bin:/usr/local/heroku/bin:/home/ciro/android-sdk/platform-tools=
:/home/ciro/android-sdk/tools:/home/ciro/android-studio//bin:/home/ciro/and=
roid-sdk/ndk-bundle:/home/ciro/android-sdk/ndk-bundle/toolchain
- s/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:/home/ciro/bak/git/=
devbin:/home/ciro/bin:/usr/local/texlive/2013/bin/x86_64-linux:/usr/local/s=
bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/us
- r/local/games:/usr/bin:/snap/bin:/home/ciro/bak/git/latex:/home/ciro/.rvm=
/bin:/home/ciro/anaconda2/bin:/home/ciro/.cabal/bin:/bin:/home/ciro/.go/bin=
:/home/ciro/.local/bin/:/home/ciro/bak/git/runlinux:/usr/bin:/h
- ome/ciro/bak/git/latex:/home/ciro/.rvm/bin:/home/ciro/anaconda2/bin:/home=
/ciro/.cabal/bin:/bin:/home/ciro/.go/bin:/home/ciro/.local/bin/:/home/ciro/=
bak/git/runlinux" PKG_CONFIG=3D"/home/ciro/bak/git/linux-kernel-m
- odule-cheat/out/x86_64/buildroot/host/bin/pkg-config" PKG_CONFIG_SYSROOT_=
DIR=3D"/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=3D1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=
=3D1 PKG_CONFIG_LIBDIR=3D"/home/ciro/bak/git/linux-kernel-module-cheat/ou
- t/x86_64/buildroot/host/lib/pkgconfig:/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host/share/pkgconfig" /usr/bin/make -j8 -C /=
home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroo
- t/build/host-qemu-custom
- ```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1762179

Title:
  Record and replay replay fails with: "ERROR:replay/replay-
  time.c:49:replay_read_clock: assertion failed"

Status in QEMU:
  New

Bug description:
  QEMU master at 08e173f29461396575c85510eb41474b993cb1fb Ubuntu 17.10
  host.

  QEMU commands:

  ```
  #!/usr/bin/env bash
  cmd=3D"\
  time \
  ./out/x86_64/buildroot/host/usr/bin/qemu-system-x86_64 \
  -M pc \
  -append 'root=3D/dev/sda console=3DttyS0 nokaslr printk.time=3Dy - lkmc_e=
val=3D\"/rand_check.out;/sbin/ifup -a;wget -S google.com;/poweroff.out;\"' \
  -kernel 'out/x86_64/buildroot/images/bzImage' \
  -nographic \
  \
  -drive file=3Dout/x86_64/buildroot/images/rootfs.ext2.qcow2,if=3Dnone,id=
=3Dimg-direct,format=3Dqcow2 \
  -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay=
 \
  -device ide-hd,drive=3Dimg-blkreplay \
  \
  -netdev user,id=3Dnet1 \
  -device rtl8139,netdev=3Dnet1 \
  -object filter-replay,id=3Dreplay,netdev=3Dnet1 \
  "
  echo "$cmd"
  eval "$cmd -icount 'shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin'"
  eval "$cmd -icount 'shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin'"
  ```

  Images uploaded to: https://github.com/cirosantilli/linux-kernel-
  module-cheat/releases/download/test-replay-arm/images4.zip

  The replay failed straight out with:

  ```
  ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed: (repla=
y_file && replay_mutex_locked())
  ```

  Images generated with: https://github.com/cirosantilli/linux-kernel-
  module-cheat/tree/9513c162ef57e6cb70006dfe870856f94ee9a133

  QEMU configure:

  ```
  cd /home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/buil=
d/host-qemu-custom; PATH=3D"/home/ciro/bak/git/linux-kernel-module-cheat/ou=
t/x86_64/buildroot/host/bin:/home/ciro/bak/git/linux-kernel-modul
  e-cheat/out/x86_64/buildroot/host/sbin:./node_modules/.bin:/usr/local/her=
oku/bin:/home/ciro/android-sdk/platform-tools:/home/ciro/android-sdk/tools:=
/home/ciro/android-studio//bin:/home/ciro/android-sdk/ndk-bundl
  e:/home/ciro/android-sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/=
prebuilt/linux-x86_64/bin:/home/ciro/bak/git/devbin:/home/ciro/bin:/usr/loc=
al/texlive/2013/bin/x86_64-linux:/home/ciro/.rvm/gems/ruby-2.4.
  1/bin:/home/ciro/.rvm/gems/ruby-2.4.1@global/bin:/home/ciro/.rvm/rubies/r=
uby-2.4.1/bin:./node_modules/.bin:/usr/local/heroku/bin:/home/ciro/android-=
sdk/platform-tools:/home/ciro/android-sdk/tools:/home/ciro/andr
  oid-studio//bin:/home/ciro/android-sdk/ndk-bundle:/home/ciro/android-sdk/=
ndk-bundle/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:/=
home/ciro/bak/git/devbin:/home/ciro/bin:/usr/local/texlive/2013
  /bin/x86_64-linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin:/usr/games:/usr/local/games:/usr/bin:/snap/bin:/home/ciro/bak/git/lat=
ex:/home/ciro/.rvm/bin:/home/ciro/anaconda2/bin:/home/ciro/.cab
  al/bin:/bin:/home/ciro/.go/bin:/home/ciro/.local/bin/:/home/ciro/bak/git/=
runlinux:/usr/bin:/home/ciro/bak/git/latex:/home/ciro/.rvm/bin:/home/ciro/a=
naconda2/bin:/home/ciro/.cabal/bin:/bin:/home/ciro/.go/bin:/home/ciro/.loca=
l/bin/:/home/ciro/bak/git/runlinux" PKG_CONFIG=3D"/home/ciro/bak/git/linux-=
kernel-module-cheat/out/x86_64/buildroot/host/bin/pkg-config" PKG_CONFIG_SY=
SROOT_DIR=3D"/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=3D1 PKG_
  CONFIG_ALLOW_SYSTEM_LIBS=3D1 PKG_CONFIG_LIBDIR=3D"/home/ciro/bak/git/linu=
x-kernel-module-cheat/out/x86_64/buildroot/host/lib/pkgconfig:/home/ciro/ba=
k/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/share/pkg
  config" AR=3D"/usr/bin/ar" AS=3D"/usr/bin/as" LD=3D"/usr/bin/ld" NM=3D"/u=
sr/bin/nm" CC=3D"/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/bu=
ildroot/host/bin/ccache /usr/bin/gcc" GCC=3D"/home/ciro/bak/git/linux-kerne
  l-module-cheat/out/x86_64/buildroot/host/bin/ccache /usr/bin/gcc" CXX=3D"=
/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/bin/=
ccache /usr/bin/g++" CPP=3D"/usr/bin/cpp" OBJCOPY=3D"/usr/bin/objcopy
  " RANLIB=3D"/usr/bin/ranlib" CPPFLAGS=3D"-I/home/ciro/bak/git/linux-kerne=
l-module-cheat/out/x86_64/buildroot/host/include" CFLAGS=3D"-O2 -I/home/cir=
o/bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/include
  " CXXFLAGS=3D"-O2 -I/home/ciro/bak/git/linux-kernel-module-cheat/out/x86_=
64/buildroot/host/include" LDFLAGS=3D"-L/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host/lib -Wl,-rpath,/home/ciro/bak/g
  it/linux-kernel-module-cheat/out/x86_64/buildroot/host/lib" INTLTOOL_PERL=
=3D/usr/bin/perl CPP=3D"/home/ciro/bak/git/linux-kernel-module-cheat/out/x8=
6_64/buildroot/host/bin/ccache /usr/bin/gcc -E" ./configure --targe
  t-list=3D"x86_64-softmmu" --prefix=3D"/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host" --interp-prefix=3D/home/ciro/bak/git/l=
inux-kernel-module-cheat/out/x86_64/buildroot/host/x86_64-buildroot-l
  inux-uclibc/sysroot --cc=3D"/home/ciro/bak/git/linux-kernel-module-cheat/=
out/x86_64/buildroot/host/bin/ccache /usr/bin/gcc" --host-cc=3D"/home/ciro/=
bak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/bin/cca
  che /usr/bin/gcc" --python=3D/home/ciro/bak/git/linux-kernel-module-cheat=
/out/x86_64/buildroot/host/bin/python2 --extra-cflags=3D"-O2 -I/home/ciro/b=
ak/git/linux-kernel-module-cheat/out/x86_64/buildroot/host/include"
  =C2=A0--extra-ldflags=3D"-L/home/ciro/bak/git/linux-kernel-module-cheat/o=
ut/x86_64/buildroot/host/lib -Wl,-rpath,/home/ciro/bak/git/linux-kernel-mod=
ule-cheat/out/x86_64/buildroot/host/lib" --enable-debug --extra-cflags
  =3D-DDEBUG_PL061=3D1 --enable-trace-backends=3Dsimple --enable-sdl --with=
-sdlabi=3D2.0
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1762179/+subscriptions
