Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e5uxS-00074P-6d
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 10:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e5uxP-0006VQ-3X
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 10:41:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e5uxO-0006V4-Q5
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 10:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e5uxN-00048D-Bn
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 14:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B2562E80D0
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 14:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Oct 2017 14:29:44 -0000
From: Carl Brassey <1725707@bugs.launchpad.net>
Reply-To: Bug 1725707 <1725707@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150859618440.18353.4071279587956365769.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1725707] [NEW] QEMU sends excess VNC data to
 websockify even when network is poor
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

Description of problem
-------------------------
In my latest topic, I reported a bug relate to QEMU's websocket:
https://bugs.launchpad.net/qemu/+bug/1718964

It has been fixed but someone mentioned that he met the same problem when u=
sing QEMU with a standalone websocket proxy.
That makes me confused because in that scenario QEMU will get a "RAW" VNC c=
onnection.
So I did a test and found that there indeed existed some problems. The prob=
lem is:

When the client's network is poor (on a low speed WAN), QEMU still sends
a lot of data to the websocket proxy, then the client get stuck. It
seems that only QEMU has this problem, other VNC servers works fine.

Environment
-------------------------
All of the following versions have been tested:

QEMU: 2.8.1.1 / 2.9.1 / 2.10.1 / master (Up to date)
Host OS: Ubuntu 16.04 Server LTS / CentOS 7 x86_64_1611
Websocket Proxy: websockify 0.6.0 / 0.7.0 / 0.8.0 / master
VNC Web Client: noVNC 0.5.1 / 0.61 / 0.62 / master
Other VNC Servers: TigerVNC 1.8 / x11vnc 0.9.13 / TightVNC 2.8.8

Steps to reproduce:
-------------------------
100% reproducible.

1. Launch a QEMU instance (No need websocket option):
qemu-system-x86_64 -enable-kvm -m 6G ./win_x64.qcow2 -vnc :0

2. Launch websockify on a separate host and connect to QEMU's VNC port

3. Open VNC Web Client (noVNC/vnc.html) in browser and connect to
websockify

4. Play a video (e.g. Watch YouTube) on VM (To produce a lot of frame
buffer update)

5. Limit (e.g. Use NetLimiter) the client inbound bandwidth to 300KB/S
(To simulate a low speed WAN)

6. Then client's output gets stuck(less than 1 fps), the cursor is
almost impossible to move

7. Monitor network traffic on the proxy server

Current result:
-------------------------
Monitor Downlink/Uplink network traffic on the proxy server
(Refer to the attachments for more details).

1. Used with QEMU
- D: 5.9 MB/s U: 5.7 MB/s (Client on LAN)
- D: 4.3 MB/s U: 334 KB/s (Client on WAN)

2. Used with other VNC servers
- D: 5.9 MB/s U: 5.6 MB/s (Client on LAN)
- D: 369 KB/s U: 328 KB/s (Client on WAN)

It is found that when the client's network is poor, all the VNC servers
(tigervnc/x11vnc/tightvnc) will reduce the VNC data send to websocket
proxy (uplink and downlink symmetry), but QEMU never drop any frames and
still sends a lot of data to websockify, the client has no capacity to
accept so much data, more and more data are accumulated in the
websockify, then it crashes.

Expected results:
-------------------------
When the client's network is poor (WAN), QEMU will reduce the VNC data send=
 to websocket proxy.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Topology"
   https://bugs.launchpad.net/bugs/1725707/+attachment/4982275/+files/Topol=
ogy.jpg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1725707

Title:
  QEMU sends excess VNC data to websockify even when network is poor

Status in QEMU:
  New

Bug description:
  Description of problem
  -------------------------
  In my latest topic, I reported a bug relate to QEMU's websocket:
  https://bugs.launchpad.net/qemu/+bug/1718964

  It has been fixed but someone mentioned that he met the same problem when=
 using QEMU with a standalone websocket proxy.
  That makes me confused because in that scenario QEMU will get a "RAW" VNC=
 connection.
  So I did a test and found that there indeed existed some problems. The pr=
oblem is:

  When the client's network is poor (on a low speed WAN), QEMU still
  sends a lot of data to the websocket proxy, then the client get stuck.
  It seems that only QEMU has this problem, other VNC servers works
  fine.

  Environment
  -------------------------
  All of the following versions have been tested:

  QEMU: 2.8.1.1 / 2.9.1 / 2.10.1 / master (Up to date)
  Host OS: Ubuntu 16.04 Server LTS / CentOS 7 x86_64_1611
  Websocket Proxy: websockify 0.6.0 / 0.7.0 / 0.8.0 / master
  VNC Web Client: noVNC 0.5.1 / 0.61 / 0.62 / master
  Other VNC Servers: TigerVNC 1.8 / x11vnc 0.9.13 / TightVNC 2.8.8

  Steps to reproduce:
  -------------------------
  100% reproducible.

  1. Launch a QEMU instance (No need websocket option):
  qemu-system-x86_64 -enable-kvm -m 6G ./win_x64.qcow2 -vnc :0

  2. Launch websockify on a separate host and connect to QEMU's VNC port

  3. Open VNC Web Client (noVNC/vnc.html) in browser and connect to
  websockify

  4. Play a video (e.g. Watch YouTube) on VM (To produce a lot of frame
  buffer update)

  5. Limit (e.g. Use NetLimiter) the client inbound bandwidth to 300KB/S
  (To simulate a low speed WAN)

  6. Then client's output gets stuck(less than 1 fps), the cursor is
  almost impossible to move

  7. Monitor network traffic on the proxy server

  Current result:
  -------------------------
  Monitor Downlink/Uplink network traffic on the proxy server
  (Refer to the attachments for more details).

  1. Used with QEMU
  - D: 5.9 MB/s U: 5.7 MB/s (Client on LAN)
  - D: 4.3 MB/s U: 334 KB/s (Client on WAN)

  2. Used with other VNC servers
  - D: 5.9 MB/s U: 5.6 MB/s (Client on LAN)
  - D: 369 KB/s U: 328 KB/s (Client on WAN)

  It is found that when the client's network is poor, all the VNC
  servers (tigervnc/x11vnc/tightvnc) will reduce the VNC data send to
  websocket proxy (uplink and downlink symmetry), but QEMU never drop
  any frames and still sends a lot of data to websockify, the client has
  no capacity to accept so much data, more and more data are accumulated
  in the websockify, then it crashes.

  Expected results:
  -------------------------
  When the client's network is poor (WAN), QEMU will reduce the VNC data se=
nd to websocket proxy.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1725707/+subscriptions
