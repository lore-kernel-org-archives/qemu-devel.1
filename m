Received: from eggs.gnu.org ([2001:4830:134:3::10]:58955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZbWl-0000Gy-3p
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZbWb-0006PZ-PY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:00:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZbWb-0006Me-Kd
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:00:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZbWa-00088N-63
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 12:00:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 23D412E80CB
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 12:00:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jan 2018 11:45:35 -0000
From: Bram Klein Gunnewiek <1156632@bugs.launchpad.net>
Reply-To: Bug 1156632 <1156632@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130318143527.10807.8580.malonedeb@wampee.canonical.com>
Message-Id: <151567113522.23701.1416869655133359568.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1156632] Re: not receiving RESET event after
 system_reset command causes QMP connection to die
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm not sure, the current implementation is multi-threaded so I won't
hit this bug if its still present. If I can find the time I will make a
proof of concept and test if the bug is still present.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1156632

Title:
  not receiving RESET event after system_reset command causes QMP
  connection to die

Status in QEMU:
  Incomplete

Bug description:
  I have written my own implementation to control machine running KVM
  instances with the QMP protocol. Its a pretty basic implementation
  that sends/receives in the same thread. This means that all of the
  events QEMU sents are received only when the application expects a
  reply from a command. In the following scenario, i'm unable to
  (re)connect to the QMP socket from QEMU after I closed the connection:

  1) Connect to QMP =

  2) Sent qmp_capabilities
  3) Receive reply
  4) Send system_reset
  5) Receive reply
  6) close socket
  7) Connect to socket -> connection refused

  However, in the following scenario, I am able to connect after I disconne=
ct the socket because I have read the two RESET events:
  1) Connect to QMP =

  2) Sent qmp_capabilities
  3) Receive reply
  4) Send system_reset
  5) Receive reply
  6) Receive reply (is a RESET event)
  7) Receive reply (is a RESET event)
  8) close socket
  9) Connect to socket -> ok

  I don't know if this is a bug or expected behavior. I can't find any
  proper way to disconnect the socket documentated. Am I do=C3=AFng somethi=
ng
  wrong, or is this a bug in the QMP implementation of QEMU?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1156632/+subscriptions
