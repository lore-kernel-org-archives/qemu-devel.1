Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rv-0007Zp-M3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rr-0005p8-0z
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:15 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  5 Dec 2016 16:32:00 -0500
Message-Id: <1480973521-28945-3-git-send-email-jcody@redhat.com>
In-Reply-To: <1480973521-28945-1-git-send-email-jcody@redhat.com>
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.8 2/3] block/nfs: fix QMP to match debug
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

The QMP definition of BlockdevOptionsNfs:
{ 'struct': 'BlockdevOptionsNfs',
  'data': { 'server': 'NFSServer',
            'path': 'str',
            '*user': 'int',
            '*group': 'int',
            '*tcp-syn-count': 'int',
            '*readahead-size': 'int',
            '*page-cache-size': 'int',
            '*debug-level': 'int' } }

To make this consistent with other block protocols like gluster, lets
change s/debug-level/debug/

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/nfs.c          | 4 ++--
 qapi/block-core.json | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index d082783..a490660 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -134,7 +134,7 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
             qdict_put(options, "page-cache-size",
                       qstring_from_str(qp->p[i].value));
         } else if (!strcmp(qp->p[i].name, "debug")) {
-            qdict_put(options, "debug-level",
+            qdict_put(options, "debug",
                       qstring_from_str(qp->p[i].value));
         } else {
             error_setg(errp, "Unknown NFS parameter name: %s",
@@ -165,7 +165,7 @@ static bool nfs_has_filename_options_conflict(QDict *options, Error **errp)
             !strcmp(qe->key, "tcp-syn-count") ||
             !strcmp(qe->key, "readahead-size") ||
             !strcmp(qe->key, "page-cache-size") ||
-            !strcmp(qe->key, "debug-level") ||
+            !strcmp(qe->key, "debug") ||
             strstart(qe->key, "server.", NULL))
         {
             error_setg(errp, "Option %s cannot be used with a filename",
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 03b19f1..f22ed2a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2292,7 +2292,7 @@
 # @page-cache-size:         #optional set the pagecache size in bytes (defaults
 #                           to libnfs default)
 #
-# @debug-level:             #optional set the NFS debug level (max 2) (defaults
+# @debug:                   #optional set the NFS debug level (max 2) (defaults
 #                           to libnfs default)
 #
 # Since 2.8
@@ -2305,7 +2305,7 @@
             '*tcp-syn-count': 'int',
             '*readahead-size': 'int',
             '*page-cache-size': 'int',
-            '*debug-level': 'int' } }
+            '*debug': 'int' } }
 
 ##
 # @BlockdevOptionsCurl
-- 
2.7.4
