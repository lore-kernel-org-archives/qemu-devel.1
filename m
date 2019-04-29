Received: from eggs.gnu.org ([209.51.188.92]:46712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLAQR-0004Wz-7v
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLAQQ-0002lU-1p
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:50:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:33528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hLAQP-0002lA-RR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:50:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hLAQM-00021q-CK
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 17:50:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EC6062E80E2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 17:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2019 17:38:23 -0000
From: Ben Wibking <1818937@bugs.launchpad.net>
Reply-To: Bug 1818937 <1818937@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155192472106.28960.15645485731508389788.malonedeb@chaenomeles.canonical.com>
Message-Id: <155655950451.13953.11840871425905318524.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818937] Re: Crash with HV_ERROR on macOS host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I can reproduce this by booting the Windows 10 x64 install ISO with the
command line:

+ WINIMG=3DWin10.iso
+ VIRTIMG=3Dvirtio-win-0.1.164.iso
+ qemu-system-x86_64 -accel hvf -drive driver=3Draw,file=3DWin10.img,if=3Dv=
irtio -m 1536 -net nic,model=3Dvirtio -net user -cdrom Win10.iso -drive fil=
e=3Dvirtio-win-0.1.164.iso,index=3D3,media=3Dcdrom -rtc base=3Dlocaltime,cl=
ock=3Dhost -smp cores=3D2 -usb -device usb-tablet -net user
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
80000001H:ECX.svm [bit 2]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
80000001H:ECX.svm [bit 2]
Unimplemented handler (fffff80641601c38) for 0 (f 11) =

Unimplemented handler (fffff8064160192f) for 0 (f 7f) =

qemu-system-x86_64: Error: HV_ERROR
./qemu-boot.sh: line 20: 32294 Abort trap: 6           qemu-system-x86_64 -=
accel hvf -drive driver=3Draw,file=3DWin10.img,if=3Dvirtio -m 1536 -net nic=
,model=3Dvirtio -net user -cdrom ${WINIMG} -drive file=3D${VIRTIMG},index=
=3D3,media=3Dcdrom -rtc base=3Dlocaltime,clock=3Dhost -smp cores=3D2 -usb -=
device usb-tablet -net user

** Attachment added: "Crash log"
   https://bugs.launchpad.net/qemu/+bug/1818937/+attachment/5260023/+files/=
crash_log.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818937

Title:
  Crash with HV_ERROR on macOS host

Status in QEMU:
  New

Bug description:
  On macOS host running Windows 10 guest, qemu crashed with error
  message: Error: HV_ERROR.

  Host: macOS Mojave 10.14.3 (18D109) Late 2014 Mac mini presumably Core i5=
 4278U.
  QEMU: git commit a3e3b0a7bd5de211a62cdf2d6c12b96d3c403560
  QEMU parameter: qemu-system-x86_64 -m 3000 -drive file=3Ddisk.img,if=3Dvi=
rtio,discard=3Dunmap -accel hvf -soundhw hda -smp 3

  thread list
  Process 56054 stopped
    thread #1: tid =3D 0x2ffec8, 0x00007fff48d0805a vImage`vLookupTable_Pla=
nar16 + 970, queue =3D 'com.apple.main-thread'
    thread #2: tid =3D 0x2ffecc, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #3: tid =3D 0x2ffecd, 0x00007fff79d715aa libsystem_kernel.dylib`=
__select + 10
    thread #4: tid =3D 0x2ffece, 0x00007fff79d71d9a libsystem_kernel.dylib`=
__sigwait + 10
  * thread #6: tid =3D 0x2ffed0, 0x00007fff79d7023e libsystem_kernel.dylib`=
__pthread_kill + 10, stop reason =3D signal SIGABRT
    thread #7: tid =3D 0x2ffed1, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #8: tid =3D 0x2ffed2, 0x00007fff79d6d7de libsystem_kernel.dylib`=
__psynch_cvwait + 10
    thread #11: tid =3D 0x2fff34, 0x00007fff79d6a17a libsystem_kernel.dylib=
`mach_msg_trap + 10, name =3D 'com.apple.NSEventThread'
    thread #30: tid =3D 0x300c04, 0x00007fff79e233f8 libsystem_pthread.dyli=
b`start_wqthread
    thread #31: tid =3D 0x300c16, 0x00007fff79e233f8 libsystem_pthread.dyli=
b`start_wqthread
    thread #32: tid =3D 0x300c17, 0x0000000000000000
    thread #33: tid =3D 0x300c93, 0x00007fff79d6d7de libsystem_kernel.dylib=
`__psynch_cvwait + 10

  =

  Crashed thread:

  * thread #6, stop reason =3D signal SIGABRT
    * frame #0: 0x00007fff79d7023e libsystem_kernel.dylib`__pthread_kill + =
10
      frame #1: 0x00007fff79e26c1c libsystem_pthread.dylib`pthread_kill + 2=
85
      frame #2: 0x00007fff79cd91c9 libsystem_c.dylib`abort + 127
      frame #3: 0x000000010baa476d qemu-system-x86_64`assert_hvf_ok(ret=3D<=
unavailable>) at hvf.c:106 [opt]
      frame #4: 0x000000010baa4c8f qemu-system-x86_64`hvf_vcpu_exec(cpu=3D0=
x00007f8e5283de00) at hvf.c:681 [opt]
      frame #5: 0x000000010b988423 qemu-system-x86_64`qemu_hvf_cpu_thread_f=
n(arg=3D0x00007f8e5283de00) at cpus.c:1636 [opt]
      frame #6: 0x000000010bd9dfce qemu-system-x86_64`qemu_thread_start(arg=
s=3D<unavailable>) at qemu-thread-posix.c:502 [opt]
      frame #7: 0x00007fff79e24305 libsystem_pthread.dylib`_pthread_body + =
126
      frame #8: 0x00007fff79e2726f libsystem_pthread.dylib`_pthread_start +=
 70
      frame #9: 0x00007fff79e23415 libsystem_pthread.dylib`thread_start + 13

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818937/+subscriptions
