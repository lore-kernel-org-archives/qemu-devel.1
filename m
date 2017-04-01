Received: from eggs.gnu.org ([2001:4830:134:3::10]:53172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJQT-0002Tc-TE
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJQQ-0001gG-5g
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:50:45 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJQP-0001g7-O9
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:50:42 -0400
Received: by mail-oi0-x243.google.com with SMTP id b187so13199794oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:50:41 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:50:40 +0300
Message-ID: <CA+KKJYACFwwGCgNVKTRne4JZTAc7s03ekSxGvznvvhGaRzmp8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 15/43] timer: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, i.mitsyanko@gmail.com, mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, gxt@mprc.pku.edu.cn, atar4qemu@gmail.com

>From 49700fb4eeee8d06fd29d13013b7d159017af5b7 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:29:29 +0300
Subject: [PATCH 15/43] timer: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/timer/exynos4210_mct.c | 43 ++++++++++++++++++++++---------------------
 hw/timer/exynos4210_pwm.c | 18 +++++++++---------
 hw/timer/exynos4210_rtc.c | 12 +++++-------
 hw/timer/hpet.c           | 24 ++++++++++++++----------
 hw/timer/mc146818rtc.c    | 33 +++++++++++++++++++--------------
 hw/timer/pl031.c          | 17 +++++++++--------
 hw/timer/puv3_ost.c       |  4 ++--
 hw/timer/sun4v-rtc.c      | 18 ++++++++++--------
 8 files changed, 90 insertions(+), 79 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 0c18934..ebda0d3 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -61,15 +61,16 @@

 #include "hw/arm/exynos4210.h"

-//#define DEBUG_MCT

-#ifdef DEBUG_MCT
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "MCT: [%24s:%5d] " fmt, __func__, __LINE__, \
-                     ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_MCT
+#define DEBUG_MCT 0
+#endif
+
+#define DPRINTF(fmt, ...) do
{                                                        \
+    if (DEBUG_MCT)
{                                                                  \
+        fprintf(stdout, "MCT: [%24s:%5d] " fmt, __func__, __LINE__,  ##
__VA_ARGS__); \
+
}
\
+} while (0);

 #define    MCT_CFG          0x000
 #define    G_CNT_L          0x100
@@ -366,7 +367,7 @@ static void
exynos4210_mct_update_freq(Exynos4210MCTState *s);
 static void exynos4210_gfrc_set_count(Exynos4210MCTGT *s, uint64_t count)
 {
     s->count = count;
-    DPRINTF("global timer frc set count 0x%llx\n", count);
+    DPRINTF("global timer frc set count 0x%lx\n", count);
     ptimer_set_count(s->ptimer_frc, count);
 }

@@ -463,7 +464,7 @@ static int32_t exynos4210_gcomp_find(Exynos4210MCTState
*s)
         res = min_comp_i;
     }

-    DPRINTF("found comparator %d: comp 0x%llx distance 0x%llx, gfrc
0x%llx\n",
+    DPRINTF("found comparator %d: comp 0x%lx distance 0x%lx, gfrc 0x%lx\n",
             res,
             s->g_timer.reg.comp[res],
             distance_min,
@@ -902,7 +903,7 @@ static void exynos4210_ltick_event(void *opaque)
         if (s->reg.int_enb & L_INT_INTENB_ICNTEIE) {
 #ifdef DEBUG_MCT
             time2[s->id] = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            DPRINTF("local timer[%d] IRQ: %llx\n", s->id,
+            DPRINTF("local timer[%d] IRQ: %lx\n", s->id,
                     time2[s->id] - time1[s->id]);
             time1[s->id] = time2[s->id];
 #endif
@@ -1006,7 +1007,7 @@ static uint64_t exynos4210_mct_read(void *opaque,
hwaddr offset,
         shift = 8 * (offset & 0x4);
         count = exynos4210_gfrc_get_count(&s->g_timer);
         value = UINT32_MAX & (count >> shift);
-        DPRINTF("read FRC=0x%llx\n", count);
+        DPRINTF("read FRC=0x%lx\n", count);
         break;

     case G_CNT_WSTAT:
@@ -1128,14 +1129,14 @@ static void exynos4210_mct_write(void *opaque,
hwaddr offset,
     case G_CNT_U:
         if (offset == G_CNT_L) {

-            DPRINTF("global timer write to reg.cntl %llx\n", value);
+            DPRINTF("global timer write to reg.cntl %lx\n", value);

             new_frc = (s->g_timer.reg.cnt & (uint64_t)UINT32_MAX << 32) +
value;
             s->g_timer.reg.cnt_wstat |= G_CNT_WSTAT_L;
         }
         if (offset == G_CNT_U) {

-            DPRINTF("global timer write to reg.cntu %llx\n", value);
+            DPRINTF("global timer write to reg.cntu %lx\n", value);

             new_frc = (s->g_timer.reg.cnt & UINT32_MAX) +
                     ((uint64_t)value << 32);
@@ -1159,7 +1160,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
             (((uint64_t)UINT32_MAX << 32) >> shift)) +
             (value << shift);

-    DPRINTF("comparator %d write 0x%llx val << %d\n", index, value, shift);
+    DPRINTF("comparator %d write 0x%lx val << %d\n", index, value, shift);

     if (offset&0x4) {
         s->g_timer.reg.wstat |= G_WSTAT_COMP_U(index);
@@ -1175,7 +1176,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
         s->g_timer.reg.tcon = value;
         s->g_timer.reg.wstat |= G_WSTAT_TCON_WRITE;

-        DPRINTF("global timer write to reg.g_tcon %llx\n", value);
+        DPRINTF("global timer write to reg.g_tcon %lx\n", value);

         /* Start FRC if transition from disabled to enabled */
         if ((value & G_TCON_TIMER_ENABLE) > (old_val &
@@ -1222,7 +1223,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
             }
         }

-        DPRINTF("global timer INT enable %llx\n", value);
+        DPRINTF("global timer INT enable %lx\n", value);
         s->g_timer.reg.int_enb = value;
         break;

@@ -1309,7 +1310,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
         if (tcntb_max[lt_i] < value) {
             tcntb_max[lt_i] = value;
         }
-        DPRINTF("local timer[%d] TCNTB write %llx; max=%x, min=%x\n",
+        DPRINTF("local timer[%d] TCNTB write %lx; max=%x, min=%x\n",
                 lt_i, value, tcntb_max[lt_i], tcntb_min[lt_i]);
 #endif
         break;
@@ -1352,7 +1353,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr
offset,
         if (icntb_max[lt_i] < value) {
             icntb_max[lt_i] = value;
         }
-DPRINTF("local timer[%d] ICNTB write %llx; max=%x, min=%x\n\n",
+DPRINTF("local timer[%d] ICNTB write %lx; max=%x, min=%x\n\n",
         lt_i, value, icntb_max[lt_i], icntb_min[lt_i]);
 #endif
 break;
@@ -1362,7 +1363,7 @@ break;
         lt_i = GET_L_TIMER_IDX(offset);
         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);

-        DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
+        DPRINTF("local timer[%d] FRCNTB write %lx\n", lt_i, value);

         s->l_timer[lt_i].reg.wstat |= L_WSTAT_FRCCNTB_WRITE;
         s->l_timer[lt_i].reg.cnt[L_REG_CNT_FRCCNTB] = value;
@@ -1379,7 +1380,7 @@ break;
     case L0_INT_CSTAT: case L1_INT_CSTAT:
         lt_i = GET_L_TIMER_IDX(offset);

-        DPRINTF("local timer[%d] CSTAT write %llx\n", lt_i, value);
+        DPRINTF("local timer[%d] CSTAT write %lx\n", lt_i, value);

         s->l_timer[lt_i].reg.int_cstat &= ~value;
         if (!s->l_timer[lt_i].reg.int_cstat) {
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index f576507..1dbff74 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -29,15 +29,15 @@

 #include "hw/arm/exynos4210.h"

-//#define DEBUG_PWM
-
-#ifdef DEBUG_PWM
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "PWM: [%24s:%5d] " fmt, __func__, __LINE__, \
-                ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_PWM
+#define DEBUG_PWM 0
+#endif
+
+#define DPRINTF(fmt, ...) do
{                                                        \
+    if (DEBUG_PWM)
{                                                                  \
+         fprintf(stdout, "PWM: [%24s:%5d] " fmt, __func__, __LINE__, ##
__VA_ARGS__); \
+
}
\
+} while (0);

 #define     EXYNOS4210_PWM_TIMERS_NUM      5
 #define     EXYNOS4210_PWM_REG_MEM_SIZE    0x50
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 1a648c5..4436043 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -39,13 +39,11 @@

 #define DEBUG_RTC 0

-#if DEBUG_RTC
-#define DPRINTF(fmt, ...) \
-        do { fprintf(stdout, "RTC: [%24s:%5d] " fmt, __func__, __LINE__, \
-                ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DPRINTF(fmt, ...) do
{                                                        \
+    if (DEBUG_RTC)
{                                                                  \
+        fprintf(stdout, "RTC: [%24s:%5d] " fmt, __func__, __LINE__,  ##
__VA_ARGS__); \
+
}
\
+} while (0);

 #define     EXYNOS4210_RTC_REG_MEM_SIZE     0x0100

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index a2c18b3..38167a7 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -36,12 +36,16 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/timer/i8254.h"

-//#define HPET_DEBUG
-#ifdef HPET_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
+
+#ifndef HPET_DEBUG
+#define HPET_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                 \
+    if (HPET_DEBUG) {                          \
+        fprintf(stderr, fmt , ## __VA_ARGS__); \
+    }                                          \
+} while (0);

 #define HPET_MSI_SUPPORT        0

@@ -387,7 +391,7 @@ static void hpet_del_timer(HPETTimer *t)
     update_irq(t, 0);
 }

-#ifdef HPET_DEBUG
+#if HPET_DEBUG
 static uint32_t hpet_ram_readb(void *opaque, hwaddr addr)
 {
     printf("qemu: hpet_read b at %" PRIx64 "\n", addr);
@@ -480,7 +484,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
     HPETState *s = opaque;
     uint64_t old_val, new_val, val, index;

-    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#x\n", addr,
value);
+    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " = %#lx\n", addr,
value);
     index = addr;
     old_val = hpet_ram_read(opaque, addr, 4);
     new_val = value;
@@ -622,7 +626,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            DPRINTF("qemu: HPET counter written. ctr = %#x -> %" PRIx64
"\n",
+            DPRINTF("qemu: HPET counter written. ctr = %#lx -> %" PRIx64
"\n",
                     value, s->hpet_counter);
             break;
         case HPET_COUNTER + 4:
@@ -631,7 +635,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             s->hpet_counter =
                 (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) <<
32);
-            DPRINTF("qemu: HPET counter + 4 written. ctr = %#x -> %"
PRIx64 "\n",
+            DPRINTF("qemu: HPET counter + 4 written. ctr = %#lx -> %"
PRIx64 "\n",
                     value, s->hpet_counter);
             break;
         default:
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 4165450..dbf3dcc 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -37,20 +37,25 @@
 #include "hw/i386/apic.h"
 #endif

-//#define DEBUG_CMOS
-//#define DEBUG_COALESCED
-
-#ifdef DEBUG_CMOS
-# define CMOS_DPRINTF(format, ...)      printf(format, ## __VA_ARGS__)
-#else
-# define CMOS_DPRINTF(format, ...)      do { } while (0)
-#endif
-
-#ifdef DEBUG_COALESCED
-# define DPRINTF_C(format, ...)      printf(format, ## __VA_ARGS__)
-#else
-# define DPRINTF_C(format, ...)      do { } while (0)
-#endif
+#ifndef DEBUG_CMOS
+#define DEBUG_CMOS 0
+#endif
+
+#ifndef DEBUG_COALESCED
+#define DEBUG_COALESCED 0
+#endif
+
+#define CMOS_DPRINTF(fmt, ...) do {           \
+    if (DEBUG_CMOS) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);
+
+#define DPRINTF_C(fmt, ...) do {              \
+    if (DEBUG_COALESCED) {                    \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define SEC_PER_MIN     60
 #define MIN_PER_HOUR    60
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index dbbeb9b..08533de 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -18,14 +18,15 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"

-//#define DEBUG_PL031
-
-#ifdef DEBUG_PL031
-#define DPRINTF(fmt, ...) \
-do { printf("pl031: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_PL031
+#define DEBUG_PL031 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_PL031) {                                   \
+        fprintf(stderr, "pl031: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 #define RTC_DR      0x00    /* Data read register */
 #define RTC_MR      0x04    /* Match register */
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0b3d717..11af32d 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -53,7 +53,7 @@ static uint64_t puv3_ost_read(void *opaque, hwaddr offset,
     default:
         DPRINTF("Bad offset %x\n", (int)offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);
     return ret;
 }

@@ -62,7 +62,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
 {
     PUV3OSTState *s = opaque;

-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
     switch (offset) {
     case 0x00: /* Match Register 0 */
         s->reg_OSMR0 = value;
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 31052322..db68561 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -15,14 +15,16 @@
 #include "qemu/timer.h"
 #include "hw/timer/sun4v-rtc.h"

-//#define DEBUG_SUN4V_RTC
-
-#ifdef DEBUG_SUN4V_RTC
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_SUN4V_RTC
+#define DEBUG_SUN4V_RTC 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                               \
+    if (DEBUG_SUN4V_RTC) {                                   \
+        fprintf(stderr, "sun4v_rtc: " fmt , ## __VA_ARGS__); \
+    }                                                        \
+} while (0);

 #define TYPE_SUN4V_RTC "sun4v_rtc"
 #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
-- 
2.8.0.rc3
