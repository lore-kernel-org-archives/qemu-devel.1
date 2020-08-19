Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7009FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A2B206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A2B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LAb-0001KV-GJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8L2y-0001Tb-Lq; Wed, 19 Aug 2020 06:10:20 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:54787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8L2t-0006ZA-So; Wed, 19 Aug 2020 06:10:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.35])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 20B215892853;
 Wed, 19 Aug 2020 12:10:09 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 12:10:08 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004de7e645e-35f4-4ee8-b522-7c0a577c96e5,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/21] ftgmac100: Fix integer overflow in ftgmac100_do_tx()
Date: Wed, 19 Aug 2020 12:09:49 +0200
Message-ID: <20200819100956.2216690-15-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819100956.2216690-1-clg@kaod.org>
References: <20200819100956.2216690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: f73ff509-cf94-4ea7-aba5-56da50eb8178
X-Ovh-Tracer-Id: 18050427308102028079
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:10:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mauro Matteo Cascella <mcascell@redhat.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ziming Zhang <ezrakiez@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When inserting the VLAN tag in packets, memmove() can generate an
integer overflow for packets whose length is less than 12 bytes.

Move the VLAN insertion when the last segment of the frame is reached
and check length against the size of the ethernet header (14 bytes) to
avoid the crash. Return FTGMAC100_INT_XPKT_LOST status if the frame is
too small. This seems like a good modeling choice even if Aspeed does
not specify anything in that case.

Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 55 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 280aa3d3a1e2..7c9fa720df03 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -481,6 +481,37 @@ static int ftgmac100_write_bd(FTGMAC100Desc *bd, dma_addr_t addr)
     return 0;
 }
 
+static int ftgmac100_insert_vlan(FTGMAC100State *s, int frame_size,
+                                  uint8_t vlan_tci)
+{
+    uint8_t *vlan_hdr = s->frame + (ETH_ALEN * 2);
+    uint8_t *payload = vlan_hdr + sizeof(struct vlan_header);
+
+    if (frame_size < sizeof(struct eth_header)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: frame too small for VLAN insertion : %d bytes\n",
+                      __func__, frame_size);
+        s->isr |= FTGMAC100_INT_XPKT_LOST;
+        goto out;
+    }
+
+    if (frame_size + sizeof(struct vlan_header) > sizeof(s->frame)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: frame too big : %d bytes\n",
+                      __func__, frame_size);
+        s->isr |= FTGMAC100_INT_XPKT_LOST;
+        frame_size -= sizeof(struct vlan_header);
+    }
+
+    memmove(payload, vlan_hdr, frame_size - (ETH_ALEN * 2));
+    stw_be_p(vlan_hdr, ETH_P_VLAN);
+    stw_be_p(vlan_hdr + 2, vlan_tci);
+    frame_size += sizeof(struct vlan_header);
+
+out:
+    return frame_size;
+}
+
 static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
                             uint32_t tx_descriptor)
 {
@@ -530,25 +561,17 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
             break;
         }
 
-        /* Check for VLAN */
-        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
-            bd.des1 & FTGMAC100_TXDES1_INS_VLANTAG &&
-            be16_to_cpu(PKT_GET_ETH_HDR(ptr)->h_proto) != ETH_P_VLAN) {
-            if (frame_size + len + 4 > sizeof(s->frame)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes\n",
-                              __func__, len);
-                s->isr |= FTGMAC100_INT_XPKT_LOST;
-                len =  sizeof(s->frame) - frame_size - 4;
-            }
-            memmove(ptr + 16, ptr + 12, len - 12);
-            stw_be_p(ptr + 12, ETH_P_VLAN);
-            stw_be_p(ptr + 14, bd.des1);
-            len += 4;
-        }
-
         ptr += len;
         frame_size += len;
         if (bd.des0 & FTGMAC100_TXDES0_LTS) {
+
+            /* Check for VLAN */
+            if (flags & FTGMAC100_TXDES1_INS_VLANTAG &&
+                be16_to_cpu(PKT_GET_ETH_HDR(s->frame)->h_proto) != ETH_P_VLAN) {
+                frame_size = ftgmac100_insert_vlan(s, frame_size,
+                                            FTGMAC100_TXDES1_VLANTAG_CI(flags));
+            }
+
             if (flags & FTGMAC100_TXDES1_IP_CHKSUM) {
                 net_checksum_calculate(s->frame, frame_size);
             }
-- 
2.25.4


