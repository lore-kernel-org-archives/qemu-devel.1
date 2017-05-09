Received: from eggs.gnu.org ([2001:4830:134:3::10]:53441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d8Ar6-0004R4-Vd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1d8Ar1-0000Zy-Rv
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:31:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1d8Ar1-0000ZL-GW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:31:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 May 2017 21:31:11 +0200
Message-Id: <20170509193112.16613-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 0/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>

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

  if needed, you can provide user/password using secret objects framework:
  "-object secret,id=sec0,data=password,format=raw \
   -net user,...,proxy-user=user,proxy-secretid=sec0"

- with a local TOR proxy:

  sudo systemctl start tor
  qemu-system-x86_64 -net nic,model=e1000 -net user,proxy-server=localhost:9050 ...

You can check your IP address is the one of the proxy by connecting
to http://check.torproject.org with a browser inside the VM.

v6:
  - fix error case in slirp_add_proxy()
  - add copyright and license in new files
  - add guards around socks5_recv() and socks5_send()

v5:
  - remove useless #includes

v4:
  - rebase
  - define some macros to use instead of meaningless values
  - better management of error cases
  - add some error logs

v3:
  - rewrite SOCKS5 functions from scratch and drop code from nmap/ncat
  - don't drop the IPv6 UDP local traffic
  - don't pass to the proxy the IPv6 TCP local traffic
  - add some comments...

v2:
  - use secret objects framework to provide password
  - add documentation for new parameters in qapi-schema.json
  - s/passwd/password/g
  - I didn't move proxy paramaters to a substruct as I didn't
    find a way to set them from the command line :(

Laurent Vivier (1):
  slirp: add SOCKS5 support

 net/slirp.c         |  39 +++++-
 qapi-schema.json    |   9 ++
 qemu-options.hx     |  11 ++
 slirp/Makefile.objs |   2 +-
 slirp/ip_icmp.c     |   2 +-
 slirp/libslirp.h    |   3 +
 slirp/slirp.c       |  65 +++++++++
 slirp/slirp.h       |   6 +
 slirp/socket.h      |   4 +
 slirp/socks5.c      | 379 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/socks5.h      |  31 +++++
 slirp/tcp_subr.c    |  22 ++-
 slirp/udp.c         |   9 ++
 slirp/udp6.c        |   8 ++
 14 files changed, 583 insertions(+), 7 deletions(-)
 create mode 100644 slirp/socks5.c
 create mode 100644 slirp/socks5.h

-- 
2.9.3
