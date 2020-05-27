Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42085C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE012088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f4njVSEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE012088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzPH-00036L-2s
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOI-0001Gu-MB; Wed, 27 May 2020 12:58:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOF-000264-Ny; Wed, 27 May 2020 12:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598731; x=1622134731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6RkZQFByFl8XM3HFMV8b3oaAVUpsBTmA2wZJl/MG+Jc=;
 b=f4njVSEkD3ABFYvhLrPnFc7l9o3ceyI6jeHkEGNEuwEBomjFAcYpM97V
 gjrzWXqMtGKwIvlqV3K17CvjVlmF6I98pf4AB8aa+ZU25qdPfw9oamRPs
 ACSyOQmyURF2kGVQ62j6wSgJ9K44uNiFJHKDQ8Yzal2qLT3OZCvzwi6cy
 R05tH3pj/UEPNg+pp+jX5ojgb7VHjxvebKrTtzN/qqOGMr7EV4mWeg24q
 34kHtmdtCge4a627wA3JQzLaMCklCFcWhRIHwKyvDun+4znnAYCiD65pn
 344fjpGgq1SzxYbi+IQpa1F+hq9gd5Fy/KWUh1eH4CKSR5MC3t9nQGFXp Q==;
IronPort-SDR: +idNhv0EVoICSggx6a2o6C+27Txr8OHyB+vU999PGiyn8+IWdh7qk2cgE2wYIrk6aNkj83fPio
 jCLWUGm18o5f+xpgWKJr5/ofzX4AHHOLlTSk92ilineEHH6nuisdgQ1bwXspRLovPKAQKj+dNf
 Y+SDz4FE6G0//xoqfAeNhmZFrS8/wHtV4ei5bRjuOeu5G8HG94BRA7U20Gl4CneXM2V5weGPDF
 zIS4uagM0PR75WFTuBKnlgtSpJNARcTBeI5v+9YQqEboWk4FzMzOr10wB9msnYNb2M+Z3YMG5Y
 S5w=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="138633212"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:58:48 +0800
IronPort-SDR: PccI82+UuO4snExQjEdlAXZsard+4MSAbLHwa8wIxWW62mNZYkTH8M+424cQedqCTsJESX2D9a
 sJKSGCyKO20LYcm+jx2OLPapVg13++Cfg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:48:39 -0700
IronPort-SDR: ax3DnG4f9g8/B0sfTbMi6Da8pYPORoqJxBxw3CQfhgOOFdJSVfJuAm3na6OlAQvvBf+FzZRks9
 XsDgjDT22oyg==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 May 2020 09:58:49 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 01/10] riscv/boot: Add a missing header include
Date: Wed, 27 May 2020 09:50:14 -0700
Message-Id: <ed478be74ded79f99105ec53903f35cc916c4a62.1590598125.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590598125.git.alistair.francis@wdc.com>
References: <cover.1590598125.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the functions declared in this header use the symbol_fn_t
typedef itself declared in "hw/loader.h", we need to include
it here to make the header file self-contained.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 include/hw/riscv/boot.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 474a940ad5..9daa98da08 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -21,6 +21,7 @@
 #define RISCV_BOOT_H
 
 #include "exec/cpu-defs.h"
+#include "hw/loader.h"
 
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
-- 
2.26.2


