Received: from eggs.gnu.org ([209.51.188.92]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP87-0000Dx-Le
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP84-0004SP-0a
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:49 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Feb 2019 16:28:07 +0100
Message-Id: <20190206152807.31896-8-laurent@vivier.eu>
In-Reply-To: <20190206152807.31896-1-laurent@vivier.eu>
References: <20190206152807.31896-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] hw/input/tsc210x: Fix building with no
 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When building with TSC_VERBOSE not defined, we get:
      CC      arm-softmmu/hw/input/tsc210x.o
    hw/input/tsc210x.c: In function ‘tsc2102_data_register_write’:
    hw/input/tsc210x.c:554:5: error: label at end of compound statement
         default:
         ^~~~~~~
    hw/input/tsc210x.c: In function ‘tsc2102_control_register_write’:
    hw/input/tsc210x.c:638:5: error: label at end of compound statement
         bad_reg:
         ^~~~~~~
    hw/input/tsc210x.c: In function ‘tsc2102_audio_register_write’:
    hw/input/tsc210x.c:766:5: error: label at end of compound statement
         default:
         ^~~~~~~
    make[1]: *** [rules.mak:69: hw/input/tsc210x.o] Error 1

Fix this by replacing the culprit fprintf(stderr) calls by a more
recent API: qemu_log_mask(LOG_GUEST_ERROR). Other fprintf() calls
are left untouched.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190204204517.23698-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/input/tsc210x.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index ded0db9351..2eb3cb9518 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -552,10 +552,8 @@ static void tsc2102_data_register_write(
         return;
 
     default:
-#ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_data_register_write: "
-                        "no such register: 0x%02x\n", reg);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_data_register_write: "
+                                       "no such register: 0x%02x\n", reg);
     }
 }
 
@@ -636,10 +634,8 @@ static void tsc2102_control_register_write(
 
     default:
     bad_reg:
-#ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_control_register_write: "
-                        "no such register: 0x%02x\n", reg);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_control_register_write: "
+                                       "no such register: 0x%02x\n", reg);
     }
 }
 
@@ -764,10 +760,8 @@ static void tsc2102_audio_register_write(
         return;
 
     default:
-#ifdef TSC_VERBOSE
-        fprintf(stderr, "tsc2102_audio_register_write: "
-                        "no such register: 0x%02x\n", reg);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_audio_register_write: "
+                                       "no such register: 0x%02x\n", reg);
     }
 }
 
-- 
2.20.1
