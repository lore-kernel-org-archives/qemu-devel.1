Received: from eggs.gnu.org ([2001:4830:134:3::10]:49184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK87-0006px-6W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK86-0005Cj-4J
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK85-0005C4-UR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:34 -0400
Date: Fri, 8 Sep 2017 17:19:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-14-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/17] vhost-user-bridge: fix resume regression
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Commit e10e798c85c2331 switched to libvhost-user which lacked support
for resuming the avail_idx based on used_idx.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-bridge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 1e5b5ca..f922cc7 100644
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
MST
