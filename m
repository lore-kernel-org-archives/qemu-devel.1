Received: from eggs.gnu.org ([2001:4830:134:3::10]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcuC3-0002uG-Bq
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcuBu-0006CV-5n
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:00:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcuBu-0006Bj-08
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:00:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB35E622DC
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 13:59:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  2 Aug 2017 14:58:34 +0100
Message-Id: <20170802135834.1455-4-dgilbert@redhat.com>
In-Reply-To: <20170802135834.1455-1-dgilbert@redhat.com>
References: <20170802135834.1455-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] io: fix qio_channel_socket_accept err
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
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com

From: Peter Xu <peterx@redhat.com>

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
Message-Id: <1501666880-10159-3-git-send-email-peterx@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 io/channel-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7ba3..591d27e8c3 100644
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
+        error_setg_errno(errp, errno, "Unable to accept connection");
+        trace_qio_channel_socket_accept_fail(ioc);
         goto error;
     }
 
-- 
2.13.3
