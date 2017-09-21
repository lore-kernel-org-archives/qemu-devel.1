Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukF-0005qK-Du
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukA-0007dY-1i
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duuk9-0007cl-SA
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE4F2356D6
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:13:48 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 21 Sep 2017 14:13:30 +0800
Message-Id: <1505974414-6033-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] chardev: support non-default gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

The old chardev may not fully support non-default GMainContext.  One
direct clue is that when we call io_add_watch_poll() sometimes we are
still passing in the NULL context pointer.

IIUC we are fine during setup since the context will be passed
correctly during setup via chr_update_read_handler().  However it
won't survive if chardev reconnected due to some reason.

This series tries to solve above problem by caching the gcontext
pointer in Chardev itself.

This will be required for the monitor OOB (out-of-band) support, since
in that series monitor backends may be run in non-default contexts.

Please review.  Thanks.

Peter Xu (4):
  chardev: new qemu_chr_be_update_read_handlers()
  chardev: add Chardev.gcontext field
  chardev: use per-dev context for io_add_watch_poll
  chardev: remove context in chr_update_read_handler

 chardev/char-fd.c      |  5 ++---
 chardev/char-fe.c      |  7 ++-----
 chardev/char-pty.c     |  5 ++---
 chardev/char-socket.c  |  7 +++----
 chardev/char-udp.c     |  5 ++---
 chardev/char.c         | 11 +++++++++++
 include/chardev/char.h | 13 ++++++++++++-
 7 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.7.4
