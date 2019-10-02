Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A1C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614AC21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwf3ARoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614AC21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57731 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhw4-0002NF-QB
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr9-0005A1-JP
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr8-0003AO-J0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhr8-00039S-D2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id q17so20487493wrx.10
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=3dvmDFlr0gurTBYD4r1hBqQhpgoTuiAsAyqm2OCYvPs=;
 b=Mwf3ARoN8D3MbOi5qyT4haz16gR0bTX9CWXmr5aDZLNlccgn5e21F89JHjxthCSRjY
 j2WGjNqCyXd3/ebj2iYxTZO5fsgrc1Ue990s4ErkSnQb4i3ByJYXuE9MXYRw8qdmyurq
 2uZrc3vjQy+QCSk0m7Xsub3hT1GsoPC/YlbBQmkP9T2i6+Qk08f7/1O3BNa2qsOtWMFG
 2O2Rlh/l725M5h4/GuDcaf7wRM0PiORKQTK+/yKBlJ1UcM5JbXO+UJXDtTN0WA7tYqZI
 pCZJ79FYwX89nmWG8NYJSMP9eodyUvyFm90INEL02c7b7urDM48K/CBG1efmfeOd0QOi
 S01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=3dvmDFlr0gurTBYD4r1hBqQhpgoTuiAsAyqm2OCYvPs=;
 b=Vann0jTDt/sWa6F0DpX7Hdp2YflXRt9bqdGGISWIkSS34iG9Pi1pJwgeudlKQnb/xh
 cWVSscQkWWbe1M7YzKNrawgBoMHTC/yhxfujKOUnFUWoT9lu22zrbp5z16ER8XszLy2U
 MvVc3bY7m5tpJuUQyT/bj479A+I4cm22rRWbWOdo9VrcCGTOqaWGFt3LoBzdqa4LcHYP
 ipp8If9nD2rZ1jD6P3O+AlOMo07yFiKKZkWXaECgfeECr2YyD+2+hxzz5Hc5ptRucXPc
 gU7pLKnulEUlMHu3J/ImDFtic0/nL5miE7SUEH13EYl1xKkU3gTzidblUTlfbyCNYXGB
 Ox+w==
X-Gm-Message-State: APjAAAUYVsycTRpSLB45bJMftMTHKcWhYlRPj6Qwjs4Tan6SDaqrH0aP
 UBHIZ54WGDADrCqA+rzb4BjfOnVS
X-Google-Smtp-Source: APXvYqwJKEp/xW3j9PwjretCMxLCxfT13rZZRIkwWEU9MYNFcdqXIzxyBPx9XnWVMa5zGAhSU2zNog==
X-Received: by 2002:adf:b60b:: with SMTP id f11mr3352379wre.95.1570035121183; 
 Wed, 02 Oct 2019 09:52:01 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/30] vmxcap: correct the name of the variables
Date: Wed,  2 Oct 2019 18:51:29 +0200
Message-Id: <1570035113-56848-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

The low bits are 1 if the control must be one, the high bits
are 1 if the control can be one.  Correct the variable names
as they are very confusing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index d8c7d6d..5dfeb2e 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -51,15 +51,15 @@ class Control(object):
         return (val & 0xffffffff, val >> 32)
     def show(self):
         print(self.name)
-        mbz, mb1 = self.read2(self.cap_msr)
-        tmbz, tmb1 = 0, 0
+        mb1, cb1 = self.read2(self.cap_msr)
+        tmb1, tcb1 = 0, 0
         if self.true_cap_msr:
-            tmbz, tmb1 = self.read2(self.true_cap_msr)
+            tmb1, tcb1 = self.read2(self.true_cap_msr)
         for bit in sorted(self.bits.keys()):
-            zero = not (mbz & (1 << bit))
-            one = mb1 & (1 << bit)
-            true_zero = not (tmbz & (1 << bit))
-            true_one = tmb1 & (1 << bit)
+            zero = not (mb1 & (1 << bit))
+            one = cb1 & (1 << bit)
+            true_zero = not (tmb1 & (1 << bit))
+            true_one = tcb1 & (1 << bit)
             s= '?'
             if (self.true_cap_msr and true_zero and true_one
                 and one and not zero):
-- 
1.8.3.1



