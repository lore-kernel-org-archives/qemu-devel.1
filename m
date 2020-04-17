Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13323C3815B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 17:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D0822209
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kye46WVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D0822209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPUfO-0006Ix-Tr
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 13:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rfried.dev@gmail.com>) id 1jPUcp-0003Ty-1g
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 13:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1jPUco-0000ky-2k
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 13:17:58 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1jPUck-0000hB-Gq; Fri, 17 Apr 2020 13:17:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id k11so3937351wrp.5;
 Fri, 17 Apr 2020 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ttOhgnDLQfGWXOWogf5pjl5Ry85FgVYUCdfxTn50lGM=;
 b=Kye46WVQ4Ke9a7G/WNj0lDYC4kqam7hYN9AOj5P97fatmE21gzdjHKhOP183Gx5q8a
 58E1hO0rxjP7P3TFPUZZWHX8D3iPDcroA8xpzn1atryLsGvsdj2EEZbtPS2I/rOLZN/Q
 I6ParmCFre8+MiKChcBtG9eg/yaMlCidtzQNliy/5Fmgc3WMIv7Ztt8uvQwoq/ZeK37C
 FJFvZbqLZLSA+yOihHkep5InMauDNuiSD5c0eOMEjuTRFqxCyJqjCWHb5YNZI8o8y9UB
 Cv0OAQC9x5UZjqZQB1Wg3nvpm9SgnK7ZFSDhUJwuwvVZwIYRqUjGzHdSX9d+PWmctFy/
 0RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ttOhgnDLQfGWXOWogf5pjl5Ry85FgVYUCdfxTn50lGM=;
 b=pe5jurk60nh8RBycN36tVh+UnGE1ONs86a8dVppXu4ejW3zheCeLKgzrNn9zinF8wD
 Vf3Iq0SWc8gwXtfooFgvgdIB4NHIlwA2lGJZ0mpHisyeugfrH0HzMqLr7O6ikIaa8RZw
 EFD+ajJrLt/mAGcnqAa4szFPEAp6J/JzLfN/N8fd6F7NEWQLn5KdPq7EqS6I2TrGnZWP
 Kuzl9FJqUAKsvQdxxOpZQg9rkVrKKUdmnc83Sgrjia+mFn2hvNMgjgCnSS7CnV5sokYN
 1wwQ+iAGurNv0rMwHL0lUyf+vROvDE1EWOxLr3tyBLi079Vv66xW7Zx2PFnsIZSs8R41
 mbjg==
X-Gm-Message-State: AGi0PubhxwHuvxaLgv9YvfLT9kwmlY5U8lhIy1GRjW0dY9CHqL5hpyS0
 f7O4TIA7naBwz9oMT8W1pPE=
X-Google-Smtp-Source: APiQypJpl9vtYahHmM/+5ZgnMU8K0YjRUFAesEObXZpSLFBLlLaFgK1gVRszbxnKL+haeTx+Fz4y7w==
X-Received: by 2002:adf:e711:: with SMTP id c17mr3386425wrm.334.1587143873393; 
 Fri, 17 Apr 2020 10:17:53 -0700 (PDT)
Received: from localhost.localdomain ([37.142.6.51])
 by smtp.gmail.com with ESMTPSA id 91sm19154440wra.37.2020.04.17.10.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 10:17:52 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: edgar.iglesias@gmail.com, alistair@alistair23.me, peter.maydell@linaro.org,
 jasowang@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH v2] Cadence: gem: fix wraparound in 64bit descriptors
Date: Fri, 17 Apr 2020 20:17:36 +0300
Message-Id: <20200417171736.441607-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wraparound of TX descriptor cyclic buffer only updated
the low 32 bits of the descriptor.
Fix that by checking if we're working with 64bit descriptors.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
v2: Fix indention problem.

 hw/net/cadence_gem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 51ec5a072d..b7b7985bf2 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1238,7 +1238,14 @@ static void gem_transmit(CadenceGEMState *s)
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
                 tx_desc_set_last(desc);
-                packet_desc_addr = s->regs[GEM_TXQBASE];
+
+                if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                    packet_desc_addr = s->regs[GEM_TBQPH];
+                    packet_desc_addr <<= 32;
+                } else {
+                    packet_desc_addr = 0;
+                }
+                packet_desc_addr |= s->regs[GEM_TXQBASE];
             } else {
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
-- 
2.26.0


