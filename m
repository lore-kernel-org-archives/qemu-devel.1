Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4762C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F173223AC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUeUbzrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F173223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Bg-0002ox-Pp
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63l-0001lf-SE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63k-00063G-VQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63k-00062e-PD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id b17so4361718wmj.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+3FqdgoTZLjOj3AoU3SzJl29O+tJ7C+eq6tKtuYqCzA=;
 b=iUeUbzrQf3WU4+1bjT5jK9Uex599qgQOobjy5lkZl8HEl39x58jWX3T5q7K3poHdz9
 jDdcBr/NDecfIctCZocc/jUo9+KTCW201yFlfLUT6F2vDFHiB31Eg44zBgSs8BDyZKTD
 OmYt03GBYdAiUVplgkxrc1ZLPXFQ3f+FYKIpSnDeHIv1dC2UNUsP/GJLYnOWRd5myJ9G
 O/f7CuqZ3W3h5e47vbDL6+M6JxFDXzQAf0dZ0kY9eDqh8WPxNdNChyKcGRKlEO/OTPxC
 m2dFKTZA1YOVsOYvFvleT39Oq3TKTj0+g2kQZAY+r011DpLPrr+FZewYDkqTcERUzAc/
 u+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=+3FqdgoTZLjOj3AoU3SzJl29O+tJ7C+eq6tKtuYqCzA=;
 b=crpgYJMB+b73MzKSAwYG2Kii61RzSmTtEqHXCpG6qmH/5hef2pNMfttSbuXDa93646
 OZMrEL/lBY6XweQrPC0LDnZ496JZQQjELcth47MsTbFuWU1Pgr2YraGsDMNooyk2tSJ1
 F+NcD8p4qV1gNvWgA0fIg9P5+HoysDdswjSpYV4S0ZRjAA1bBsl4Sc5egRxnubShHMVx
 UlUzA9VAVMv83uamwVE5DrrJYIvt6RIDS+oAX0uxrGtNL7hbu0Re6xcivsSsdbucbP9g
 pZDhhWpgaWo7nmiiVzTnvsdspHozTtZiR8ap6r0p/KA72GAZv/ZOZv8OdVtn4fd9NbH0
 /iJQ==
X-Gm-Message-State: APjAAAXb1gm0K2Kv+2sxkxK2diCo+jXv+yGnAvzq9w16GAp8hFGrDmJt
 Z51txjGUE/36Z7grIwIS4D7rNknW
X-Google-Smtp-Source: APXvYqzpic9ziSoieYYY4+MLVzxC3/Vl35DvSuuGUxCVzXpBrK2J0ozGrlkfORVItAus5NLnuZEP3Q==
X-Received: by 2002:a1c:64d4:: with SMTP id y203mr6664971wmb.27.1574179735274; 
 Tue, 19 Nov 2019 08:08:55 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] target/i386: Export TAA_NO bit to guests
Date: Tue, 19 Nov 2019 17:08:40 +0100
Message-Id: <1574179728-35535-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

TSX Async Abort (TAA) is a side channel attack on internal buffers in
some Intel processors similar to Microachitectural Data Sampling (MDS).

Some future Intel processors will use the ARCH_CAP_TAA_NO bit in the
IA32_ARCH_CAPABILITIES MSR to report that they are not vulnerable to
TAA. Make this bit available to guests.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f60df3..296b491 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1205,7 +1205,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
             "ssb-no", "mds-no", "pschange-mc-no", NULL,
-            NULL, NULL, NULL, NULL,
+            "taa-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
1.8.3.1



