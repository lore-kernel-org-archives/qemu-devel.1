Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D412EC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8983F216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd+YlPvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8983F216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUzl-0002lW-9c
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk8-0004LB-HX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk3-0002mw-A2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUjz-0002jC-R2
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id h19so8294606wme.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NL1qamEi1SWCxCZDQ+Ft1vPKiyaKCd/QL3Bjak1vxXQ=;
 b=Nd+YlPvYNskjnp2NN5XY0QePTM253d0iLZfXER0olQ8TFtJt0zWB8nO/vin0waW/RJ
 RNhAUriBDt8gzQydZHbd4ii8CRjTLrooceH1GGAARkD5eOQFk/+TRcjOFdP0qTSCcBOj
 1UBK9Ls6krJQSBH5uotnqZLuwLbPfSEuQFw/4BhKGJZVIn9Qlf2ud1s03EidXTVIFb4v
 giMdepo8oIqx8RZb6wRe/KWv0nu4reQ2JYB8DNJbzMHzcKJYj5IGqV3ci7SrLm7Jzy/x
 P4SfOjVrWvYd8kbWn6wFfirqNY+1v2VSylWhgi6JKoovUeJ9Ml9ut5flW5XH8ZmhtuPB
 ObGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NL1qamEi1SWCxCZDQ+Ft1vPKiyaKCd/QL3Bjak1vxXQ=;
 b=DrBvo4XlMFuwQZJz7h3wXc2q5Vb4MmeL7Jwn1UNFvZeQuMjjZ+Z5zI3bz/gsK0PDJa
 neowKdx/gG1zXJlPw7Z6flcvcBGIeVd8sXt6pxOoeypkKe8fIfcdSIXJYzJqzAOhSs6b
 QbSCqtnQfY3a7npDizt2hy9i+2fHPo0Mb3AsGu+QbIArObeaqkD1H0U78Dd+RSL4reoh
 LWrSC50fpgWZQ/pB86yTuMEM/4Bjj4UGX0kCg9ZpsUa8BdUzBnYaahCC0F2npdznFoS1
 5y4hcIPmUt6X4IHrYXoHfb7bbvcI50JoZ28tiCf2D1q5Y9vRAvVOpghG9XQmDBAP8OYL
 3utQ==
X-Gm-Message-State: APjAAAXoUIwdpjUk6w2NvmeBiAWN7eE0szc8sbLHCgbNuHOlpFbJ+gtu
 aMoV/hHvt//S8MHxJ9sK1Tk6rXZngCc=
X-Google-Smtp-Source: APXvYqwJ0V5dfMDxy4F8t9gFM7WF1jwib/clFm4YPqc9GcJrTFWc0dR7nTO4OP038XF6viVLpHhvdg==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr4453308wmg.155.1562358210084; 
 Fri, 05 Jul 2019 13:23:30 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:17 +0200
Message-Id: <1562358202-28008-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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



