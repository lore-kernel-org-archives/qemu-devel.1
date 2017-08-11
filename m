Received: from eggs.gnu.org ([2001:4830:134:3::10]:60392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzpu-000641-Ft
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzpq-000517-IF
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfzpq-00050r-Cf
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Aug 2017 21:37:56 -0500
Message-Id: <20170811023759.26390-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Fix NBD client after server error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com

Patch 1 is a much smaller patch than Vladimir's attempt [1] at fixing
the client in the face of a malicious server.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01501.html

Patch 2 is not to be applied; it is a hack for easily creating a
malicious server; by setting NBD_SERVER_DEBUG to a positive integer,
the server will intentionally send bad magic when it reaches that
many replies.

I tested using:
 NBD_SERVER_DEBUG=1 ./qemu-nbd -f raw -x foo file
coupled with
 qemu-io -c 'r 0 1' -c 'r 0 1' -f raw nbd://localhost:10809/foo

Without the patch, the qemu-io client hangs; with the patch, the
client reports 'read failed: Input/output error' for the first read
(where the bad server was detected) and 'read failed: Broken pipe'
for the second (because the client has already dropped the
connection from the bad server).

I would like this to go in -rc3, but would definitely appreciate
review, as the manipulation of coroutines was tricky for me to
step through in the debugger, and I want to make sure I'm not
leaking any memory or stranding an incomplete coroutine.

Eric Blake (2):
  nbd: Drop connection if broken server is detected
  HACK: define NBD_SERVER_DEBUG to force malicious server

 block/nbd-client.c |  9 +++++++--
 nbd/server.c       | 11 +++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.13.4
