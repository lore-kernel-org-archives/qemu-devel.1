Received: from eggs.gnu.org ([2001:4830:134:3::10]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbn-0002vG-OR
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <max7255@yandex-team.ru>) id 1gFpbk-0007e3-D4
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:11 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:35276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <max7255@yandex-team.ru>)
	id 1gFpbj-0007d2-VZ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 20:04:08 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id E64A520F73
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:04:02 +0300 (MSK)
From: Maxim Samoylov <max7255@yandex-team.ru>
Date: Fri, 26 Oct 2018 03:03:39 +0300
Message-Id: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
Subject: [Qemu-devel] [PATCH RFC 0/4] slirp: support hostfwd for ipv6
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: max7255@yandex-team.ru

The following patch implements ipv6 host port forwarding support
for qemu slirp net subsystem.

The slirp itself supports ipv6 communication, but
hostfwd currently does not allow listening on and forwarding
ports for ipv6 addresses.

This should be useful, when host works in v6-capable environment
and guests should be accessible there.

Turns out the only thing should be done is to properly parse 
ipv6 addresses and pass them down to listening socket create logic.

The proposed option ipv6-hostfwd syntax is the same as for the hostfwd option,
but one should enclose their ipv6 addresses into square brackets, e.g.:

ipv6-hostfwd=tcp::7255-[fec0::5054:ff:fe12:3456]:80

The guest ipv6 address intended to be specified explicitly,
because there is no dhcpv6 server in slirp.


Maxim Samoylov (4):
  slirp: add helper for tcp6 socket creation
  slirp: add helper for udp6 socket creation
  slirp: add helpers for ipv6 hostfwd manipulation
  net/slirp: add ipv6-hostfwd option for user netdev type

 hmp-commands.hx     |  31 ++++++++
 include/net/slirp.h |   2 +
 net/slirp.c         | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/net.json       |   3 +-
 slirp/libslirp.h    |   6 ++
 slirp/slirp.c       |  43 +++++++++++
 slirp/socket.c      |  73 ++++++++++++++++++
 slirp/socket.h      |   2 +
 slirp/udp.c         |  48 ++++++++++++
 slirp/udp.h         |   2 +
 10 files changed, 423 insertions(+), 1 deletion(-)

-- 
2.7.4
