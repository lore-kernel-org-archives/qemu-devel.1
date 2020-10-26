Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D2C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4688D2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhoL5J5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4688D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzkJ-0007Mm-6D
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPL-0002xI-D1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPA-0006hW-3l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=YtpemJyXeENG1iyhpnYrZIyJX9D2vPnFL8PqSIH7ibQ=;
 b=NhoL5J5U25IV6rpGvFMaSJcCxkaThFq5gHjkBGoU6Ys0PgRc/CubKj0duXrxM0y5J4Xzes
 GBPE06uGvW9GzsOqkITPmCOKKau6QU98u4Fb9j9JfPSUK52Cjm6hsLMaQmVMIerSuOX0U8
 ruPMgy5Upb+Wz2tHJDhPLIPEwHLE2O4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-XnQVwli7NduG9h-LypXLCA-1; Mon, 26 Oct 2020 06:06:57 -0400
X-MC-Unique: XnQVwli7NduG9h-LypXLCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 978EC1009E3E;
 Mon, 26 Oct 2020 10:06:56 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8863E8B84F;
 Mon, 26 Oct 2020 10:06:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/31] fuzz: Declare DMA Read callback function
Date: Mon, 26 Oct 2020 11:06:14 +0100
Message-Id: <20201026100632.212530-14-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

This patch declares the fuzz_dma_read_cb function and uses the
preprocessor and linker(weak symbols) to handle these cases:

When we build softmmu/all with --enable-fuzzing, there should be no
strong symbol defined for fuzz_dma_read_cb, and we link against a weak
stub function.

When we build softmmu/fuzz with --enable-fuzzing, we link against the
strong symbol in generic_fuzz.c

When we build softmmu/all without --enable-fuzzing, fuzz_dma_read_cb is
an empty, inlined function. As long as we don't call any other functions
when building the arguments, there should be no overhead.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20201023150746.107063-6-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/memory.h |  8 ++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 93d27bff26..4aaf578ce6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -47,6 +47,14 @@ void fuzz_dma_read_cb(size_t addr,
                       size_t len,
                       MemoryRegion *mr,
                       bool is_write);
+#else
+static inline void fuzz_dma_read_cb(size_t addr,
+                                    size_t len,
+                                    MemoryRegion *mr,
+                                    bool is_write)
+{
+    /* Do Nothing */
+}
 #endif
 
 extern bool global_dirty_log;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index a5d1641820..cec0e0f743 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3246,6 +3246,19 @@ void memory_region_init_rom_device(MemoryRegion *mr,
     vmstate_register_ram(mr, owner_dev);
 }
 
+/*
+ * Support softmmu builds with CONFIG_FUZZ using a weak symbol and a stub for
+ * the fuzz_dma_read_cb callback
+ */
+#ifdef CONFIG_FUZZ
+void __attribute__((weak)) fuzz_dma_read_cb(size_t addr,
+                      size_t len,
+                      MemoryRegion *mr,
+                      bool is_write)
+{
+}
+#endif
+
 static const TypeInfo memory_region_info = {
     .parent             = TYPE_OBJECT,
     .name               = TYPE_MEMORY_REGION,
-- 
2.18.2


