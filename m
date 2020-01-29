Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1EC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2994F2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2994F2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjoK-0002GV-80
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjlP-0004Mu-3V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjlN-0001EG-O0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:35:59 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50032)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iwjlN-0000jN-HB; Wed, 29 Jan 2020 04:35:57 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 251622999F; Wed, 29 Jan 2020 04:35:35 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <d6e8d06ad4d02f4a30c4caa6001967f806f21a1a.1580290069.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1580290069.git.fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 01/14] dp8393x: Mask EOL bit from descriptor addresses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jan 2020 20:27:49 +1100
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Least Significant bit of a descriptor address register is used as
an EOL flag. It has to be masked when the register value is to be used
as an actual address for copying memory around. But when the registers
are to be updated the EOL bit should not be masked.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Changed since v1:
 - Added macros to name constants as requested by Philippe Mathieu-Daud=C3=
=A9.
---
 hw/net/dp8393x.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index cdc2631c0c..14901c1445 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -145,6 +145,9 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __=
VA_ARGS__); } while (0)
 #define SONIC_ISR_PINT   0x0800
 #define SONIC_ISR_LCD    0x1000
=20
+#define SONIC_DESC_EOL   0x0001
+#define SONIC_DESC_ADDR  0xFFFE
+
 #define TYPE_DP8393X "dp8393x"
 #define DP8393X(obj) OBJECT_CHECK(dp8393xState, (obj), TYPE_DP8393X)
=20
@@ -197,7 +200,8 @@ static uint32_t dp8393x_crba(dp8393xState *s)
=20
 static uint32_t dp8393x_crda(dp8393xState *s)
 {
-    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
+    return (s->regs[SONIC_URDA] << 16) |
+           (s->regs[SONIC_CRDA] & SONIC_DESC_ADDR);
 }
=20
 static uint32_t dp8393x_rbwc(dp8393xState *s)
@@ -217,7 +221,8 @@ static uint32_t dp8393x_tsa(dp8393xState *s)
=20
 static uint32_t dp8393x_ttda(dp8393xState *s)
 {
-    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
+    return (s->regs[SONIC_UTDA] << 16) |
+           (s->regs[SONIC_TTDA] & SONIC_DESC_ADDR);
 }
=20
 static uint32_t dp8393x_wt(dp8393xState *s)
@@ -506,8 +511,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
-            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
-            if (dp8393x_get(s, width, 0) & 0x1) {
+            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0);
+            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
                 /* EOL detected */
                 break;
             }
@@ -763,13 +768,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
     /* XXX: Check byte ordering */
=20
     /* Check for EOL */
-    if (s->regs[SONIC_LLFA] & 0x1) {
+    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
         size =3D sizeof(uint16_t) * 1 * width;
         address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)s->data, size, 0);
-        if (dp8393x_get(s, width, 0) & 0x1) {
+        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -827,7 +832,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * wi=
dth,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
     s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
-    if (s->regs[SONIC_LLFA] & 0x1) {
+    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* EOL detected */
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
     } else {
--=20
2.24.1


