Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vQ-0001Lw-NF
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vQ-0000C1-1c
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d62vP-0000BR-Rn
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAE9C61D0E
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:39:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 02:38:44 +0400
Message-Id: <20170503223846.6559-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170503223846.6559-1-marcandre.lureau@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/5] audio: fix WAVState leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 audio/wavcapture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 8bfb9e7654..5863803584 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -88,6 +88,7 @@ static void wav_capture_destroy (void *opaque)
     WAVState *wav =3D opaque;
=20
     AUD_del_capture (wav->cap, wav);
+    g_free (wav);
 }
=20
 static void wav_capture_info (void *opaque)
--=20
2.12.0.191.gc5d8de91d
