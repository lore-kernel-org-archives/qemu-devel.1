Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87428C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9922133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9922133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFqM-0001pN-Hs
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFFkT-0003bI-O0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFFkO-0007RL-4Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iFFkK-0007NG-AT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBA7130A5A5A;
 Tue,  1 Oct 2019 10:51:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E78CB46;
 Tue,  1 Oct 2019 10:51:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/5] hw/m68k/next-cube: Avoid static RTC variables and
 introduce control register
Date: Tue,  1 Oct 2019 12:50:55 +0200
Message-Id: <20191001105057.3949-4-thuth@redhat.com>
In-Reply-To: <20191001105057.3949-1-thuth@redhat.com>
References: <20191001105057.3949-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 01 Oct 2019 10:51:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <huth@tuxfamily.org>

Coverity currently complains that the "if (0x00 & (0x80 >> (phase - 8))"
in next-cube.c can never be true. Right it is. The "0x00" is meant as value
of the control register of the RTC, which is currently not implemented yet.
Thus, let's add a register variable for this now. However, the RTC
registers are currently defined as static variables in nextscr2_write(),
which is quite ugly. Thus let's also move the RTC variables to the main
machine state instead. In the long run, we should likely even refactor
the whole RTC code into a separate device in a separate file, but that's
something for calm winter nights later... as a first step, cleaning up
the static variables and shutting up the warning from Coverity should
be sufficient.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190921091738.26953-1-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 73 +++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9a4a7328f9..e5343348d0 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -60,6 +60,15 @@ typedef struct next_dma {
     uint32_t size;
 } next_dma;
 
+typedef struct NextRtc {
+    uint8_t ram[32];
+    uint8_t command;
+    uint8_t value;
+    uint8_t status;
+    uint8_t control;
+    uint8_t retval;
+} NextRtc;
+
 typedef struct {
     MachineState parent;
 
@@ -77,7 +86,7 @@ typedef struct {
     uint32_t scr1;
     uint32_t scr2;
 
-    uint8_t rtc_ram[32];
+    NextRtc rtc;
 } NeXTState;
 
 /* Thanks to NeXT forums for this */
@@ -105,11 +114,8 @@ static void nextscr2_write(NeXTState *s, uint32_t val, int size)
     static int led;
     static int phase;
     static uint8_t old_scr2;
-    static uint8_t rtc_command;
-    static uint8_t rtc_value;
-    static uint8_t rtc_status = 0x90;
-    static uint8_t rtc_return;
     uint8_t scr2_2;
+    NextRtc *rtc = &s->rtc;
 
     if (size == 4) {
         scr2_2 = (val >> 8) & 0xFF;
@@ -135,52 +141,52 @@ static void nextscr2_write(NeXTState *s, uint32_t val, int size)
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
             if (phase < 8) {
-                rtc_command = (rtc_command << 1) |
-                              ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                rtc->command = (rtc->command << 1) |
+                               ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
             }
             if (phase >= 8 && phase < 16) {
-                rtc_value = (rtc_value << 1) | ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                rtc->value = (rtc->value << 1) |
+                             ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
 
                 /* if we read RAM register, output RT_DATA bit */
-                if (rtc_command <= 0x1F) {
+                if (rtc->command <= 0x1F) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    if (s->rtc_ram[rtc_command] & (0x80 >> (phase - 8))) {
+                    if (rtc->ram[rtc->command] & (0x80 >> (phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
 
-                    rtc_return = (rtc_return << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                    rtc->retval = (rtc->retval << 1) |
+                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 }
                 /* read the status 0x30 */
-                if (rtc_command == 0x30) {
+                if (rtc->command == 0x30) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
                     /* for now status = 0x98 (new rtc + FTU) */
-                    if (rtc_status & (0x80 >> (phase - 8))) {
+                    if (rtc->status & (0x80 >> (phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
 
-                    rtc_return = (rtc_return << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                    rtc->retval = (rtc->retval << 1) |
+                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 }
                 /* read the status 0x31 */
-                if (rtc_command == 0x31) {
+                if (rtc->command == 0x31) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
-                    /* for now 0x00 */
-                    if (0x00 & (0x80 >> (phase - 8))) {
+                    if (rtc->control & (0x80 >> (phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
-                    rtc_return = (rtc_return << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                    rtc->retval = (rtc->retval << 1) |
+                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 }
 
-                if ((rtc_command >= 0x20) && (rtc_command <= 0x2F)) {
+                if ((rtc->command >= 0x20) && (rtc->command <= 0x2F)) {
                     scr2_2 = scr2_2 & (~SCR2_RTDATA);
                     /* for now 0x00 */
                     time_t time_h = time(NULL);
                     struct tm *info = localtime(&time_h);
                     int ret = 0;
 
-                    switch (rtc_command) {
+                    switch (rtc->command) {
                     case 0x20:
                         ret = SCR2_TOBCD(info->tm_sec);
                         break;
@@ -205,22 +211,22 @@ static void nextscr2_write(NeXTState *s, uint32_t val, int size)
                     if (ret & (0x80 >> (phase - 8))) {
                         scr2_2 |= SCR2_RTDATA;
                     }
-                    rtc_return = (rtc_return << 1) |
-                                 ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
+                    rtc->retval = (rtc->retval << 1) |
+                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 }
 
             }
 
             phase++;
             if (phase == 16) {
-                if (rtc_command >= 0x80 && rtc_command <= 0x9F) {
-                    s->rtc_ram[rtc_command - 0x80] = rtc_value;
+                if (rtc->command >= 0x80 && rtc->command <= 0x9F) {
+                    rtc->ram[rtc->command - 0x80] = rtc->value;
                 }
                 /* write to x30 register */
-                if (rtc_command == 0xB1) {
+                if (rtc->command == 0xB1) {
                     /* clear FTU */
-                    if (rtc_value & 0x04) {
-                        rtc_status = rtc_status & (~0x18);
+                    if (rtc->value & 0x04) {
+                        rtc->status = rtc->status & (~0x18);
                         s->int_status = s->int_status & (~0x04);
                     }
                 }
@@ -229,8 +235,8 @@ static void nextscr2_write(NeXTState *s, uint32_t val, int size)
     } else {
         /* else end or abort */
         phase = -1;
-        rtc_command = 0;
-        rtc_value = 0;
+        rtc->command = 0;
+        rtc->value = 0;
     }
     s->scr2 = val & 0xFFFF00FF;
     s->scr2 |= scr2_2 << 8;
@@ -881,9 +887,10 @@ static void next_cube_init(MachineState *machine)
     /*     0x0000XX00 << vital bits */
     ns->scr1 = 0x00011102;
     ns->scr2 = 0x00ff0c80;
+    ns->rtc.status = 0x90;
 
     /* Load RTC RAM - TODO: provide possibility to load contents from file */
-    memcpy(ns->rtc_ram, rtc_ram2, 32);
+    memcpy(ns->rtc.ram, rtc_ram2, 32);
 
     /* 64MB RAM starting at 0x04000000  */
     memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_size);
-- 
2.18.1


