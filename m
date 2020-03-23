Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFAAC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8745220736
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QmidH2Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8745220736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIkz-0001Ik-IJ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIjH-0007yE-B1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIjG-00033X-9U
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:46:39 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13382
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIjG-000331-1x; Mon, 23 Mar 2020 04:46:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02N8dj0Q010653; Mon, 23 Mar 2020 01:46:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=qEAv6IpogbV7YHyhj2l6c6UjHVFT5rsptczJTs+HL8c=;
 b=QmidH2EckQDjt3AcVakyn4T5TG19v6Ne2x5+5HfHlbXgcPYaCIXc5RadonxBLFQPnSHN
 ehFMaSaBms/o1IYBkvqGN4Sz2ZRqV383mUjY0l61DwyhCt86bP+4rmldwTewh3qnb6f3
 zBJ5VnVFCXct5nKA8sbFCU4VbWGQzJRJTV1r9WnmnNDSlSD/cbXbeq33A2fwzIBOgNog
 gsTcmMHRm0OrvrBbNRwwqeAh7CtWdDgsGF5ALO35clHOIk84rTFF2eu12EZ7jtHTSfER
 haudumhaenwYVoszg+1t7WK2SUYOZrGijsa+fY8a844T7iXkCxPqX2BvUZOSqkAXTHcF ew== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 2ywg9ndrvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 01:46:34 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Mar
 2020 01:46:32 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Mar 2020 01:46:27 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <bharatb.linux@gmail.com>, <jean-philippe@linaro.org>,
 <yang.zhong@intel.com>
Subject: [PATCH v9 1/9] hw/vfio/common: Remove error print on mmio region
 translation by viommu
Date: Mon, 23 Mar 2020 14:16:09 +0530
Message-ID: <20200323084617.1782-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323084617.1782-1-bbhushan2@marvell.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_02:2020-03-21,
 2020-03-23 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.148.174
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
Cc: Eric Auger <eric.auger@redhat.com>, Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARM, the MSI doorbell is translated by the virtual IOMMU.
As such address_space_translate() returns the MSI controller
MMIO region and we get an "iommu map to non memory area"
message. Let's remove this latter.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 hw/vfio/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5ca11488d6..c586edf47a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
                                  &xlat, &len, writable,
                                  MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
-        error_report("iommu map to non memory area %"HWADDR_PRIx"",
-                     xlat);
         return false;
     }
 
-- 
2.17.1


