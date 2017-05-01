Received: from eggs.gnu.org ([2001:4830:134:3::10]:48774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5JlN-0007xf-La
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5JlI-000398-LM
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:25:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:33270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5JlI-00037x-A8
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5JlF-0003Gq-Lr
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 22:25:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 801012E80C4
	for <qemu-devel@nongnu.org>; Mon,  1 May 2017 22:25:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 May 2017 22:19:29 -0000
From: Henrik Pitkala <hpitkala@hotmail.com>
Reply-To: Bug 1687309 <1687309@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170430183454.2796.53809.malonedeb@soybean.canonical.com>
Message-Id: <20170501221929.26845.77527.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687309] Re: Assertion !usb_packet_is_inflight(p)
 fails in OHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The attached ZIP file contains USB packet capture file made with
Wireshark on host OS side during crash.

What happens in the capture:

- packets 1-202: starting Qemu

- running lsusb and v4l-info -> no packets produced

- packets 203-268: fswebcam testpic05.jpg -> OK

- packets 269-320: fswebcam testpic05b.jpg -> crash as described in the
bug report

For your reference, testpic05.jpg is attached, too.

** Attachment added: "usb-packet-capture-on-qemu-crash-170501.zip"
   https://bugs.launchpad.net/qemu/+bug/1687309/+attachment/4870531/+files/=
usb-packet-capture-on-qemu-crash-170501.zip

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687309

Title:
  Assertion !usb_packet_is_inflight(p) fails in OHCI

Status in QEMU:
  New

Bug description:
  I'm trying to get a USB web camera working in Qemu & Raspbian. USB
  works and V4L shows device info correctly and capturing frames from
  the camera works sometimes, but mostly it crashes with error message:

  qemu-system-arm: hw/usb/core.c:558: usb_packet_setup: Assertion
  `!usb_packet_is_inflight(p)' failed.

  This looks similar to the previous bug which also caused a crash on
  the same kind of assertion but the culprit was XHCI:
  https://bugs.launchpad.net/qemu/+bug/1653384

  =3D=3D Versions =3D=3D

  QEMU emulator version 2.9.50 (v2.9.0-303-g81b2d5c-dirty),
  configured with
  ./configure --target-list=3Darm-softmmu,arm-linux-user,armeb-linux-user -=
-enable-libusb --enable-libssh2 --enable-debug

  libusb: 1.0.21

  Guest: 2017-04-10-raspbian-jessie-lite.img with kernel 4.4.34 for
  Raspbian on Qemu

  Host: Ubuntu 16.04.2 LTS, kernel 4.4.0-72-generic

  Command: /usr/local/bin/qemu-system-arm -kernel qemu-rpi-kernel
  /kernel-qemu-4.4.34-v4lm-jessie -cpu arm1176 -m 256 -M versatilepb
  -no-reboot -append "root=3D/dev/sda2 panic=3D1" -drive
  format=3Draw,file=3D2017-04-10-raspbian-jessie-lite.img -usb -usbdevice
  host:046d:0928 -net nic,model=3Dvirtio -net user,hostfwd=3Dtcp::2222-:22

  Web camera is an old Logitech QuickCam Express Etch2 (046d:0928). It
  works otherwise without problems.

  =3D=3D GDB Backtrace =3D=3D

  qemu-system-arm: hw/usb/core.c:558: usb_packet_setup: Assertion
  `!usb_packet_is_inflight(p)' failed.

  Thread 1 "qemu-system-arm" received signal SIGABRT, Aborted.
  0x00007fffdea6f428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix=
/sysv/linux/raise.c:54
  54      ../sysdeps/unix/sysv/linux/raise.c: Tiedostoa tai hakemistoa ei o=
le.
  (gdb) bt full
  #0  0x00007fffdea6f428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:54
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resultvar =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid =3D 16526
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0selftid =3D 16526
  #1  0x00007fffdea7102a in __GI_abort () at abort.c:89
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0save_stage =3D 2
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0act =3D {__sigaction_hand=
ler =3D {sa_handler =3D 0x4, sa_sigaction =3D 0x4}, sa_mask =3D {__val =3D =
{140737488345776,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0140737488351076, 140737488345856, 48702688480, 140737352876032,=
 93825001457954, 558, 93825001458576, 0, 0,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0140736929192332, 140736930289240, 140736930302896, 260615966, 1=
40736930289240, 93825001457954}},
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sa_flags =3D =
-135479296, sa_restorer =3D 0x555555e20922}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sigs =3D {__val =3D {32, =
0 <repeats 15 times>}}
  #2  0x00007fffdea67bd7 in __assert_fail_base (fmt=3D<optimized out>,
  =C2=A0=C2=A0=C2=A0=C2=A0assertion=3Dassertion@entry=3D0x555555e20922 "!us=
b_packet_is_inflight(p)",
  =C2=A0=C2=A0=C2=A0=C2=A0file=3Dfile@entry=3D0x555555e20686 "hw/usb/core.c=
", line=3Dline@entry=3D558,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x555555e20b90 <__PRE=
TTY_FUNCTION__.27044> "usb_packet_setup") at assert.c:92
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str =3D 0x5555573e0800 ""
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0total =3D 4096
  #3  0x00007fffdea67c82 in __GI___assert_fail (assertion=3D0x555555e20922 =
"!usb_packet_is_inflight(p)",
  =C2=A0=C2=A0=C2=A0=C2=A0file=3D0x555555e20686 "hw/usb/core.c", line=3D558,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3D0x555555e20b90 <__PRETTY_FUNCTION__.27=
044> "usb_packet_setup") at assert.c:101
  No locals.
  #4  0x0000555555b4015a in usb_packet_setup (p=3D0x555556e81bc8, pid=3D105=
, ep=3D0x55555733e180, stream=3D0, id=3D260615936,
  =C2=A0=C2=A0=C2=A0=C2=A0short_not_ok=3Dfalse, int_req=3Dfalse) at hw/usb/=
core.c:558
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__PRETTY_FUNCTION__ =3D "=
usb_packet_setup"
  #5  0x0000555555b4f2ee in ohci_service_iso_td (ohci=3D0x555556e814c0, ed=
=3D0x7fffffffdda0, completion=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at hw/usb/hcd-ohci.c:852
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int_req =3D false
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dir =3D 2
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D 1023
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0str =3D 0x555555e233cf "i=
n"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid =3D 105
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -8788
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i =3D -8912
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev =3D 0x55555733d070
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep =3D 0x55555733e180
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iso_td =3D {flags =3D 403=
9218540, bp =3D 251170816, next =3D 260615872, be =3D 251173880, offset =3D=
 {59386, 0, 6, 0, 53328,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A05=
3376, 0, 0}}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0addr =3D 260615936
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0starting_frame =3D 38252
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0relative_frame_number =3D=
 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0frame_count =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_offset =3D 59386
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0next_offset =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_offset =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_addr =3D 251172858
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_addr =3D 251173880
  #6  0x0000555555b5055c in ohci_service_ed_list (ohci=3D0x555556e814c0, he=
ad=3D260608080, completion=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at hw/usb/hcd-ohci.c:1239
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ed =3D {flags =3D 6708032=
2, tail =3D 260614272, head =3D 260615936, next =3D 0}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0next_ed =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cur =3D 260608080
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0active =3D 1
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link_cnt =3D 1
  #7  0x0000555555b50857 in ohci_frame_boundary (opaque=3D0x555556e814c0) a=
t hw/usb/hcd-ohci.c:1304
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0n =3D 12
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ohci =3D 0x555556e814c0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hcca =3D {intr =3D {26060=
8080 <repeats 32 times>}, frame =3D 38252, pad =3D 0, done =3D 0}
  #8  0x0000555555d12050 in timerlist_run_timers (timer_list=3D0x5555569396=
00) at util/qemu-timer.c:536
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ts =3D 0x555556ebc9b0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current_time =3D 22499159=
2167
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0progress =3D false
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cb =3D 0x555555b50778 <oh=
ci_frame_boundary>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0opaque =3D 0x555556e814c0
  #9  0x0000555555d1209c in qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUA=
L) at util/qemu-timer.c:547
  No locals.
  #10 0x0000555555d1244e in qemu_clock_run_all_timers () at util/qemu-timer=
.c:662
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0progress =3D false
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type =3D QEMU_CLOCK_VIRTU=
AL
  #11 0x0000555555d12bf9 in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:525
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timeout =3D 499
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0timeout_ns =3D 977642
  #12 0x0000555555969440 in main_loop () at vl.c:1899
  No locals.
  #13 0x0000555555971229 in main (argc=3D21, argv=3D0x7fffffffe358, envp=3D=
0x7fffffffe408) at vl.c:4717
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snapshot =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux_boot =3D 1
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0initrd_filename =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel_filename =3D 0x555=
5568d78c0 "qemu-rpi-kernel/kernel-qemu-4.4.34-v4lm-jessie"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel_cmdline =3D 0x5555=
568d8c80 "root=3D/dev/sda2 panic=3D1 "
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boot_order =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boot_once =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ds =3D 0x55555718f750
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cyls =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0heads =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0secs =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0translation =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0opts =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0machine_opts =3D 0x555556=
8d8b20
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hda_opts =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0icount_opts =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0accel_opts =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0olist =3D 0x55555629fc80 =
<qemu_machine_opts>
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0optind =3D 21
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0optarg =3D 0x7fffffffe780=
 "user,hostfwd=3Dtcp::2222-:22"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0loadvm =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0machine_class =3D 0x55555=
68eff50
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu_model =3D 0x7fffffffe=
6c2 "arm1176"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vga_model =3D 0x555555d8d=
8c4 "std"
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_chrdev =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_log =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pid_file =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0incoming =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defconfig =3D true
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0userconfig =3D true
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nographic =3D false
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0display_type =3D DT_GTK
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0display_remote =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0log_mask =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0log_file =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_file =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0maxram_size =3D 268435456
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram_slots =3D 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vmstate_dump_file =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0main_loop_err =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D 0x0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_data_dirs =3D false
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bdo_queue =3D {sqh_first =
=3D 0x0, sqh_last =3D 0x7fffffffe140}
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__func__ =3D "main"

  (P.S. Tiedostoa tai hakemistoa ei ole =3D file or directory doesn't
  exist.)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687309/+subscriptions
