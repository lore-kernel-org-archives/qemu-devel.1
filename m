Received: from eggs.gnu.org ([2001:4830:134:3::10]:33850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmhoc-0004Qx-Lx
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dmhoY-00010C-Pz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dmhoY-0000zx-K6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BC0561486
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 14:48:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 29 Aug 2017 16:48:05 +0200
Message-Id: <20170829144805.28872-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170829144805.28872-1-marcandre.lureau@redhat.com>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] vhost-user-bridge: fix resume regression
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
Cc: victork@redhat.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Commit e10e798c85c2331 switched to libvhost-user which lacked support
for resuming the avail_idx based on used_idx.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-bridge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 1e5b5ca3da..dca48512ba 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -466,11 +466,18 @@ vubr_panic(VuDev *dev, const char *msg)
     vubr->quit =3D 1;
 }
=20
+static bool
+vubr_queue_resume_to_used(VuDev *dev, int qidx)
+{
+    return true;
+}
+
 static const VuDevIface vuiface =3D {
     .get_features =3D vubr_get_features,
     .set_features =3D vubr_set_features,
     .process_msg =3D vubr_process_msg,
     .queue_set_started =3D vubr_queue_set_started,
+    .queue_resume_to_used =3D vubr_queue_resume_to_used,
 };
=20
 static void
--=20
2.14.1.146.gd35faa819
