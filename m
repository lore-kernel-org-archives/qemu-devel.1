Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D55DC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE40D21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSUm5Pht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE40D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7cm-0001CL-2p
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Na-0005Ft-Ll
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4NY-0000a6-L6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:02:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4NV-0000Ts-GO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:02:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so15441571wrm.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KkUQSWRyDo7N3gMjPFgWAFIufs62qiUnuMkPV6Fsbp4=;
 b=eSUm5Pht6gJL8SzhSmxiPQULQJzBY0cI1Q3x7OssvcCHel0w6maC1/oSV00SeY+mNE
 8VZRlirc9S5A9t3kbYe9DONj7hwVro5koBmKvSSkP2QtNRvsldq5aSaXanaqrpcS+dJA
 i9hKFixCEVTX4S2f300g2A7FLiRhDTkUMy4EnejnUcQmm0DVL3eDc7U8u0Mvsje2MXOx
 G32NAhHC2CrJVEHh6GJUjf7qPe33hzxWgul1PhERAM2+eCl0O6XczVSZeTmgeeYVf9Zz
 094Zd3+uerm+ugLO6uDhjVFtduCY+cg24fBIkB8MXtpKRfanMN+rurh9PaK0cQ/ANYYf
 Zi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkUQSWRyDo7N3gMjPFgWAFIufs62qiUnuMkPV6Fsbp4=;
 b=fIc0vcLs3AbzMjutZ8Ucaba+Wb0aw39XC1+6YLxALJH6nzuoFJE2155sgGqZPuZYJi
 EgAxE1fet11qBA/p+ylJ+0160DaGljugGpaQRqnWIa9MVq/IqrRvetKWfAqD/3VwELX6
 HU90BWqfKgrIpH5NAG/3NWdDN1Y0n6oG/nIVA2sbwH/5R7lBT/3oCFdhZQWYKFDTGMal
 OgYemvitR7+T7/xKwbCBbU4tD0Pb7qRa3Oy4skrqAqf/j0beOGyjxDNQhza8yI+KUkCv
 n9RNz+cTAnWsRJIBiI9kDKxAGxUfQ3BTBkRl7ZgBLb2+F90NHQs28ecyW1KMa41wY97f
 kvYg==
X-Gm-Message-State: APjAAAVnqDN3QiNvYffC7IOfVpgvxycBBpKKJK5d0bjdEb8Ed1y0CR/9
 sJLWvdRpwjufPGgE6X7b+7qgZt9LcNz/ag==
X-Google-Smtp-Source: APXvYqyEeY51OM8LgNBMbG1hjRPU4+p7Z1PjSrZ9DifrGkNIeT8Yswg4PjQNbADUNvXPK1zDZWGJEQ==
X-Received: by 2002:adf:e947:: with SMTP id m7mr8960339wrn.123.1561999192071; 
 Mon, 01 Jul 2019 09:39:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:04 +0100
Message-Id: <20190701163943.22313-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PULL 07/46] pci: designware: Update MSI mapping when
 MSI address changes
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

From: Andrey Smirnov <andrew.smirnov@gmail.com>

MSI mapping needs to be update when MSI address changes, so add the
code to do so.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index ec697c8f9df..931cd954e87 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -290,11 +290,13 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_ADDR_LO:
         root->msi.base &= 0xFFFFFFFF00000000ULL;
         root->msi.base |= val;
+        designware_pcie_root_update_msi_mapping(root);
         break;
 
     case DESIGNWARE_PCIE_MSI_ADDR_HI:
         root->msi.base &= 0x00000000FFFFFFFFULL;
         root->msi.base |= (uint64_t)val << 32;
+        designware_pcie_root_update_msi_mapping(root);
         break;
 
     case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
-- 
2.20.1


