Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA1-0007TO-6P
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBuA0-0003Pt-Dq
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 22:02:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  6 Nov 2017 21:02:28 -0600
Message-Id: <20171107030236.23633-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/8] various NBD fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com

Sparked by my question on whether we were handling zero-length
reads correctly according to the NBD spec, but grew to fix
other things as well such as some typos, tracing weaknesses,
and better handling of read-only exports.

The order these patches are listed here is bisection-friendly,
but applying the patches out of order (for example, applying
7/8 before any short-circuiting patches stop the client from
sending 0-length requests, and before the server is fixed to
stop botching replies to 0-length requests) proved important
to my ability to test that the patches are needed.

One of the patches is not strictly NBD, and begs the question
of whether other filter drivers (mirror, throttle, etc) should
also be reflecting the read-only status of their underlying
BDS.  Some of my testing included setting up a read-only NBD
server and a read-write qemu-io session, then attempting
'w 0 0', 'w -z 0 0', and 'd 0 0'; these should not succeed if
the corresponding 'w 0 1' fails, but the end goal is that the
server shouldn't even need to be involved in these corner cases.

Eric Blake (8):
  nbd-client: Fix error message typos
  nbd/client: Nicer trace of structured reply
  raw: Reflect read-only protocol layer
  nbd-client: Honor server read-only advertisement
  nbd: Fix struct name for structured reads
  nbd-client: Short-circuit 0-length operations
  nbd-client: Stricter enforcing of structured reply spec
  nbd/server: Fix structured read of length 0

 include/block/nbd.h | 18 +++++++++++++-----
 block/nbd-client.c  | 38 +++++++++++++++++++++++++++++++-------
 block/raw-format.c  |  6 ++++++
 nbd/client.c        |  4 +++-
 nbd/server.c        | 23 +++++++++++++++++++++--
 nbd/trace-events    |  3 ++-
 6 files changed, 76 insertions(+), 16 deletions(-)

-- 
2.13.6
