Received: from eggs.gnu.org ([2001:4830:134:3::10]:52583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhuSU-0001M7-BV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhuSR-0007n0-8w
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:22:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fhuSR-0007kG-3d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:22:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 434B64067F19
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 10:22:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 11:22:15 +0100
Message-Id: <20180724102215.31866-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] audio/hda: Fix migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com, berrange@redhat.com, quintela@redhat.com, marcandre.lureau@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix outgoing migration which was crashing in
vmstate_hda_audio_stream_buf_needed, I think the problem
is that we have room for upto 4 streams in the array but only
use 2, when we come to try and save the state of the unused
streams we hit st->state == NULL.

Fixes: 280c1e1cdb24d80ecdfc
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/audio/hda-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 2b58c3505b..617a1c1016 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -786,7 +786,7 @@ static void hda_audio_reset(DeviceState *dev)
 static bool vmstate_hda_audio_stream_buf_needed(void *opaque)
 {
     HDAAudioStream *st = opaque;
-    return st->state->use_timer;
+    return st->state && st->state->use_timer;
 }
 
 static const VMStateDescription vmstate_hda_audio_stream_buf = {
-- 
2.17.1
