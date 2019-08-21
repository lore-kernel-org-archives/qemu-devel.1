Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C22C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C794222CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqQzmlLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C794222CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SGj-0003Jz-P5
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFC-0001dX-9v
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFB-0002C6-B6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:09:50 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFB-0002BH-5X
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:09:49 -0400
Received: by mail-pg1-x544.google.com with SMTP id d1so1483426pgp.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aNW7oyEvoHsrxfrKUUVGh07z9yQZ1vU7GETYRhFz3DU=;
 b=ZqQzmlLXSqGPmVNzIoS8y5lAGunxRH9DLrRBOWQFAp6DIYqN8z+P6Tzp9YDaIWIRs4
 eUx5SYoNDSdTw362OZa0KHThiv6EGo0SQ3v1MWdd3QZhPkXYTxasa2ervEQz0NNQJ/9n
 0xAv00jbj8DHN6l0cdifGjeiuWZSdB/4Fpuk90jokcQxcSDiLJkJ+/E3bEYam1EIlswg
 ccptWCObD2tcRDi6kGb2jg2G4YPBOf3fOoLgnY2VkTm9juSafW+09QUx7rNYv5VngF++
 bvAxK3ewMyMkzcRo/HHOPdq1h5nRKX7ky86XN/VsUKX1b231kXHadSNdqiDtR4vqezBE
 miag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aNW7oyEvoHsrxfrKUUVGh07z9yQZ1vU7GETYRhFz3DU=;
 b=iBn0tuAVaLOINA+53qGMsSg1VDkFVXDQ34R1Vaugnz+LhOVYYQhmnBrrTzYijgg5Xk
 7GR9q96Q80g099wHWu7UxNboJZnbJWYRludDdDV07wua0g2WrRGM6NO/0b43RhqyEIK+
 yP+7Lf0bH4YrINOK3IaOM8eW5Go+1hxa07WdouWvQC3/XLIkeq1rdL4YmI2YtWYS+0L/
 VQZ1wGl3hBO3QAd2WgGqiXzfiAIi1hzClPGgmaVDdB6EHfnd6pyocuJ7Gad4aCYwCm8C
 /xJ64HzGUEe7QRs/wyRv/+Q7THObcYiBZTc99+115sy/ZyhCKWaezh370nUvIpAhaoQX
 D98Q==
X-Gm-Message-State: APjAAAVYwo6Y0l/nl0S8kYRJFyElMsYgxw1quPtk8h3UA3KGHEYCHHx+
 cH3PBu17HyguiOz/J3cHyJi+TUVvrf0=
X-Google-Smtp-Source: APXvYqwpRPo2DgERBdXT0eU6CHGK36DvF5hIosilVyalBchZBKuM+pqvJ/ORw9/7jIfp4MiGtiNeig==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr29501714pgk.431.1566400187973; 
 Wed, 21 Aug 2019 08:09:47 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.09.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:09:47 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:08:57 +1000
Message-Id: <bfa88041c6918905fa36359a6685ed1e5e721dc4.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel]  [PATCH v8 03/21] memory: Introduce size_memop
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
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Introduce no-op size_memop to aid preparatory conversion of
interfaces.

Once interfaces are converted, size_memop will be implemented to
return a MemOp from size in bytes.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 7262ca3dfd..dfd76a1604 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -107,4 +107,14 @@ typedef enum MemOp {
     MO_SSIZE = MO_SIZE | MO_SIGN,
 } MemOp;
 
+/* Size in bytes to MemOp.  */
+static inline unsigned size_memop(unsigned size)
+{
+    /*
+     * FIXME: No-op to aid conversion of memory_region_dispatch_{read|write}
+     * "unsigned size" operand into a "MemOp op".
+     */
+    return size;
+}
+
 #endif
-- 
2.23.0


