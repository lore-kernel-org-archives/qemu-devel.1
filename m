Received: from eggs.gnu.org ([209.51.188.92]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gj044-0006zF-EJ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gj043-000830-Hj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:05:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:46382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gj043-00080e-Bx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:05:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gj041-0007ew-QG
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 11:05:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B67E02E80CD
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 11:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Jan 2019 10:53:29 -0000
From: Daniel Berrange <1795100@bugs.launchpad.net>
Reply-To: Bug 1795100 <1795100@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153818746845.29396.3425570709275982365.malonedeb@soybean.canonical.com>
Message-Id: <154746320989.20384.17728890769906581562.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1795100] Re: VNC unix-domain socket unlink()ed
 prematurely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It only affects VNC, not chardevs because the chardevs fail to call
qio_channel_close() and just rely on finalize() cleaning up the open
socket. To fix this we just need to made the code conditional on it
being a listener socket

  if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_LISTEN)) {
   ...
  }

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795100

Title:
  VNC unix-domain socket unlink()ed prematurely

Status in QEMU:
  New

Bug description:
  With qemu 3.0.0 (I don't believe this happened with previous
  versions), if I tell it `-vnc unix:/path/to/vnc.sock`, qemu will
  unlink() that file when the first client disconnects, meaning that
  once I disconnect, I can't ever reconnect without restarting the VM.

  A stupid testcase demonstrating the issue:

  In terminal A:

      $ qemu-system-x86_64 -vnc unix:$PWD/vnc.sock

  In terminal B:

      $ ls vnc.sock
      vnc.sock
      $ socat STDIO UNIX-CONNECT:vnc.sock <<<''
      RFB 003.008
      $ ls vnc.sock
      ls: cannot access 'vnc.sock': No such file or directory

  I have determined that the offending unlink() call is the one in
  io/channel-socket.c:qio_channel_socket_close().  That call was first
  introduced in commit d66f78e1eaa832f73c771d9df1b606fe75d52a50, which
  first appeared in version 3.0.0.

  This type of premature unlink() does not happen on monitor.sock with
  `-monitor unix:/path/to/monitor.sock,server,nowait`.

  I am not familiar enough with the QIO subsystem to suggest a fix that
  fixes VNC, but preserves the QMP fix targeted in the offending commit.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1795100/+subscriptions
