Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMDwO-0002s3-HU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMDwN-0001TN-77
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMDwM-0001Rb-QN
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:51 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Nov 2018 16:15:15 +0100
Message-Id: <20181112151516.10012-4-kraxel@redhat.com>
In-Reply-To: <20181112151516.10012-1-kraxel@redhat.com>
References: <20181112151516.10012-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] pulseaudio: process audio data in smaller
 chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Max Ehrlich <maxehr@umiacs.umd.edu>, Martin Schrodt <martin@schrodt.org>

The rate of pulseaudio absorbing the audio stream is used to control the
the rate of the guests audio stream.  When the emulated hardware uses
small chunks (like intel-hda does) we need small chunks on the audio
backend side too, otherwise that feedback loop doesn't work very well.

Cc: Max Ehrlich <maxehr@umiacs.umd.edu>
Cc: Martin Schrodt <martin@schrodt.org>
Buglink: https://bugs.launchpad.net/bugs/1795527
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181109142032.1628-1-kraxel@redhat.com
---
 audio/paaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 949769774d..4c100bc318 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -227,7 +227,7 @@ static void *qpa_thread_out (void *arg)
             }
         }
=20
-        decr =3D to_mix =3D audio_MIN (pa->live, pa->g->conf.samples >> =
2);
+        decr =3D to_mix =3D audio_MIN(pa->live, pa->g->conf.samples >> 5=
);
         rpos =3D pa->rpos;
=20
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -319,7 +319,7 @@ static void *qpa_thread_in (void *arg)
             }
         }
=20
-        incr =3D to_grab =3D audio_MIN (pa->dead, pa->g->conf.samples >>=
 2);
+        incr =3D to_grab =3D audio_MIN(pa->dead, pa->g->conf.samples >> =
5);
         wpos =3D pa->wpos;
=20
         if (audio_pt_unlock(&pa->pt, __func__)) {
--=20
2.9.3
