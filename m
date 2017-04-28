Received: from eggs.gnu.org ([2001:4830:134:3::10]:57947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d40la-0000JK-7X
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d40lV-0005Av-Kr
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:56:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d40lV-0005An-FK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 03:56:33 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Apr 2017 09:56:12 +0200
Message-Id: <20170428075612.9997-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] audio: release capture buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>, Huawei PSIRT <PSIRT@huawei.com>

AUD_add_capture() allocates two buffers which get never released.
Add the missing calls to AUD_del_capture().

Impact: Allows vnc clients to exhaust host memory by repeatly
starting and stopping audio capture.

Cc: P J P <ppandit@redhat.com>
Cc: Huawei PSIRT <PSIRT@huawei.com>
Reported-by: "Jiangxin (hunter, SCC)" <jiangxin1@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index c8898d8422..beafed209b 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2028,6 +2028,8 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
                     sw = sw1;
                 }
                 QLIST_REMOVE (cap, entries);
+                g_free (cap->hw.mix_buf);
+                g_free (cap->buf);
                 g_free (cap);
             }
             return;
-- 
2.9.3
