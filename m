Received: from eggs.gnu.org ([209.51.188.92]:56948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk65f-00051h-ND
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk65e-000481-QB
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk65e-00045x-Ho
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:32 +0400
Message-Id: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/27] slirp: make it again a standalone
 project (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Hi,

The goal is to allow building libslirp as an independent library.

After this series is applied, it is possible to build an independent
libslirp.  However, QEMU still requires internals of libslirp to
handle migration. I will be posting the remaining part to handle
migration and link with the external libslirp in a 3rd part.

Marc-Andr=C3=A9 Lureau (27):
  slirp: generalize guestfwd with a callback based approach
  net/slirp: simplify checking for cmd: prefix
  net/slirp: free forwarding rules on cleanup
  net/slirp: fix leaks on forwaring rule registration error
  slirp: add callbacks for timer
  slirp: replace trace functions with DEBUG calls
  slirp: replace QEMU_PACKED with SLIRP_PACKED
  slirp: replace most qemu socket utilities with slirp own version
  slirp: replace qemu_set_nonblock()
  slirp: add unregister_poll_fd() callback
  slirp: replace qemu_notify_event() with a callback
  slirp: move QEMU state saving to a separate unit
  slirp: do not include qemu headers in libslirp.h public API header
  slirp: improve windows headers inclusion
  slirp: add slirp own version of pstrcpy
  slirp: remove qemu timer.h dependency
  slirp: remove now useless QEMU headers inclusions
  slirp: replace net/eth.h inclusion with own defines
  slirp: replace qemu qtailq with slirp own copy
  slirp: replace remaining qemu headers dependency
  slirp: prefer c99 types over BSD kind
  slirp: improve send_packet() callback
  slirp: replace global polling with per-instance & notifier
  slirp: remove slirp_instances list
  slirp: use polling callbacks, drop glib requirement
  slirp: pass opaque to all callbacks
  slirp: API is extern C

 include/net/net.h        |   2 +-
 include/qemu/main-loop.h |  15 +
 slirp/debug.h            |  13 +-
 slirp/ip.h               |  14 +-
 slirp/ip6.h              |   5 +-
 slirp/ip6_icmp.h         |  16 +-
 slirp/ip_icmp.h          |  18 +-
 slirp/libslirp.h         |  71 ++-
 slirp/main.h             |   2 +-
 slirp/mbuf.h             |   2 +-
 slirp/misc.h             |  15 +-
 slirp/qtailq.h           | 193 ++++++++
 slirp/sbuf.h             |   2 +-
 slirp/slirp.h            |  45 +-
 slirp/socket.h           |   9 +-
 slirp/state.h            |   9 +
 slirp/tcp_var.h          |  14 +-
 slirp/udp.h              |   2 +-
 slirp/util.h             | 128 +++++
 net/net.c                |   4 +-
 net/slirp.c              | 185 +++++++-
 slirp/arp_table.c        |   1 -
 slirp/bootp.c            |   1 -
 slirp/cksum.c            |   1 -
 slirp/dhcpv6.c           |   4 +-
 slirp/dnssearch.c        |   1 -
 slirp/if.c               |   4 +-
 slirp/ip6_icmp.c         |  27 +-
 slirp/ip6_input.c        |   1 -
 slirp/ip6_output.c       |   2 -
 slirp/ip_icmp.c          |  14 +-
 slirp/ip_input.c         |   5 +-
 slirp/ip_output.c        |   1 -
 slirp/mbuf.c             |   1 -
 slirp/misc.c             |  64 +--
 slirp/ncsi.c             |   3 +-
 slirp/ndp_table.c        |   2 -
 slirp/sbuf.c             |   8 +-
 slirp/slirp.c            | 978 ++++++++++++---------------------------
 slirp/socket.c           |  33 +-
 slirp/state.c            | 394 ++++++++++++++++
 slirp/tcp_input.c        |  29 +-
 slirp/tcp_output.c       |  13 +-
 slirp/tcp_subr.c         |  49 +-
 slirp/tcp_timer.c        |   3 +-
 slirp/tftp.c             |  16 +-
 slirp/udp.c              |  16 +-
 slirp/udp6.c             |   2 -
 slirp/util.c             | 205 ++++++++
 stubs/slirp.c            |  13 -
 util/main-loop.c         |  30 +-
 util/osdep.c             |   2 +-
 Makefile.objs            |   1 -
 slirp/Makefile.objs      |   4 +-
 slirp/trace-events       |   5 -
 stubs/Makefile.objs      |   3 +-
 56 files changed, 1739 insertions(+), 961 deletions(-)
 create mode 100644 slirp/qtailq.h
 create mode 100644 slirp/state.h
 create mode 100644 slirp/util.h
 create mode 100644 slirp/state.c
 create mode 100644 slirp/util.c
 delete mode 100644 stubs/slirp.c
 delete mode 100644 slirp/trace-events

--=20
2.20.1.98.gecbdaf0899
