Received: from eggs.gnu.org ([2001:4830:134:3::10]:48325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cYXcN-0003OZ-PO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cYXcJ-0006Yu-Mm
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:33:03 -0500
Received: from mail.ispras.ru ([83.149.199.45]:34170)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cYXcJ-0006Xr-BP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 07:32:59 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170131115913.6828.12266.stgit@PASHA-ISP>
	<CAJ+F1CKUVDvnyhOT6XR1=bQL8ia9GCUBx=0xotGCBmojtR6XSg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKUVDvnyhOT6XR1=bQL8ia9GCUBx=0xotGCBmojtR6XSg@mail.gmail.com>
Date: Tue, 31 Jan 2017 15:32:57 +0300
Message-ID: <001001d27bbe$2770c3f0$76524bd0$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Marc-Andr=C3=A9_Lureau'?= <marcandre.lureau@gmail.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com

This patch is needed to make this timer deterministic and to use =
execution record/replay

for audio devices.

=20

audio_reset_timer is used in the function audio_vm_change_state_handler.

Therefore every time VM is stopped or restarted the timer will be reset =
to new timeout.

Virtual clock does not proceed while VM is stopped. Therefore there is =
no need

in resetting the timeout when VM restarts.

=20

Pavel Dovgalyuk

=20

From: Marc-Andr=C3=A9 Lureau [mailto:marcandre.lureau@gmail.com]=20
Sent: Tuesday, January 31, 2017 3:16 PM
To: Pavel Dovgalyuk; qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; dovgaluk@ispras.ru; kraxel@redhat.com
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer =
deterministic

=20

Hi

=20

On Tue, Jan 31, 2017 at 4:03 PM Pavel Dovgalyuk =
<pavel.dovgaluk@ispras.ru> wrote:

This patch changes resetting strategy of the audio polling timer.
It does not change expiration time if the timer is already set.

=20

You describe the change, but could you explain the reasons you propose =
it?
=20

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 audio/audio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index c845a44..1ee95a5 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1112,8 +1112,10 @@ static int audio_is_timer_needed (void)
 static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
-        timer_mod (s->ts,
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
+        if (!timer_pending(s->ts)) {
+            timer_mod (s->ts,
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + =
conf.period.ticks);
+        }
     }
     else {
         timer_del (s->ts);



--=20

Marc-Andr=C3=A9 Lureau
