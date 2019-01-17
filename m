Received: from eggs.gnu.org ([209.51.188.92]:33276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTQ-0004Bh-Ry
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTO-00087Y-Pi
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:08 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:37 -0600
Message-Id: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
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
https://repo.or.cz/qemu/ericb.git qemu-nbd-list-v4

Currently based on master.

Since v3:
- 1 new patch (1/21)
- split old patch 15/19 into two (16,17/21)
- retitle two patches (git backport-diff doesn't do too well at showing
the diff on a retitled patch; 5,11/21)
- fix review comments from Rich, Vladimir

001/21:[down] 'iotests: Make 233 output more reliable'
002/21:[----] [--] 'maint: Allow for EXAMPLES in texi2pod'
003/21:[----] [--] 'qemu-nbd: Enhance man page'
004/21:[0006] [FC] 'qemu-nbd: Sanity check partition bounds'
005/21:[down] 'nbd/server: Hoist length check to qmp_nbd_server_add'
006/21:[0025] [FC] 'nbd/server: Favor [u]int64_t over off_t'
007/21:[----] [-C] 'qemu-nbd: Avoid strtol open-coding'
008/21:[----] [--] 'nbd/client: Refactor nbd_receive_list()'
009/21:[----] [--] 'nbd/client: Move export name into NBDExportInfo'
010/21:[----] [--] 'nbd/client: Change signature of nbd_negotiate_simple_=
meta_context()'
011/21:[down] 'nbd/client: Split out nbd_send_meta_query()'
012/21:[0003] [FC] 'nbd/client: Split out nbd_receive_one_meta_context()'
013/21:[----] [--] 'nbd/client: Refactor return of nbd_receive_negotiate(=
)'
014/21:[0003] [FC] 'nbd/client: Split handshake into two functions'
015/21:[----] [-C] 'nbd/client: Pull out oldstyle size determination'
016/21:[down] 'nbd/client: Refactor nbd_opt_go() to support NBD_OPT_INFO'
017/21:[0032] [FC] 'nbd/client: Add nbd_receive_export_list()'
018/21:[0006] [FC] 'nbd/client: Add meta contexts to nbd_receive_export_l=
ist()'
019/21:[0014] [FC] 'qemu-nbd: Add --list option'
020/21:[0004] [FC] 'nbd/client: Work around 3.0 bug for listing meta cont=
exts'
021/21:[0002] [FC] 'iotests: Enhance 223, 233 to cover 'qemu-nbd --list''

Eric Blake (21):
  iotests: Make 233 output more reliable
  maint: Allow for EXAMPLES in texi2pod
  qemu-nbd: Enhance man page
  qemu-nbd: Sanity check partition bounds
  nbd/server: Hoist length check to qmp_nbd_server_add
  nbd/server: Favor [u]int64_t over off_t
  qemu-nbd: Avoid strtol open-coding
  nbd/client: Refactor nbd_receive_list()
  nbd/client: Move export name into NBDExportInfo
  nbd/client: Change signature of nbd_negotiate_simple_meta_context()
  nbd/client: Split out nbd_send_meta_query()
  nbd/client: Split out nbd_receive_one_meta_context()
  nbd/client: Refactor return of nbd_receive_negotiate()
  nbd/client: Split handshake into two functions
  nbd/client: Pull out oldstyle size determination
  nbd/client: Refactor nbd_opt_go() to support NBD_OPT_INFO
  nbd/client: Add nbd_receive_export_list()
  nbd/client: Add meta contexts to nbd_receive_export_list()
  qemu-nbd: Add --list option
  nbd/client: Work around 3.0 bug for listing meta contexts
  iotests: Enhance 223, 233 to cover 'qemu-nbd --list'

 qemu-nbd.texi              | 116 +++++-
 Makefile                   |   2 +
 include/block/nbd.h        |  31 +-
 block/nbd-client.c         |   9 +-
 blockdev-nbd.c             |  10 +-
 nbd/client.c               | 775 ++++++++++++++++++++++++++-----------
 nbd/server.c               |  24 +-
 qemu-nbd.c                 | 224 ++++++++---
 nbd/trace-events           |  17 +-
 scripts/texi2pod.pl        |   2 +-
 tests/qemu-iotests/223     |   2 +
 tests/qemu-iotests/223.out |  20 +
 tests/qemu-iotests/233     |  30 +-
 tests/qemu-iotests/233.out |  19 +-
 14 files changed, 942 insertions(+), 339 deletions(-)

--=20
2.20.1
