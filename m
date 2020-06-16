Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7683BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4524320882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTTfYhsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4524320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5VJ-00062B-Dh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5Mg-0001kr-0v
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5MY-0005hU-LG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Iv7v8PdWQtDExiV3Bxv+45O8mnx/h/MEgHTbFx+U8pI=;
 b=WTTfYhsQD4pfvX2sHZZKhDKw8d2G9k3e3F7pwI8ljH5admqILFgJtRM1U6Ny5FXyQl4fD1
 ME+IWL4C6Kfrm/FD7alNT8J7y9XxNIT1QzAmCT2B3eqVNndHocLXIq5ft++RcdOlv/7QNT
 cotllp/lmJIE/W11YMltSNxk6o3mORc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-bhm_cbFKNT60VwE75Z0wbg-1; Tue, 16 Jun 2020 02:46:20 -0400
X-MC-Unique: bhm_cbFKNT60VwE75Z0wbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835581138300;
 Tue, 16 Jun 2020 06:46:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E242E8202D;
 Tue, 16 Jun 2020 06:46:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 12/33] net: cadence_gem: Fix the queue address update during
 wrap around
Date: Tue, 16 Jun 2020 14:45:23 +0800
Message-Id: <1592289944-13727-13-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

During wrap around and reset, queues are pointing to initial base
address of queue 0, irrespective of what queue we are dealing with.
Fix it by assigning proper base address every time.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/cadence_gem.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 2e273dca..fd3e4a8 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -845,6 +845,35 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
     return 0;
 }
 
+static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx, int q)
+{
+    uint32_t base_addr = 0;
+
+    switch (q) {
+    case 0:
+        base_addr = s->regs[tx ? GEM_TXQBASE : GEM_RXQBASE];
+        break;
+    case 1 ... (MAX_PRIORITY_QUEUES - 1):
+        base_addr = s->regs[(tx ? GEM_TRANSMIT_Q1_PTR :
+                                 GEM_RECEIVE_Q1_PTR) + q - 1];
+        break;
+    default:
+        g_assert_not_reached();
+    };
+
+    return base_addr;
+}
+
+static inline uint32_t gem_get_tx_queue_base_addr(CadenceGEMState *s, int q)
+{
+    return gem_get_queue_base_addr(s, true, q);
+}
+
+static inline uint32_t gem_get_rx_queue_base_addr(CadenceGEMState *s, int q)
+{
+    return gem_get_queue_base_addr(s, false, q);
+}
+
 static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
 {
     hwaddr desc_addr = 0;
@@ -1043,7 +1072,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         /* Next descriptor */
         if (rx_desc_get_wrap(s->rx_desc[q])) {
             DB_PRINT("wrapping RX descriptor list\n");
-            s->rx_desc_addr[q] = s->regs[GEM_RXQBASE];
+            s->rx_desc_addr[q] = gem_get_rx_queue_base_addr(s, q);
         } else {
             DB_PRINT("incrementing RX descriptor list\n");
             s->rx_desc_addr[q] += 4 * gem_get_desc_len(s, true);
@@ -1199,7 +1228,7 @@ static void gem_transmit(CadenceGEMState *s)
                                     sizeof(desc_first));
                 /* Advance the hardware current descriptor past this packet */
                 if (tx_desc_get_wrap(desc)) {
-                    s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
+                    s->tx_desc_addr[q] = gem_get_tx_queue_base_addr(s, q);
                 } else {
                     s->tx_desc_addr[q] = packet_desc_addr +
                                          4 * gem_get_desc_len(s, false);
@@ -1251,7 +1280,7 @@ static void gem_transmit(CadenceGEMState *s)
                 } else {
                     packet_desc_addr = 0;
                 }
-                packet_desc_addr |= s->regs[GEM_TXQBASE];
+                packet_desc_addr |= gem_get_tx_queue_base_addr(s, q);
             } else {
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
@@ -1457,7 +1486,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         if (!(val & GEM_NWCTRL_TXENA)) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
-                s->tx_desc_addr[i] = s->regs[GEM_TXQBASE];
+                s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
             }
         }
         if (gem_can_receive(qemu_get_queue(s->nic))) {
-- 
2.5.0


