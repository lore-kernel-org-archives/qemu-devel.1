Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0001U3-5M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1o-0004XZ-TO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1o-0004XD-N1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:20 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:44 +0200
Message-Id: <20170504071811.3547-4-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 03/30] audio: release capture buffers
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

AUD_add_capture() allocates two buffers which are never released.
Add the missing calls to AUD_del_capture().

Impact: Allows vnc clients to exhaust host memory by repeatedly
starting and stopping audio capture.

Fixes: CVE-2017-8309
Cc: P J P <ppandit@redhat.com>
Cc: Huawei PSIRT <PSIRT@huawei.com>
Reported-by: "Jiangxin (hunter, SCC)" <jiangxin1@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20170428075612.9997-1-kraxel@redhat.com
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
