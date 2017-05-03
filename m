Received: from eggs.gnu.org ([2001:4830:134:3::10]:53411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vM-0001J8-Um
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vJ-00006E-1k
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d62vI-00005a-SB
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFD5EC04B946
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:39:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 02:38:43 +0400
Message-Id: <20170503223846.6559-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170503223846.6559-1-marcandre.lureau@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/5] audio: fix capture buffer leaks
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
 audio/audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index c8898d8422..beafed209b 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2028,6 +2028,8 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *c=
b_opaque)
                     sw =3D sw1;
                 }
                 QLIST_REMOVE (cap, entries);
+                g_free (cap->hw.mix_buf);
+                g_free (cap->buf);
                 g_free (cap);
             }
             return;
--=20
2.12.0.191.gc5d8de91d
