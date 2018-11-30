Received: from eggs.gnu.org ([2001:4830:134:3::10]:55985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtI-0004Om-L4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtG-0004Eu-Tr
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:29 -0600
Message-Id: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 00/14] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

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

Based-on: <20181130023232.3079982-1-eblake@redhat.com>
[0/3] NBD dirty bitmap cleanups

(well, only weakly based on it - the two series can be applied
in either order, where if you apply this series but revert 12/14,
then iotest 223 in 14/14 will expose the bug fixed by patch 1/3
in the other series)

Also available at:
https://repo.or.cz/qemu/ericb.git qemu-nbd-list-v1

Eric Blake (14):
  qemu-nbd: Use program name in error messages
  nbd/client: More consistent error messages
  qemu-nbd: Fail earlier for -c/-d on non-linux
  qemu-nbd: Simplify --partition handling
  nbd/client: Drop pointless buf variable
  nbd/client: Move export name into NBDExportInfo
  nbd/client: Refactor nbd_negotiate_simple_meta_context()
  nbd/client: Refactor nbd_receive_list()
  nbd/client: Refactor return of nbd_receive_negotiate()
  nbd/client: Split handshake into two functions
  nbd/client: Add nbd_receive_export_list()
  nbd/client: Work around 3.0 bug for listing meta contexts
  qemu-nbd: Add --list option
  iotests: Enhance 223, 233 to cover 'qemu-nbd --list'

 include/block/nbd.h        |  23 +-
 nbd/nbd-internal.h         |   1 +
 block/nbd-client.c         |   5 +-
 nbd/client.c               | 595 +++++++++++++++++++++++++------------
 qemu-nbd.c                 | 196 ++++++++++--
 nbd/trace-events           |   8 +-
 tests/qemu-iotests/223     |   2 +
 tests/qemu-iotests/223.out |  20 ++
 tests/qemu-iotests/233     |  10 +
 tests/qemu-iotests/233.out |  17 +-
 10 files changed, 650 insertions(+), 227 deletions(-)

-- 
2.17.2
