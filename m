Received: from eggs.gnu.org ([209.51.188.92]:32797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwoHI-0003BH-Cl
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwoHG-0005cJ-GT
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:20:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gwoHE-0005aJ-TF
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:20:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gwoHD-0007ab-IZ
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 13:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8538E2E80C8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 13:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Feb 2019 13:10:57 -0000
From: Anisse Astier <1816819@bugs.launchpad.net>
Reply-To: Bug 1816819 <1816819@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155068228906.30253.11103905943605426100.malonedeb@chaenomeles.canonical.com>
Message-Id: <155075465707.31376.15095841911718508805.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1816819] Re: Chardev websocket stops listening
 after first connection disconnects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I can confirm that this patch fixes the issue. I can now reconnect after
a client has disconnected.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1816819

Title:
  Chardev websocket stops listening after first connection disconnects

Status in QEMU:
  New

Bug description:
  Using qemu option:
   -chardev socket,id=3Dwebsock0,websocket,port=3D13042,host=3D127.0.0.1,se=
rver,nowait -serial chardev:websock0

  To have a websocket listening chardev. After the first connection
  disconnects (that does a full websocket handshake), subsequent
  connections aren't accepted. See below for a reproducing session
  kindly provided by Daniel:

  $ telnet localhost 13042
  Trying ::1...
  telnet: connect to address ::1: Connection refused
  Trying 127.0.0.1...
  Connected to localhost.
  Escape character is '^]'.
  GET / HTTP/1.1
  Upgrade: websocket
  Connection: Upgrade
  Host: localhost:%s
  Origin: http://localhost
  Sec-WebSocket-Key: o9JHNiS3/0/0zYE1wa3yIw=3D=3D
  Sec-WebSocket-Version: 13
  Sec-WebSocket-Protocol: binary

  HTTP/1.1 101 Switching Protocols
  Server: QEMU VNC
  Date: Wed, 20 Feb 2019 16:52:04 GMT
  Upgrade: websocket
  Connection: Upgrade
  Sec-WebSocket-Accept: b3DnPh7O8hyYE5sIjQxl/c1J+S8=3D
  Sec-WebSocket-Protocol: binary

  sfsd
  =EF=BF=BD&=EF=BF=BDonly binary frames may be fragmentedConnection closed =
by foreign host.

  $ telnet localhost 13042
  Trying ::1...
  telnet: connect to address ::1: Connection refused
  Trying 127.0.0.1...
  Connected to localhost.
  Escape character is '^]'.
  GET / HTTP/1.1
  Upgrade: websocket
  Connection: Upgrade
  Host: localhost:%s
  Origin: http://localhost
  Sec-WebSocket-Key: o9JHNiS3/0/0zYE1wa3yIw=3D=3D
  Sec-WebSocket-Version: 13
  Sec-WebSocket-Protocol: binary


  ...no response.....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1816819/+subscriptions
