Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF62C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8592133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKyJRbEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8592133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVMX-0006N9-9w
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkS-0004Yk-M9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkR-00034V-Eu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUkQ-0002gi-NQ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so6392901wru.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wzOpofdcurA5wsLNGyb10WqGKKid4Jy5IfhsoibOXrE=;
 b=DKyJRbEy18ZuxnVwrFYwij/hUBPHQFs+eLH81D2+OLJm6Lc4O1N7Ka7gP5hp9Kp0Dn
 blHm3xxR9lB89/uQZZHkhWoyKeeJZigr/0d1ESjD+NDw+gXrgyFsNWg19v/QJC7qiJnT
 x+sKOkYqkRJDcG/kFUrOz0efF2ZNTKGdSuHoa6GLbDZeMwGuVrFab3hk6k0FXMJ1Gw7k
 t9zUck5qkEKbpXyKDKTOwLTKiek/TUZ7cIghtugOYxASa88iESXLb4FHKPV3aQ6rwobS
 /m/oEzJlgwqaUCo6xzPdHSn5hvsukjjRaFevxRs9qtv4cWaMluPqOMUvvWIaDJLugGoo
 /khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=wzOpofdcurA5wsLNGyb10WqGKKid4Jy5IfhsoibOXrE=;
 b=LbO1p3sWNbc3bdHXWOedVd9DirdVRj2BzuoOl9BFeOIwLKoxbiGFBZuqB3kUsP/c/8
 nILEiYkzrYS2RPuZJxa7qQ9dZI+WzRoVa9LVRGkcKGTyHfT/T9Wvipc5DIfilMLCvkgD
 O/lGoWS8B5PzzAkjmafDwRje/gPuwJ9QMFPaosnELdCUb6/UjKPxVwrFKZDrzj5e42Ys
 keO/QTtGnSkwyN17zYOnc7GfISTgoqA72hyrA/x7jKozqnFpSLTdktKGNVt5lm+tNdDp
 oC6NiThnYuhSUYoRLoiIJciuFzmpMMVG9PhzlImElhkKDSDG0nK87M5ufvCyx5ghRqo8
 APTg==
X-Gm-Message-State: APjAAAV/w1rsZZtjReKxWA5fZU/Ie0Q/3vwRMpxeUJBRYJTXjEE7BJK1
 iX8gYKCDsPq2l9P5LXEdntEqX4hVgMs=
X-Google-Smtp-Source: APXvYqwbScvg06K9GOeh0UAuMC5Jp6uHLlTBh7UDryM1cWfw1LeQStZUjOPuXmMI2Gvwgjk0b9S7Eg==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr4880872wro.86.1562358206572;
 Fri, 05 Jul 2019 13:23:26 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:13 +0200
Message-Id: <1562358202-28008-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 03/12] i386/kvm: Fix build with -m32
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
Cc: Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

find_next_bit() takes a pointer of type "const unsigned long *", but the
first argument passed here is a "uint64_t *".  These types are
incompatible when compiling qemu with -m32.

Just use ctz64() instead.

Fixes: c686193072a47032d83cb4e131dc49ae30f9e5d
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190624193913.28343-1-mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e4b4f57..31490bf 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1043,14 +1043,15 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     CPUX86State *env = &cpu->env;
     uint32_t r, fw, bits;
     uint64_t deps;
-    int i, dep_feat = 0;
+    int i, dep_feat;
 
     if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) {
         return 0;
     }
 
     deps = kvm_hyperv_properties[feature].dependencies;
-    while ((dep_feat = find_next_bit(&deps, 64, dep_feat)) < 64) {
+    while (deps) {
+        dep_feat = ctz64(deps);
         if (!(hyperv_feat_enabled(cpu, dep_feat))) {
                 fprintf(stderr,
                         "Hyper-V %s requires Hyper-V %s\n",
@@ -1058,7 +1059,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
                         kvm_hyperv_properties[dep_feat].desc);
                 return 1;
         }
-        dep_feat++;
+        deps &= ~(1ull << dep_feat);
     }
 
     for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
-- 
1.8.3.1



