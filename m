Received: from eggs.gnu.org ([209.51.188.92]:59671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaX-0003aA-Nt
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYJ-0001m1-18
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:36 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:57:53 -0600
Message-Id: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/19] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

I got tired of debugging whether a server was advertising the
correct things during negotiation by inspecting the trace
logs of qemu-io as client - not to mention that without SOME
sort of client tracing particular commands, we can't easily
regression test the server for correct behavior.  The final
straw was at KVM Forum, when Nir asked me to make sure there
was a way to easily determine if an NBD server is exposing what
we really want (and fixing x-dirty-bitmap to behave saner fell
out as a result of answering that question).

I note that upstream NBD has 'nbd-client -l $host' for querying
just export names (with no quoting, so you have to know that
a blank line means the default export), but it wasn't powerful
enough, so I implemented 'qemu-nbd -L' to document everything.
Upstream NBD has separate 'nbd-client' and 'nbd-server' binaries,
while we only have 'qemu-nbd' (which is normally just a server,
but 'qemu-nbd -c' also operates a second thread as a client).
Our other uses of qemu as NBD client are for consuming a block
device (as in qemu-io, qemu-img, or a drive to qemu) - but those
binaries are less suited to something so specific to the NBD
protocol.

Bonus: As a result of my work on this series, nbdkit now supports
NBD_OPT_INFO (my interoperability testing between server
implementations has been paying off, both at fixing server bugs,
and at making this code more reliable across difference in valid
servers).

Also available at:
https://repo.or.cz/qemu/ericb.git qemu-nbd-list-v2

Based-on: <20181221093529.23855-1-jsnow@redhat.com>
[jsnow: 0/11 bitmaps: remove x- prefix from QMP api]
Based-on: <20190111163519.11457-1-philmd@redhat.com>
[philmd: qemu-nbd: Rename 'exp' variable clashing with math::exp() symbol=
]
Based-on: <20190111194720.15671-1-eblake@redhat.com>
[eblake: 0/8 Promote x-nbd-server-add-bitmap to stable]

Since v2:
- Several patches merged already
- 3 new patches based on audit of off_t vs. strtol
- rebase patches on top of other changes, such as qemu-nbd --bitmap
- address various review comments [Vladimir, Rich]
- drop patch 12/22

001/19:[0020] [FC] 'maint: Allow for EXAMPLES in texi2pod'
002/19:[0030] [FC] 'qemu-nbd: Enhance man page'
003/19:[down] 'qemu-nbd: Sanity check partition bounds'
004/19:[down] 'nbd/server: Hoist length check to qemp_nbd_server_add'
005/19:[down] 'nbd/server: Favor [u]int64_t over off_t'
006/19:[0007] [FC] 'qemu-nbd: Avoid strtol open-coding'
007/19:[0016] [FC] 'nbd/client: Refactor nbd_receive_list()'
008/19:[----] [--] 'nbd/client: Move export name into NBDExportInfo'
009/19:[----] [--] 'nbd/client: Change signature of nbd_negotiate_simple_=
meta_context()'
010/19:[0007] [FC] 'nbd/client: Split out nbd_send_one_meta_context()'
011/19:[0048] [FC] 'nbd/client: Split out nbd_receive_one_meta_context()'
012/19:[----] [--] 'nbd/client: Refactor return of nbd_receive_negotiate(=
)'
013/19:[----] [-C] 'nbd/client: Split handshake into two functions'
014/19:[----] [--] 'nbd/client: Pull out oldstyle size determination'
015/19:[0008] [FC] 'nbd/client: Add nbd_receive_export_list()'
016/19:[----] [-C] 'nbd/client: Add meta contexts to nbd_receive_export_l=
ist()'
017/19:[0015] [FC] 'qemu-nbd: Add --list option'
018/19:[----] [--] 'nbd/client: Work around 3.0 bug for listing meta cont=
exts'
019/19:[0002] [FC] 'iotests: Enhance 223, 233 to cover 'qemu-nbd --list''

Eric Blake (19):
  maint: Allow for EXAMPLES in texi2pod
  qemu-nbd: Enhance man page
  qemu-nbd: Sanity check partition bounds
  nbd/server: Hoist length check to qemp_nbd_server_add
  nbd/server: Favor [u]int64_t over off_t
  qemu-nbd: Avoid strtol open-coding
  nbd/client: Refactor nbd_receive_list()
  nbd/client: Move export name into NBDExportInfo
  nbd/client: Change signature of nbd_negotiate_simple_meta_context()
  nbd/client: Split out nbd_send_one_meta_context()
  nbd/client: Split out nbd_receive_one_meta_context()
  nbd/client: Refactor return of nbd_receive_negotiate()
  nbd/client: Split handshake into two functions
  nbd/client: Pull out oldstyle size determination
  nbd/client: Add nbd_receive_export_list()
  nbd/client: Add meta contexts to nbd_receive_export_list()
  qemu-nbd: Add --list option
  nbd/client: Work around 3.0 bug for listing meta contexts
  iotests: Enhance 223, 233 to cover 'qemu-nbd --list'

 qemu-nbd.texi              | 114 ++++--
 Makefile                   |   2 +
 include/block/nbd.h        |  31 +-
 block/nbd-client.c         |   9 +-
 blockdev-nbd.c             |  10 +-
 nbd/client.c               | 756 ++++++++++++++++++++++++++-----------
 nbd/server.c               |  23 +-
 qemu-nbd.c                 | 221 ++++++++---
 nbd/trace-events           |  11 +-
 scripts/texi2pod.pl        |   2 +-
 tests/qemu-iotests/223     |   2 +
 tests/qemu-iotests/223.out |  20 +
 tests/qemu-iotests/233     |  19 +-
 tests/qemu-iotests/233.out |  15 +
 14 files changed, 910 insertions(+), 325 deletions(-)

--=20
2.20.1
