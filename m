Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D2DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0D921872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E7EDGRZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0D921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO93o-0007rd-8d
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90n-000519-8S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90m-0004CM-AQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90m-0004C1-35; Fri, 25 Oct 2019 19:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046132; x=1603582132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FI6cG3zfTPQCvMUxHiSic1vMFtD9mJgMAFMEx1PCwOo=;
 b=E7EDGRZGj2IP5BmXeAu+KK7j3nWNNtJPLzZVRbSccSNx0YQf0vqlfe5U
 6nraZ/7Bq7WjSkGeUm/fqJdroBmhUvkaOwDhljSHbS5GuIuYdt3G4Hmt4
 U5ymljeAa9sNJYVHSh+S+4zL4RKTiIVHipE3gbjkBmfEx6UV0TteIyOs0
 brJnpUpcj9CJL6O+mvivkV4MsmL+ek5y8s1G3GnWzq9dQaGCbfWx2j3Nh
 8yZlfpGd7CZRXEClTd1l25QzTp3GpktbOMIOItLpOIEG1l8J3kizAq4RR
 fsIH66xPB9llvjXBEoOZgiLTrIUoSXMoXdGnLYnATv1AVqghUxKaB1vhj Q==;
IronPort-SDR: 4l0ACIQGLGmOWZ5nOTdIOYKxmg3lzMAmmoIPdvGqVWJ7CsgC3q4Z2Wvj5C/rPdeflac/FVpU0l
 tsrp9lK82fBaSIbG3wetZKLEM4qjIdJe0Dvbq315P/K9roZJrxEPLVuF9k5qDa2VALJl3WeHWB
 SwlZafVdqJ/Z4TrS2cWC3+1WCXI9rWx7A6wgQEt2voZkUv18omtPJoVpGo2eprYQqaUrBMEUq2
 +5V4V/c0uzuJkRB7pa5pJNkzdf96lqypUY7NykA6a9GCMpYLW+e5ylm73YnAufm7g55SueME7s
 ECA=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520383"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:09 +0800
IronPort-SDR: ht03ARS33S6GCmcx/70kIIkC54+2jD0C0jj6tDESxmgeJuESssjDf8aUz14zjTzDVNVupc24um
 fEemQflvL/GpnOS3vM6JALBG/YwYnIaQNj6B2VuQVQceaKctAZwuCBAfhxEEoPQMGimyAfG/s2
 /9FTu4+eehnzz1rPH245WrCzmfqQe9V3v5xIt6bvKwGE+t3R52cu03kBLhDh9rb05RapA+z8do
 0W+7nUNcZCiaYr+2A4FxZbzez1KTvvB0t871Bp83b5dokHpMKoxjbnYt1SO/aVLEPZmn7pKXlO
 nb8ZFqIU+UPTKZsVRYwv4kn4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:35 -0700
IronPort-SDR: /GD4YmzPrJmuht30+ba6LFrckbBdvrB6kI5DEfAygemnC/p4vxjZfZIojKfJrfyg5LU38WGdXH
 cs0XHRIBF22SX778MjQLt/FfL4GFciZPhteSW2yqTPbeDGKpQO+DYGGcmFZ71Y3UM2DiuMWnHd
 66A8lmsL2SnONhijvmLZzQ0FK1McNRwqQvXXnQ6lz1vbe3mP7ScIda1WcTXVVUG/Aut0F2ZFDM
 fxdtDPGixg/thMCmCJehbS/KyygWYkzjx1WOzsI12eTSs2KVszQszmEACcwAB6LbYRAczr14h9
 /XY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:09 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 02/27] target/riscv: Add the Hypervisor extension
Date: Fri, 25 Oct 2019 16:23:13 -0700
Message-Id: <3df46da156e3786de08b5b47f08277efcf6f366b.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f889427869..91e1c56fc4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -67,6 +67,7 @@
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
+#define RVH RV('H')
 
 /* S extension denotes that Supervisor mode exists, however it is possible
    to have a core that support S mode but does not have an MMU and there
-- 
2.23.0


