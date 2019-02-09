Received: from eggs.gnu.org ([209.51.188.92]:48787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gsK3Q-0005DY-8V
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gsK3L-0008PN-Hy
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:15:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:45490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gsK3H-0008JH-PA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 23:15:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gsK3B-0005wr-Mw
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 04:15:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AB9102E80C7
	for <qemu-devel@nongnu.org>; Sat,  9 Feb 2019 04:15:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Feb 2019 04:07:31 -0000
From: Nathan Wallace <1815263@bugs.launchpad.net>
Reply-To: Bug 1815263 <1815263@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154968525163.25022.16965396624156433331.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815263] [NEW] hvf accelerator crashes on quest
 boot
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

Host OS: macOS High Sierra (10.13.6)
MacBook Pro (Retina, Mid 2015)
Processor: 2.8GHz Intel Core i7
Guest OS: OpenBSD 6.4 install media (install64.iso)
Qemu 3.1.0 release, built with:
./configure --prefix=3D/usr/local/Cellar/qemu/3.1.0_1 --cc=3Dclang
      --host-cc=3Dclang
      --disable-bsd-user
      --disable-guest-agent
      --enable-curses
      --enable-libssh2
      --enable-vde
      --extra-cflags=3D-DNCURSES_WIDECHAR=3D1
      --enable-cocoa
      --disable-sdl
      --disable-gtk
      --enable-hvf
      --target-list=3Dx86_64-softmmu
      --enable-debug

I invoke qemu like this:
Last command had exit code: 0 at 22:58
nwallace@nwallace-ltm3:~
$ sudo qemu-system-x86_64 -M accel=3Dhvf -boot d -cdrom ~/Downloads/install=
64.iso
Password:
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
80000001H:ECX.svm [bit 2]
bad size

Abort trap: 6
Last command had exit code: 134 at 22:58
nwallace@nwallace-ltm3:~
$

I ran qemu in lldb to get a stack trace and I get:
Last command had exit code: 0 at 22:54
nwallace@nwallace-ltm3:~/Downloads
$ sudo lldb -- qemu-system-x86_64 -M accel=3Dhvf -boot d -cdrom /Users/nwal=
lace/Downloads/install64.iso
Password:
(lldb) target create "qemu-system-x86_64"
Current executable set to 'qemu-system-x86_64' (x86_64).
(lldb) settings set -- target.run-args  "-M" "accel=3Dhvf" "-boot" "d" "-cd=
rom" "/Users/nwallace/Downloads/install64.i
so"
(lldb) run
Process 96474 launched: '/usr/local/bin/qemu-system-x86_64' (x86_64)
Process 96474 stopped
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D signal SIGU=
SR2
    frame #0: 0x00007fff5ef0c00a libsystem_kernel.dylib`__sigsuspend + 10
libsystem_kernel.dylib`__sigsuspend:
->  0x7fff5ef0c00a <+10>: jae    0x7fff5ef0c014            ; <+20>
    0x7fff5ef0c00c <+12>: movq   %rax, %rdi
    0x7fff5ef0c00f <+15>: jmp    0x7fff5ef02b0e            ; cerror
    0x7fff5ef0c014 <+20>: retq
Target 0: (qemu-system-x86_64) stopped.
(lldb) process handle SIGUSR1 -n true -p true -s false
NAME         PASS   STOP   NOTIFY
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D
SIGUSR1      true   false  true
(lldb) process handle SIGUSR2 -n true -p true -s false
NAME         PASS   STOP   NOTIFY
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D
SIGUSR2      true   false  true
(lldb) c
Process 96474 resuming
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
80000001H:ECX.svm [bit 2]
Process 96474 stopped and restarted: thread 9 received signal: SIGUSR2
<line above repeats about 64 times or so>
Process 96474 stopped and restarted: thread 9 received signal: SIGUSR2
bad size

Process 96474 stopped
* thread #9, stop reason =3D signal SIGABRT
    frame #0: 0x00007fff5ef0bb66 libsystem_kernel.dylib`__pthread_kill + 10
libsystem_kernel.dylib`__pthread_kill:
->  0x7fff5ef0bb66 <+10>: jae    0x7fff5ef0bb70            ; <+20>
    0x7fff5ef0bb68 <+12>: movq   %rax, %rdi
    0x7fff5ef0bb6b <+15>: jmp    0x7fff5ef02ae9            ; cerror_nocancel
    0x7fff5ef0bb70 <+20>: retq
Target 0: (qemu-system-x86_64) stopped.
(lldb) bt
* thread #9, stop reason =3D signal SIGABRT
  * frame #0: 0x00007fff5ef0bb66 libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fff5f0d6080 libsystem_pthread.dylib`pthread_kill + 333
    frame #2: 0x00007fff5ee671ae libsystem_c.dylib`abort + 127
    frame #3: 0x000000010016b6ec qemu-system-x86_64`exec_cmps_single + 400
    frame #4: 0x000000010016ada4 qemu-system-x86_64`exec_cmps + 65
    frame #5: 0x0000000100169aaa qemu-system-x86_64`exec_instruction + 48
    frame #6: 0x0000000100164eb2 qemu-system-x86_64`hvf_vcpu_exec + 2658
    frame #7: 0x000000010005bed6 qemu-system-x86_64`qemu_hvf_cpu_thread_fn =
+ 200
    frame #8: 0x00000001003ee531 qemu-system-x86_64`qemu_thread_start + 107
    frame #9: 0x00007fff5f0d3661 libsystem_pthread.dylib`_pthread_body + 340
    frame #10: 0x00007fff5f0d350d libsystem_pthread.dylib`_pthread_start + =
377
    frame #11: 0x00007fff5f0d2bf9 libsystem_pthread.dylib`thread_start + 13
(lldb) quit
Quitting LLDB will kill one or more processes. Do you really want to procee=
d: [Y/n] Y
Last command had exit code: 0 at 23:01
nwallace@nwallace-ltm3:~/Downloads
$


I'm happy to work with someone more knowledgeable to reproduce this issue a=
nd provide debugging assistance as I'm able.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815263

Title:
  hvf accelerator crashes on quest boot

Status in QEMU:
  New

Bug description:
  Host OS: macOS High Sierra (10.13.6)
  MacBook Pro (Retina, Mid 2015)
  Processor: 2.8GHz Intel Core i7
  Guest OS: OpenBSD 6.4 install media (install64.iso)
  Qemu 3.1.0 release, built with:
  ./configure --prefix=3D/usr/local/Cellar/qemu/3.1.0_1 --cc=3Dclang
        --host-cc=3Dclang
        --disable-bsd-user
        --disable-guest-agent
        --enable-curses
        --enable-libssh2
        --enable-vde
        --extra-cflags=3D-DNCURSES_WIDECHAR=3D1
        --enable-cocoa
        --disable-sdl
        --disable-gtk
        --enable-hvf
        --target-list=3Dx86_64-softmmu
        --enable-debug

  I invoke qemu like this:
  Last command had exit code: 0 at 22:58
  nwallace@nwallace-ltm3:~
  $ sudo qemu-system-x86_64 -M accel=3Dhvf -boot d -cdrom ~/Downloads/insta=
ll64.iso
  Password:
  qemu-system-x86_64: warning: host doesn't support requested feature: CPUI=
D.80000001H:ECX.svm [bit 2]
  bad size

  Abort trap: 6
  Last command had exit code: 134 at 22:58
  nwallace@nwallace-ltm3:~
  $

  I ran qemu in lldb to get a stack trace and I get:
  Last command had exit code: 0 at 22:54
  nwallace@nwallace-ltm3:~/Downloads
  $ sudo lldb -- qemu-system-x86_64 -M accel=3Dhvf -boot d -cdrom /Users/nw=
allace/Downloads/install64.iso
  Password:
  (lldb) target create "qemu-system-x86_64"
  Current executable set to 'qemu-system-x86_64' (x86_64).
  (lldb) settings set -- target.run-args  "-M" "accel=3Dhvf" "-boot" "d" "-=
cdrom" "/Users/nwallace/Downloads/install64.i
  so"
  (lldb) run
  Process 96474 launched: '/usr/local/bin/qemu-system-x86_64' (x86_64)
  Process 96474 stopped
  * thread #1, queue =3D 'com.apple.main-thread', stop reason =3D signal SI=
GUSR2
      frame #0: 0x00007fff5ef0c00a libsystem_kernel.dylib`__sigsuspend + 10
  libsystem_kernel.dylib`__sigsuspend:
  ->  0x7fff5ef0c00a <+10>: jae    0x7fff5ef0c014            ; <+20>
      0x7fff5ef0c00c <+12>: movq   %rax, %rdi
      0x7fff5ef0c00f <+15>: jmp    0x7fff5ef02b0e            ; cerror
      0x7fff5ef0c014 <+20>: retq
  Target 0: (qemu-system-x86_64) stopped.
  (lldb) process handle SIGUSR1 -n true -p true -s false
  NAME         PASS   STOP   NOTIFY
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D
  SIGUSR1      true   false  true
  (lldb) process handle SIGUSR2 -n true -p true -s false
  NAME         PASS   STOP   NOTIFY
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D
  SIGUSR2      true   false  true
  (lldb) c
  Process 96474 resuming
  qemu-system-x86_64: warning: host doesn't support requested feature: CPUI=
D.80000001H:ECX.svm [bit 2]
  Process 96474 stopped and restarted: thread 9 received signal: SIGUSR2
  <line above repeats about 64 times or so>
  Process 96474 stopped and restarted: thread 9 received signal: SIGUSR2
  bad size

  Process 96474 stopped
  * thread #9, stop reason =3D signal SIGABRT
      frame #0: 0x00007fff5ef0bb66 libsystem_kernel.dylib`__pthread_kill + =
10
  libsystem_kernel.dylib`__pthread_kill:
  ->  0x7fff5ef0bb66 <+10>: jae    0x7fff5ef0bb70            ; <+20>
      0x7fff5ef0bb68 <+12>: movq   %rax, %rdi
      0x7fff5ef0bb6b <+15>: jmp    0x7fff5ef02ae9            ; cerror_nocan=
cel
      0x7fff5ef0bb70 <+20>: retq
  Target 0: (qemu-system-x86_64) stopped.
  (lldb) bt
  * thread #9, stop reason =3D signal SIGABRT
    * frame #0: 0x00007fff5ef0bb66 libsystem_kernel.dylib`__pthread_kill + =
10
      frame #1: 0x00007fff5f0d6080 libsystem_pthread.dylib`pthread_kill + 3=
33
      frame #2: 0x00007fff5ee671ae libsystem_c.dylib`abort + 127
      frame #3: 0x000000010016b6ec qemu-system-x86_64`exec_cmps_single + 400
      frame #4: 0x000000010016ada4 qemu-system-x86_64`exec_cmps + 65
      frame #5: 0x0000000100169aaa qemu-system-x86_64`exec_instruction + 48
      frame #6: 0x0000000100164eb2 qemu-system-x86_64`hvf_vcpu_exec + 2658
      frame #7: 0x000000010005bed6 qemu-system-x86_64`qemu_hvf_cpu_thread_f=
n + 200
      frame #8: 0x00000001003ee531 qemu-system-x86_64`qemu_thread_start + 1=
07
      frame #9: 0x00007fff5f0d3661 libsystem_pthread.dylib`_pthread_body + =
340
      frame #10: 0x00007fff5f0d350d libsystem_pthread.dylib`_pthread_start =
+ 377
      frame #11: 0x00007fff5f0d2bf9 libsystem_pthread.dylib`thread_start + =
13
  (lldb) quit
  Quitting LLDB will kill one or more processes. Do you really want to proc=
eed: [Y/n] Y
  Last command had exit code: 0 at 23:01
  nwallace@nwallace-ltm3:~/Downloads
  $

  =

  I'm happy to work with someone more knowledgeable to reproduce this issue=
 and provide debugging assistance as I'm able.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815263/+subscriptions
