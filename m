Received: from eggs.gnu.org ([2001:4830:134:3::10]:58435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuPm-0007bK-Cr
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuPj-0000aM-5M
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:37:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuPi-0000ZC-Tf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:36:59 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:02 +0400
Message-Id: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
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
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

What do you think?

Marc-Andr=C3=A9 Lureau (41):
  slirp: move socket pair creation in helper function
  glib-compat: add g_spawn_async_with_fds() fallback
  slirp: simplify fork_exec()
  slirp: remove unused M_TRAILINGSPACE
  slirp: use a callback structure to interface with qemu
  slirp: add a callback for qemu_chr_fe_write_all()
  slirp: add clock_get_ns() callback
  slirp: add callbacks for timer
  slirp: add a set_nonblock() callback
  slirp: remove PROBE_CONN dead-code
  slirp: remove FULL_BOLT
  slirp: remove the disabled readv()/writev() code path
  slirp: remove HAVE_SYS_SIGNAL_H
  slirp: remove unused HAVE_SYS_BITYPES_H
  slirp: remove NO_UNIX_SOCKETS
  slirp: remove unused HAVE_SYS_STROPTS_H
  slirp: remove unused HAVE_ARPA_INET_H
  slirp: remove unused HAVE_SYS_WAIT_H
  slirp: remove unused HAVE_SYS_SELECT_H
  slirp: remove HAVE_SYS_IOCTL_H
  slirp: remove HAVE_SYS_FILIO_H
  slirp: remove unused DECLARE_IOVEC
  slirp: remove unused HAVE_INET_ATON
  slirp: replace HOST_WORDS_BIGENDIAN with glib equivalent
  slirp: replace SIZEOF_CHAR_P with glib equivalent
  slirp: replace compile time DO_KEEPALIVE
  slirp: remove unused global slirp_instance
  slirp: replace error_report() with g_critical()
  slirp: improve a bit the debug macros
  slirp: replace trace functions with DEBUG calls
  slirp: add a callback to log guest errors
  slirp: remove unused sbflush()
  slirp: replace qemu_notify_event() with a callback
  slirp: remove #if notdef dead code
  slirp: NULL is defined by glib (at least)
  slirp: remove dead TCP_ACK_HACK code
  slirp: replace ARRAY_SIZE with G_N_ELEMENTS
  net: do not depend on slirp internals
  slirp: move QEMU state saving to a separate unit
  slirp: replace remaining QEMU dependency
  build-sys: add a basic meson build

 include/glib-compat.h |  56 ++++++
 net/colo.h            |   3 +-
 net/util.h            |  55 +++++
 slirp/debug.h         |  47 ++++-
 slirp/ip.h            |  24 ++-
 slirp/ip6.h           |   8 +-
 slirp/ip6_icmp.h      |  22 +-
 slirp/libslirp.h      |  35 +++-
 slirp/main.h          |   4 -
 slirp/mbuf.h          |   1 -
 slirp/qtailq.h        | 218 ++++++++++++++++++++
 slirp/sbuf.h          |   3 +-
 slirp/slirp.h         |  58 ++----
 slirp/slirp_config.h  |  86 --------
 slirp/socket.h        |   1 +
 slirp/state.h         |   9 +
 slirp/tcp.h           |   4 +-
 slirp/util.h          | 145 +++++++++++++
 net/colo-compare.c    |   1 +
 net/colo.c            |   1 +
 net/filter-rewriter.c |   1 +
 net/slirp.c           |  65 +++++-
 slirp/arp_table.c     |  13 +-
 slirp/bootp.c         |   4 +-
 slirp/cksum.c         |   5 +-
 slirp/dhcpv6.c        |  19 +-
 slirp/dnssearch.c     |   1 -
 slirp/if.c            |   6 +-
 slirp/ip6_icmp.c      |  34 ++--
 slirp/ip6_input.c     |   1 -
 slirp/ip6_output.c    |   2 -
 slirp/ip_icmp.c       |  25 ++-
 slirp/ip_input.c      | 201 ------------------
 slirp/ip_output.c     |   1 -
 slirp/mbuf.c          |   3 +-
 slirp/misc.c          | 188 +++++++++--------
 slirp/ncsi.c          |   5 +-
 slirp/ndp_table.c     |  20 +-
 slirp/sbuf.c          |   8 +-
 slirp/slirp.c         | 458 +++---------------------------------------
 slirp/socket.c        |  72 +++----
 slirp/state.c         | 394 ++++++++++++++++++++++++++++++++++++
 slirp/tcp_input.c     |  86 ++------
 slirp/tcp_output.c    |   3 +-
 slirp/tcp_subr.c      |  21 +-
 slirp/tcp_timer.c     |   3 +-
 slirp/tftp.c          |  18 +-
 slirp/udp.c           |  13 +-
 slirp/udp6.c          |   8 +-
 slirp/util.c          | 176 ++++++++++++++++
 stubs/slirp.c         |   2 +-
 Makefile.objs         |   1 -
 slirp/Makefile.objs   |   4 +-
 slirp/meson.build     |  48 +++++
 slirp/trace-events    |   5 -
 55 files changed, 1547 insertions(+), 1148 deletions(-)
 create mode 100644 slirp/qtailq.h
 delete mode 100644 slirp/slirp_config.h
 create mode 100644 slirp/state.h
 create mode 100644 slirp/util.h
 create mode 100644 slirp/state.c
 create mode 100644 slirp/util.c
 create mode 100644 slirp/meson.build
 delete mode 100644 slirp/trace-events

--=20
2.19.1.708.g4ede3d42df
