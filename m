Received: from eggs.gnu.org ([2001:4830:134:3::10]:54246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eifHV-00048E-55
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eifHU-0008EA-74
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eifHU-0008Du-19
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:49:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EC4328203
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 11:49:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 11:49:38 +0000
Message-Id: <20180205114938.15784-5-berrange@redhat.com>
In-Reply-To: <20180205114938.15784-1-berrange@redhat.com>
References: <20180205114938.15784-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] ui: extend VNC trottling tracing to SASL
 codepaths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

In previous commit:

  commit 6aa22a29187e1908f5db738d27c64a9efc8d0bfa
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Mon Dec 18 19:12:27 2017 +0000

    ui: add trace events related to VNC client throttling

trace points related to unthrottling client I/O were missed from the
SASL codepaths.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 8ebd0d3d00..3751a777a4 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -79,12 +79,23 @@ size_t vnc_client_write_sasl(VncState *vs)
=20
     vs->sasl.encodedOffset +=3D ret;
     if (vs->sasl.encodedOffset =3D=3D vs->sasl.encodedLength) {
+        bool throttled =3D vs->force_update_offset !=3D 0;
+        size_t offset;
         if (vs->sasl.encodedRawLength >=3D vs->force_update_offset) {
             vs->force_update_offset =3D 0;
         } else {
             vs->force_update_offset -=3D vs->sasl.encodedRawLength;
         }
+        if (throttled && vs->force_update_offset =3D=3D 0) {
+            trace_vnc_client_unthrottle_forced(vs, vs->ioc);
+        }
+        offset =3D vs->output.offset;
         buffer_advance(&vs->output, vs->sasl.encodedRawLength);
+        if (offset >=3D vs->throttle_output_offset &&
+            vs->output.offset < vs->throttle_output_offset) {
+            trace_vnc_client_unthrottle_incremental(vs, vs->ioc,
+                                                    vs->output.offset);
+        }
         vs->sasl.encoded =3D NULL;
         vs->sasl.encodedOffset =3D vs->sasl.encodedLength =3D 0;
     }
--=20
2.14.3
