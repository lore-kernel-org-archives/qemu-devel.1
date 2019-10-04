Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D3E2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1+pwSut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D3E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRAc-0001B7-Rm
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvf-0007TN-GF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQve-0001zK-3G
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iGQvc-0001xR-1P
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id z9so8031059wrl.11
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZDqqXdcMXiQ0rY6+l1b7+0ccr/E+z+91d4l9ckAYnz8=;
 b=Y1+pwSut5tKZjysY8cv0rIp5iVCM5GO6zqh+tET7Fm66KN6AGBlIBHb/3jLKHtqU0r
 XA9BVsfhgBZHxUR+T1SZOIYUV27H6UpLOJnmgKczvXxLrurMvnsrivfiTaq0Lw4SKwzk
 5itzbUHbuvy3/R874v874qAa7FVJeyUF7axBfM3UYj/y+RM3MGHsimoPVV/D5ko37BL5
 q4xptReR/L2WapjUvUl25NQU6R3UMlSbJXXwXctRbnEmdgVcp3OIUnCCLJ7k16bJ+Q7e
 wL3Ua/A1jzewMZjXYGemmQAbDtb/tupzpAUPS+yV30MN0I8dFfS5xNQL6J/5T1epU6dx
 L0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ZDqqXdcMXiQ0rY6+l1b7+0ccr/E+z+91d4l9ckAYnz8=;
 b=qc+1VEqWuZo0kqvDQmqmQ74ScHFEnoA75VJqKKNtxRbhp46UcXRPznib8NstTRYxfU
 CyGfgpD51MOQ65ZG9Y+tVJRWY6GH+SQtDYtIIENOkbeJ7nGlg+VZfbBTxUEI1WxdzwUh
 8PjuFZ1NROZ9lFt8616ZnTQvtuC9zubo8qYOtNqlStOdZV7utUHXGggqwF4YlJ7gwrfd
 hQYQ5g/4mI++8c2RFsFoATKYv3mHFv+LvTd4n/u56X+lxyOCkTvJX7EWiuSKnXiBr+Rk
 WKyUZzxBjtbrnZbePI2+PJNA6HAEnfhHseDpnV/Sz56XXng1pS0wfbUqa/W275zX7JEv
 oN+Q==
X-Gm-Message-State: APjAAAUAze/qy+tjeD21XQLIFnzebRUmwchWVUFdmtMGaG0CuBnz9q6O
 zTmOZf5XchfoVV4FzHz6f49YIjR3
X-Google-Smtp-Source: APXvYqynAv0MyljEWOZ876CmCylDCMs7fD8k+JURG+33CcvDlCYyuLA/rJN9qsPLwtl+SXRGydUZBQ==
X-Received: by 2002:a5d:430e:: with SMTP id h14mr12201567wrq.18.1570208377075; 
 Fri, 04 Oct 2019 09:59:37 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u7sm7041270wrp.19.2019.10.04.09.59.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:59:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] target/i386/kvm: Silence warning from Valgrind about
 uninitialized bytes
Date: Fri,  4 Oct 2019 18:59:23 +0200
Message-Id: <1570208363-11948-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
References: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
index be4bbfb..11b9c85 100644
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


