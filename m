Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC57CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCE0246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV7Nst5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE0246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fh8-0003Ja-Qd
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fgI-0002NA-R1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fgH-00035O-LF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fgH-00035A-Ha
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2D4/HHRV+tLTLX0JwO3/UHKwj6I/1LOewrF/U3RfwM=;
 b=AV7Nst5PVIKADYot0Sl9+r8BEs/LBPAt+ya1x7oxRXr79Ho4+FwKVMlOg71Knf67j89T4K
 p/gCHve87og4uNXc7sCOiz3y+jg0IucI8TISjktg2k60ubBaqu0dmsaiKpbOhNIrMRAvbX
 DXajqkAgQ+V0/VyBqcxC9OOSxZKBD88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Ud06JH0nMp-rJ6pWdL6eOQ-1; Mon, 02 Mar 2020 02:39:58 -0500
X-MC-Unique: Ud06JH0nMp-rJ6pWdL6eOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A4ACDB60;
 Mon,  2 Mar 2020 07:39:57 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B7348;
 Mon,  2 Mar 2020 07:39:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 01/23] dp8393x: Mask EOL bit from descriptor addresses
Date: Mon,  2 Mar 2020 15:39:27 +0800
Message-Id: <1583134789-23861-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134789-23861-1-git-send-email-jasowang@redhat.com>
References: <1583134789-23861-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

The Least Significant bit of a descriptor address register is used as
an EOL flag. It has to be masked when the register value is to be used
as an actual address for copying memory around. But when the registers
are to be updated the EOL bit should not be masked.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 7045193..216d44b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -145,6 +145,9 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA=
_ARGS__); } while (0)
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
@@ -509,7 +514,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
                                MEMTXATTRS_UNSPECIFIED, s->data,
                                size);
             s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
-            if (dp8393x_get(s, width, 0) & 0x1) {
+            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
                 /* EOL detected */
                 break;
             }
@@ -765,13 +770,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     /* XXX: Check byte ordering */
=20
     /* Check for EOL */
-    if (s->regs[SONIC_LLFA] & 0x1) {
+    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
         size =3D sizeof(uint16_t) * 1 * width;
         address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                            s->data, size);
-        if (dp8393x_get(s, width, 0) & 0x1) {
+        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -831,7 +836,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
                        dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
                        MEMTXATTRS_UNSPECIFIED, s->data, size);
     s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
-    if (s->regs[SONIC_LLFA] & 0x1) {
+    if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* EOL detected */
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
     } else {
--=20
2.5.0


