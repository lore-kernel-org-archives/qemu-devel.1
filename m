Received: from eggs.gnu.org ([2001:4830:134:3::10]:49476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVGR-0001oM-9x
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhVGO-0005Cv-3N
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhVGN-0005Ca-TY
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:23:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29E727BE43
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:17:18 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 15 Aug 2017 14:17:01 +0800
Message-Id: <1502777827-18874-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 0/6] migration: re-use migrate_incoming for
 postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This series is based on the postcopy failure recovery series. It
sololy tries to provide a new way to allow the destination to have a
new incoming channel.

One use case is when we are doing postcopy migration using a fd on
destination side. When network failure is detected, destination QEMU
will switch to postcopy-pause state for a recovery. However since the
old fd is disconnected and not valid any more, there is no way to do a
reconnection without a new reconfiguration.

With this series, we can specify the new listening channel by using
"migrate_incoming xxx:xxx" command. It was used only for "-incoming
defer" to defer an incoming migration. This series extended its usage
for paused postcopy as well.

Please review, thanks.

Peter Xu (6):
  migration: free SocketAddress where allocated
  migration: return incoming task tag for sockets
  migration: return incoming task tag for exec
  migration: return incoming task tag for fd
  migration: store listen task tag
  migration: allow migrate_incoming for paused VM

 migration/exec.c      | 18 ++++++++++-------
 migration/exec.h      |  2 +-
 migration/fd.c        | 18 ++++++++++-------
 migration/fd.h        |  2 +-
 migration/migration.c | 56 +++++++++++++++++++++++++++++++++++++++++----------
 migration/migration.h |  2 ++
 migration/socket.c    | 40 +++++++++++++++++++++++-------------
 migration/socket.h    |  4 ++--
 8 files changed, 99 insertions(+), 43 deletions(-)

-- 
2.7.4
