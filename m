Received: from eggs.gnu.org ([2001:4830:134:3::10]:46798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxef-0001cc-Ew
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxee-0005QR-MI
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dIxee-0005Pj-GC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78B06B1E40
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 13:39:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  8 Jun 2017 10:39:04 -0300
Message-Id: <20170608133906.12737-4-ehabkost@redhat.com>
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] websock: Don't try to set *errp directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Assigning directly to *errp is not valid, as errp may be NULL,
&error_fatal, or &error_abort.  Use error_propagate() instead.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 io/channel-websock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 8fabadea2f..5a3badbec2 100644
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
2.11.0.259.g40922b1
