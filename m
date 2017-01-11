Received: from eggs.gnu.org ([2001:4830:134:3::10]:47344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRKFO-000105-DQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRKFJ-0001AO-Hv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:51:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:47142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRKFJ-0001AH-9t
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:51:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRKFG-0003Ia-Vx
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 14:51:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB8882E81D5
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 14:51:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 14:40:20 -0000
From: Fabian Lesniak <fabian@lesniak-it.de>
Reply-To: Bug 1653384 <1653384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161231213844.1229.87554.malonedeb@soybean.canonical.com>
Message-Id: <20170111144020.21116.19598.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1653384] Re: Assertion failed with USB pass
 through with XHCI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

using qemu commit f634151b02ce5c80605383894f1f63f2c12e0033
configured with --python=3D/usr/bin/python2 --target-list=3Dx86_64-softmmu =
--audio-drv-list=3D"oss alsa sdl pa" --enable-debug
running with -m 1024 -drive if=3Dpflash,file=3Dovmf-arch.bin,format=3Draw -=
drive file=3Darch.raw,format=3Draw,if=3Dvirtio -device nec-usb-xhci,id=3Dxh=
ci -device usb-host,bus=3Dxhci.0,vendorid=3D0x046d,productid=3D0x0a4d

I get:
(gdb) bt full
#0  0x00007fffdccb304f in raise () at /usr/lib/libc.so.6
#1  0x00007fffdccb447a in abort () at /usr/lib/libc.so.6
#2  0x00007fffdccabea7 in __assert_fail_base () at /usr/lib/libc.so.6
#3  0x00007fffdccabf52 in  () at /usr/lib/libc.so.6
#4  0x0000555555a8ab6e in usb_packet_cleanup (p=3D0x7fff5c125c18) at hw/usb=
/core.c:619
        __PRETTY_FUNCTION__ =3D "usb_packet_cleanup"
#5  0x0000555555aa8d97 in xhci_ep_free_xfer (xfer=3D0x7fff5c125c10) at hw/u=
sb/hcd-xhci.c:1465
#6  0x0000555555aaa9a8 in xhci_kick_epctx (epctx=3D0x7fff5c0205d0, streamid=
=3D0) at hw/usb/hcd-xhci.c:2201
        xfer =3D 0x7fff5c125c10
        xhci =3D 0x7fff76538010
        stctx =3D 0x7fffffffd960
        xfer =3D 0x2ffffd920
        ring =3D 0x5555562aeed0 <timers_state+16>
        ep =3D 0x0
        mfindex =3D 113160
        length =3D 1434054766
        i =3D 32767
        __PRETTY_FUNCTION__ =3D "xhci_kick_epctx"
#7  0x0000555555aa88d9 in xhci_ep_kick_timer (opaque=3D0x7fff5c0205d0) at h=
w/usb/hcd-xhci.c:1363
        epctx =3D 0x7fff5c0205d0
#8  0x0000555555b6217f in timerlist_run_timers (timer_list=3D0x5555567a25a0=
) at qemu-timer.c:540
        ts =3D 0x7fff5cb8f210
        current_time =3D 31951197002
        progress =3D false
        cb =3D 0x555555aa88b4 <xhci_ep_kick_timer>
        opaque =3D 0x7fff5c0205d0
#9  0x0000555555b621cb in qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL)=
 at qemu-timer.c:551
#10 0x0000555555b62564 in qemu_clock_run_all_timers () at qemu-timer.c:665
        progress =3D false
        type =3D QEMU_CLOCK_VIRTUAL
#11 0x0000555555b610be in main_loop_wait (nonblocking=3D0) at main-loop.c:5=
16
        ret =3D 0
        timeout =3D 1000
        timeout_ns =3D 289955
#12 0x00005555558f0b97 in main_loop () at vl.c:1966
        nonblocking =3D false
        last_io =3D 0
#13 0x00005555558f847c in main (argc=3D11, argv=3D0x7fffffffde18, envp=3D0x=
7fffffffde78) at vl.c:4685
        i =3D 0
        snapshot =3D 0
        linux_boot =3D 0
        initrd_filename =3D 0x0
        kernel_filename =3D 0x0
        kernel_cmdline =3D 0x555555c8ecb6 ""
        boot_order =3D 0x555555c7c5b5 "cad"
        boot_once =3D 0x0
        ds =3D 0x555557777de0
        cyls =3D 0
        heads =3D 0
        secs =3D 0
        translation =3D 0
        hda_opts =3D 0x0
        opts =3D 0x0
        machine_opts =3D 0x5555567a2480
        icount_opts =3D 0x0
        olist =3D 0x0
        optind =3D 11
        optarg =3D 0x7fffffffe296 "usb-host,bus=3Dxhci.0,vendorid=3D0x046d,=
productid=3D0x0a4d"
        loadvm =3D 0x0
        machine_class =3D 0x55555676bef0
        cpu_model =3D 0x0
        vga_model =3D 0x555555c7cece "std"
        qtest_chrdev =3D 0x0
        qtest_log =3D 0x0
        pid_file =3D 0x0
        incoming =3D 0x0
        defconfig =3D true
        userconfig =3D true
        nographic =3D false
        display_type =3D DT_GTK
        display_remote =3D 0
        log_mask =3D 0x0
        log_file =3D 0x0
        trace_file =3D 0x0
        maxram_size =3D 1073741824
        ram_slots =3D 0
        vmstate_dump_file =3D 0x0
        main_loop_err =3D 0x0
        err =3D 0x0
        list_data_dirs =3D false
        __func__ =3D "main"

Hope this helps.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1653384

Title:
  Assertion failed with USB pass through with XHCI controller

Status in QEMU:
  New

Bug description:
  Starting qemu 2.8.0 with XHCI controller and host device passed
  through results in an assertion failure:

  qemu-system-x86_64: hw/usb/core.c:623: usb_packet_cleanup: Assertion
  `!usb_packet_is_inflight(p)' failed.

  Can be reproduced with the following command (passing through a Lenovo
  keyboard):

  qemu-system-x86_64 -usb  -device nec-usb-xhci,id=3Dusb -device usb-
  host,vendorid=3D0x04b3,productid=3D0x3025,id=3Dhostdev0,bus=3Dusb.0,port=
=3D1

  If nec-usb-xhci is changed to usb-ehci, qemu tries to boot without
  assertion failures.

  =

  Can be reproduced with the latest master (commit dbe2b65) and v2.8.0.

  Bisected the issue to following commit:
  first bad commit: [94b037f2a451b3dc855f9f2c346e5049a361bd55] xhci: use li=
nked list for transfers

  =

  Backtrace from commit dbe2b65:

  #0  0x00007f2eb4657227 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:55
          resultvar =3D 0
          pid =3D 3453
          selftid =3D 3453
  #1  0x00007f2eb465867a in __GI_abort () at abort.c:89
          save_stage =3D 2
          act =3D {__sigaction_handler =3D {sa_handler =3D 0x4, sa_sigactio=
n =3D 0x4}, sa_mask =3D {__val =3D {140734740550528, 93876690035339, =

                140734740550624, 48833659808, 0, 0, 0, 21474836480, 1407347=
40550792, 139838573009553, 140734740550560, 139838573043008, =

                139838573024160, 93876666665872, 139838702616576, 139838573=
024160}}, sa_flags =3D 1528954938, =

            sa_restorer =3D 0x55615b2202c0 <__PRETTY_FUNCTION__.38612>}
          sigs =3D {__val =3D {32, 0 <repeats 15 times>}}
  #2  0x00007f2eb46502cd in __assert_fail_base (fmt=3D0x7f2eb47893a0 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n", =

      assertion=3Dassertion@entry=3D0x55615b22003a "!usb_packet_is_inflight=
(p)", file=3Dfile@entry=3D0x55615b21fdf0 "hw/usb/core.c", line=3Dline@entry=
=3D619, =

      function=3Dfunction@entry=3D0x55615b2202c0 <__PRETTY_FUNCTION__.38612=
> "usb_packet_cleanup") at assert.c:92
          str =3D 0x55615cfdf510 ""
          total =3D 4096
  #3  0x00007f2eb4650382 in __GI___assert_fail (assertion=3D0x55615b22003a =
"!usb_packet_is_inflight(p)", file=3D0x55615b21fdf0 "hw/usb/core.c", =

      line=3D619, function=3D0x55615b2202c0 <__PRETTY_FUNCTION__.38612> "us=
b_packet_cleanup") at assert.c:101
  No locals.
  #4  0x000055615afc385e in usb_packet_cleanup ()
  No symbol table info available.
  #5  0x000055615afda555 in xhci_ep_free_xfer ()
  No symbol table info available.
  #6  0x000055615afdc156 in xhci_kick_epctx ()
  No symbol table info available.
  #7  0x000055615afda099 in xhci_ep_kick_timer ()
  No symbol table info available.
  #8  0x000055615b08ceee in timerlist_run_timers ()
  No symbol table info available.
  #9  0x000055615b08cf36 in qemu_clock_run_timers ()
  No symbol table info available.
  #10 0x000055615b08d2df in qemu_clock_run_all_timers ()
  No symbol table info available.
  #11 0x000055615b08be40 in main_loop_wait ()
  No symbol table info available.
  #12 0x000055615ae3870f in main_loop ()
  No symbol table info available.
  #13 0x000055615ae4027b in main ()

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1653384/+subscriptions
