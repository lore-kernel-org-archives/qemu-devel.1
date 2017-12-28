Received: from eggs.gnu.org ([2001:4830:134:3::10]:38658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUSde-0001Ct-7m
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 02:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUSdb-0005Bw-2b
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 02:30:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUSda-0005Az-Sr
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 02:29:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA3FA883BD
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 07:29:56 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 28 Dec 2017 15:29:42 +0800
Message-Id: <20171228072945.9573-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] chardev: convert leftover glib APIs to use
 dedicate gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There were existing work that tried to allow chardev to be run in a
dedicated gcontext rather than the default main context/thread.
Basically that work passed in the correct gcontext during
g_source_attach().  However, I found something missing along the way,
that some legacy glib APIs are used by chardev code which take the
main context as default:

   g_timeout_add_seconds
   g_timeout_add
   g_idle_add

To fully allow the chardevs to be run in dedicated gcontext, we need
to convert all these legacy APIs into g_source_attach() calls as well,
with the correct gcontext passed in.

This series tries to clean the rest of things up.

I picked up patch 1 from monitor-oob series into this series (which is
a missing of chardev frontend call fix for g_source_attach()), so that
this series can be a complete fix.

Please review.  Thanks,

Peter Xu (3):
  chardev: use backend chr context when watch for fe
  chardev: let g_idle_add() be with chardev gcontext
  chardev: introduce qemu_chr_timeout_add() and use

 chardev/char-fe.c      |  2 +-
 chardev/char-pty.c     | 16 ++++++++--------
 chardev/char-socket.c  |  4 ++--
 chardev/char.c         | 20 ++++++++++++++++++++
 hw/char/terminal3270.c |  7 ++++---
 include/chardev/char.h |  2 ++
 6 files changed, 37 insertions(+), 14 deletions(-)

-- 
2.14.3
