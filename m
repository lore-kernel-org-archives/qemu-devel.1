Received: from eggs.gnu.org ([2001:4830:134:3::10]:44948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEwMe-0001ez-2Q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEwMZ-0003g6-5q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gEwMX-0003bq-1U
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:46 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 Oct 2018 15:04:40 +0200
Message-Id: <20181023130440.6323-2-armbru@redhat.com>
In-Reply-To: <20181023130440.6323-1-armbru@redhat.com>
References: <20181023130440.6323-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/40] block: Use warn_report() & friends to
 report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Liu Yuan <namei.unix@gmail.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  Convert a few that are actually warnings to
warn_report().

While there, improve a rather useless warning in sheepdog.c.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>
Cc: Liu Yuan <namei.unix@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181017082702.5581-4-armbru@redhat.com>

Drop changes to "without an explicit read-only=on" warnings, because
there's a series removing them pending.  Also drop a cc: to a former
Sheepdog maintainer.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c    | 2 +-
 block/rbd.c      | 4 ++--
 block/sheepdog.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index bb69faf34a..73998c2860 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1844,7 +1844,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     iscsi_set_timeout(iscsi, timeout);
 #else
     if (timeout) {
-        error_report("iSCSI: ignoring timeout value for libiscsi <1.15.0");
+        warn_report("iSCSI: ignoring timeout value for libiscsi <1.15.0");
     }
 #endif
 
diff --git a/block/rbd.c b/block/rbd.c
index 014c68d629..e5bf5a146f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -750,8 +750,8 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         /* Take care whenever deciding to actually deprecate; once this ability
          * is removed, we will not be able to open any images with legacy-styled
          * backing image strings. */
-        error_report("RBD options encoded in the filename as keyvalue pairs "
-                     "is deprecated");
+        warn_report("RBD options encoded in the filename as keyvalue pairs "
+                    "is deprecated");
     }
 
     /* Remove the processed options from the QDict (the visitor processes
diff --git a/block/sheepdog.c b/block/sheepdog.c
index b229a664d9..0125df9d49 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -572,7 +572,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
     if (s->addr->type == SOCKET_ADDRESS_TYPE_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
         if (ret < 0) {
-            error_report("%s", strerror(errno));
+            warn_report("can't set TCP_NODELAY: %s", strerror(errno));
         }
     }
 
-- 
2.17.2
