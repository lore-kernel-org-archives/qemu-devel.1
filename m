Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft85I-0008EL-KX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft85F-00060T-H1
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ft85F-00060A-C6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1074F4021CC3
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:08:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Aug 2018 17:08:25 +0800
Message-Id: <20180824090826.21370-3-peterx@redhat.com>
In-Reply-To: <20180824090826.21370-1-peterx@redhat.com>
References: <20180824090826.21370-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 2/3] monitor: generate flag parse helper from
 init func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Just to put the flag parsing part into a standalone function, which will
be used in follow up patches.  No functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 vl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 16b913f9d5..25e156c020 100644
--- a/vl.c
+++ b/vl.c
@@ -2302,10 +2302,8 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 }
 #endif
 
-static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
+static int mon_parse_flags(QemuOpts *opts)
 {
-    Chardev *chr;
-    const char *chardev;
     const char *mode;
     int flags;
 
@@ -2330,6 +2328,16 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
         flags |= MONITOR_USE_OOB;
     }
 
+    return flags;
+}
+
+static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    Chardev *chr;
+    const char *chardev;
+    int flags;
+
+    flags = mon_parse_flags(opts);
     chardev = qemu_opt_get(opts, "chardev");
     chr = qemu_chr_find(chardev);
     if (chr == NULL) {
-- 
2.17.1
