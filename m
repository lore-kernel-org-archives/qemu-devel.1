Received: from eggs.gnu.org ([2001:4830:134:3::10]:52628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRM2B-0004mq-ER
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRM26-0005uH-E1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:45:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:38119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRM26-0005tR-9K
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:45:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRM22-0008NM-FO
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:45:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A86692E80C7
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:45:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 16:35:47 -0000
From: Fabian Lesniak <fabian@lesniak-it.de>
Reply-To: Bug 1653384 <1653384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161231213844.1229.87554.malonedeb@soybean.canonical.com>
Message-Id: <20170111163547.14276.11781.malone@soybean.canonical.com>
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

I examined xhci_kick_epctx (frame 6) and looked into xfer and
xfer->packet, maybe this helps:

(gdb) bt
#0  0x00007fffdccb304f in raise () at /usr/lib/libc.so.6
#1  0x00007fffdccb447a in abort () at /usr/lib/libc.so.6
#2  0x00007fffdccabea7 in __assert_fail_base () at /usr/lib/libc.so.6
#3  0x00007fffdccabf52 in  () at /usr/lib/libc.so.6
#4  0x0000555555a8ab6e in usb_packet_cleanup (p=3D0x7fff5c3bcd88) at hw/usb=
/core.c:619
#5  0x0000555555aa8d97 in xhci_ep_free_xfer (xfer=3D0x7fff5c3bcd80) at hw/u=
sb/hcd-xhci.c:1465
#6  0x0000555555aaa9a8 in xhci_kick_epctx (epctx=3D0x7fff5c745290, streamid=
=3D0) at hw/usb/hcd-xhci.c:2201
#7  0x0000555555aa88d9 in xhci_ep_kick_timer (opaque=3D0x7fff5c745290) at h=
w/usb/hcd-xhci.c:1363
#8  0x0000555555b6217f in timerlist_run_timers (timer_list=3D0x5555567a25a0=
) at qemu-timer.c:540
#9  0x0000555555b621cb in qemu_clock_run_timers (type=3DQEMU_CLOCK_VIRTUAL)=
 at qemu-timer.c:551
#10 0x0000555555b62564 in qemu_clock_run_all_timers () at qemu-timer.c:665
#11 0x0000555555b610be in main_loop_wait (nonblocking=3D0) at main-loop.c:5=
16
#12 0x00005555558f0b97 in main_loop () at vl.c:1966
#13 0x00005555558f847c in main (argc=3D11, argv=3D0x7fffffffde18, envp=3D0x=
7fffffffde78) at vl.c:4685
(gdb) f 6
#6  0x0000555555aaa9a8 in xhci_kick_epctx (epctx=3D0x7fff5c745290, streamid=
=3D0) at hw/usb/hcd-xhci.c:2201
2201            xhci_ep_free_xfer(epctx->retry);
(gdb) info local
xfer =3D 0x7fff5c3bcd80
xhci =3D 0x7fff76538010
stctx =3D 0x7fffffffd960
xfer =3D 0x2ffffd920
ring =3D 0x5555562aeed0 <timers_state+16>
ep =3D 0x0
mfindex =3D 126425
length =3D 1434054766
i =3D 32767
__PRETTY_FUNCTION__ =3D "xhci_kick_epctx"
(gdb) print xfer
$1 =3D (XHCITransfer *) 0x7fff5c3bcd80
(gdb) print *xfer
$2 =3D {epctx =3D 0x7fff5c745290, packet =3D {pid =3D 105, id =3D 102896435=
2, ep =3D 0x555558342660, stream =3D 0, iov =3D {iov =3D 0x7fff5c138960, ni=
ov =3D 1, nalloc =3D 1, size =3D 5}, parameter =3D 0, short_not_ok =3D fals=
e, int_req =3D true, status =3D -6, actual_length =3D 0, state =3D USB_PACK=
ET_ASYNC, combined =3D 0x0, queue =3D {tqe_next =3D 0x0, tqe_prev =3D 0x555=
558342678}, combined_entry =3D {tqe_next =3D 0x0, tqe_prev =3D 0x0}}, sgl =
=3D {sg =3D 0x5555586401e0, nsg =3D 1, nalloc =3D 1, size =3D 5, dev =3D 0x=
7fff76538010, as =3D 0x7fff76538220}, running_async =3D true, running_retry=
 =3D false, complete =3D false, int_req =3D true, iso_pkts =3D 0, streamid =
=3D 0, in_xfer =3D true, iso_xfer =3D false, timed_xfer =3D false, trb_coun=
t =3D 1, trbs =3D 0x7fff5c025690, status =3D CC_INVALID, pkts =3D 0, pktsiz=
e =3D 0, cur_pkt =3D 0, mfindex_kick =3D 126424, next =3D {tqe_next =3D 0x0=
, tqe_prev =3D 0x0}}
(gdb) print xfer->packet
$3 =3D {pid =3D 105, id =3D 1028964352, ep =3D 0x555558342660, stream =3D 0=
, iov =3D {iov =3D 0x7fff5c138960, niov =3D 1, nalloc =3D 1, size =3D 5}, p=
arameter =3D 0, short_not_ok =3D false, int_req =3D true, status =3D -6, ac=
tual_length =3D 0, state =3D USB_PACKET_ASYNC, combined =3D 0x0, queue =3D =
{tqe_next =3D 0x0, tqe_prev =3D 0x555558342678}, combined_entry =3D {tqe_ne=
xt =3D 0x0, tqe_prev =3D 0x0}}

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
