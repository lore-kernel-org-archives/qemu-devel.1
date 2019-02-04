Received: from eggs.gnu.org ([209.51.188.92]:39724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gql7h-0005zz-3e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gql7g-0001a6-5W
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:45:45 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 21:45:17 +0100
Message-Id: <20190204204517.23698-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/input/tsc210x: Fix building with no
 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

When building with TSC_VERBOSE not defined, we get:
      CC      arm-softmmu/hw/input/tsc210x.o
    hw/input/tsc210x.c: In function =E2=80=98tsc2102_data_register_write=E2=
=80=99:
    hw/input/tsc210x.c:554:5: error: label at end of compound statement
         default:
         ^~~~~~~
    hw/input/tsc210x.c: In function =E2=80=98tsc2102_control_register_wri=
te=E2=80=99:
    hw/input/tsc210x.c:638:5: error: label at end of compound statement
         bad_reg:
         ^~~~~~~
    hw/input/tsc210x.c: In function =E2=80=98tsc2102_audio_register_write=
=E2=80=99:
    hw/input/tsc210x.c:766:5: error: label at end of compound statement
         default:
         ^~~~~~~
    make[1]: *** [rules.mak:69: hw/input/tsc210x.o] Error 1

Fix this by replacing the culprit fprintf(stderr) calls by a more
recent API: qemu_log_mask(LOG_GUEST_ERROR). Other fprintf() calls
are left untouched.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/input/tsc210x.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index ded0db9351..2eb3cb9518 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -552,10 +552,8 @@ static void tsc2102_data_register_write(
         return;
=20
     default:
-#ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_data_register_write: "
-                        "no such register: 0x%02x\n", reg);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_data_register_write: "
+                                       "no such register: 0x%02x\n", reg=
);
     }
 }
=20
@@ -636,10 +634,8 @@ static void tsc2102_control_register_write(
=20
     default:
     bad_reg:
-#ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_control_register_write: "
-                        "no such register: 0x%02x\n", reg);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_control_register_write: =
"
+                                       "no such register: 0x%02x\n", reg=
);
     }
 }
=20
@@ -764,10 +760,8 @@ static void tsc2102_audio_register_write(
         return;
=20
     default:
-#ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_audio_register_write: "
-                        "no such register: 0x%02x\n", reg);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_audio_register_write: "
+                                       "no such register: 0x%02x\n", reg=
);
     }
 }
=20
--=20
2.20.1
