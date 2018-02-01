Received: from eggs.gnu.org ([2001:4830:134:3::10]:41538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehHGO-0001qg-0i
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehHGK-0000x6-V5
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:59:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ehHGK-0000wo-P6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:58:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC6874B702
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 15:58:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu,  1 Feb 2018 15:58:41 +0000
Message-Id: <20180201155841.27509-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1] ui: correctly advance output buffer when
 writing SASL data
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

In this previous commit:

  commit 8f61f1c5a6bc06438a1172efa80bc7606594fa07
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Mon Dec 18 19:12:20 2017 +0000

    ui: track how much decoded data we consumed when doing SASL encoding

I attempted to fix a flaw with tracking how much data had actually been
processed when encoding with SASL. With that flaw, the VNC server could
mistakenly discard queued data that had not been sent.

The fix was not quite right though, because it merely decremented the
vs->output.offset value. This is effectively to discarding data from the
end of the pending output buffer. We actually need to discard data from
the start of the pending output buffer. We also want to free memory that
is no longer required. The correct way to handle this is to use the
buffer_advance() helper method instead of directly manipulating the
offset value.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 74a5f513f2..fbccca8c8a 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -84,7 +84,7 @@ size_t vnc_client_write_sasl(VncState *vs)
         } else {
             vs->force_update_offset -=3D vs->sasl.encodedRawLength;
         }
-        vs->output.offset -=3D vs->sasl.encodedRawLength;
+        buffer_advance(&vs->output, vs->sasl.encodedRawLength);
         vs->sasl.encoded =3D NULL;
         vs->sasl.encodedOffset =3D vs->sasl.encodedLength =3D 0;
     }
--=20
2.14.3
