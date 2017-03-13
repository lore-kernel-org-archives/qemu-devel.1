Received: from eggs.gnu.org ([2001:4830:134:3::10]:42815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4W-0000bD-ET
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4V-0002Or-OP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4V-0002NQ-HZ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:55:59 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AE3B63B05
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:55:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:22 -0500
Message-Id: <20170313195547.21466-6-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/30] trace: Fix parameter types in io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces.  In this case, the only platform where
pid_t in the caller does not match int in the trace definition is
64-bit mingw, where the system headers are still buggy in declaring
a 64-bit pid_t even though getpid() only returns 32 bits, so a cast
in the caller is the easiest workaround.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/channel-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-command.c b/io/channel-command.c
index 319c5ed..a90a078 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -39,7 +39,7 @@ qio_channel_command_new_pid(int writefd,
     ioc->writefd = writefd;
     ioc->pid = pid;

-    trace_qio_channel_command_new_pid(ioc, writefd, readfd, pid);
+    trace_qio_channel_command_new_pid(ioc, writefd, readfd, (int) pid);
     return ioc;
 }

-- 
2.9.3
