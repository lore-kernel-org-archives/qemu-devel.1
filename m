Received: from eggs.gnu.org ([2001:4830:134:3::10]:59097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA0-0008V8-Hj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVe9x-0001Kr-0p
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVe9w-0001K5-PK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51F88A78ED
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 13:27:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:50 +0200
Message-Id: <1499952476-3454-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] websock: Don't try to set *errp directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Assigning directly to *errp is not valid, as errp may be NULL,
&error_fatal, or &error_abort.  Use error_propagate() instead.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170608133906.12737-4-ehabkost@redhat.com>
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 io/channel-websock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 8fabade..5a3badb 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -856,7 +856,7 @@ static ssize_t qio_channel_websock_readv(QIOChannel *ioc,
     ssize_t ret;
 
     if (wioc->io_err) {
-        *errp = error_copy(wioc->io_err);
+        error_propagate(errp, error_copy(wioc->io_err));
         return -1;
     }
 
@@ -902,7 +902,7 @@ static ssize_t qio_channel_websock_writev(QIOChannel *ioc,
     ssize_t ret;
 
     if (wioc->io_err) {
-        *errp = error_copy(wioc->io_err);
+        error_propagate(errp, error_copy(wioc->io_err));
         return -1;
     }
 
-- 
2.7.5
