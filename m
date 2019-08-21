Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02163C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBA5205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXr9roGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBA5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SKO-00015g-LX
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFR-000201-4j
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFP-0002YJ-UZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:04 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFP-0002X2-Ox
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:03 -0400
Received: by mail-pg1-x542.google.com with SMTP id m3so1458187pgv.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9hMnFqHZSm8mCOtREv+YT9P7cMZzmYDoyQ1x70QuHNQ=;
 b=rXr9roGp3yJGIuxNFKGASZcpKqXVDN7ZI2tzQWq+IxwbGS+z1kKmtx/cOhlTPQUqaB
 AndOTgHx/twtBO6nz7aI8AinZIHp4GuKbex15ihm8MlNVCLKvdmzrn+/1ol08bw4TT/x
 JuyJvjodKpe0MYq6b8eREmaUCL4Q2VERMTkJShnyqHuWkhhHZQrGwU5A8WziBWOMhfqu
 8GpmScSwRHiUXRmnPtoQgDesAM9LsbNpq+eY7XVlX2VuM8DZpKWI4GoH9OifZSOsMn8K
 OwemD6nnRfqa9VeDtTfPS52/Ue16ErOf2BaWynawk+ywr9FxAqu92Fgit5A7PaAyveXV
 4qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9hMnFqHZSm8mCOtREv+YT9P7cMZzmYDoyQ1x70QuHNQ=;
 b=q7iUUSMSd/t7+bKFynZMzeNag0hmSCIvzVBbArFzhQ9tOlifNat7eZ275mGuuqAdOz
 QuKSL7imfMjHz2Z1/wH0NsIRthfdvC7ntL7AXAXKf/jGCBaNbAQH/Nyk2nzksNA9UtqB
 9EhoNYESJQFsDqq8SuAP059p65gYGcDjF9YQgLvTWplpjSpt8V4rZrz2sP95ptRe8Led
 NLXQQGGf0OUtIZafgi61WR/LsNgybmY+krR7v1RiN+oLc9GWzhouDPy5+jk+CN2C1jv6
 OHLHnbcVewHMBkFJgEbtG/zUcCIcqxQ3IvVYU4yqIUQqWWLVbdsZsjYyFyjw+WuKXeER
 dBVw==
X-Gm-Message-State: APjAAAVJMJgOvmv0fbax1qv8yGBtcQtTG2aojzlLQFIXfJK0gz3afgrf
 rb3KJLYonOc1YkkoVtMuE9YYsHlLT4I=
X-Google-Smtp-Source: APXvYqwPwh8Uvecf8wMp/Z1Rypdl9wuO0GMAmN0AZSVTYOARUxuC0A2XoLWk7BeVA0siFhRlxC6fqw==
X-Received: by 2002:a17:90a:7d09:: with SMTP id g9mr489705pjl.38.1566400202566; 
 Wed, 21 Aug 2019 08:10:02 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.09.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:02 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:01 +1000
Message-Id: <4f59237776f5ea9d42f144400b8e75c040e9e906.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v8 07/21] hw/virtio: Access MemoryRegion with
 MemOp
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/virtio/virtio-pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8babd92e59..82c5e87a44 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 
+#include "exec/memop.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
@@ -552,7 +553,8 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIFIED);
+    memory_region_dispatch_write(mr, addr, val, size_memop(len),
+                                 MEMTXATTRS_UNSPECIFIED);
 }
 
 static void
@@ -575,7 +577,8 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
-    memory_region_dispatch_read(mr, addr, &val, len, MEMTXATTRS_UNSPECIFIED);
+    memory_region_dispatch_read(mr, addr, &val, size_memop(len),
+                                MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
         pci_set_byte(buf, val);
-- 
2.23.0


