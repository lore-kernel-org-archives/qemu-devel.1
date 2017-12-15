Received: from eggs.gnu.org ([2001:4830:134:3::10]:60726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQX-0006t5-Au
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQW-0003zy-8A
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:48448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsQU-0003xd-Hk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsQN-0008Ik-A4
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 165642E817B
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:52:00 -0000
From: Thomas Huth <1718964@bugs.launchpad.net>
Reply-To: Bug 1718964 <1718964@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150609439728.30760.16378952760062218203.malonedeb@wampee.canonical.com>
Message-Id: <151335312220.25692.9491345609031418152.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1718964] Re: Memory leak when using websocket
 over a low speed network
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
https://bugs.launchpad.net/bugs/1718964

Title:
  Memory leak when using websocket over a low speed network

Status in QEMU:
  Fix Released

Bug description:
  Description of problem
  -------------------------

  When VNC is connected to QEMU via websocket over a low speed network
  (e.g. 300KB/S Wide Area Network), and there is a lot of frame buffer
  update, the VNC Client will get stuck, the cursor is almost impossible
  to move, which may result in accumulation of a large number of data in
  the QEMU process (memory consumption will keep increasing).

  =

  Environment
  -------------------------
  All of the following versions have been tested:

  QEMU: 2.5.1 / 2.6.0 / 2.8.1.1 / 2.9.0 / 2.10.0
  Host OS: Ubuntu 16.04 Server LTS / CentOS 7 x86_64_1611
  Guest OS: Windows 7 64bit / Ubuntu 16.04 Desktop LTS
  Client OS: Windows 7 64bit / Windows 10 64bit
  Client Browser: IE 11.0.9600 / Chrome 60.0.3112 / Firefox 55.0.2
  VNC Client: TigerVNC Viewer 1.8 / UltraVNC Viewer 1.2.1.5 / TightVNC View=
er 2.8.8 =

  VNC Web Client: noVNC 0.5.1 / noVNC 0.61 / noVNC 0.62
  VNC Server: TigerVNC 1.8 / x11vnc 0.9.13 / TightVNC 2.8.8
  VNC Client: TigerVNC Viewer 1.8 / UltraVNC Viewer 1.2.1.5 / TightVNC View=
er 2.8.8

  =

  Steps to reproduce:
  -------------------------
  100% reproducible.

  1. Launch a QEMU instance with websocket option:
  qemu-system-x86_64 -enable-kvm -m 6G ./win_x64.qcow2 -vnc :1,websocket=3D=
5701

  2. Open VNC Web Client (noVNC/vnc.html) in browser and connect to QEMU
  VM via websocket

  3. Play a video (e.g. Watch YouTube) on VM (To produce a lot of frame
  buffer update)

  4. Limit (e.g. Use NetLimiter) the client inbound bandwidth to 300KB/S
  (To simulate a low speed WAN)

  5. Then client's output gets stuck(less than 1 fps), the cursor is
  almost impossible to move

  6. Observe QEMU process on the host, more and more data are
  accumulated in the process, the consumption of memory continues to
  keep increasing

  =

  Current result:
  -------------------------
  [Top - Initial status]
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMA=
ND         =

   2725 root      20   0 7229144 5.910g  23024 S  16.3 18.9   0:12.84 qemu-=
system-x86_64

  [Top - After an hour's playing w/o limit (6-8MB/S)]
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMA=
ND         =

   2725 root      20   0 7370284 6.046g  23132 S  28.0 19.3  35:58.15 qemu-=
system-x86_64

  [Top - Limit the bandwidth and continue to playing for another an hour (3=
00KB/S)]
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMA=
ND         =

   2725 root      20   0 11.029g 8.853g  23132 S  20.0 28.2  72:14.17 qemu-=
system-x86_64

  Also test several other combinations in the same environment:

  1. Client(VNC Viewer) - Server(QEMU)
  2. Client(VNC Viewer) - Server(tigervnc/x11vnc/tightvnc)
  3. Client(noVNC)      - Server(tigervnc/x11vnc/tightvnc)

  Likewise, the client's inbound bandwidth is limited to 300KB/S, =

  although a lot of frame are lost, all of they still works (at least the m=
ouse is movable).

  It's found that when connect to QEMU via websocket, it never drop any fra=
mes.
  QEMU still sends a lot of data to its websocket even when the network is =
congested, =

  the process is continually consuming more memory, then it gets stack.

  =

  Expected results:
  -------------------------
  When the network is poor (non-LAN), QEMU would reduce the VNC data send t=
o its websocket correspondingly, and the memory usage remains stable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1718964/+subscriptions
