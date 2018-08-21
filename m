Received: from eggs.gnu.org ([2001:4830:134:3::10]:60886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001Am-8i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3m-0005aG-51
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:51285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3j-0005Qk-FL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:12 -0400
Received: by mail-wm0-x22e.google.com with SMTP id y2-v6so3642563wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:08 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.03.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:03:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:36 +0200
Message-Id: <1534870966-9287-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/74] fix "Missing break in switch" coverity
 reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Many of these are marked as "intentional/fix required" because they
just need adding a fall through comment.  This is exactly what this
patch does, except for target/mips/translate.c where it is easier to
duplicate the code, and hw/audio/sb16.c where I consulted the DOSBox
sources and decide to just remove the LOG_UNIMP before the fallthrough.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/m68k.c            |  1 +
 hw/arm/pxa2xx.c         |  2 +-
 hw/audio/cs4231a.c      |  1 +
 hw/audio/gusemu_hal.c   |  1 +
 hw/audio/sb16.c         | 11 ++++++++---
 hw/display/cg3.c        |  1 +
 hw/display/cirrus_vga.c |  3 ++-
 hw/timer/sh_timer.c     |  1 +
 target/arm/helper.c     |  1 +
 target/i386/translate.c |  2 ++
 10 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index a687df4..0dc8aa1 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1623,6 +1623,7 @@ print_insn_arg (const char *d,
 
     case 'X':
       place = '8';
+      /* fall through */
     case 'Y':
     case 'Z':
     case 'W':
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index b67b0ce..f598a1c 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -409,7 +409,7 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
     case MDCNFG ... SA1110:
         if ((addr & 3) == 0)
             return s->mm_regs[addr >> 2];
-
+        /* fall through */
     default:
         printf("%s: Bad register " REG_FMT "\n", __func__, addr);
         break;
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index aaebec1..9089dcb 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -305,6 +305,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
 
     case 6:
         as.endianness = 1;
+        /* fall through */
     case 2:
         as.fmt = AUD_FMT_S16;
         s->shift = as.nchannels;
diff --git a/hw/audio/gusemu_hal.c b/hw/audio/gusemu_hal.c
index 1150fc4..ae40ca3 100644
--- a/hw/audio/gusemu_hal.c
+++ b/hw/audio/gusemu_hal.c
@@ -261,6 +261,7 @@ void gus_write(GUSEmuState * state, int port, int size, unsigned int data)
             GUSregb(IRQStatReg2x6) = 0x10;
             GUS_irqrequest(state, state->gusirq, 1);
         }
+        /* fall through */
     case 0x20D:                /* SB2xCd no IRQ */
         GUSregb(SB2xCd) = (uint8_t) data;
         break;
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 5a4d323..c5b9bf7 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -741,10 +741,15 @@ static void complete (SB16State *s)
             ldebug ("set time const %d\n", s->time_const);
             break;
 
-        case 0x42:              /* FT2 sets output freq with this, go figure */
-            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
-                          " should\n");
         case 0x41:
+        case 0x42:
+            /*
+             * 0x41 is documented as setting the output sample rate,
+             * and 0x42 the input sample rate, but in fact SB16 hardware
+             * seems to have only a single sample rate under the hood,
+             * and FT2 sets output freq with this (go figure).  Compare:
+             * http://homepages.cae.wisc.edu/~brodskye/sb16doc/sb16doc.html#SamplingRate
+             */
             s->freq = dsp_get_hilo (s);
             ldebug ("set freq %d\n", s->freq);
             break;
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 6fff485..1c199ab 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -232,6 +232,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
                 s->b[s->dac_index] = regval;
                 /* Index autoincrement */
                 s->dac_index = (s->dac_index + 1) & 0xff;
+                /* fall through */
             default:
                 s->dac_state = 0;
                 break;
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 7583b18..04c87c8 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -1426,7 +1426,8 @@ static void cirrus_vga_write_sr(CirrusVGAState * s, uint32_t val)
         s->vga.hw_cursor_y = (val << 3) | (s->vga.sr_index >> 5);
 	break;
     case 0x07:			// Extended Sequencer Mode
-    cirrus_update_memory_access(s);
+        cirrus_update_memory_access(s);
+        /* fall through */
     case 0x08:			// EEPROM Control
     case 0x09:			// Scratch Register 0
     case 0x0a:			// Scratch Register 1
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 5f8736c..91b18ba 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -74,6 +74,7 @@ static uint32_t sh_timer_read(void *opaque, hwaddr offset)
     case OFFSET_TCPR:
         if (s->feat & TIMER_FEAT_CAPT)
             return s->tcpr;
+        /* fall through */
     default:
         hw_error("sh_timer_read: Bad offset %x\n", (int)offset);
         return 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c9bce1e..1b05480 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12331,6 +12331,7 @@ int arm_rmode_to_sf(int rmode)
         /* FIXME: add support for TIEAWAY and ODD */
         qemu_log_mask(LOG_UNIMP, "arm: unimplemented rounding mode: %d\n",
                       rmode);
+        /* fall through for now */
     case FPROUNDING_TIEEVEN:
     default:
         rmode = float_round_nearest_even;
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 07d185e..1f9d1d9 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4689,6 +4689,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x82:
         if (CODE64(s))
             goto illegal_op;
+        /* fall through */
     case 0x80: /* GRP1 */
     case 0x81:
     case 0x83:
@@ -8292,6 +8293,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x10e ... 0x10f:
         /* 3DNow! instructions, ignore prefixes */
         s->prefix &= ~(PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA);
+        /* fall through */
     case 0x110 ... 0x117:
     case 0x128 ... 0x12f:
     case 0x138 ... 0x13a:
-- 
1.8.3.1
