Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Gavin.Grant@mathworks.co.uk>) id 1fvPMH-00025X-Fz
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Gavin.Grant@mathworks.co.uk>) id 1fvPMC-0002rl-GQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:59:45 -0400
Received: from mail-dm3nam03on0627.outbound.protection.outlook.com
	([2a01:111:f400:fe49::627]:15712
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Gavin.Grant@mathworks.co.uk>)
	id 1fvPM8-0002oY-Mk
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:59:38 -0400
From: Gavin Grant <gavingrant@protonmail.com>
Date: Thu, 30 Aug 2018 16:57:56 +0100
Message-ID: <20180830155757.103694-1-gavingrant@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] slirp: Propagate host TCP RST packet to the
 guest after socket disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org

[PATCH] slirp: Propagate host TCP RST packet to the guest after socket disconnected

Please bear with me, since this is my first correspondence with the qemu-devel
mailing list (or any public devel mailing list for that matter!).

I believe I have witnessed a discrepancy between SLIRP TCP and normal UNIX/Linux
TCP behaviour relating to the sending of RST packet(s) after a socket has been
closed gracefully by a host client application, then the application
subsequently exits. When the host socket is closed gracefully, it is in a
"half-closed" state. i.e. The socket can no longer be read from, but it can be
written to and will wait in FIN_WAIT_1 & FIN_WAIT_2 states until the remote peer
sends a FIN. This is fine. But when the application exits, the host socket is no
longer connected. I would expect subsequent slirp_send() calls to return an EPIPE
error, causing RST packet(s) to be sent to the server, causing it to close its
socket.

However, unlike soread() in 27d92ebc5ed1bb0b518d0ebc4c609182ad20a799, sowrite()
does not call tcp_drop() for specific errno's, so the server socket will remain
open. sbappend() does not implement error handling, as it relies on errors to
be handled in soread().

My proposed patch attempts to address this by checking for closed & disconnected
socket status in soread(). Forgive me if my logic and proposal are foolish!

The application(s) that I observed this behaviour from were libiio test
programs (https://github.com/analogdevicesinc/libiio/tree/master/tests), which
connect to an iiod daemon process running on the server, to interface with the
Linux Industrial Input/Output (IIO) subsystem. I noticed that if iiod is running
on a QEMU server with SLIRP, then iiod does not notice when client applications
close their connection and exit. This can result in multiple threads open on the
server, with their sockets stuck in the CLOSE_WAIT state. Once several of these
threads exist, my QEMU system becomes extremely slow and unusable.
