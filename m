Received: from eggs.gnu.org ([2001:4830:134:3::10]:45879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmiRE-00081U-Ei
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmiRB-0001hr-AD
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:28:24 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 29 Aug 2017 17:27:51 +0200
Message-Id: <20170829152751.3174-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170829152751.3174-1-marcandre.lureau@redhat.com>
References: <20170829152751.3174-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] vhost-user-bridge: fix resume
 regression (since 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: victork@redhat.com, qemu-stable@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Commit e10e798c85c2331 switched to libvhost-user which lacked support
for resuming the avail_idx based on used_idx.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.14.1.146.gd35faa819
