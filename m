Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9DE32186A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqMnKaq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DE32186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOy2-0006Aq-5X
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx2-0004Rk-57
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx0-0005dm-Ca
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id s10so33382521wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=I7r9/QjL8RuKBxpXMjuZlnSwNbq823MwcTI3Yaf9uyQ=;
 b=QqMnKaq2Lr9LgyPgpIG3mRvCf2u2bWUfVV8lhIgkYVYjD8y+nsM/lZzrdcp7ijiAvh
 im/ExmavNO6GM10W5yzPttOQHQkE81eD3xSoH+Y4lds0HSlx9sqaS8i4eE3FD8YKYZs3
 tR2kWzDvODxosMFVZ1qZQB7QXjFX2lw9ZAZvwf5B7nOojT6gMQaKUlJv6Giwx+45TZ15
 djsSZcuY7wv0IYUfTKOeOlTX2LAWR55QcsLLM2ZRmITz8XgE5FrS66q1wU052/IlOf/7
 JmXjUuLnklCOrC2IhN3JGxktLqQtAApOcOAjajyNTRnmUunrF2T+zMGFSuAOcdLChBAU
 7nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I7r9/QjL8RuKBxpXMjuZlnSwNbq823MwcTI3Yaf9uyQ=;
 b=eSVFdjNrRntoiNIuzwOKwLjGmXXIboz8DjERkhxLWCRJecgJIbtKATxlVg79ejcsdY
 YPNtJ1it11J35NNlaWHSv4Z198PLHTjiyWkZbM74i0xdHOyvKAhhALTyfK724RG36pNw
 vZHg7ooZTUvPL5j64zhg9/ijzA4Uhooomhq3JWV3DXwsVheMPv5JyQOvsUn4JfmSyerZ
 qCby22CFu5UNGbbIAMdCuuWClnWlUBtu9vHk4wIu/6QSM6cB4sBr8HWTbSvyPpiZltKh
 2yByHKIuojHk7EqzcdTfhKdhK5sydW6lDFmLXL6eW/D6LEfCH1TA8xaTsnQZEti2WKP2
 jVOw==
X-Gm-Message-State: AOAM531v9oUAhLRep+hGsIQWeHeHrxUYjxo2v4qwcfEYL0IIh/NGjca/
 Kda0i1MJ1REAbm9rCwloXE4Rkb6sMkalzQ==
X-Google-Smtp-Source: ABdhPJzceQIGujK+Bymfs+Rd0kjP+elfIua6Aard7si9DwwOFxn6c1Qmn9KRZ8PGRw8dAq80WFMsDA==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr1823354wrb.232.1593795248424; 
 Fri, 03 Jul 2020 09:54:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/34] Add a phy-num property to the i.MX FEC emulator
Date: Fri,  3 Jul 2020 17:53:32 +0100
Message-Id: <20200703165405.17672-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Christophe Dubois <jcd@tribudubois.net>

We need a solution to use an Ethernet PHY that is not the first device
on the MDIO bus (device 0 on MDIO bus).

As an example with the i.MX6UL the NXP SOC has 2 Ethernet devices but
only one MDIO bus on which the 2 related PHY are connected but at unique
addresses.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: a1a5c0e139d1c763194b8020573dcb6025daeefa.1593296112.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/imx_fec.h |  1 +
 hw/net/imx_fec.c         | 24 +++++++++++++++++-------
 hw/net/trace-events      |  4 ++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 7b3faa40194..9f03034b893 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -268,6 +268,7 @@ typedef struct IMXFECState {
     uint32_t phy_advertise;
     uint32_t phy_int;
     uint32_t phy_int_mask;
+    uint32_t phy_num;
 
     bool is_fec;
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index eefedc252de..2c148040414 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -280,12 +280,16 @@ static void imx_phy_reset(IMXFECState *s)
 static uint32_t imx_phy_read(IMXFECState *s, int reg)
 {
     uint32_t val;
+    uint32_t phy = reg / 32;
 
-    if (reg > 31) {
-        /* we only advertise one phy */
+    if (phy != s->phy_num) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad phy num %u\n",
+                      TYPE_IMX_FEC, __func__, phy);
         return 0;
     }
 
+    reg %= 32;
+
     switch (reg) {
     case 0:     /* Basic Control */
         val = s->phy_control;
@@ -331,20 +335,25 @@ static uint32_t imx_phy_read(IMXFECState *s, int reg)
         break;
     }
 
-    trace_imx_phy_read(val, reg);
+    trace_imx_phy_read(val, phy, reg);
 
     return val;
 }
 
 static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
 {
-    trace_imx_phy_write(val, reg);
+    uint32_t phy = reg / 32;
 
-    if (reg > 31) {
-        /* we only advertise one phy */
+    if (phy != s->phy_num) {
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s.phy]%s: Bad phy num %u\n",
+                      TYPE_IMX_FEC, __func__, phy);
         return;
     }
 
+    reg %= 32;
+
+    trace_imx_phy_write(val, phy, reg);
+
     switch (reg) {
     case 0:     /* Basic Control */
         if (val & 0x8000) {
@@ -926,7 +935,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                                                        extract32(value,
                                                                  18, 10)));
         } else {
-            /* This a write operation */
+            /* This is a write operation */
             imx_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
         }
         /* raise the interrupt as the PHY operation is done */
@@ -1315,6 +1324,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 static Property imx_eth_properties[] = {
     DEFINE_NIC_PROPERTIES(IMXFECState, conf),
     DEFINE_PROP_UINT32("tx-ring-num", IMXFECState, tx_ring_num, 1),
+    DEFINE_PROP_UINT32("phy-num", IMXFECState, phy_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e6875c4c0f6..5db45456d92 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -413,8 +413,8 @@ i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
 
 # imx_fec.c
-imx_phy_read(uint32_t val, int reg) "0x%04"PRIx32" <= reg[%d]"
-imx_phy_write(uint32_t val, int reg) "0x%04"PRIx32" => reg[%d]"
+imx_phy_read(uint32_t val, int phy, int reg) "0x%04"PRIx32" <= phy[%d].reg[%d]"
+imx_phy_write(uint32_t val, int phy, int reg) "0x%04"PRIx32" => phy[%d].reg[%d]"
 imx_phy_update_link(const char *s) "%s"
 imx_phy_reset(void) ""
 imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
-- 
2.20.1


