Received: from eggs.gnu.org ([2001:4830:134:3::10]:37992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csZH6-0007sk-Tm
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1csZH3-0002zs-0j
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1csZH2-0002zY-Lz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Mar 2017 20:21:36 +0200
Message-Id: <20170327182137.7006-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>

This patch implements the SOCKS5 client part for "-net user" backend.

It allows to route all internet traffic of the virtual machine
to a SOCKS5 server.

But all the local traffic (to the host) is sent to the host.
It is needed because this SOCKS5 client doesn't route UDP traffic,
and this allows to use the host DNS server.

I've tested this using public SOCKS5 proxy list found on the WEB, and
using TOR server on my host.

Used with TOR, all the TCP connections are sent to the TOR network and
this allows to insert a virtual machine directly in the TOR network
without needing more configuration in the virtual machine.

But be aware that all DNS requests will be sent to the host that can
forward them to internet with its own IP address. So confidentiality
will not be as good as with the TOR browser which hides in the TOR
network all the DNS requests.

If you want to test this:

- with a public SOCKS5 server, ask google for "socks5 proxy address"
  and start QEMU with, for instance:

  qemu-system-x86_64 -net nic,model=e1000 -net user,proxy-server=46.105.121.37:63066 ...

  if needed, you can provide user/password with
  "-net user,...,proxy-user=user,proxy-passwd=passwd"

- with a local TOR proxy:

  sudo systemctl start tor
  qemu-system-x86_64 -net nic,model=e1000 -net user,proxy-server=localhost:9050 ...

You can check your IP address is the one of the proxy by connecting
to http://check.torproject.org with a browser inside the VM.

Laurent Vivier (1):
  slirp: add SOCKS5 support

 net/slirp.c         |  30 +++++-
 qapi-schema.json    |   3 +
 qemu-options.hx     |  11 ++
 slirp/Makefile.objs |   2 +-
 slirp/ip_icmp.c     |   2 +-
 slirp/libslirp.h    |   3 +
 slirp/slirp.c       |  66 +++++++++++-
 slirp/slirp.h       |   6 ++
 slirp/socket.h      |   4 +
 slirp/socks5.c      | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/socks5.h      |  85 ++++++++++++++++
 slirp/tcp_subr.c    |  21 +++-
 slirp/udp.c         |   9 ++
 slirp/udp6.c        |   2 +-
 14 files changed, 515 insertions(+), 12 deletions(-)
 create mode 100644 slirp/socks5.c
 create mode 100644 slirp/socks5.h

-- 
2.9.3
