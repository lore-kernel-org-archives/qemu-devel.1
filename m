Received: from eggs.gnu.org ([2001:4830:134:3::10]:45964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29I-0008Rv-FC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29H-0002jb-Jj
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29H-0002iv-Ee
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:03 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:50 +0100
Message-Id: <20180724183454.120276-4-dgilbert@redhat.com>
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] audio/hda: Fix migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, kraxel@redhat.com, lidongchen@tencent.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix outgoing migration which was crashing in
vmstate_hda_audio_stream_buf_needed, I think the problem
is that we have room for upto 4 streams in the array but only
use 2, when we come to try and save the state of the unused
streams we hit st->state =3D=3D NULL.

Fixes: 280c1e1cdb24d80ecdfc
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180724102215.31866-1-dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
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
     HDAAudioStream *st =3D opaque;
-    return st->state->use_timer;
+    return st->state && st->state->use_timer;
 }
=20
 static const VMStateDescription vmstate_hda_audio_stream_buf =3D {
--=20
2.17.1
