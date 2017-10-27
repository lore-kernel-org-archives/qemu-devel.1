Received: from eggs.gnu.org ([2001:4830:134:3::10]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824G-00017V-Tz
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824G-0005Ua-14
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 27 Oct 2017 12:40:25 +0200
Message-Id: <20171027104037.8319-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 00/12] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

I've incorporated a few more tweaks since v5, addressing the various
bugs I pointed out there:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04817.html
- make sure iotests pass
- split a large patch
- consistently use absolute offsets
- clean up awkward logic in handling option requests

I plan to send a pull request before Tuesday's freeze deadline; with a
plan to do lots of interoperability testing (including validation of
behavior against a server that sends more than one chunk for a read),
and with any resulting bug fixes trying to land as soon as possible
during the freeze.

I'm also a bit disappointed that iotest 83 is more verbose. I'll post a
follow RFC that undoes the verbosity regression, as evidence that we
should probably be tracing things instead; such a cleanup would count
as a bug fix, even if my pull request includes this series as-is.

001/12:[----] [--] 'nbd: Include error names in trace messages'
002/12:[----] [--] 'nbd: Move nbd_errno_to_system_errno() to public header'
003/12:[----] [--] 'nbd: Expose constants and structs for structured read'
004/12:[----] [--] 'nbd/server: Report error for write to read-only export'
005/12:[down] 'nbd/server: Simplify nbd_negotiate_options loop'
006/12:[0066] [FC] 'nbd/server: Refactor zero-length option check'
007/12:[0007] [FC] 'nbd: Minimal structured read for server'
008/12:[----] [--] 'nbd/server: Include human-readable message in structured errors'
009/12:[0004] [FC] 'nbd/client: refactor nbd_receive_starttls'
010/12:[----] [--] 'nbd/client: prepare nbd_receive_reply for structured reply'
011/12:[----] [--] 'nbd: Move nbd_read() to common header'
012/12:[0055] [FC] 'nbd: Minimal structured read for client'

Eric Blake (8):
  nbd: Include error names in trace messages
  nbd: Move nbd_errno_to_system_errno() to public header
  nbd: Expose constants and structs for structured read
  nbd/server: Report error for write to read-only export
  nbd/server: Simplify nbd_negotiate_options loop
  nbd/server: Refactor zero-length option check
  nbd/server: Include human-readable message in structured errors
  nbd: Move nbd_read() to common header

Vladimir Sementsov-Ogievskiy (4):
  nbd: Minimal structured read for server
  nbd/client: refactor nbd_receive_starttls
  nbd/client: prepare nbd_receive_reply for structured reply
  nbd: Minimal structured read for client

 block/nbd-client.h         |   1 +
 include/block/nbd.h        | 106 +++++++++-
 nbd/nbd-internal.h         |  23 +--
 block/nbd-client.c         | 492 ++++++++++++++++++++++++++++++++++++++++++---
 nbd/client.c               | 217 +++++++++++++-------
 nbd/common.c               |  84 ++++++++
 nbd/server.c               | 209 ++++++++++++++-----
 nbd/trace-events           |  15 +-
 tests/qemu-iotests/083.out |  15 ++
 9 files changed, 968 insertions(+), 194 deletions(-)

-- 
2.13.6
