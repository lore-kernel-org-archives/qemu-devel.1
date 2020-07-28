Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A85206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/Hz83ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A85206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RNt-0007KF-D0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k0RFv-0000jy-Vl
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:11:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k0RFu-000846-42
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595949061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGmSho80hRJEgScVaDEnT/Pg7XjU4Fmj6TVlaAS5JRA=;
 b=T/Hz83ln34DG0zPlhMIdQeO9R52fRPdRfH+8mLk9Mk5vrva60AAzufFZJkj0hi0iHDZ2BA
 cJioSm31ggD/YMstRVadjqELAMLnBrXHx12ZfJQSURbnuDeEINLD0xTg0W6waN1h+850Gr
 V36DH4YEYQTV7qlRUESS4Z4CE4474FE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-VVFPvW5SOEyhMrSabjs0Eg-1; Tue, 28 Jul 2020 11:10:59 -0400
X-MC-Unique: VVFPvW5SOEyhMrSabjs0Eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C783A18C63C3;
 Tue, 28 Jul 2020 15:10:56 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-203.ams2.redhat.com [10.36.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 214BC69328;
 Tue, 28 Jul 2020 15:10:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH for-5.2 v4 11/11] hw/arm/smmuv3: Advertise SMMUv3.2 range
 invalidation
Date: Tue, 28 Jul 2020 17:08:15 +0200
Message-Id: <20200728150815.11446-12-eric.auger@redhat.com>
In-Reply-To: <20200728150815.11446-1-eric.auger@redhat.com>
References: <20200728150815.11446-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, robh@kernel.org, robin.murphy@arm.com,
 mst@redhat.com, zhangfei.gao@foxmail.com, shameerali.kolothum.thodi@huawei.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose the RIL bit so that the guest driver uses range
invalidation. Although RIL is a 3.2 features, We let
the AIDR advertise SMMUv3.1 support as v3.x implementation
is allowed to implement features from v3.(x+1).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v2 -> v3:
- keep the AIDR equal to 2. BBML support, which is 3.2
  mandatory feature will be addressed in a separate
  patch.
- added Peter's R-b (same version as in v1)
---
 hw/arm/smmuv3-internal.h | 1 +
 hw/arm/smmuv3.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 9ae7d97faf..fa3c088972 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -55,6 +55,7 @@ REG32(IDR1,                0x4)
 REG32(IDR2,                0x8)
 REG32(IDR3,                0xc)
      FIELD(IDR3, HAD,         2, 1);
+     FIELD(IDR3, RIL,        10, 1);
 REG32(IDR4,                0x10)
 REG32(IDR5,                0x14)
      FIELD(IDR5, OAS,         0, 3);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b262f0e4a7..0122700e72 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -254,6 +254,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
 
    /* 4K and 64K granule support */
-- 
2.21.3


