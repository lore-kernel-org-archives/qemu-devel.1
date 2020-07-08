Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA49C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A3F206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx1EsXn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A3F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIry-0006Ig-51
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jtISE-00034a-1B
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jtISB-00019U-5P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2g+B7IYS/q8kC2gq1xewuZ82Q1wxCicLVrYYCMiePk=;
 b=bx1EsXn6HtAXeVQNtcdTlJAt69qRQK84JE20ZOE9vnQWkQgn9O3A1khdDC/WvUPD2vSWFZ
 6HXFko3akjPNvo5BkEWtriIwWdtLq79d0MkNoUdPIOWbjErjY/vk3gsDUlHzf/In8totpq
 eItioF5CgFF6OUNJ5CZw8pvjJSvyJOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-ZgPrnBcmMBOQYshNCabp9w-1; Wed, 08 Jul 2020 10:20:00 -0400
X-MC-Unique: ZgPrnBcmMBOQYshNCabp9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80DC8107ACCA;
 Wed,  8 Jul 2020 14:19:58 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BADEB5BAC3;
 Wed,  8 Jul 2020 14:19:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH v3 09/11] hw/arm/smmuv3: Let AIDR advertise SMMUv3.0 support
Date: Wed,  8 Jul 2020 16:18:54 +0200
Message-Id: <20200708141856.15776-10-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-1-eric.auger@redhat.com>
References: <20200708141856.15776-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the support for AIDR register. It currently advertises
SMMU V3.0 spec.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/arm/smmuv3-internal.h | 1 +
 include/hw/arm/smmuv3.h  | 1 +
 hw/arm/smmuv3.c          | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index ef093eaff5..6296235020 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -64,6 +64,7 @@ REG32(IDR5,                0x14)
 #define SMMU_IDR5_OAS 4
 
 REG32(IIDR,                0x18)
+REG32(AIDR,                0x1C)
 REG32(CR0,                 0x20)
     FIELD(CR0, SMMU_ENABLE,   0, 1)
     FIELD(CR0, EVENTQEN,      2, 1)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 36b2f45253..68d7a963e0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -41,6 +41,7 @@ typedef struct SMMUv3State {
 
     uint32_t idr[6];
     uint32_t iidr;
+    uint32_t aidr;
     uint32_t cr[3];
     uint32_t cr0ack;
     uint32_t statusr;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 89ab11fc36..718f28462e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1251,6 +1251,9 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     case A_IIDR:
         *data = s->iidr;
         return MEMTX_OK;
+    case A_AIDR:
+        *data = s->aidr;
+        return MEMTX_OK;
     case A_CR0:
         *data = s->cr[0];
         return MEMTX_OK;
-- 
2.21.3


