Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD296C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A822A20578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV5T8xbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A822A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5B4i-0003h9-Sr
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j5B2V-0001pk-9R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j5B2U-0002kA-9Z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:20:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j5B2U-0002ju-1u
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:20:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so2380291wmb.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QlV6PTrsKM9eegByilijvW4b3zkmigFmOoaJ7S5tzUM=;
 b=mV5T8xbdzBaGvY5GNxt9OV2YBNmEkSro11uM3uersXfIEh/36OtZuJu6eDcQHjdV7b
 ngHy3y03GEU2Jpkct/CovxY4uvwlcvhaJpCS8N2lixqkEt11scAB5H4P5YUCxDFANpLI
 V2Oj7a5JmDeU0GOnt/QtPtl439GIR4k86AgyvVMX0tH+Lm5AhrwxfSzujYI6xXsF2vqh
 GUrE4X6BSD/kPq86aKYvfXSU3U5AakhpEkf0BHGPQYv6Avtpe+qjzAPgPd90JDuSU5JQ
 BTqvoT8dzlE12BCtxjilBfKjPi6xEWPIUMjASr+vu7AcILvUOmSC6hYa1nWrZCQsP5ru
 kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QlV6PTrsKM9eegByilijvW4b3zkmigFmOoaJ7S5tzUM=;
 b=TxrQBXByy4dng1G++QWBaMYKri5gAF/U9fYY+827fb5IQne0uMJivkTwS75oXKQvqW
 dr0afnZtWB495W4XzNwva0YWht10PAWNLq1pCe9UUo5QrSUA6z4FUOgStliS7XuhHyXk
 +KH9l/vyY28X3rqacdk9WSM2xYlbnuK70FVExF7LNfjbxEpEKhxsEK/iNQWS2MuU11gI
 +CbbzxxGOAEJk/WLt6P00b1UErIrZVCA0RxpKbg3xQVe5WZuf/RFv5p3D4tOq4Kl9p6Q
 O9SHTsPVfs/5c0INj8PzO4YZzhMaSTQj+X4Wzfcl6Qp9BjwVllXgEKQ9Od4aGEx6FzG3
 doKA==
X-Gm-Message-State: APjAAAXvzfDVth3ix/XPP2WN1q7N7Z29MoBl1AkEGJr7hvUlXjWEnRd/
 74GInKOlJ95j9nQdJoG29vfNsaSu
X-Google-Smtp-Source: APXvYqwPDCrfkEDXnFSxbY5GQeVcn9RvRTModVGPo/FhIG7rGFDcBMj/9UWn2o0d+rRcw/xCPf+qsQ==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr5064455wmg.16.1582302026528; 
 Fri, 21 Feb 2020 08:20:26 -0800 (PST)
Received: from donizetti.fritz.box ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id f62sm4653530wmf.36.2020.02.21.08.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:20:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: check for empty register in FXAM
Date: Fri, 21 Feb 2020 17:20:24 +0100
Message-Id: <20200221162024.18808-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: chengang@emindsoft.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fxam instruction returns the wrong result after fdecstp or after
an underflow.  Check fptags to handle this.

Reported-by: <chengang@emindsoft.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 99f28f267f..792a128a6d 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -991,7 +991,11 @@ void helper_fxam_ST0(CPUX86State *env)
         env->fpus |= 0x200; /* C1 <-- 1 */
     }
 
-    /* XXX: test fptags too */
+    if (env->fptags[env->fpstt]) {
+        env->fpus |= 0x4100; /* Empty */
+        return;
+    }
+
     expdif = EXPD(temp);
     if (expdif == MAXEXPD) {
         if (MANTD(temp) == 0x8000000000000000ULL) {
-- 
2.21.1


