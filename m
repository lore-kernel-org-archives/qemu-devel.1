Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B90C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC82C20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWiAQUNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC82C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zws-0005e3-UW
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0M-0003lF-Uf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003cE-TU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:02 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0L-0003Yv-Gg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id z15so6099308wrl.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZOJUPvTLdaLO4oOnRYZfh9hBX2YQQN/SKXqT5LsoKIk=;
 b=dWiAQUNic+HzSjkKsGxwX7JeLZLVeNTR7cpjoMGdXpu9hqQuPYMz43GdojrWqYgtGz
 z52CdEpydwRczH9jgAuM/dU7JIxainZa4XbMZu1iP8wblrWGLiI3498IG88c5V5edzYX
 dJrOQTvebERtSpz+RZ/UyFdGrSmZmn/ZyyMmrWirIix3WzTtqPd1d2iAWwe4tpYKhq4v
 SeywpUvDbC0VonooJ7kwTHRd5m0LiZNq9Fv3Jg4k5TilK2ODTfxIicekGPeqiNurQrRy
 /ZV9ZdBeQKgRekQYaU/BOsV1LPog5rRD+f+GvDjXQNODFoePJSExuv0XzQLwDoOUykRM
 zr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZOJUPvTLdaLO4oOnRYZfh9hBX2YQQN/SKXqT5LsoKIk=;
 b=Vb+DHiewnmaNL5tCP58bZ/EL/dPunQqh/nRRY8BDcBG8Qu7N++J38IzKmM+fbSJyJK
 qY1EGdUeUkoP3MOXUp6tSlEqyqBXaZNMCp9HRAP2+sANaNGcxUUm30kyqtK7Hvl84n1L
 z2/lxu3+i6NIqLJvH+92AfKwBSTA6hsMZI/hwqhEaSqGF34SPcVSlk3yklmT+xEqY6pH
 RGEfPvYqvEqq/zOW8tcs9pYOZQKEfVmUtB4Dg3HZC1a+uJhoF4gYuQ2Tbp/1U7cU3Evl
 U9plKHBRtwU8imilafDPJOW/yB/b8X/U4t8RNmR3M851ZfM8E501Bm9W6im8C2BVAxss
 MfPA==
X-Gm-Message-State: APjAAAUN8wWDL3ffYPA/FoFMEVSXt0pB0NF4bnLVDLkYUnJNwB2atamG
 mbgHvYnzAGXlgApMSu9nh8jabJiu
X-Google-Smtp-Source: APXvYqwpxHPZZquPCT/+Jdpz4O+exmLILXS0XGGffKyQQAhfMFGjk0eWmnTiNBKotD51s4Q1GEemZw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr70073118wrv.86.1582632476369; 
 Tue, 25 Feb 2020 04:07:56 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 123/136] hw/core: Let devices own the MemoryRegion they create
Date: Tue, 25 Feb 2020 13:07:21 +0100
Message-Id: <1582632454-16491-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-26-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/core/platform-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 22c5f76..d494e5c 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -187,7 +187,8 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
     d = SYS_BUS_DEVICE(dev);
     pbus = PLATFORM_BUS_DEVICE(dev);
 
-    memory_region_init(&pbus->mmio, NULL, "platform bus", pbus->mmio_size);
+    memory_region_init(&pbus->mmio, OBJECT(dev), "platform bus",
+                       pbus->mmio_size);
     sysbus_init_mmio(d, &pbus->mmio);
 
     pbus->used_irqs = bitmap_new(pbus->num_irqs);
-- 
1.8.3.1



