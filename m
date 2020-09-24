Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2CB2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hH94C2HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2CB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO85-0001ds-Un
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUz-0003Oc-S7
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUq-0006I0-0a
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8IF91sjN25lbtFmQe6SfV4tAQBciSF2GxvmgEJFKxE=;
 b=hH94C2HVkLWAHTeN9qTvW/X43EbuHT7jpWzimEzlWhtV1swQQOSOQWDy0yHIowSvY+YaPQ
 o1sHd7DUytV/d8NwOTEbKvuhVAr9Z+H5sPaMrxyU4luQ3PqM9oYYfzXT0HpSFK8HJzNQ1T
 Aw0XOw3nos6ipEqs/ixhKZbYh2FL+rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-ATeukPI1NvuzkaV6HuHQVg-1; Thu, 24 Sep 2020 05:24:55 -0400
X-MC-Unique: ATeukPI1NvuzkaV6HuHQVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446771882FC6;
 Thu, 24 Sep 2020 09:24:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6EC455764;
 Thu, 24 Sep 2020 09:24:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 88/92] net/can: Add can_dlc2len and can_len2dlc for CAN FD.
Date: Thu, 24 Sep 2020 05:23:10 -0400
Message-Id: <20200924092314.1722645-89-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
Message-Id: <0a2efc6ef9c458505952ed230e49ae25cad7f324.1600069689.git.pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/net/can_emu.h |  4 ++++
 net/can/can_core.c    | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/can_emu.h b/include/net/can_emu.h
index cab98ee8ec..6f9b206bb5 100644
--- a/include/net/can_emu.h
+++ b/include/net/can_emu.h
@@ -122,4 +122,8 @@ int can_bus_client_set_filters(CanBusClientState *,
                                const struct qemu_can_filter *filters,
                                size_t filters_cnt);
 
+uint8_t can_dlc2len(uint8_t can_dlc);
+
+uint8_t can_len2dlc(uint8_t len);
+
 #endif
diff --git a/net/can/can_core.c b/net/can/can_core.c
index 90f4d8576a..0115d78794 100644
--- a/net/can/can_core.c
+++ b/net/can/can_core.c
@@ -33,6 +33,42 @@
 #include "net/can_emu.h"
 #include "qom/object_interfaces.h"
 
+/* CAN DLC to real data length conversion helpers */
+
+static const uint8_t dlc2len[] = {
+    0, 1, 2, 3, 4, 5, 6, 7,
+    8, 12, 16, 20, 24, 32, 48, 64
+};
+
+/* get data length from can_dlc with sanitized can_dlc */
+uint8_t can_dlc2len(uint8_t can_dlc)
+{
+    return dlc2len[can_dlc & 0x0F];
+}
+
+static const uint8_t len2dlc[] = {
+    0, 1, 2, 3, 4, 5, 6, 7, 8,                              /* 0 - 8 */
+    9, 9, 9, 9,                                             /* 9 - 12 */
+    10, 10, 10, 10,                                         /* 13 - 16 */
+    11, 11, 11, 11,                                         /* 17 - 20 */
+    12, 12, 12, 12,                                         /* 21 - 24 */
+    13, 13, 13, 13, 13, 13, 13, 13,                         /* 25 - 32 */
+    14, 14, 14, 14, 14, 14, 14, 14,                         /* 33 - 40 */
+    14, 14, 14, 14, 14, 14, 14, 14,                         /* 41 - 48 */
+    15, 15, 15, 15, 15, 15, 15, 15,                         /* 49 - 56 */
+    15, 15, 15, 15, 15, 15, 15, 15                          /* 57 - 64 */
+};
+
+/* map the sanitized data length to an appropriate data length code */
+uint8_t can_len2dlc(uint8_t len)
+{
+    if (unlikely(len > 64)) {
+        return 0xF;
+    }
+
+    return len2dlc[len];
+}
+
 struct CanBusState {
     Object object;
 
-- 
2.26.2



