Received: from eggs.gnu.org ([2001:4830:134:3::10]:49013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ5-0007Oo-OV
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIq-0003vV-HT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:14 +0200
Message-Id: <1502117160-24655-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 10/56] hmp: Make balloon's argument unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

The previous commit made it unsigned in QMP.  Switch HMP's args_type
from 'M' to 'o'.  Loses support for expressions (QEMU pocket
calculator), gains support for units other than mebibytes.  Negative
values are no longer accepted and interpreted modulo 2^64.  Instead,
values between 2^63 and 2^64-1 are now accepted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands.hx | 2 +-
 hmp.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19..46ce79c 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1433,7 +1433,7 @@ ETEXI
 
     {
         .name       = "balloon",
-        .args_type  = "value:M",
+        .args_type  = "value:o",
         .params     = "target",
         .help       = "request VM to change its memory allocation (in MB)",
         .cmd        = hmp_balloon,
diff --git a/hmp.c b/hmp.c
index 4556045..1932a11 100644
--- a/hmp.c
+++ b/hmp.c
@@ -781,7 +781,7 @@ void hmp_info_balloon(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    monitor_printf(mon, "balloon: actual=%" PRIu64 "\n", info->actual >> 20);
+    monitor_printf(mon, "balloon: actual=%" PRId64 "\n", info->actual >> 20);
 
     qapi_free_BalloonInfo(info);
 }
@@ -1178,7 +1178,7 @@ void hmp_block_passwd(Monitor *mon, const QDict *qdict)
 
 void hmp_balloon(Monitor *mon, const QDict *qdict)
 {
-    int64_t value = qdict_get_int(qdict, "value");
+    uint64_t value = qdict_get_uint(qdict, "value");
     Error *err = NULL;
 
     qmp_balloon(value, &err);
-- 
2.7.5
