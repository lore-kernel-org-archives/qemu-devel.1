Received: from eggs.gnu.org ([2001:4830:134:3::10]:42225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2t-0002Yl-HE
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2s-00048S-LG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:55 +0200
Message-Id: <20170713163219.9024-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/29] i8254: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/timer/i8254_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 976d5200f1..ee064aa819 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -93,7 +93,7 @@ int64_t pit_get_next_transition_time(PITChannelState *s=
, int64_t current_time)
         }
         break;
     case 2:
-        base =3D (d / s->count) * s->count;
+        base =3D QEMU_ALIGN_DOWN(d, s->count);
         if ((d - base) =3D=3D 0 && d !=3D 0) {
             next_time =3D base + s->count;
         } else {
@@ -101,7 +101,7 @@ int64_t pit_get_next_transition_time(PITChannelState =
*s, int64_t current_time)
         }
         break;
     case 3:
-        base =3D (d / s->count) * s->count;
+        base =3D QEMU_ALIGN_DOWN(d, s->count);
         period2 =3D ((s->count + 1) >> 1);
         if ((d - base) < period2) {
             next_time =3D base + period2;
--=20
2.13.1.395.gf7b71de06
