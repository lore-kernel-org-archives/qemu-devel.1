Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F87BC10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1242086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3JjPbvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1242086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi0F-00077X-9j
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrC-0005E9-Lj
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrB-0003Dw-J4
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrB-0003Cz-C7
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so20460588wrw.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7wcBLal9cVFkgaCtfQxJxYKhmsjCSuFD9FIEO060xXw=;
 b=E3JjPbvXTVE2hldjOBDhjC7atG3mYxKBtXCZPmFUTwd6fcJHdWHU4cb9asK/dieV9R
 2p+iqFTDfYLDeWGhoFF/H+Hqf78jhhgC/X4kTehNTJwclDt/BhVRcwCRSB7USVYQk9b0
 rc5DJmiJAOp/eYJM7FrswQnRyo3Pd6ob5coCk0zJIEGcKk1gHUpOxSSYfbTArU/uSCQ0
 GX7yWYcLPGkY+rQHGp6lA+bvYBPbjx7HBUI/bklJkJroBA+7yrPu3FTVpPNJMMt0IyJ3
 CGzImDWLTGb45E+423LBfWSlUkNboZk7urPqAUR/f75CDh0JsRlmSehcUhSA7gv0zOLS
 PuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7wcBLal9cVFkgaCtfQxJxYKhmsjCSuFD9FIEO060xXw=;
 b=osoD9QV9AahzG9oVDQFAUarhguYD+t4Y9DrNQAg7NWV2bxbEyPdgdIm98mzwaOnu8T
 IKPwmHpNw02WClfhShYQ5uAWxVk9kozsOBRX+SkjqXVU+/lXchE6YLtwhuczYWxKEycg
 D9N5iYnET7mOHOjV0rz5SKiC9X8bquBr7qn9RQKbgaTwRUv1Vu0yI3R3H8gvuESo78V7
 /JIae7keOCKrOj4xvR17+kYWCykU/dx5FTEjjOps2A+XFyGEhf9st71NWIbXS2RTnkHd
 jofN6aS1JzvT/BxdTUNGz06z5RkFhbVKyf01+vPVt79lE5HYVn5uNQAWsz90lvGZlxMN
 rGOw==
X-Gm-Message-State: APjAAAWsXgqcS9yTw+wfylNwnU/VXLV+qIsUf+da/JPGrwbaHVurN2eN
 mY/BjNlKRrQCzsqoURm/iaEhpXy3
X-Google-Smtp-Source: APXvYqy0KlRLgifrLEwjYcOTemNjwZ6QTZcg1rWR0jwRMj/SQPvtBjcFeWzZviuWkFguOhQJAMivww==
X-Received: by 2002:a05:6000:108c:: with SMTP id
 y12mr3383528wrw.238.1570035124117; 
 Wed, 02 Oct 2019 09:52:04 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/30] target/i386/kvm: Silence warning from Valgrind about
 uninitialized bytes
Date: Wed,  2 Oct 2019 18:51:32 +0200
Message-Id: <1570035113-56848-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

When I run QEMU with KVM under Valgrind, I currently get this warning:

 Syscall param ioctl(generic) points to uninitialised byte(s)
    at 0x95BA45B: ioctl (in /usr/lib64/libc-2.28.so)
    by 0x429DC3: kvm_ioctl (kvm-all.c:2365)
    by 0x51B249: kvm_arch_get_supported_msr_feature (kvm.c:469)
    by 0x4C2A49: x86_cpu_get_supported_feature_word (cpu.c:3765)
    by 0x4C4116: x86_cpu_expand_features (cpu.c:5065)
    by 0x4C7F8D: x86_cpu_realizefn (cpu.c:5242)
    by 0x5961F3: device_set_realized (qdev.c:835)
    by 0x7038F6: property_set_bool (object.c:2080)
    by 0x707EFE: object_property_set_qobject (qom-qobject.c:26)
    by 0x705814: object_property_set_bool (object.c:1338)
    by 0x498435: pc_new_cpu (pc.c:1549)
    by 0x49C67D: pc_cpus_init (pc.c:1681)
  Address 0x1ffeffee74 is on thread 1's stack
  in frame #2, created by kvm_arch_get_supported_msr_feature (kvm.c:445)

It's harmless, but a little bit annoying, so silence it by properly
initializing the whole structure with zeroes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 91d0bf6..522d9fd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -188,7 +188,7 @@ static int kvm_get_tsc(CPUState *cs)
     struct {
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
-    } msr_data;
+    } msr_data = {};
     int ret;
 
     if (env->tsc_valid) {
@@ -448,7 +448,7 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     struct {
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
-    } msr_data;
+    } msr_data = {};
     uint64_t value;
     uint32_t ret, can_be_one, must_be_one;
 
-- 
1.8.3.1



