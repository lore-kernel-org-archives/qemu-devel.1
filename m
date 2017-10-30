Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GbK-0007tN-E5
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9GbI-0006Hk-Bi
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9GbI-0006HS-2a
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:24:00 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 30 Oct 2017 20:23:55 +0000
Message-Id: <20171030202356.11047-2-dgilbert@redhat.com>
In-Reply-To: <20171030202356.11047-1-dgilbert@redhat.com>
References: <20171030202356.11047-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] hmp: Replace error_report_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, groug@kaod.org, lu.zhipeng@zte.com.cn

From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>

Use hmp_handle_error instend of error_report_err to set error.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Reviewed-by: Jiyun Fan <fan.jiyun@zte.com.cn>
Message-Id: <1508411793-22868-1-git-send-email-lu.zhipeng@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hmp.c b/hmp.c
index a01be50daa..35a7041824 100644
--- a/hmp.c
+++ b/hmp.c
@@ -670,7 +670,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
=20
     info2l =3D qmp_query_vnc_servers(&err);
     if (err) {
-        error_report_err(err);
+        hmp_handle_error(mon, &err);
         return;
     }
     if (!info2l) {
@@ -785,7 +785,7 @@ void hmp_info_balloon(Monitor *mon, const QDict *qdic=
t)
=20
     info =3D qmp_query_balloon(&err);
     if (err) {
-        error_report_err(err);
+        hmp_handle_error(mon, &err);
         return;
     }
=20
@@ -1128,7 +1128,7 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qd=
ict)
=20
     data =3D qmp_ringbuf_read(chardev, size, false, 0, &err);
     if (err) {
-        error_report_err(err);
+        hmp_handle_error(mon, &err);
         return;
     }
=20
@@ -1195,9 +1195,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_balloon(value, &err);
-    if (err) {
-        error_report_err(err);
-    }
+    hmp_handle_error(mon, &err);
 }
=20
 void hmp_block_resize(Monitor *mon, const QDict *qdict)
@@ -1534,10 +1532,7 @@ void hmp_migrate_set_cache_size(Monitor *mon, cons=
t QDict *qdict)
     Error *err =3D NULL;
=20
     qmp_migrate_set_cache_size(value, &err);
-    if (err) {
-        error_report_err(err);
-        return;
-    }
+    hmp_handle_error(mon, &err);
 }
=20
 /* Kept for backwards compatibility */
@@ -1568,10 +1563,7 @@ void hmp_migrate_set_capability(Monitor *mon, cons=
t QDict *qdict)
=20
 end:
     qapi_free_MigrationCapabilityStatusList(caps);
-
-    if (err) {
-        error_report_err(err);
-    }
+    hmp_handle_error(mon, &err);
 }
=20
 void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
@@ -1680,9 +1672,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
  cleanup:
     qapi_free_MigrateSetParameters(p);
     visit_free(v);
-    if (err) {
-        error_report_err(err);
-    }
+    hmp_handle_error(mon, &err);
 }
=20
 void hmp_client_migrate_info(Monitor *mon, const QDict *qdict)
@@ -1936,7 +1926,7 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
=20
     qmp_migrate(uri, !!blk, blk, !!inc, inc, false, false, &err);
     if (err) {
-        error_report_err(err);
+        hmp_handle_error(mon, &err);
         return;
     }
=20
--=20
2.14.3
