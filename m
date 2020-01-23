Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB056C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A730021835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaS/WIK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueA3-0007g5-C6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrF-0004ny-Nx
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrE-0003BI-LD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:33757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrE-00039g-Ep
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id m10so1389237wmc.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=edun+OJ+YJzFF5lv8jtNkTbaWNOC2ILXKY6V/xrxpmY=;
 b=AaS/WIK+Vp8VzdZ2g3g6E6uGHTOSpBadzOvJ49AzRVyDwY+B+VsS1T006rKFefGUC/
 Nx3O76y0b6zlIlcX0PJxGJBl2/vyMXKgh+T+kHTYKFOMtkOtWyoif7X9uS6Lk4fAhZyh
 ohzibnMwTHvMG6Q3508y6zAnGRYw3POF2fX4F+NGRHozKjECzXSsn2gnr7eImHT5ilS3
 6VYnI+o3sP1a+WJyz9qKHa4Kk2K1vYYvQB9vGoxJmnAYrEo9IrYtOnf4zNWiYg18YbK+
 33sNeJf0pvg7sInVRWDUfRecG/isFvD1eSy3IepM4kM3rxj2Tq9P+k8e2csWJP7aPgVU
 82ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=edun+OJ+YJzFF5lv8jtNkTbaWNOC2ILXKY6V/xrxpmY=;
 b=RQGNtMBZmqdLBfuA7DKJSfi8icSKYFBa5JXWTe4zJOMNCze43QpPtD+igqX7WXyvBj
 HuVztaWLyJ0vfcoOiSKFJ1s2CbwwsnNqtxCuu+vWF0GL+7FvlSJf+3PXE2t0/DH4i7HM
 JIUHHtkvchSh14TGln6OJFFirp8CW1W71GI11N9EZysh4a2TxawKhwuCpShj+rJaHX/C
 k3RYAToGtWD51xZjsVKhlfdf7OXfSeKBfbHaYeWxETj4CKe0Sl06rPBmS5GzRr5wBJrj
 4ODtGdiemBVrlEupH3bYQDEH2geJC/UgVy5iSRTQdceBRuJLiKNIQD8Sy/8MtI56vB82
 TXIw==
X-Gm-Message-State: APjAAAV9JXDex9jox+VAMSxj+JYGNxyx5hJpFolq0sGi/khjPcDhdaVV
 R/QMGSfi8sozK9cexeN41de7rJRg
X-Google-Smtp-Source: APXvYqzm+Ihy8uzmhSx5kYvJh0HGVcI3gbN2wEGPLoSf+bC2IoiPozlo+8lnqpaq5sgHjMLpairptw==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr1203162wmm.98.1579787355304; 
 Thu, 23 Jan 2020 05:49:15 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/59] hw/net/imx_fec: Remove unuseful FALLTHROUGH comments
Date: Thu, 23 Jan 2020 14:48:13 +0100
Message-Id: <1579787342-27146-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

We don't need to explicit these obvious switch fall through
comments. Stay consistent with the rest of the codebase.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191218192526.13845-6-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/imx_fec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c01ce4f..5a83678 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -901,8 +901,8 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
             s->regs[index] = 0;
         }
         break;
-    case ENET_TDAR1:    /* FALLTHROUGH */
-    case ENET_TDAR2:    /* FALLTHROUGH */
+    case ENET_TDAR1:
+    case ENET_TDAR2:
         if (unlikely(single_tx_ring)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "[%s]%s: trying to access TDAR2 or TDAR1\n",
-- 
1.8.3.1



