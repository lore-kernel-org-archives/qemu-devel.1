Received: from eggs.gnu.org ([209.51.188.92]:46044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw2Qr-0005Pj-Th
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw2Qr-00080i-1m
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:15:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw2Qq-0007zF-R2
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:15:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7AAC13A40
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 10:15:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 19 Feb 2019 11:15:10 +0100
Message-Id: <20190219101510.9356-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] audio: don't use alsa by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, berrange@redhat.com, david@redhat.com

In case no sound hardware is present the driver initializes
successfully and throws errors later on, i.e. effectively the
automatic probing doesn't work.  So the driver should not be
used by default (until that is fixed).  Drop the can_be_default
flag.

Explicitly picking the alsa driver (using QEMU_AUDIO_DRV=alsa
environment variable) will continue to work.

Buglink: https://bugs.launchpad.net/qemu/+bug/1816052
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/alsaaudio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 635be73bf4..1cc570e30b 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -1218,7 +1218,6 @@ static struct audio_driver alsa_audio_driver = {
     .init           = alsa_audio_init,
     .fini           = alsa_audio_fini,
     .pcm_ops        = &alsa_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (ALSAVoiceOut),
-- 
2.9.3
