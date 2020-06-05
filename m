Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85F72074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oQvR1f1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85F72074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1HX-0003dR-Tx
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BQ-0002Bi-IG; Thu, 04 Jun 2020 21:30:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BP-00008B-C9; Thu, 04 Jun 2020 21:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320608; x=1622856608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6lyDezE9T3xfhuHvCp1ygcMomdR21tCda3tTt8j91Lw=;
 b=oQvR1f1gDcdyxwmb19OMUPVUxH8BiOZdwdjRaWs+ayKcKl1ul7tKdg3T
 MJiqii4nUnTwSJIEinyxj/FbMUXLqgyr95jq8L37+cen4j0ilFKU6vWT8
 FWPGyoChablrTN1TeW/YLSP0yAobVxmpn4HD0cbB9Db7fHmkucKlBL1vd
 wINMacLLCcDpTYqTd6H4Yr+kACbucNN7NWe8n7XIgaqXR2L97YeLHX2Ud
 lD7aNbBLDDl4Jt+v+pjsd4gl0UjCDo0AeV5sfN9sE8B64hglEJ+62L8tU
 +T37SBdIMIjqrS0DMAEhNo7eQDuP3/bGkX8N4+RVJt1XDcuvbrZgS7963 Q==;
IronPort-SDR: S2IQQUa1vycJkRnWSUh9SECdGgNpdfD4YadY+ckzm7cISBniHid1X0UlSW7++tTUktYIa+QBWj
 tli8f2bS/B5+j/hC5+6Fxym1mcT0SNQ41J0zxa9MJ5UdwLGFX42/wQV2drCtfTPv2AGrSL3+3/
 7qTCYy6E/wIwp7IANlY5UwoqPpgl5QPQBqZt57SrFXTjQQr0j3mIWWphhQR5fLUbZ61re+9Pvx
 M29p7RTkoZnywopngMcj4J/cTKKVwY+ROWcTdqjMcwEmmrKYZmSNMNeTB46NWXIDoMgA+OnCkW
 XBY=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="143573569"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:52 +0800
IronPort-SDR: 97qWfK5GMYor+NphrvOecmEkEF0ixaY8qEIgOKMmrpdMSrmhcGNzsHQQqUWZty/mS6TMP6+2qv
 f+QFpITIvc8yLuOo7gRJLZlFU0tpCbeug=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:18:55 -0700
IronPort-SDR: Spl5iQxMsPQH+1X0PrOaNDybErX+9EBTZYKhLdwpgIoEyzRFQsKPsk+jJY6nd/U0W7dim6EkBy
 WvuYywfJR43A==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:29:52 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 08/17] target/riscv: Don't allow guest to write to htinst
Date: Thu,  4 Jun 2020 18:21:04 -0700
Message-Id: <05da8d05e9339e9bdda92bdbdfc63a4c2d51d16f.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:41
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 383be0a955..53665b0985 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -854,7 +854,6 @@ static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
 {
-    env->htinst = val;
     return 0;
 }
 
-- 
2.26.2


