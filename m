Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAC2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CF220693
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBF/r6yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CF220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCr9m-0007E0-7M
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr3Z-0006pv-3q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:09:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr3T-0000Hi-CA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598908170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/zsC0BUSVnvnOAATtAHSUR0VnlZ0EYtxvufRre8z6M=;
 b=HBF/r6yMu4q973sAApxm58Qh8faErc408ZnTmjYysTdp3qdCzA39R0unTwSVX+UOwW+N2X
 I4xOcdp/5rg9fJaGY0Yh4aPJO+CRLwAIcpfIpie/XwyZv+EQsfg3h94MOW4Wd7HkaIp96S
 j/lqakbh4YVX+io4h7dYcjVMGX3xETs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ZhMFAdT7OwytgmRc49EoeA-1; Mon, 31 Aug 2020 17:09:23 -0400
X-MC-Unique: ZhMFAdT7OwytgmRc49EoeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C82F91005E62;
 Mon, 31 Aug 2020 21:09:21 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B89E16E27;
 Mon, 31 Aug 2020 21:09:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/18] [automated] Use DECLARE_*CHECKER* macros (pass 3)
Date: Mon, 31 Aug 2020 17:07:35 -0400
Message-Id: <20200831210740.126168-14-ehabkost@redhat.com>
In-Reply-To: <20200831210740.126168-1-ehabkost@redhat.com>
References: <20200831210740.126168-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 $ ./scripts/codeconverter/converter.py -i \
   --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v3 -> v4: this is a new patch added in series v4

The script was re-run after series rebase.

This is being submitted as a separate patch to make review
easier, but it can be squashed into the previous patch once it
gets reviewed.
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: Helge Deller <deller@gmx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: qemu-riscv@nongnu.org
---
 include/hw/arm/armsse.h            | 7 ++-----
 include/hw/riscv/spike.h           | 4 ++--
 include/hw/virtio/vhost-user-blk.h | 4 ++--
 hw/hppa/lasi.c                     | 4 ++--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index e5788e9d3c..452cbb5793 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -110,7 +110,8 @@
 #define TYPE_ARM_SSE "arm-sse"
 typedef struct ARMSSE ARMSSE;
 typedef struct ARMSSEClass ARMSSEClass;
-#define ARM_SSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARM_SSE)
+DECLARE_OBJ_CHECKERS(ARMSSE, ARMSSEClass,
+                     ARM_SSE, TYPE_ARM_SSE)
 
 /*
  * These type names are for specific IoTKit subsystems; other than
@@ -227,9 +228,5 @@ struct ARMSSEClass {
     const ARMSSEInfo *info;
 };
 
-#define ARM_SSE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(ARMSSEClass, (klass), TYPE_ARM_SSE)
-#define ARM_SSE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(ARMSSEClass, (obj), TYPE_ARM_SSE)
 
 #endif
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 121396d07a..cddeca2e77 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -28,8 +28,8 @@
 
 #define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
 typedef struct SpikeState SpikeState;
-#define SPIKE_MACHINE(obj) \
-    OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
+DECLARE_INSTANCE_CHECKER(SpikeState, SPIKE_MACHINE,
+                         TYPE_SPIKE_MACHINE)
 
 struct SpikeState {
     /*< private >*/
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index 9d38877907..dc40ab6f11 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -24,8 +24,8 @@
 
 #define TYPE_VHOST_USER_BLK "vhost-user-blk"
 typedef struct VHostUserBlk VHostUserBlk;
-#define VHOST_USER_BLK(obj) \
-        OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
+DECLARE_INSTANCE_CHECKER(VHostUserBlk, VHOST_USER_BLK,
+                         TYPE_VHOST_USER_BLK)
 
 #define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
 
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index 1acb9ce631..c0b970f55c 100644
--- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -54,8 +54,8 @@
 #define ICR_TOC_BIT        LASI_BIT(1)  /* bit 1 in ICR */
 
 typedef struct LasiState LasiState;
-#define LASI_CHIP(obj) \
-    OBJECT_CHECK(LasiState, (obj), TYPE_LASI_CHIP)
+DECLARE_INSTANCE_CHECKER(LasiState, LASI_CHIP,
+                         TYPE_LASI_CHIP)
 
 struct LasiState {
     PCIHostState parent_obj;
-- 
2.26.2


