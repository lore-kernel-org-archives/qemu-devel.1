Received: from eggs.gnu.org ([209.51.188.92]:39927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1Il-0001IV-IR
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx1Ik-0000gv-6c
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:15:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx1Ij-0008QG-Gp
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 22:15:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D61099CED
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 03:14:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 22 Feb 2019 11:14:09 +0800
Message-Id: <20190222031413.20250-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] iothread: create gcontext unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>

When I first read the iothread code, the gcontext confused me for
quite a while.  Meanwhile, I've been tackling with some races due to
this complexity as well.  How much we'll pay for creating the gcontext
unconditionally?  Do we really need this flexibitily (or is it really
a flexibility after all)?  I don't see much gain of existing code, but
I might be wrong.  Anyway, I wrote this patchset to see how the list
would think about it.

This series directly originates from previous discussion with
Marc-Andre where there's a slightly hacky way to try to acquire the
gcontext:

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05460.html

Now with this series logically above patch is not needed any more.
Please read patch 4 for more information.

And if this patchset can survive... how about running gcontext
directly in iothread_run()?  I believe there could be a bit more
things to clean but I'll see.

Make check passes for me.

Comments welcomed.  Thanks,

Peter Xu (4):
  iothread: replace init_done_cond with a semaphore
  iothread: create the gcontext onconditionally
  iothread: create main loop unconditionally
  iothread: push gcontext earlier in the thread_fn

 include/sysemu/iothread.h |  5 +--
 iothread.c                | 77 +++++++++++++++------------------------
 2 files changed, 32 insertions(+), 50 deletions(-)

-- 
2.17.1
