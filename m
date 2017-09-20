Received: from eggs.gnu.org ([2001:4830:134:3::10]:40636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9X-0004QF-Co
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9M-0005bD-3d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55126
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9L-0005ag-UZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hbt5139612
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:59 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d39xyvaq8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:59 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 18:45:58 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:21 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920004521.9417-13-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/12] vhost-user-bridge: fix resume regression
 (since 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Commit e10e798c85c2331 switched to libvhost-user which lacked support
for resuming the avail_idx based on used_idx.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 672339f7eff5e9226f302037290e84e783d2b5cd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/vhost-user-bridge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 1e5b5ca3da..f922cc75ae 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -466,11 +466,18 @@ vubr_panic(VuDev *dev, const char *msg)
     vubr->quit =3D 1;
 }
=20
+static bool
+vubr_queue_is_processed_in_order(VuDev *dev, int qidx)
+{
+    return true;
+}
+
 static const VuDevIface vuiface =3D {
     .get_features =3D vubr_get_features,
     .set_features =3D vubr_set_features,
     .process_msg =3D vubr_process_msg,
     .queue_set_started =3D vubr_queue_set_started,
+    .queue_is_processed_in_order =3D vubr_queue_is_processed_in_order,
 };
=20
 static void
--=20
2.11.0
