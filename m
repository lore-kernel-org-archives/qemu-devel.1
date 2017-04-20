Received: from eggs.gnu.org ([2001:4830:134:3::10]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F95-0008Sk-HT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F92-00089y-Q9
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F92-00084S-CL
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8t-0006uv-Ad
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:54 +0100
Message-Id: <1492706470-10921-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/24] stellaris: Don't hw_error() on bad
 register accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Current recommended style is to log a guest error on bad register
accesses, not kill the whole system with hw_error().  Change the
hw_error() calls to log as LOG_GUEST_ERROR or LOG_UNIMP or use
g_assert_not_reached() as appropriate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1491486314-25823-1-git-send-email-peter.maydell@linaro.org
---
 hw/arm/stellaris.c | 60 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 9edcd49..ea7a809 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -108,7 +108,10 @@ static void gptm_reload(gptm_state *s, int n, int reset)
     } else if (s->mode[n] == 0xa) {
         /* PWM mode.  Not implemented.  */
     } else {
-        hw_error("TODO: 16-bit timer mode 0x%x\n", s->mode[n]);
+        qemu_log_mask(LOG_UNIMP,
+                      "GPTM: 16-bit timer mode unimplemented: 0x%x\n",
+                      s->mode[n]);
+        return;
     }
     s->tick[n] = tick;
     timer_mod(s->timer[n], tick);
@@ -149,7 +152,9 @@ static void gptm_tick(void *opaque)
     } else if (s->mode[n] == 0xa) {
         /* PWM mode.  Not implemented.  */
     } else {
-        hw_error("TODO: 16-bit timer mode 0x%x\n", s->mode[n]);
+        qemu_log_mask(LOG_UNIMP,
+                      "GPTM: 16-bit timer mode unimplemented: 0x%x\n",
+                      s->mode[n]);
     }
     gptm_update_irq(s);
 }
@@ -286,7 +291,8 @@ static void gptm_write(void *opaque, hwaddr offset,
         s->match_prescale[0] = value;
         break;
     default:
-        hw_error("gptm_write: Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "GPTM: read at bad offset 0x%x\n", (int)offset);
     }
     gptm_update_irq(s);
 }
@@ -425,7 +431,10 @@ static int ssys_board_class(const ssys_state *s)
         }
         /* for unknown classes, fall through */
     default:
-        hw_error("ssys_board_class: Unknown class 0x%08x\n", did0);
+        /* This can only happen if the hardwired constant did0 value
+         * in this board's stellaris_board_info struct is wrong.
+         */
+        g_assert_not_reached();
     }
 }
 
@@ -479,8 +488,7 @@ static uint64_t ssys_read(void *opaque, hwaddr offset,
             case DID0_CLASS_SANDSTORM:
                 return pllcfg_sandstorm[xtal];
             default:
-                hw_error("ssys_read: Unhandled class for PLLCFG read.\n");
-                return 0;
+                g_assert_not_reached();
             }
         }
     case 0x070: /* RCC2 */
@@ -512,7 +520,8 @@ static uint64_t ssys_read(void *opaque, hwaddr offset,
     case 0x1e4: /* USER1 */
         return s->user1;
     default:
-        hw_error("ssys_read: Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSYS: read at bad offset 0x%x\n", (int)offset);
         return 0;
     }
 }
@@ -614,7 +623,8 @@ static void ssys_write(void *opaque, hwaddr offset,
         s->ldoarst = value;
         break;
     default:
-        hw_error("ssys_write: Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSYS: write at bad offset 0x%x\n", (int)offset);
     }
     ssys_update(s);
 }
@@ -748,7 +758,8 @@ static uint64_t stellaris_i2c_read(void *opaque, hwaddr offset,
     case 0x20: /* MCR */
         return s->mcr;
     default:
-        hw_error("strllaris_i2c_read: Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "stellaris_i2c: read at bad offset 0x%x\n", (int)offset);
         return 0;
     }
 }
@@ -823,17 +834,18 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
         s->mris &= ~value;
         break;
     case 0x20: /* MCR */
-        if (value & 1)
-            hw_error(
-                      "stellaris_i2c_write: Loopback not implemented\n");
-        if (value & 0x20)
-            hw_error(
-                      "stellaris_i2c_write: Slave mode not implemented\n");
+        if (value & 1) {
+            qemu_log_mask(LOG_UNIMP, "stellaris_i2c: Loopback not implemented");
+        }
+        if (value & 0x20) {
+            qemu_log_mask(LOG_UNIMP,
+                          "stellaris_i2c: Slave mode not implemented");
+        }
         s->mcr = value & 0x31;
         break;
     default:
-        hw_error("stellaris_i2c_write: Bad offset 0x%x\n",
-                  (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "stellaris_i2c: write at bad offset 0x%x\n", (int)offset);
     }
     stellaris_i2c_update(s);
 }
@@ -1057,8 +1069,8 @@ static uint64_t stellaris_adc_read(void *opaque, hwaddr offset,
     case 0x30: /* SAC */
         return s->sac;
     default:
-        hw_error("strllaris_adc_read: Bad offset 0x%x\n",
-                  (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "stellaris_adc: read at bad offset 0x%x\n", (int)offset);
         return 0;
     }
 }
@@ -1078,8 +1090,9 @@ static void stellaris_adc_write(void *opaque, hwaddr offset,
             return;
         case 0x04: /* SSCTL */
             if (value != 6) {
-                hw_error("ADC: Unimplemented sequence %" PRIx64 "\n",
-                          value);
+                qemu_log_mask(LOG_UNIMP,
+                              "ADC: Unimplemented sequence %" PRIx64 "\n",
+                              value);
             }
             s->ssctl[n] = value;
             return;
@@ -1110,13 +1123,14 @@ static void stellaris_adc_write(void *opaque, hwaddr offset,
         s->sspri = value;
         break;
     case 0x28: /* PSSI */
-        hw_error("Not implemented:  ADC sample initiate\n");
+        qemu_log_mask(LOG_UNIMP, "ADC: sample initiate unimplemented");
         break;
     case 0x30: /* SAC */
         s->sac = value;
         break;
     default:
-        hw_error("stellaris_adc_write: Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "stellaris_adc: write at bad offset 0x%x\n", (int)offset);
     }
     stellaris_adc_update(s);
 }
-- 
2.7.4
