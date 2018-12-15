Received: from eggs.gnu.org ([2001:4830:134:3::10]:34167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYANv-0004ZP-7N
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYANu-0007uZ-06
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:02 -0600
Message-Id: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/22] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

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

v1->v2:

Lots of rework: several new patches added, several split into more
managable pieces, a couple reordered. Use g_free consistently. Add
R-b where the patch didn't change too much beyond the review.

001/22:[----] [--] 'qemu-nbd: Use program name in error messages'
002/22:[down] 'nbd: Document timeline of various features'
003/22:[down] 'maint: Allow for EXAMPLES in texi2pod'
004/22:[down] 'qemu-nbd: Enhance man page'
005/22:[0006] [FC] 'nbd/client: More consistent error messages'
006/22:[0009] [FC] 'qemu-nbd: Fail earlier for -c/-d on non-linux'
007/22:[down] 'qemu-nbd: Avoid strtol open-coding'
008/22:[0012] [FC] 'nbd/client: Drop pointless buf variable'
009/22:[0114] [FC] 'nbd/client: Refactor nbd_receive_list()'
010/22:[0006] [FC] 'nbd/client: Move export name into NBDExportInfo'
011/22:[down] 'nbd/client: Change signature of nbd_negotiate_simple_meta_context()'
012/22:[down] 'nbd/client: Improve error handling in nbd_negotiate_simple_meta_context()'
013/22:[down] 'nbd/client: Split out nbd_send_one_meta_context()'
014/22:[down] 'nbd/client: Split out nbd_receive_one_meta_context()'
015/22:[----] [-C] 'nbd/client: Refactor return of nbd_receive_negotiate()'
016/22:[0036] [FC] 'nbd/client: Split handshake into two functions'
017/22:[down] 'nbd/client: Pull out oldstyle size determination'
018/22:[0078] [FC] 'nbd/client: Add nbd_receive_export_list()'
019/22:[down] 'nbd/client: Add meta contexts to nbd_receive_export_list()'
020/22:[0034] [FC] 'qemu-nbd: Add --list option'
021/22:[0028] [FC] 'nbd/client: Work around 3.0 bug for listing meta contexts'
022/22:[0021] [FC] 'iotests: Enhance 223, 233 to cover 'qemu-nbd --list''

Eric Blake (22):
  qemu-nbd: Use program name in error messages
  nbd: Document timeline of various features
  maint: Allow for EXAMPLES in texi2pod
  qemu-nbd: Enhance man page
  nbd/client: More consistent error messages
  qemu-nbd: Fail earlier for -c/-d on non-linux
  qemu-nbd: Avoid strtol open-coding
  nbd/client: Drop pointless buf variable
  nbd/client: Refactor nbd_receive_list()
  nbd/client: Move export name into NBDExportInfo
  nbd/client: Change signature of nbd_negotiate_simple_meta_context()
  nbd/client: Improve error handling in
    nbd_negotiate_simple_meta_context()
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

 docs/interop/nbd.txt       |  19 +-
 qemu-nbd.texi              | 107 ++++-
 Makefile                   |  18 +-
 include/block/nbd.h        |  27 +-
 nbd/nbd-internal.h         |   3 +-
 block/nbd-client.c         |   9 +-
 nbd/client.c               | 796 +++++++++++++++++++++++++------------
 qemu-nbd.c                 | 216 ++++++++--
 nbd/trace-events           |  11 +-
 scripts/texi2pod.pl        |   2 +-
 tests/qemu-iotests/223     |   2 +
 tests/qemu-iotests/223.out |  20 +
 tests/qemu-iotests/233     |  19 +-
 tests/qemu-iotests/233.out |  17 +-
 14 files changed, 918 insertions(+), 348 deletions(-)

-- 
2.17.2
