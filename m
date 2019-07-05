Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC908C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A482133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxJZ3Yoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A482133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUL1-0005k3-4N
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEO-0005Ur-Ja
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEN-0004By-Iz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEN-0004BO-CY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so10740108wma.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NL1qamEi1SWCxCZDQ+Ft1vPKiyaKCd/QL3Bjak1vxXQ=;
 b=fxJZ3Yoqg8OHwz53erMfDvAHc5CGSxdzOcMQ+kT3NQyCpD5BmplEnSVWGgJZs5hSEc
 15tBoG21dneEE+K24cQQ/qEdkEqqBicBHf46O+IeR9wzgdWKsJe0D7nIF5/g67Ze2DV1
 OUbfVUdHbPXuBfWN70bKvNYMs3jlPL9TdBaw1ntdB2+Vb2sXPurSg9NlGrOlc7jc/Wgr
 if0nnkHUT2RDd5W16earw6sPNlUKA+IhZoCJNF4IN/2ihD3T7w9kSt7+EhqLxIZfj68B
 tI2Q5/5Up+XNQP8PWbK5fmztDkOcCAtlBxkiAIwkLG7lcqDWPtjZV6xiHYNt/vvJudSz
 21GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NL1qamEi1SWCxCZDQ+Ft1vPKiyaKCd/QL3Bjak1vxXQ=;
 b=kI9ta6WI1N/yFrElgb9KJCebyAiDBlIS2tjpv9udTSvLwbJ4L7DMOro21hA29198S4
 5edQo+Xo+/xLWhf9MbHEGy3wH2V3HTFJtihqK4J4BGK3wQQZFM7siEmB9ZFpzKQi5oS9
 sRDfQ8HHLTmwVdTHVhd2lER1ZHDRTAuKs7snUqkFP5jY/yDhurbNdAtQZxMiaRjHqvT/
 t0PVbY9Kbo0GZQQZci2KOjCW7QDCrLC8JfL9pBx/HTfTWfFqdGSxHMvL3IL36fWhCUw3
 UVhxbYGG/PVqCeiOEdDM5WLC8PKaQPf1V5QcqQUI/ZCE+PtQ9FPedu6mqo6e6wqWuE9w
 QFnA==
X-Gm-Message-State: APjAAAXmASaqhwLWV0CIiimY5gSat9WLucZdysQFJ7ewr9hE1wdae6CT
 koMSLRndG8YKLJgPRIddZMQS4tDkm1k=
X-Google-Smtp-Source: APXvYqzdysGP6KWHtcfyiy+5CHe7kwFtrdzJ67i/12GsoyxT8it3L1g9cH3yJdMOXRBs9oJH9onegw==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr4670924wme.93.1562356250131; 
 Fri, 05 Jul 2019 12:50:50 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:34 +0200
Message-Id: <1562356239-19391-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 07/12] target/i386: fix feature check in
 hyperv-stub.c
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Commit 2d384d7c8 broken the build when built with:

  configure --without-default-devices --disable-user

The reason was the conversion of cpu->hyperv_synic to
cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
hyperv-stub to do the same feature check as in the real hyperv.c

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20190624123835.28869-1-alex.bennee@linaro.org>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hyperv-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
index fe548cb..0028527 100644
--- a/target/i386/hyperv-stub.c
+++ b/target/i386/hyperv-stub.c
@@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     switch (exit->type) {
     case KVM_EXIT_HYPERV_SYNIC:
-        if (!cpu->hyperv_synic) {
+        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
             return -1;
         }
 
-- 
1.8.3.1



