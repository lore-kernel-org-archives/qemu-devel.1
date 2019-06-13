Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CEBC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FDE21721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqddfPVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FDE21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOs7-0007B4-9b
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58811)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcz-0007uF-RP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcx-0003zF-Do
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:49 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:32989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcv-0003wG-63
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id n9so20572366wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A6zB6s48Mdps2LC1th7zZyg8f6vSOggdH9q3F9SoDps=;
 b=GqddfPVKPAImuE+nN8zpYvXcatzOSLgJqFUAadSshC0ahGORjGzEM1fSizt+Hp629B
 eoN/4Wu26fgJmYlJ8ZnngfduwZOp1EKPafuiJO5uc3GxHQLwc9P9bAwCf6Da2ntuXA9V
 2KAkuj4ymP9ivFVJ3PE9aw8a/EwGJTYS1NxJfyhMjR+nKttessRpBZEYOza/byEb2W4A
 TMogiNOLHQftGc0c5H+djmRndyVhHOu2w0ZBwuT1LOoI+fP6LQb2oppPnPKAxHJJ4BM+
 DByE+Fa3b0cpnljXUbc5uJBjXZ0vA59z3881W06dFSW6aUWZ0vkMVgL5kT3MQ8CPoboK
 sxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A6zB6s48Mdps2LC1th7zZyg8f6vSOggdH9q3F9SoDps=;
 b=WmKeiDbm9i7n/iUNM2F+fF8WLoASW8yB9Pn/rFq7viBTJDDD+s6BDSzrW1hZHB+fvJ
 dAvFICnqhyHfbLLNrDXQ1NDEL0ETkPhBD6cCCOzN3VGV/u8pjDbBE/YioboHTnizbTc9
 wdSHT5NUcnTP90CVSooyBbQxUPjvN9LbQMPGyAYRNtF1xU/87wx4MM89zpQSm3fB47se
 eJJo2Ar0hydtZRmmjTDUO7XJ1Vi2/B8xI0tt7nuoFnQOnxMAv9hXLVCIiTwbMLjjWAn7
 nkJgl15bf0jZFeof1zL5pxk8fBfnvaGxthT77ObQKDC2iU+cBO2oj8k8JGZXJhI0xR2y
 142A==
X-Gm-Message-State: APjAAAXD5WzUmFqmERYbZpZrozlkQyeVrYV29Rij6WQwwtRFQa848f15
 hhoS25zK1VO5Ry3cSmT2FTKgjoVe3x8pTw==
X-Google-Smtp-Source: APXvYqzx1FkXL3gI2ZObyEj0/mA2HyEpmfL25QCK5KSSmms8GjAyajRqaIYUsAlsk1FEFrrFI508Eg==
X-Received: by 2002:adf:9cd0:: with SMTP id h16mr42664147wre.211.1560428083050; 
 Thu, 13 Jun 2019 05:14:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:52 +0100
Message-Id: <20190613121433.5246-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 07/48] decodetree: Fix comparison of Field
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Typo comparing the sign of the field, twice, instead of also comparing
the mask of the field (which itself encodes both position and length).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190604154225.26992-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 81874e22cc7..d7a59d63ac3 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -184,7 +184,7 @@ class Field:
         return '{0}(insn, {1}, {2})'.format(extr, self.pos, self.len)
 
     def __eq__(self, other):
-        return self.sign == other.sign and self.sign == other.sign
+        return self.sign == other.sign and self.mask == other.mask
 
     def __ne__(self, other):
         return not self.__eq__(other)
-- 
2.20.1


