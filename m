Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB80FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3522074B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dlyr2J51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3522074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqn6-0002Yj-Al
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqct-00080r-P7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqcr-0006Jw-NK
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+ic4XYc4a38mwCG7bGYIrFsYTNeEPqO632utFxp4Gc=;
 b=Dlyr2J51UB7uohJwxj9q2vTqNQkTimC2uxhTEq0pnE/9E2sagLKlWmRHfSm2T99CmnAAab
 OLrS9O3KUH5E7r9ynVMg7nyZfDEV43DntWc0oSdp7skaGE5wkoY5LNzzWzZE/64Qc1Ti6z
 UGWKmx+0MeGPvCcz9+1VYB5sdgsybug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-via2PX4WMLC7482Gq1Sy6w-1; Mon, 28 Sep 2020 06:43:17 -0400
X-MC-Unique: via2PX4WMLC7482Gq1Sy6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A674F1DDF4;
 Mon, 28 Sep 2020 10:43:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2903F5C1A3;
 Mon, 28 Sep 2020 10:42:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5D12140825; Mon, 28 Sep 2020 12:42:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] move MemMapEntry
Date: Mon, 28 Sep 2020 12:42:45 +0200
Message-Id: <20200928104256.9241-2-kraxel@redhat.com>
In-Reply-To: <20200928104256.9241-1-kraxel@redhat.com>
References: <20200928104256.9241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is defined twice already.  Move to a common header file to
remove duplication and make it available to everybody.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/hwaddr.h | 5 +++++
 include/hw/arm/virt.h | 5 -----
 hw/arm/sbsa-ref.c     | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/exec/hwaddr.h b/include/exec/hwaddr.h
index a71c93cc810a..8f16d179a885 100644
--- a/include/exec/hwaddr.h
+++ b/include/exec/hwaddr.h
@@ -18,4 +18,9 @@ typedef uint64_t hwaddr;
 #define HWADDR_PRIx PRIx64
 #define HWADDR_PRIX PRIX64
 
+typedef struct MemMapEntry {
+    hwaddr base;
+    hwaddr size;
+} MemMapEntry;
+
 #endif
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index d018a4f29788..655b895d5eba 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -111,11 +111,6 @@ typedef enum VirtGICType {
     VIRT_GIC_VERSION_NOSEL,
 } VirtGICType;
 
-typedef struct MemMapEntry {
-    hwaddr base;
-    hwaddr size;
-} MemMapEntry;
-
 struct VirtMachineClass {
     MachineClass parent;
     bool disallow_affinity_adjustment;
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 257ada942550..9c3a893bedfd 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -80,11 +80,6 @@ enum {
     SBSA_EHCI,
 };
 
-typedef struct MemMapEntry {
-    hwaddr base;
-    hwaddr size;
-} MemMapEntry;
-
 struct SBSAMachineState {
     MachineState parent;
     struct arm_boot_info bootinfo;
-- 
2.27.0


