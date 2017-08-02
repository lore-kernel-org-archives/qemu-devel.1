Received: from eggs.gnu.org ([2001:4830:134:3::10]:59241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dckI0-0003NK-Dj
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dckHz-0000kB-GY
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dckHz-0000jc-39
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:25:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23D7416BAFA
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 03:25:38 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 Aug 2017 11:25:21 +0800
Message-Id: <1501644321-17721-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1501644321-17721-1-git-send-email-peterx@redhat.com>
References: <1501644321-17721-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] io: fix qio_channel_socket_accept err
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

When accept failed, we should setup errp with the reason. More
importantly, the caller may assume errp be non-NULL when error happens,
and not setting the errp may crash QEMU.

At the same time, move the trace_qio_channel_socket_accept_fail() after
the if check on EINTR. Two reasons:

1. when EINTR happened, it's not really a fault (we should just try
   again), so we should not log with an "accept failure".

2. trace_*() functions may overwrite errno, then the old errno will be
   missing. We need to either check errno before trace_*() calls, or
   reserve the errno.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/channel-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7..442f230 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -340,10 +340,11 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
     cioc->fd = qemu_accept(ioc->fd, (struct sockaddr *)&cioc->remoteAddr,
                            &cioc->remoteAddrLen);
     if (cioc->fd < 0) {
-        trace_qio_channel_socket_accept_fail(ioc);
         if (errno == EINTR) {
             goto retry;
         }
+        trace_qio_channel_socket_accept_fail(ioc);
+        error_setg_errno(errp, errno, "Unable to accept connection");
         goto error;
     }
 
-- 
2.7.4
