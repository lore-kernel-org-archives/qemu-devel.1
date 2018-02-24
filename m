Received: from eggs.gnu.org ([2001:4830:134:3::10]:54336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epX6G-0002Zz-6w
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 05:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epX6C-0001w3-6l
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 05:30:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1epX6B-0001u5-Sh
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 05:30:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1epX6B-0004tV-0V
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 10:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02A342E8042
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 10:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Feb 2018 10:25:07 -0000
From: Daniel Henrique Barboza <1688231@bugs.launchpad.net>
Reply-To: Bug 1688231 <1688231@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170504110626.10123.22333.malonedeb@gac.canonical.com>
Message-Id: <151946790768.8314.10359545201491590137.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1688231] Re: [Qemu-ppc] sendkey is not working
 for any of the keystrokes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, you are right: sendkey does not send keys to the serial console. I
had a chat with Peter last year about it in the IRC where the explained:

<danielhb> hey! quick question: is the 'sendkey' monitor command supposed t=
o send the key presses to the serial console of the guest when running with=
 -nographics ? The command works fine with VGA/VNC graphics but the serial =
console doesn't show the character key being sent by the command
<pm215> no, 'sendkey' sends a key to whatever physical keyboard is currentl=
y being emulated, regardless of what is being done with serial devices
<danielhb> pm215, I 've debugged the code and saw that the scancodes are be=
ing sent to the emulated keyboard via sendkey. I just wondered why the seri=
al console doesn't show the keysyms but the VGA does
<pm215> because keyboards don't plug into serial terminals
<pm215> this is like having a server with a PC keyboard plugged into it and=
 also a serial port which you're using as the serial terminal
<pm215> pressing a key on the PC keyboard doesn't do anything to the serial=
 terminal
<danielhb> pm215, that makes sense, haven't thought of  that. thanks!

Given that the bug report was created around a wrong assumption, this
should be closed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1688231

Title:
  [Qemu-ppc] sendkey is not working for any of the keystrokes

Status in QEMU:
  New

Bug description:
  sendkey option is not working for any of the keystrokes in ppc64le,

  Qemu version:
  # qemu-img --version
  qemu-img version 2.9.50 (v2.9.0-303-g81b2d5c-dirty)

  Qemu command line:
  # qemu-system-ppc64 --enable-kvm --nographic -vga none -machine pseries -=
m 4G,slots=3D32,maxmem=3D32G -smp 16,maxcpus=3D32 -device virtio-blk-pci,dr=
ive=3Drootdisk -drive file=3D/var/lib/libvirt/images/f25-upstream-ppc64le.q=
cow2,if=3Dnone,cache=3Dnone,format=3Dqcow2,id=3Drootdisk -monitor telnet:12=
7.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net user -redir tcp:200=
0::22

  Guest booted successfully and logged in
  Fedora 25 (Twenty Five)
  Kernel 4.11.0-rc4 on an ppc64le (hvc0)

  atest-guest login: updatedb (5582) used greatest stack depth: 9568 bytes =
left
  root
  Password: =

  Last login: Mon Mar 27 01:57:51 on hvc0
  [root@atest-guest ~]# =


  Qemu monitor:
  # telnet 127.0.0.1 1234
  Trying 127.0.0.1...
  Connected to 127.0.0.1.
  Escape character is '^]'.
  QEMU 2.9.50 monitor - type 'help' for more information
  (qemu) sendkey a
  (qemu) sendkey ret

  But from the console, I couldn't observe the keystroke a or return.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1688231/+subscriptions
