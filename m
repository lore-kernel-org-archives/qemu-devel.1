Received: from eggs.gnu.org ([2001:4830:134:3::10]:42525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsn1-0007eP-BJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsmw-0006TL-9t
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:24:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:55314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsmw-0006Rh-3Q
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:24:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsmu-0005Qy-3k
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:24:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0FF642E80D3
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:24:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:15:21 -0000
From: Thomas Huth <1617929@bugs.launchpad.net>
Reply-To: Bug 1617929 <1617929@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160829083959.18113.76446.malonedeb@chaenomeles.canonical.com>
Message-Id: <151335452236.16551.1920302836073419810.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1617929] Re: qemu hangs in pselect syscall
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
https://bugs.launchpad.net/bugs/1617929

Title:
  qemu hangs in pselect syscall

Status in QEMU:
  Fix Released

Bug description:
  I'm using git commit d75aa4372f0414c9960534026a562b0302fcff29 (v2.7.0-rc4=
) configured with;
      --enable-linux-user \
      --disable-system \
      --disable-tools \
      --disable-guest-agent \
      --static --disable-linux-aio \
      --disable-fdt \
      --without-pixman \
      --disable-blobs \
  Stable version (v2.6.0) also have the same problem.

  In a chroot environment I ran below command-line to compile some things, =
different sources each time.
      /usr/bin/qemu-arm -0 /usr/bin/edje_cc /usr/bin/edje_cc -id /home/abui=
ld/rpmbuild/BUILD/org.tizen.browser-1.6.2/services/SimpleUI/images_mob/ -DB=
ROWSER_RESOLUTION_720x1280=3D1 -DPROFILE_MOBILE=3D1 /home/abuild/rpmbuild/B=
UILD/org.tizen.browser-1.6.2/services/SimpleUI/edc/TextPopup_mob.edc /home/=
abuild/rpmbuild/BUILD/org.tizen.browser-1.6.2/build-tizen/services/SimpleUI=
/720x1280_TextPopup.edj

  Here is back trace with gdb;
  #0  safe_syscall_end () at /usr/src/debug/qemu-2.6.94/linux-user/host/i38=
6/safe-syscall.inc.S:78
  #1  0x60049370 in safe_pselect6 (nfds=3D10, readfds=3D0xffa31b5c, writefd=
s=3D0xffa31bdc, exceptfds=3D0xffa31c5c, timeout=3D0x0, sig=3D0x0)
      at /usr/src/debug/qemu-2.6.94/linux-user/syscall.c:855
  #2  0x6004b2fe in do_select (n=3D10, rfd_addr=3D1082122232, wfd_addr=3D10=
82122360, efd_addr=3D1082122488, target_tv_addr=3D0)
      at /usr/src/debug/qemu-2.6.94/linux-user/syscall.c:1386
  #3  0x6005e5ba in do_syscall (cpu_env=3D0x640d0454, num=3D142, arg1=3D10,=
 arg2=3D1082122232, arg3=3D1082122360, arg4=3D1082122488, arg5=3D0, arg6=3D=
1087473216, arg7=3D0, =

      arg8=3D0) at /usr/src/debug/qemu-2.6.94/linux-user/syscall.c:9690
  #4  0x60045def in cpu_loop (env=3D0x640d0454) at /usr/src/debug/qemu-2.6.=
94/linux-user/main.c:876
  #5  0x60047640 in main (argc=3D10, argv=3D0xffa33c84, envp=3D0xffa33cb0) =
at /usr/src/debug/qemu-2.6.94/linux-user/main.c:4817

  Attached core file taken from gdb. To see the stack frame, you could try; =

  $ tar -xf reproduced_118_04.tar.bz2; gdb --core core.1823 qemu-arm

  And recent strace log for PID 1823(stucked one);
  79965 [  313s] 1823 :0x8e _newselect(10,[9,3,],[],[],NULL)
  79966 [  313s]  =3D=3D>[pselect6(0xa)=3D]
  79967 [  313s]  [pselect6=3D0x1]<=3D=3D
  79968 [  313s] 1823 :0x8e _newselect(10,[9,],[],[],NULL)
  79969 [  313s] 1823 :0x8e =3D>  =3D 0x00000001 ([9,],[],[],NULL)
  79970 [  313s] 1823 :0xfc epoll_wait(3,1082121456,32,0,1082121456,3)
  79971 [  313s] 1823 :0xfc epoll_wait(3,1082121456,32,0,1082121456,3)
  79972 [  313s] 1823 :0xfc =3D>  =3D 0
  79973 [  313s] 1823 :0x3 read(9,0x407fdeec,16)
  79974 [  313s] 1823 :0x3 read(9,0x407fdeec,16)
  79975 [  313s] 1823 :0x3 =3D>  =3D 8
  79976 [  313s] 1823 :0x107 clock_gettime(1,1082122120,0,1082829144,108282=
7588,0)
  79977 [  313s] 1823 :0x107 clock_gettime(1,1082122120,0,1082829144,108282=
7588,0)
  79978 [  313s] 1823 :0x107 =3D>  =3D 0
  79979 [  313s] 1823 :0x8e _newselect(10,[9,3,],[],[],NULL)
  79980 [  313s]  =3D=3D>[pselect6(0xa)=3D]

  I'm using 64-bit Ubuntu with kernel release Linux 3.19.0-25-generic #26~1=
4.04.1-Ubuntu.
  Reproducibility is low. One occurrence out of 50+ trials.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1617929/+subscriptions
