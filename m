Received: from eggs.gnu.org ([2001:4830:134:3::10]:35981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fr58a-0005aQ-RE
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 13:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fr58W-0001FD-Qb
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 13:35:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:59548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fr58W-0001EE-Ke
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 13:35:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fr58T-0001no-RH
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 17:35:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5306E2E8524
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 17:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Aug 2018 17:22:37 -0000
From: Michele Denber <1787505@bugs.launchpad.net>
Reply-To: Bug 1787505 <1787505@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153446472677.27869.256879611828000197.malonedeb@chaenomeles.canonical.com>
Message-Id: <153461295795.3544.9919122097248662758.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1787505] Re: Solaris host: no network connection,
 mouse pointer mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thank you very much.  The following invocation fixed the mouse problem
(mostly) and made the Ethernet device available to the guest:

./qemu-system-x86_64 -m 2047 -boot d  -usb -device usb-tablet -smp 3
-netdev user,id=3Dn0 -device rtl8139,netdev=3Dn0 -hda
/bkpool/qemuimages/XP.img -cdrom /bkpool/qemuimages/xp.iso

There is one minor problem with the mouse.  Without the "-usb" qemu
displays the guest cursor position with an arrow, and the host cursor
position with a four pixel-wide box, separated by a distance that varies
with position on the screen.  After adding "-usb", the guest cursor
correctly tracks the host mouse, but the little box remains displayed,
speared on the tip on the guest cursor arrow.

Also, while the guest now has a network device it still can't talk to
any destination.  Oddly, if I try to ftp to some server it says
"connected" but then nothing else.  Web pages all come back as
"unreachable" even when requested by IP rather than name.  Even pinging
the router fails (though the documentation states that ping won't work
anyway).  The guest shows packets beign sent, but none received.  I
tried various other options listed in the documentation without success,
eg.

# qemu-system-x86_64: Host doesn't belong to network
 ./qemu-system-x86_64 -m 2047 -boot d  -usb -device usb-tablet  -smp 3 -net=
dev user,id=3Dn0,host=3D192.168.0.20, \
> hostname=3Dcanadiceq,dns=3D127.0.0.1,net=3D192.168.0.20/24 -device rtl813=
9,netdev=3Dn0 -hda  /bkpool/qemuimages/XP.img -cdrom /bkpool/qemuimages/xp.=
iso &
1212
# qemu-system-x86_64: Host doesn't belong to network

My best guess also didn't work:

./qemu-system-x86_64 -m 2047 -boot d  -usb -device usb-tablet  -smp 3 -netd=
ev user,id=3Dn0,hostfwd=3Dtcp::8080-:80,\
> net=3D192.168.0.0/24 -device rtl8139,netdev=3Dn0 -hda  /bkpool/qemuimages=
/XP.img -cdrom /bkpool/qemuimages/xp.iso &

That at least starts up, but no communication.

I guess I just don't understand what needs to be listed where in the
qemu invocation.  My guest TCP parameters are set up the same way as a
different working XP system.  I can't tell what I need to get the guest
to talk to the Internet.  I have a host IP (192.168.0.20), guest IP
(192.168.0.21), router IP (192.168.0.1), and DNS IP (208.67.222.222).
What goes where?  Do I need to set up anything special on the Solaris
end?  I've read over the documenation but still can't figure it out.

"If you have access to a Linux box, I'd definitely recommend testing the
same setup there."

I do, but I only have one legit XP license.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787505

Title:
  Solaris host: no network connection, mouse pointer mismatch

Status in QEMU:
  New

Bug description:
  This is probably a bit far afield but on a Solaris 10 SPARC host (Sun
  M3000) running a Windows XP guest like this:

  ./qemu-system-x86_64 -m 1024 -boot d  -smp 3 -net nic -net user -hda
  /bkpool/qemuimages/XP.img -cdrom /bkpool/qemuimages/xp.iso &

  the vnc server starts up and Windows boots normally.  However, there
  is no network connectivity.  There are no network devices visible in
  XP's Networking tab of Control Panel and a ping of the local router
  reports "unreachable".

  Also, the keyboard works fine but the guest mouse pointer is offset
  from the host mouse position by an amount that varies by screen
  position.  This makes it impossible to point to locations near the
  edge of the qemu window.  This seems to be a previously reported
  problem, but the suggested fix, " -device usb-tablet", prevents qemu
  from even starting:

  qemu-system-x86_64: -device usb-tablet: No 'usb-bus' bus found for
  device 'usb-tablet'

  The physical mouse is connected to the USB port of a Sun Ray 2fs
  controlling the M3000 via Sun Ray server.  I apologize if this is a
  configuration issue and not a bug but I don't know where else to
  report it and have been unable to find a solution in the
  documentation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787505/+subscriptions
