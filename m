Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9a-0004Rh-3q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9V-0005iJ-AH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57906
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9V-0005fQ-4w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hbSP041250
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:04 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d39bk780v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:04 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 20:46:03 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:16 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920004521.9417-8-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/12] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

After calling qcow2_inactivate(), all qcow2 caches must be flushed, but t=
his
may not happen, because the last call qcow2_store_persistent_dirty_bitmap=
s()
can lead to marking l2/refcont cache as dirty.

Let's move qcow2_store_persistent_dirty_bitmaps() before the ca=D1=81he f=
lushing
to fix it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 83a8c775a8bf134eb18a719322939b74a818d750)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 40ba26c111..a756bf9541 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2053,6 +2053,14 @@ static int qcow2_inactivate(BlockDriverState *bs)
     int ret, result =3D 0;
     Error *local_err =3D NULL;
=20
+    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    if (local_err !=3D NULL) {
+        result =3D -EINVAL;
+        error_report_err(local_err);
+        error_report("Persistent bitmaps are lost for node '%s'",
+                     bdrv_get_device_or_node_name(bs));
+    }
+
     ret =3D qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret) {
         result =3D ret;
@@ -2067,14 +2075,6 @@ static int qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
=20
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
-    if (local_err !=3D NULL) {
-        result =3D -EINVAL;
-        error_report_err(local_err);
-        error_report("Persistent bitmaps are lost for node '%s'",
-                     bdrv_get_device_or_node_name(bs));
-    }
-
     if (result =3D=3D 0) {
         qcow2_mark_clean(bs);
     }
--=20
2.11.0
