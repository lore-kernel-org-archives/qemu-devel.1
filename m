Received: from eggs.gnu.org ([2001:4830:134:3::10]:36365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dQ-Qr
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003fK-IP
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003eN-Co
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 621244022931
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:07 +0100
Message-Id: <20180216115410.27287-7-kraxel@redhat.com>
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/9] ui: avoid risk of 32-bit int overflow in
 VNC buffer check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

For very large framebuffers, it is theoretically possible for the result
of 'vs->throttle_output_offset * VNC_THROTTLE_OUTPUT_LIMIT_SCALE' to
exceed the size of a 32-bit int. For this to happen in practice, the
video RAM would have to be set to a large enough value, which is not
likely today. None the less we can be paranoid against future growth by
using division instead of multiplication when checking the limits.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180205114938.15784-2-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index e371710f4f..746293ddfa 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1579,8 +1579,8 @@ void vnc_write(VncState *vs, const void *data, size=
_t len)
      * handshake, or from the job thread's VncState clone
      */
     if (vs->throttle_output_offset !=3D 0 &&
-        vs->output.offset > (vs->throttle_output_offset *
-                             VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
+        (vs->output.offset / VNC_THROTTLE_OUTPUT_LIMIT_SCALE) >
+        vs->throttle_output_offset) {
         trace_vnc_client_output_limit(vs, vs->ioc, vs->output.offset,
                                       vs->throttle_output_offset);
         vnc_disconnect_start(vs);
--=20
2.9.3
