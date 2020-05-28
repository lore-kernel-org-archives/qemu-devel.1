Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFA2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C67207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oORw18Q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C67207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR04-0000WK-Ds
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvN-00027q-Jj; Thu, 28 May 2020 18:22:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvK-0005fa-1O; Thu, 28 May 2020 18:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704571; x=1622240571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6RkZQFByFl8XM3HFMV8b3oaAVUpsBTmA2wZJl/MG+Jc=;
 b=oORw18Q8A1EihJyannqzPQ17wYQ/8g1Kbq5yp1IcRJ2zTRbgWZOuuXlk
 yOeJp3x4SEROTGARXUd+7zokDy3oo2vT9xIf4Jgtfe6hy26/Y6yM9yKaM
 vyHWpOC8Xcu+jDAVtUvu0w4j3XU6A6galUEkKoCzozrrQXlyDNj0PRngH
 q5qvDMuNHjdoXf12VEWfulAEjHvyju4BbMHqHlJJEg+k/yQTiGgphy0CD
 tQ4XRLpOvpC5C2uaLxdyBJwyB1CeDssVwO9UFAvnPhrhatbwDdkheqyJU
 4bKLseSeu7McZ3AOHB2SKUfrGCBdp95sPBEgnuYnfkg5JQaV3q2JuA3+2 A==;
IronPort-SDR: TroVOFqSTQc23EcrO4USPUmT5dEwV2uZEf/zfBarzgprkrZAFIOTVdi5l4aC5/sSJsF9DDyyKc
 KwXIt2rQ4JPwPzwPViX6NrJ2z5hVnujtG1rpCJgF3sBC07cvChTBHyBQKuSqTa3UHMqarnAASj
 WLVzOnXMpWnMQPo/9iuxEaheFEDjlOI3eHk0YRC6VAyOE3dAGXrqVRENshne8cVjcErI+49t0y
 CIAbTaT02QwMraQJYg3zds07Gfz43yskYuCrgiUsEaeGz3rwvBJYEGy+OI0K1Ww1gUVboetTEy
 iAo=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="139073326"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:22:47 +0800
IronPort-SDR: fbWDAwdOfVQWb1a0YtGLpY6oHCgHvC1H7bkYmuNM31pQvzCEJDhOFwjB1eMN11PLt6QwgsaURa
 zrKDc2NX9CQqFK1/xsp+ISXC8CxiM2pVA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:12:01 -0700
IronPort-SDR: Dwnn15WbeYVaQuiFaqO1AJOIjAgX/bAYUBrRn56ezUbBdL59/NnZOUTCbxItgbejN2yYVJRfZV
 Lq6cnnti3D6g==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:22:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 01/11] riscv/boot: Add a missing header include
Date: Thu, 28 May 2020 15:14:09 -0700
Message-Id: <7a0a552fd69403a64bf7aaf25a6ef02c10635ed1.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704015.git.alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:22:43
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


