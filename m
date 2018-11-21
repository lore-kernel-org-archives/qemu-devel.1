Received: from eggs.gnu.org ([2001:4830:134:3::10]:50391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaeI-0003bo-39
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaeA-0000gV-2e
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPae9-0000es-QX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:06:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:17 +0400
Message-Id: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 00/30] slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch

This series goal is to allow building libslirp as an independent library.

While looking at making SLIRP a seperate running process, I thought
that having an independent library from QEMU would be a first step.

There has been some attempts to make slirp a seperate project in the past=
.
(https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
Unfortunately, they forked from QEMU and didn't provide enough
compatibility for QEMU to make use of it (in particular, vmstate
handling was removed, they lost git history etc). Furthermore, they
are not maintained as far as I can see.

I would propose to make slirp a seperate project, that can initially
be used by QEMU as a submodule, keeping Makefile.objs until a proper
shared library with stability guarantees etc is ready..

The subproject could created by preserving git tags, and cleaning up the =
code style, this way:

git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clang-fo=
rmat -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-empty =
--tag-name-filter cat -- --all
(my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8a240=
4678ac73)

v2:
 - rebased on top of maintainer tree (thanks for picking patches,
   and reducing the burden of long series!)
 - added "slirp: drop <Vista compatibility" (although it is a bit problem=
atic)
 - follow a suggestion from Paolo, and refactor the exec_list/guestfwd
 - added "slirp: use virtual time for packet expiration", following Paolo=
 suggestion
 - drop the "scale" argument from the timer API
 - changed the build-sys to group objects in slirp.mo, to allow
   slirp-cflags, among other benefits
 - move to glib logging, set G_LOG_DOMAIN, add SLIRP_DEBUG environment va=
riable
 - document the added callbacks, as requested by Stefan H.
 - a few more cleanups

Marc-Andr=C3=A9 Lureau (30):
  fixup! net: do not depend on slirp internals
  slirp: drop <Vista compatibility
  glib-compat: add g_spawn_async_with_fds() fallback
  slirp: simplify fork_exec()
  slirp: rename exec_list
  slirp: factor out guestfwd addition checks
  slirp: generalize guestfwd with a callback based approach
  net/slirp: simplify checking for cmd: prefix
  net/slirp: fix a few memory leaks
  slirp: use virtual time for packet expiration
  slirp: add clock_get_ns() callback
  slirp: add callbacks for timer
  build-sys: use a seperate slirp-obj-y && slirp.mo
  slirp: set G_LOG_DOMAIN
  slirp: replace error_report() and a fprintf with g_critical()
  slirp: replace some fprintf() with DEBUG_MISC
  slirp: replace a DEBUG block with WITH_ICMP_ERROR_MSG
  slirp: no need to make DPRINTF conditional on DEBUG
  slirp: always build with debug statements
  slirp: introduce SLIRP_DEBUG environment variable
  slirp: use %p for pointers format
  slirp: remove remaining DEBUG blocks
  slirp: replace DEBUG_ARGS with DEBUG_ARG
  slirp: call into g_debug() for DEBUG macros
  slirp: replace trace functions with DEBUG calls
  slirp: add a set_nonblock() callback
  slirp: replace qemu_notify_event() with a callback
  slirp: move QEMU state saving to a separate unit
  slirp: replace remaining QEMU dependency
  build-sys: add a basic meson build

 include/glib-compat.h |  56 +++++
 net/colo.h            |   1 +
 net/util.h            |  26 +++
 slirp/debug.h         |  45 ++--
 slirp/ip.h            |  14 +-
 slirp/ip6.h           |   5 +-
 slirp/ip6_icmp.h      |  16 +-
 slirp/libslirp.h      |  38 +++-
 slirp/misc.h          |  19 +-
 slirp/qtailq.h        | 218 +++++++++++++++++++
 slirp/sbuf.h          |   2 +-
 slirp/slirp.h         |  19 +-
 slirp/socket.h        |   5 +-
 slirp/state.h         |   9 +
 slirp/util.h          | 148 +++++++++++++
 net/slirp.c           |  94 +++++---
 slirp/arp_table.c     |  13 +-
 slirp/bootp.c         |   8 +-
 slirp/cksum.c         |   9 +-
 slirp/dhcpv6.c        |   8 +-
 slirp/dnssearch.c     |   1 -
 slirp/if.c            |   4 +-
 slirp/ip6_icmp.c      |  34 ++-
 slirp/ip6_input.c     |   3 +-
 slirp/ip6_output.c    |   6 +-
 slirp/ip_icmp.c       |  30 +--
 slirp/ip_input.c      |   1 -
 slirp/ip_output.c     |   1 -
 slirp/mbuf.c          |   1 -
 slirp/misc.c          | 132 ++++++------
 slirp/ncsi.c          |   1 -
 slirp/ndp_table.c     |  34 ++-
 slirp/sbuf.c          |   8 +-
 slirp/slirp.c         | 490 ++++++++----------------------------------
 slirp/socket.c        |  51 +++--
 slirp/state.c         | 394 +++++++++++++++++++++++++++++++++
 slirp/tcp_input.c     |  26 ++-
 slirp/tcp_output.c    |   3 +-
 slirp/tcp_subr.c      |  27 ++-
 slirp/tcp_timer.c     |   1 -
 slirp/tftp.c          |  14 +-
 slirp/udp.c           |  12 +-
 slirp/udp6.c          |  13 +-
 slirp/util.c          | 176 +++++++++++++++
 Makefile.objs         |   4 +-
 Makefile.target       |   5 +-
 slirp/Makefile.objs   |  39 +++-
 slirp/meson.build     |  48 +++++
 slirp/trace-events    |   5 -
 49 files changed, 1553 insertions(+), 764 deletions(-)
 create mode 100644 slirp/qtailq.h
 create mode 100644 slirp/state.h
 create mode 100644 slirp/util.h
 create mode 100644 slirp/state.c
 create mode 100644 slirp/util.c
 create mode 100644 slirp/meson.build
 delete mode 100644 slirp/trace-events

--=20
2.20.0.rc1
