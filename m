Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC44C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215A5208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIU9dAEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215A5208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm8I-00068n-65
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5D-00088B-OR; Thu, 07 May 2020 15:21:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5C-0005FG-SZ; Thu, 07 May 2020 15:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879282; x=1620415282;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cs2msFudz/GDP6Z+alIv+E1wTpJvl8biJfFKRWtgCbk=;
 b=AIU9dAEIOLOXNdJnsI1ZGXt7N6/PlBZdqS4BKX8/A5y9nvGQlYCdywXR
 +v13vWZ8fjluwIM230rsSH10OYS/TlkpC89AcFZV5nILxILGoT88LTkbW
 g9YCQ3hTYIMI8hTgw0AxPwZoWZYaH9GOQAQiYxG7JTeNGtf/ec1nmnSYM
 rgyjJmUVxN2G+PVrgcMU3Z83IARb6wmlYmzjycLztumJadZ4odrE5F/nM
 fGyRURaAHSLzUazcB8NPT/Uq/aYZUqyFJGiL2JkAT2v+MVOoM4veSSQs6
 G/d6QepZPxZx/rLkkhcob7zL0EVLnGoyyC84nSCwkjgT+QCCcUrpQyp2E Q==;
IronPort-SDR: nqTiZ78VutqA5zZkhy0tt/uRYnD2sB9gVLDKXxX80lU2UroAuQ2MgdJIrJi885X3lvghOI6Fa4
 KTZpIz1WLp/Pm7XM7/gr5D6xL/6zJScbLxzkhZbdI3H21d+DWMK4TbMywJUpM20D0nsfGSkZ/l
 zJBtBOJpJ5RQecmXW6ADUJyd4NiS51hKR2YZT3xYnfNYIYZXHv0uF+B0oY6Fs9Iad53EX0Y1XT
 iPYkJiWvhS2Csinl0xGmnUiR5o0Q01xEPWeKNACIOw00HOet2E7xDfUiRZ0TljAHcUGHrc0AmB
 wtQ=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="246038025"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:21:20 +0800
IronPort-SDR: NJJ71/SYdlc0/GfEQF1JOiQAa60qSkrSmxmJVuIPK0SkLBdi/OXKuQyvS2yy6JMPW+5oVQdv7X
 emwoyl7UBY7vxZS3d3ldiZioS70sUmDNI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:11:45 -0700
IronPort-SDR: 43CXw0rJhfRtm3DyWsS25lrTVG/5eNBQwuOFrdv/5pxNCuM6neNAHg2Z3wbtpbwlUoRgxdJ3rf
 plxUpcGxMm7Q==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 May 2020 12:21:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/9] riscv/boot: Add a missing header include
Date: Thu,  7 May 2020 12:13:01 -0700
Message-Id: <dc10c6b220154fd448630ef7a790e5d7e59ab45a.1588878756.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588878756.git.alistair.francis@wdc.com>
References: <cover.1588878756.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:21:18
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


