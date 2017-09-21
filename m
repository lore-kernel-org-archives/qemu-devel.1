Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukJ-0005rU-9P
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukI-0007sE-8A
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duukI-0007qL-2S
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 398FBC04B94A
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:13:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 21 Sep 2017 14:13:32 +0800
Message-Id: <1505974414-6033-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1505974414-6033-1-git-send-email-peterx@redhat.com>
References: <1505974414-6033-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] chardev: add Chardev.gcontext field
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

It caches the gcontext that is used to poll the chardev IO.  Before this
patch, we only passed it in via chr_update_read_handlers().  However
that may not be enough if the char backend is disconnected and
reconnected afterward.  There are chardev codes that still assumed the
context be NULL (which is the main context).  Will fix that up in
following up patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char.c         | 1 +
 include/chardev/char.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index e090dd5..89eabea 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -185,6 +185,7 @@ void qemu_chr_be_update_read_handlers(Chardev *s,
 {
     ChardevClass *cc = CHARDEV_GET_CLASS(s);
 
+    s->gcontext = context;
     if (cc->chr_update_read_handler) {
         cc->chr_update_read_handler(s, context);
     }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 2068ea4..84fb773 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -55,6 +55,7 @@ struct Chardev {
     int logfd;
     int be_open;
     GSource *gsource;
+    GMainContext *gcontext;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
 };
 
-- 
2.7.4
