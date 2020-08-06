Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE70C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E387C2312D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E387C2312D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3g1I-0006sR-Vo
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpl-0001cY-KU; Thu, 06 Aug 2020 09:21:25 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:42065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpf-0000vn-C1; Thu, 06 Aug 2020 09:21:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.111])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 3FEF5545F8B3;
 Thu,  6 Aug 2020 15:21:15 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 15:21:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00516a44fc9-6842-4507-a5e9-3945436a9983,
 96EDEDBD7B7627A0205C40E9E2B74F8D513A659B) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH for-5.2 14/19] ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
Date: Thu, 6 Aug 2020 15:21:01 +0200
Message-ID: <20200806132106.747414-15-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200806132106.747414-1-clg@kaod.org>
References: <20200806132106.747414-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 95c5e04f-67c0-40bd-9edf-c86d7739f403
X-Ovh-Tracer-Id: 273312204112694063
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgihesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehheefgeejiedtffefteejudevjeeufeeugfdtfeeuleeuteevleeihffhgfdtleenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:21:12
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

Check length against the size of the ethernet header (14 bytes) to
avoid the crash and return FTGMAC100_INT_XPKT_LOST status. This seems
like a good modeling choice even if Aspeed does not specify anything
in that case.

Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 280aa3d3a1e2..987b843fabc4 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -540,10 +540,21 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
                 s->isr |= FTGMAC100_INT_XPKT_LOST;
                 len =  sizeof(s->frame) - frame_size - 4;
             }
-            memmove(ptr + 16, ptr + 12, len - 12);
-            stw_be_p(ptr + 12, ETH_P_VLAN);
-            stw_be_p(ptr + 14, bd.des1);
-            len += 4;
+
+            if (len < sizeof(struct eth_header)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                         "%s: frame too small for VLAN insertion : %d bytes\n",
+                         __func__, len);
+                s->isr |= FTGMAC100_INT_XPKT_LOST;
+            } else {
+                uint8_t *vlan_hdr = ptr + (ETH_ALEN * 2);
+                uint8_t *payload = vlan_hdr + sizeof(struct vlan_header);
+
+                memmove(payload, vlan_hdr, len - (ETH_ALEN * 2));
+                stw_be_p(vlan_hdr, ETH_P_VLAN);
+                stw_be_p(vlan_hdr + 2, FTGMAC100_TXDES1_VLANTAG_CI(bd.des1));
+                len += sizeof(struct vlan_header);
+            }
         }
 
         ptr += len;
-- 
2.25.4


